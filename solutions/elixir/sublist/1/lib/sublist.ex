defmodule Sublist do

  defp contains?(_, []), do: true
  defp contains?([], _), do: false
  defp contains?(list, sublist), do: List.starts_with?(list, sublist) or contains?(tl(list), sublist)

  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) do
    cond do
      contains?(a, b) -> :superlist
      contains?(b, a) -> :sublist
      true -> :unequal
    end
  end
end
