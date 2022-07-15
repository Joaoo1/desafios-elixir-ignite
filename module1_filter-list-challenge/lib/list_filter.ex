defmodule ListFilter do
  def call([]), do: 0

  def call(list) do
    odd_values = get_odd_values_from_list(list)
    Enum.count(odd_values)
  end

  defp get_odd_values_from_list(list) do
    Enum.filter(list, fn v ->
      if Kernel.is_number(v) do
        is_odd(v)
      else
        result = Integer.parse(v)

        case result do
          :error ->
            false

          _ ->
            {converted_value, _} = result
            is_odd(converted_value)
        end
      end
    end)
  end

  defp is_odd(value) do
    rem(value, 2) != 0
  end
end
