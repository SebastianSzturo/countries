defmodule Countries.Utils do
  def to_map([item | _] = values) when is_tuple(item),
    do:
      Enum.reduce(values, Map.new(), fn {key, value}, acc ->
        Map.put(acc, key |> to_string() |> String.to_atom(), to_map(value))
      end)

  def to_map(value) when is_list(value), do: to_string(value)
  def to_map(value), do: value
end
