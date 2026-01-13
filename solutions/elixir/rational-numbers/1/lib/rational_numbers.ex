defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, a2}, {b1, b2}), do: {(a1 * b2) + (b1 * a2), a2 * b2} |> reduce()

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, a2}, {b1, b2}), do: {(a1 * b2) - (b1 * a2), a2 * b2} |> reduce()

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}), do: {a1 * b1, a2 * b2} |> reduce()

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, a2}, {b1, b2}), do: {a1 * b2, b1 * a2} |> reduce()

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  defp abs_one(n) when n < 0, do: n * -1
  defp abs_one(n), do: n
  
  def abs({num, den}), do: {abs_one(num), abs_one(den)} |> reduce()

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, a2}, n) when n < 0, do: {a2 ** abs_one(n), a1 ** abs_one(n)} |> reduce()
  def pow_rational({a1, a2}, n), do: {a1 ** n, a2 ** n} |> reduce()

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}), do: x ** (a / b)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))

  def reduce({num, den}) when den < 0, do: reduce({num * -1, den * -1})
  def reduce({num, den}) do
    gcd = gcd(abs_one(num), abs_one(den))
    {div(num, gcd), div(den, gcd)}
  end
  def reduce(fraction), do: fraction
end
