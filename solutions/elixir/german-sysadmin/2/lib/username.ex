defmodule Username do
  def sanitize([]), do: []
  def sanitize([head | tail]) when head in [?ä, ?ö, ?ü, ?ß, ?_] or (head >= ?a and head <= ?z), do: sanitize_char(head) ++ sanitize(tail)
  def sanitize([head | tail]), do: sanitize(tail)

  defp sanitize_char(char) do
    case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> [char]
    end
  end
end