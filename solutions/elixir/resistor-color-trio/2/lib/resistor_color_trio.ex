defmodule ResistorColorTrio do

  @colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  defp get_unit(value) when value >= 1_000_000_000, do: %{divisor: 1_000_000_000.0, prefix: :gigaohms}
  defp get_unit(value) when value >= 1_000_000, do: %{divisor: 1_000_000.0, prefix: :megaohms}
  defp get_unit(value) when value >= 1_000, do: %{divisor: 1_000.0, prefix: :kiloohms}
  defp get_unit(_value), do: %{divisor: 1.0, prefix: :ohms}

  defp value(colors) do
    colors
    |> Enum.take(2)
    |> Enum.map(&Map.get(@colors, &1))
    |> Enum.join()
    |> String.to_integer()
    |> Kernel.*(10 ** Map.get(@colors, Enum.at(colors, 2)))
  end

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors 
    |> value() 
    |> then(fn resistance ->
      unit = get_unit(resistance)
      {resistance / unit.divisor, unit.prefix}
    end)
  end
end
