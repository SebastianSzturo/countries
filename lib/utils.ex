defmodule Countries.Utils do

  @alpha2_chars Enum.to_list(?A..?Z)
  @ris_offset 127397
  @deprecated_alpha2 ['AN', 'BU', 'CS', 'DD', 'FX', 'NT', 'QU', 'SU', 'TP', 'YD', 'YU', 'ZR']

  def convert_alpha2_to_flag_emoji(alpha2) when alpha2 in @deprecated_alpha2,
    do: nil
  def convert_alpha2_to_flag_emoji([char1, char2])
    when char1 in @alpha2_chars and char2 in @alpha2_chars,
    do: to_string([char1 + @ris_offset, char2 + @ris_offset])
  def convert_to_flag_emoji(_), do: nil

  def to_map([item | _] = values) when is_tuple(item),
    do: Enum.reduce(values, Map.new, fn ({key, value}, acc) ->
      Map.put(acc, key |> to_string() |> String.to_atom(), to_map(value))
    end)
  def to_map(value) when is_list(value), do: to_string(value)
  def to_map(value), do: value
end
