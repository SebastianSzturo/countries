defmodule Countries do
  @doc """
  Returns all countries.
  """
  def all do
    countries()
  end

  @doc """
  Returns one country given is alpha2 country code

  ## Examples

      iex> %Countries.Country{name: name} = Countries.get("PL")
      iex> name
      "Poland"
  """

  def get(country_code) do
    [country] = filter_by(:alpha2, country_code)
    country
  end

  @doc """
  Filters countries by given attribute.

  Returns a list of `Countries.Country` structs

  ## Examples

      iex> countries = Countries.filter_by(:region, "Europe")
      iex> Enum.count(countries)
      51
      iex> Enum.map(countries, &Map.get(&1, :alpha2)) |> Enum.take(5)
      ["AD", "AL", "AT", "AX", "BA"] 

      iex> countries = Countries.filter_by(:unofficial_names, "Reino Unido")
      iex> Enum.count(countries)
      1
      iex> Enum.map(countries, &Map.get(&1, :name)) |> List.first
      "United Kingdom of Great Britain and Northern Ireland"

  """
  def filter_by(attribute, value) do
    Enum.filter(countries(), fn country ->
      Map.get(country, attribute)
      |> equals_or_contains_in_list(value)
    end)
  end

  defp equals_or_contains_in_list(attribute, value) when is_list(attribute) do
    Enum.member?(attribute, value)
  end

  defp equals_or_contains_in_list(attribute, value) do
    attribute == value
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
    filter_by(attribue, value) |> length > 0
  end

  # -- Load countries from yaml files once on compile time ---

  # Ensure :yamerl is running
  Application.start(:yamerl)

  @countries Countries.Loader.load()

  defp countries do
    @countries
  end
end
