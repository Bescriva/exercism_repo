defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dist = (x ** 2 + y ** 2) ** 0.5
    cond do
      dist > 10 -> 0
      dist > 5 -> 1
      dist > 1 -> 5
      true -> 10
    end
  end
end
