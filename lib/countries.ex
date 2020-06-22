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
