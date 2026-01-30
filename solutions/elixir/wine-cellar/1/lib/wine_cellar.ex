defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end
  
  def filter([], _), do: []
  def filter([{wine_color, value} | tail], color) when wine_color == color, do: [value | filter(tail, color)]
  def filter([_ | tail], color), do: filter(tail, color)

  def filter(wines, color, year: year), do: wines |> filter(color) |> filter_by_year(year)
  def filter(wines, color, country: country), do: wines |> filter(color) |> filter_by_country(country)
  def filter(wines, color, country: country, year: year), do: wines |> filter(color) |> filter_by_year(year) |> filter_by_country(country)
  def filter(wines, color, year: year, country: country), do: wines |> filter(color) |> filter_by_year(year) |> filter_by_country(country)

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
