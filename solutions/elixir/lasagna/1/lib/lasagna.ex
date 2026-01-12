defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(mins), do: 40 - mins

  def preparation_time_in_minutes(layers), do: layers * 2

  def total_time_in_minutes(layers, mins), do: preparation_time_in_minutes(layers) + mins

  def alarm(), do: "Ding!"
end
