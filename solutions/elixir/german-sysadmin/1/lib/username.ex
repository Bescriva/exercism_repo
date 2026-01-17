defmodule Username do

  def sanitize([]), do: []
  def sanitize([head | tail]) when head in [?ä, ?ö, ?ü, ?ß, ?_] or (head >= ?a and head <= ?z), do: sanitize_char(head) ++ sanitize(tail)
  def sanitize([_ | tail]), do: sanitize(tail)

  defp sanitize_char(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [char]
    end
  end
end
