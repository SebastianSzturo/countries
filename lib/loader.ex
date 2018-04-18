defmodule Countries.Loader do
  @moduledoc false

  import Countries.Utils, only: [to_map: 1]
  alias Countries.Country

  @data_path Path.expand("data", __DIR__)

  # loads all country data from our yaml files
  # :yamerl returns a really terrible data structure
  #    [[{'name', 'Germany'}, {'code', 'DE'}], [{'nam:e', 'Austria'}, {'code', 'AT'}]]
  # We need to transform that to maps:
  #    [%{name: "Germany', code: "DE"}, %{name: 'Austria', code: "AT"}]
  def load do
    data_path("countries.yaml")
    |> :yamerl.decode_file
    |> List.first
    |> Enum.flat_map(fn code ->
         "countries/#{code}.yaml"
         |> data_path()
         |> :yamerl.decode_file
       end)
    |> Enum.flat_map(fn countries ->
      Enum.map(countries, fn {_, values} -> values end)
    end)
    |> Enum.map(&convert_country/1)
  end

  defp data_path(path) do
    Path.join(@data_path, path)
  end

  defp convert_country(country_data) do
     Enum.reduce(country_data, %Country{}, fn({attribute, value}, country) ->
       with attribute = List.to_atom(attribute) do
         Map.put(country, attribute, convert_value(attribute, value))
       end
     end)
  end

  @do_not_convert ~w[national_number_lengths national_destination_code_lengths]a

  defp convert_value(_, :null),
    do: nil

  defp convert_value(:vat_rates, vat_rates) when not is_nil(vat_rates) do
    Map.new(vat_rates, fn
      {key, :null}       -> {List.to_atom(key), nil}
      {key, value}       -> {List.to_atom(key), value}
    end)
  end

  defp convert_value(:unofficial_names, names),
    do: Enum.map(names, &to_string/1)

  defp convert_value(:geo, values),
    do: to_map(values)

  defp convert_value(attribute, value)
    when is_list(value) and not attribute in @do_not_convert,
    do: to_string(value)

  defp convert_value(_, value),
    do: value
end
