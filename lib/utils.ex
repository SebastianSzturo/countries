defmodule Countries.Utils do
  @moduledoc """
  Helper functions.
  """

  @doc """
  Convert Tuple or List to Map.

  ## Examples

      iex> Countries.Utils.to_map([{'foo', 1}, {'bar', '2'}])
      %{bar: "2", foo: 1}

      iex> Countries.Utils.to_map(["foo", "bar"])
      "foobar"

  """
  def to_map([item | _] = values) when is_tuple(item),
    do:
      Enum.reduce(values, Map.new(), fn {key, value}, acc ->
        Map.put(acc, key |> to_string() |> String.to_atom(), to_map(value))
      end)

  def to_map(value) when is_list(value), do: to_string(value)
  def to_map(value), do: value
end
