defmodule Countries.Subdivisions do

  def all(country) do
    subdivisions(country.alpha2)
  end

  # Ensure :yamerl is running
  Application.start(:yamerl)

  defp subdivisions(country_code) do
    data_path = fn(path) ->
      Path.join("data", path) |> Path.expand(__DIR__)
    end

    try do
      data_path.("subdivisions/#{country_code}.yaml") |> :yamerl.decode_file |> List.first
    catch
      _exception -> []
    end
  end

end
