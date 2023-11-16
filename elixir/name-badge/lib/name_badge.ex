defmodule NameBadge do
  def print(id, name, department) do
    dep = if department, do: String.upcase(department), else: "OWNER"

    if !id do
      "#{name} - #{dep}"
    else
      "[#{id}] - #{name} - #{dep}"
    end
  end
end
