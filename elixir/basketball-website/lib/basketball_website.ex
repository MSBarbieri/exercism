defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    list = String.split(path, ".")
    iter(data, list)
  end

  defp iter(nil, _), do: nil

  defp iter(data, []), do: data

  defp iter(data, [first | rest]), do: iter(data[first], rest)

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
