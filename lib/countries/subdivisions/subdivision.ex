defmodule Countries.Subdivisions.Subdivision do
  @moduledoc """
  Country Subdivision struct.
  """
  alias Countries.Geo

  @type t() :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          unofficial_names: [String.t()],
          translations: %{atom() => String.t()},
          geo: Geo.t()
        }

  defstruct [:id, :name, :unofficial_names, :translations, :geo]

  @doc """
  Cast the information received in the `yamerl` format, property lists
  where the keys are charlists and the values could be charlists, lists,
  booleans, or numbers.
  """
  def cast(proplist) do
    proplist =
      proplist
      |> Enum.map(&cast_attrib/1)
      |> Enum.reject(&is_nil/1)

    struct(__MODULE__, proplist)
  end

  defp cast_attrib({'id', value}), do: {:id, to_string(value)}
  defp cast_attrib({'name', value}), do: {:name, to_string(value)}
  defp cast_attrib({'unofficial_names', values}), do: {:unofficial_names, maybe_sublists(values)}
  defp cast_attrib({'translations', map}), do: {:translations, cast_translations(map)}
  defp cast_attrib({'geo', geo_data}), do: {:geo, Geo.cast(geo_data)}
  defp cast_attrib({_ignored_key, _value}), do: nil

  defp cast_translations(data) do
    for {language, name} <- data, into: %{} do
      {to_string(language), to_string(name)}
    end
  end

  defp maybe_sublists([[_ | _] | _] = sublists) do
    Enum.map(sublists, &to_string/1)
  end

  defp maybe_sublists([_ | _] = list), do: [to_string(list)]
end
