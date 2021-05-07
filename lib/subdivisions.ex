defmodule Countries.Subdivisions do
  @moduledoc """
  Module for providing subdivisions related functions.
  """

  import Countries.Utils, only: [to_map: 1]
  alias Countries.Subdivision

  @doc """
  Returns all subvidisions by country.

  ## Examples

      iex> country = Countries.get("PL")
      iex> Countries.Subdivisions.all(country)

  """
  def all(country) do
    country.alpha2
    |> subdivisions()
    |> Enum.map(&convert_subdivision/1)
  end

  defp convert_subdivision({id, attrs}) do
    Enum.reduce(attrs, %Subdivision{id: id}, fn {attribute, value}, subdivision ->
      with attribute = List.to_atom(attribute) do
        Map.put(subdivision, attribute, convert_value(attribute, value))
      end
    end)
  end

  defp convert_value(_, :null),
    do: nil

  defp convert_value(:unofficial_names, names),
    do: Enum.map(names, &to_string/1)

  defp convert_value(:translations, names),
    do: to_map(names)

  defp convert_value(:geo, values),
    do: to_map(values)

  defp convert_value(_, value) when is_list(value),
    do: to_string(value)

  defp convert_value(_, value),
    do: value

  # Ensure :yamerl is running
  Application.start(:yamerl)

  defp subdivisions(country_code) do
    data_path = fn path ->
      # Path.join("data", path) |> Path.expand(__DIR__)
      Path.join([:code.priv_dir(:countries), "data"] ++ path)
    end

    try do
      data_path.(["subdivisions", "#{country_code}.yaml"])
      |> :yamerl.decode_file()
      |> List.first()
    catch
      _exception -> []
    end
  end
end
