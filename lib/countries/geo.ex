defmodule Countries.Geo do
  @moduledoc """
  The information about geoposition that could be found in `Countries.Country`
  and in `Countries.Subdivisions.Subdivision` is defined and handled in this
  module.

  This is available only the action for `cast/1` that is casting the values
  inside of a map. The result is like this:

  ```
  %{
    "bounds" => [
      %{"northeast" => %{"lat" => 43.8504, "lng" => 4.6362}},
      %{"southwest" => %{"lat" => 27.4985, "lng" => -18.2648001}}
    ],
    "latitude" => 40.46366700000001,
    "latitude_dec" => "40.396026611328125",
    "longitude" => -3.74922,
    "longitude_dec" => "-3.550692558288574",
    "max_latitude" => 43.8504,
    "max_longitude" => 4.6362,
    "min_latitude" => 27.4985,
    "min_longitude" => -18.2648001
  }
  ```
  """

  @type bounds_map() :: %{String.t() => %{String.t() => float()}}
  @type t() :: %{String.t() => float() | String.t() | bounds_map()}

  @type bounds_value() :: [{charlist(), [{charlist(), float()}]}]

  @doc """
  The input expected for this function is a property list which is
  a list of 2-element tuples where the key is a charlist element and
  the value could be or a float or another charlist element.

  For example:

  ```
  [
    {'bounds', [
      {'northeast', [{'lat', 43.8504}, {'lng', 4.6362}]},
      {'southwest', [{'lat', 27.4985}, {'lng', -18.2648001}]}
    ]},
    {'latitude', 40.46366700000001},
    {'latitude_dec', "40.396026611328125"},
    {'longitude', -3.74922},
    {'longitude_dec', "-3.550692558288574"},
    {'max_latitude', 43.8504},
    {'max_longitude', 4.6362},
    {'min_latitude', 27.4985},
    {'min_longitude', -18.2648001}
  ]
  ```
  """
  @spec cast(values :: [{charlist(), charlist() | float() | bounds_value()}]) :: t()
  def cast(values) do
    Enum.map(values, fn
      {'latitude', value} ->
        {"latitude", value}

      {'latitude_dec', value} ->
        {"latitude_dec", to_string(value)}

      {'longitude', value} ->
        {"longitude", value}

      {'longitude_dec', value} ->
        {"longitude_dec", to_string(value)}

      {'max_latitude', value} ->
        {"max_latitude", value}

      {'max_longitude', value} ->
        {"max_longitude", value}

      {'min_latitude', value} ->
        {"min_latitude", value}

      {'min_longitude', value} ->
        {"min_longitude", value}

      {'bounds', data} ->
        bounds =
          Enum.map(data, fn {cardinal_point, lat_lng} ->
            lat_lng = Map.new(lat_lng)

            %{
              to_string(cardinal_point) => %{
                "lat" => lat_lng['lat'],
                "lng" => lat_lng['lng']
              }
            }
          end)

        {"bounds", bounds}
    end)
    |> Enum.reject(&is_nil/1)
    |> Map.new()
  end
end
