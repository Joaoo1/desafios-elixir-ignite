defmodule GenReport.Parser do
  def parse_file(filename) do
    response =
      filename
      |> File.stream!()
      |> Stream.map(fn line -> parse_line(line) end)

    IO.inspect(Enum.at(response, 0))
    response
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.downcase/1)
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(3, &parse_month/1)
    |> List.update_at(4, &String.to_integer/1)
  end

  defp parse_month(month_in_number) do
    case month_in_number do
      "1" -> "janeiro"
      "2" -> "fevereiro"
      "3" -> "março"
      "4" -> "abril"
      "5" -> "maio"
      "6" -> "junho"
      "7" -> "julho"
      "8" -> "agosto"
      "9" -> "setembro"
      "10" -> "outubro"
      "11" -> "novembro"
      "12" -> "dezembro"
    end
  end
end
