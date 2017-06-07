defmodule Countries do

  @doc """
  Returns all countries.
  """
  def all do
    countries()
  end

  @doc """
  Filters countries by given attribute.

  Returns a list of `Countries.Country` structs

  ## Examples
    iex> Countries.filter_by(:region, "Europe")
    [%Countries.Country{address_format: nil, alpha2: "VA" ...
  """
  def filter_by(attribute, value) do
    Enum.filter(countries(), fn(country) ->
      Map.get(country, attribute) == value
    end)
  end

  @doc """
  Checks if country for specific attribute and value exists.

  Returns boolean

  ## Examples
    iex> Countries.exists?(:name, "Poland")
    true

    iex> Countries.exists?(:name, "Polande")
    false
  """
  def exists?(attribue, value) do
    (filter_by(attribue, value) |> length) > 0
  end

  #-- Load countries from yaml files once on compile time ---

  # Ensure :yamerl is running
  Application.start(:yamerl)

  @countries Countries.Loader.load

  defp countries do
    @countries
  end

end
