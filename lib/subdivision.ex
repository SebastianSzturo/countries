defmodule Countries.Subdivision do
  @moduledoc """
  Country Subdivision struct.
  """

  defstruct [:id, :name, :unofficial_names, :translations, :geo]
end
