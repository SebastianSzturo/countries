defmodule Countries.Loader do
  @moduledoc """
  This module handle the loading of the YAML data placed in the
  priv directory and provide some functions to make easier handle
  that data.
  """

  @doc """
  Loads all country data from our YAML files, :yamerl returns a
  really terrible data structure (à la Erlang):

  ```
  [[{'name', 'Germany'}, {'code', 'DE'}], [{'nam:e', 'Austria'}, {'code', 'AT'}]]
  ```

  We need to transform that to maps:

  ```
  [%{name: "Germany', code: "DE"}, %{name: 'Austria', code: "AT"}]
  ```

  This function is only loading the required file and decoding it in
  the terrible data structure.
  """
  @spec load(path :: [String.t()]) :: term()
  def load(path) do
    Path.join([:code.priv_dir(:countries), "data" | path])
    |> String.to_charlist()
    |> :yamerl.decode_file()
  end

  @doc """
  Normalize is in charge to transform as good as possible the
  input data from the yamerl into the maps. This function is
  a helper intended to be in use for modules like
  `Countries.Country` and `Countries.Subdivisions.Subdivision`.
  """
  @spec normalize(:null) :: nil
  def normalize(:null), do: nil
  @spec normalize(boolean()) :: boolean()
  def normalize(true), do: true
  def normalize(false), do: false
  @spec normalize(charlist()) :: String.t()
  def normalize(value), do: to_string(value)
end
