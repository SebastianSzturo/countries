defmodule Countries do
  alias Countries.Country, as: Country

  @doc """
  Returns all countries.
  """
  def all do
    countries
  end

  @doc """
  Filters countries by given attribute.
  Returns a List of %Country{}

  ## Examples
    iex> Countries.filter_by(:region, "Europe")
    [%Countries.Country{address_format: nil, alpha2: 'VA' ...
  """
  def filter_by(attribute, value) do
    Enum.filter(countries, fn(country) ->
      value_as_char_list = to_char_list(value)
      country[attribute] == value_as_char_list
    end)
  end

  defp countries do
    # Lets load all country data from our yaml files
    codes = List.first(:yamerl.decode_file(data_path "countries.yaml"))
    country_data =
      Enum.reduce(codes, [], fn (code, countries) ->
        countries ++ :yamerl.decode_file(data_path "countries/#{code}.yaml")
      end)

    # :yamerl returns a really terrible data structure
    #    [[{'name', 'Germany'}, {'code', 'DE'}], [{'nam:e', 'Austria'}, {'code', 'AT'}]]
    # We need to transform that to maps:
    #    [%{name: 'Germany', code: "DE"}, %{name: 'Austria', code: "AT"}]
    countries =
      Enum.reduce(country_data, [], fn (country_data, countries) ->
        country =
          Enum.reduce(country_data, %Country{}, fn({key, value}, country) ->
            key_as_atom = String.to_atom(to_string key)
            Map.put(country, key_as_atom, value)
          end)

        List.insert_at(countries, 0, country)
      end)
  end

  defp data_path(path) do
    Path.join("data", path) |> Path.expand(__DIR__)
  end
end
