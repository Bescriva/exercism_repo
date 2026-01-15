defmodule BirdCount do
  @today 0

  def today([]), do: nil
  def today(list), do: Enum.at(list, @today)

  def increment_day_count([]), do: [1]
  def increment_day_count(list), do: List.update_at(list, @today, &(&1 + 1))

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  defp total([], acc), do: acc
  defp total([head | tail], acc), do: total(tail, acc + head)
  def total(list), do: total(list, 0)

  defp busy_days([], acc), do: acc
  defp busy_days([head | tail], acc) when head >= 5, do: busy_days(tail, acc + 1)
  defp busy_days([_ | tail], acc), do: busy_days(tail, acc)
  def busy_days(list), do: busy_days(list, 0)
end
