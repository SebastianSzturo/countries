defmodule Countries do
  @doc """
  Returns all countries.
  """
  def all do
    countries()
  end

  @doc """
  Returns one country by given name

  ## Examples

      iex> %Countries.Country{alpha2: alpha2} = Countries.get("Poland")
      iex> alpha2
      "PL"
  """

  def get(attrs) when is_bitstring(attrs) do
    country = filter_by(:name, attrs)

    case length(country) do
      0 ->
        []

      1 ->
        List.first(country)
    end
  end

  @doc """
  Returns one country by given alpha2 country code

  ## Examples

      iex> %Countries.Country{name: name} = Countries.get_by_alpha2("PL")
      iex> name
      "Poland"
  """

  def get_by_alpha2(attrs) when bit_size(attrs) == 16 do
    [country] = filter_by(:alpha2, attrs)
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
      country
      |> Map.get(attribute)
      |> equals_or_contains_in_list(value)
    end)
  end

  defp equals_or_contains_in_list(nil, _), do: false
  defp equals_or_contains_in_list([], _), do: false

  defp equals_or_contains_in_list([attribute | rest], value) do
    if equals_or_contains_in_list(attribute, value) do
      true
    else
      equals_or_contains_in_list(rest, value)
    end
  end

  defp equals_or_contains_in_list(attribute, value),
    do: normalize(attribute) == normalize(value)

  defp normalize(value) when is_integer(value),
    do: value |> Integer.to_string() |> normalize()

  defp normalize(value) when is_binary(value),
    do: value |> String.downcase() |> String.replace(~r/\s+/, "")

  defp normalize(value), do: value

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
