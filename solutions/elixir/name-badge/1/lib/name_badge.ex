defmodule NameBadge do
  def print(id, name, department) do
    (if id, do: "[#{id}] - ", else: "")
    |> Kernel.<>("#{name} - ")
    |> Kernel.<>(String.upcase(department || "OWNER"))
  end
end
