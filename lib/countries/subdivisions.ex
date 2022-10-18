defmodule Countries.Subdivisions do
  @moduledoc """
  Module for providing subdivisions related functions.
  """
  alias Countries.Subdivisions.Subdivision

  @doc """
  Returns all subvidisions by country.

  ## Examples

      iex> country = Countries.get("PL")
      iex> Countries.Subdivisions.all(country)

  """
  def all(country) do
    Countries.Loader.load(["subdivisions", "#{country.alpha2}.yaml"])
    |> List.first()
    |> Enum.map(fn {id, data} -> Subdivision.cast([{'id', id} | data]) end)
  end
end
