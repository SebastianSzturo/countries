defmodule Countries do
  @moduledoc """
  Module for providing countries related functions.
  """
  alias Countries.Country

  @doc """
  Returns all countries.
  """
  @spec all :: [Country.t()]
  def all, do: countries()

  @doc """
  Returns one country given is alpha2 country code.

  ## Examples

      iex> %Countries.Country{name: name} = Countries.get_by_alpha2!("PL")
      iex> name
      "Poland"

  """
  @spec get_by_alpha2!(country_code :: String.t()) :: Country.t()
  def get_by_alpha2!(country_code) do
    [country] = filter_by(:alpha2, country_code)
    country
  end

  @doc """
  Returns the country based on the 2-letters country code or `nil` if that
  was not found.

  ## Examples

      iex> %Countries.Country{name: name} = Countries.get_by_alpha2("PL")
      iex> name
      "Poland"

      iex> Countries.get_by_alpha2("")
      nil
  """
  @spec get_by_alpha2(country_code :: String.t()) :: Country.t() | nil
  def get_by_alpha2(country_code) do
    case filter_by(:alpha2, country_code) do
      [country] -> country
      [] -> nil
    end
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
    equals_or_contains_in_list(attribute, value) || equals_or_contains_in_list(rest, value)
  end

  defp equals_or_contains_in_list(attribute, value),
    do: normalize(attribute) == normalize(value)

  defp normalize(value) do
    value
    |> to_string()
    |> String.downcase()
    |> String.replace(~r/\s+/, "")
  end

  @doc """
  Checks if country for specific attribute and value exists.

  Returns boolean.

  ## Examples

      iex> Countries.exists?(:name, "Poland")
      true

      iex> Countries.exists?(:name, "Polande")
      false

  """
  def exists?(attribute, value) do
    filter_by(attribute, value) != []
  end

  @countries Countries.Loader.load(["countries.yaml"])
             |> List.first()
             |> Enum.flat_map(fn code ->
               Countries.Loader.load(["countries", "#{code}.yaml"])
             end)
             |> Enum.map(fn [{_country, data}] -> Country.cast(data) end)

  defp countries, do: @countries
end
