defmodule GenReport do
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def build(), do: {:error, "Insira o nome de um arquivo"}

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Insira uma lista de nomes de arquivos"}
  end

  def build_from_many(filenames) do
    filenames
    |> Task.async_stream(&build/1)
    |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, safe_sum(all_hours[name], hours))

    hours_per_year =
      Map.put(
        hours_per_year,
        name,
        Map.put(
          create_map_if_nil(hours_per_year[name]),
          year,
          safe_sum(hours_per_year[name][year], hours)
        )
      )

    hours_per_month =
      Map.put(
        hours_per_month,
        name,
        Map.put(
          create_map_if_nil(hours_per_month[name]),
          month,
          safe_sum(hours_per_month[name][month], hours)
        )
      )

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  def create_map_if_nil(map) when is_nil(map), do: %{}

  def create_map_if_nil(map) when not is_nil(map), do: map

  def safe_sum(nillable_value, value) when is_nil(nillable_value), do: value

  def safe_sum(nillable_value, value) when not is_nil(nillable_value) do
    value + nillable_value
  end

  defp report_acc do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }
  end

  defp sum_reports(
         %{
           "all_hours" => all_hours1,
           "hours_per_month" => hours_per_month1,
           "hours_per_year" => hours_per_year1
         },
         %{
           "all_hours" => all_hours2,
           "hours_per_month" => hours_per_month2,
           "hours_per_year" => hours_per_year2
         }
       ) do
    all_hours = merge_maps(all_hours1, all_hours2)

    hours_per_month =
      Map.merge(hours_per_month1, hours_per_month2, fn _k, v1, v2 -> merge_maps(v1, v2) end)

    hours_per_year =
      Map.merge(hours_per_year1, hours_per_year2, fn _k, v1, v2 -> merge_maps(v1, v2) end)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end
end
