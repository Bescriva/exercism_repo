defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand), do: calculate(radicand, 0, div(radicand, 2) + 1)

  defp calculate(_ , left, right) when left >= right, do: right
  defp calculate(radicand, left, right) do
    mid = div(left + right, 2)
    square = mid * mid
    cond do
      square == radicand -> mid
      square < radicand -> calculate(radicand, mid + 1, right)
      square > radicand -> calculate(radicand, left, mid)
    end
  end
end
