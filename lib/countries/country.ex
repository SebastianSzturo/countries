defmodule Countries.Country do
  @moduledoc """
  Country struct.
  """
  alias Countries.{Geo, Loader}

  @type bound_cardinal_points() :: :northeast | :southwest

  @ignored_fields [
    'latitude',
    'longitude',
    'min_longitude',
    'max_longitude',
    'min_latitude',
    'max_latitude',
    'latitude_dec',
    'longitude_dec'
  ]

  @type t :: %__MODULE__{
          number: String.t(),
          alpha2: String.t(),
          alpha3: String.t(),
          currency_code: String.t() | nil,
          alt_currency: String.t() | nil,
          name: String.t(),
          unofficial_names: [String.t()],
          continent: String.t(),
          region: String.t(),
          subregion: String.t(),
          geo:
            %{
              bounds: %{
                bound_cardinal_points() => %{lat: float(), lng: float()}
              },
              latitude: float(),
              latitude_dec: String.t(),
              longitude: float(),
              longitude_dec: String.t(),
              max_latitude: float(),
              max_longitude: float(),
              min_latitude: float(),
              min_longitude: float()
            }
            | nil,
          world_region: String.t(),
          country_code: String.t(),
          national_destination_code_lengths: [pos_integer()],
          national_number_lengths: [pos_integer()],
          international_prefix: String.t(),
          national_prefix: String.t(),
          ioc: String.t() | nil,
          gec: String.t() | nil,
          un_locode: String.t(),
          languages_official: [String.t()] | nil,
          languages_spoken: [String.t()],
          nationality: String.t(),
          address_format: String.t() | nil,
          dissolved_on: String.t() | nil,
          eu_member: boolean() | nil,
          eea_member: boolean() | nil,
          postal_code: boolean(),
          start_of_week: String.t() | nil,
          unofficial_names: [String.t()],
          vat_rates:
            %{
              parking: nil | pos_integer() | float(),
              reduced: [pos_integer() | float()],
              standard: pos_integer() | float(),
              super_reduced: nil | pos_integer() | float()
            }
            | nil,
          nanp_prefix: String.t() | nil
        }

  defstruct [
    :number,
    :alpha2,
    :alpha3,
    :currency_code,
    :alt_currency,
    :name,
    :unofficial_names,
    :continent,
    :region,
    :subregion,
    :geo,
    :world_region,
    :country_code,
    :national_destination_code_lengths,
    :national_number_lengths,
    :international_prefix,
    :national_prefix,
    :ioc,
    :gec,
    :un_locode,
    :languages_official,
    :languages_spoken,
    :nationality,
    :address_format,
    :dissolved_on,
    :eu_member,
    :eea_member,
    :vat_rates,
    :postal_code,
    :start_of_week,
    :nanp_prefix
  ]

  @doc """
  Cast the input property list from yamerl into the Country struct handled
  by this module.
  """
  @spec cast(properlist :: [{charlist(), term()}]) :: t()
  def cast([{_, _} | _] = proplist) do
    proplist =
      proplist
      |> Enum.map(&cast_attrib/1)
      |> Enum.reject(&is_nil/1)

    struct(__MODULE__, proplist)
  end

  defp cast_attrib({'number', value}), do: {:number, to_string(value)}
  defp cast_attrib({'alpha2', value}), do: {:alpha2, Loader.normalize(value)}
  defp cast_attrib({'alpha3', value}), do: {:alpha3, Loader.normalize(value)}
  defp cast_attrib({'currency', value}), do: {:currency_code, Loader.normalize(value)}
  defp cast_attrib({'currency_code', value}), do: {:currency_code, Loader.normalize(value)}
  defp cast_attrib({'name', value}), do: {:name, Loader.normalize(value)}

  defp cast_attrib({'unofficial_names', values}),
    do: {:unofficial_names, Enum.map(values, &Loader.normalize/1)}

  defp cast_attrib({'names', values}),
    do: {:unofficial_names, Enum.map(values, &Loader.normalize/1)}

  defp cast_attrib({'continent', value}), do: {:continent, Loader.normalize(value)}
  defp cast_attrib({'region', value}), do: {:region, Loader.normalize(value)}
  defp cast_attrib({'subregion', value}), do: {:subregion, Loader.normalize(value)}
  defp cast_attrib({'geo', value}), do: {:geo, Geo.cast(value)}
  defp cast_attrib({'world_region', value}), do: {:world_region, Loader.normalize(value)}
  defp cast_attrib({'country_code', value}), do: {:country_code, Loader.normalize(value)}

  defp cast_attrib({'national_destination_code_lengths', values}),
    do: {:national_destination_code_lengths, values}

  defp cast_attrib({'national_number_lengths', values}), do: {:national_number_lengths, values}

  defp cast_attrib({'international_prefix', value}),
    do: {:international_prefix, to_string(value)}

  defp cast_attrib({'national_prefix', value}), do: {:national_prefix, Loader.normalize(value)}
  defp cast_attrib({'ioc', value}), do: {:ioc, Loader.normalize(value)}
  defp cast_attrib({'gec', value}), do: {:gec, Loader.normalize(value)}
  defp cast_attrib({'un_locode', value}), do: {:un_locode, Loader.normalize(value)}

  defp cast_attrib({'languages_official', values}),
    do: {:languages_official, Enum.map(values, &Loader.normalize/1)}

  defp cast_attrib({'languages_spoken', values}),
    do: {:languages_spoken, Enum.map(values, &Loader.normalize/1)}

  defp cast_attrib({'languages', values}),
    do: {:languages_spoken, Enum.map(values, &Loader.normalize/1)}

  defp cast_attrib({'nationality', value}), do: {:nationality, Loader.normalize(value)}
  defp cast_attrib({'address_format', value}), do: {:address_format, Loader.normalize(value)}
  defp cast_attrib({'dissolved_on', value}), do: {:dissolved_on, Loader.normalize(value)}
  defp cast_attrib({'eu_member', value}), do: {:eu_member, Loader.normalize(value)}
  defp cast_attrib({'eea_member', value}), do: {:eea_member, Loader.normalize(value)}
  defp cast_attrib({'alt_currency', value}), do: {:alt_currency, Loader.normalize(value)}
  defp cast_attrib({'vat_rates', value}), do: {:vat_rates, cast_vat(value)}
  defp cast_attrib({'postal_code', value}), do: {:postal_code, Loader.normalize(value)}
  defp cast_attrib({'start_of_week', value}), do: {:start_of_week, Loader.normalize(value)}
  defp cast_attrib({'nanp_prefix', value}), do: {:nanp_prefix, Loader.normalize(value)}
  defp cast_attrib({field, _value}) when field in @ignored_fields, do: nil

  defp cast_vat(values), do: values
end
