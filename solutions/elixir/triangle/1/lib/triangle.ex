defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguard has_non_positive_sides(a, b, c) when a <= 0 or b <= 0 or c <= 0
  defguard is_degenerate(a, b, c) when not (a + b >= c and b + c >= a and a + c >= b)
  defguard is_equilateral(a, b, c) when a == b and b == c
  defguard is_scalene(a, b, c) when a != b and a != c and b != c
  defguard is_isosceles(a, b, c) when not is_equilateral(a, b, c) and not is_scalene(a, b, c)

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when has_non_positive_sides(a, b, c), do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when is_degenerate(a, b, c), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) when is_equilateral(a, b, c), do: {:ok, :equilateral}
  def kind(a, b, c) when is_isosceles(a, b, c), do: {:ok, :isosceles}
  def kind(a, b, c) when is_scalene(a, b, c), do: {:ok, :scalene}
end
