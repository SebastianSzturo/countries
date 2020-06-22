defmodule Countries do
  @doc """
  Returns all countries.
  """
  def all do
    countries()
  end

  @doc """
    Returns one country gived is alpha2 country code
  """

  def get(country_code) do
    [country] = filter_by(:alpha2, country_code)
    country
  end

  @doc """
  Filters countries by given attribute.

  Returns a list of `Countries.Country` structs

  ## Examples
    iex> Countries.filter_by(:region, "Europe")
    [%Countries.Country{address_format: nil, alpha2: "VA" ...

    iex> Countries.filter_by(:names, "Reino Unido")
    [%Countries.Country{address_format: nil, alpha2: "GB" ...
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
  def exists?(attribute, value) do
    filter_by(attribute, value) |> length > 0
  end

  # -- Load countries from yaml files once on compile time ---

  # Ensure :yamerl is running
  Application.start(:yamerl)

  @countries Countries.Loader.load()

  defp countries do
    @countries
  end
end
