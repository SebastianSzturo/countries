defmodule Countries.LoaderTest do
  use ExUnit.Case, async: true
  alias Countries.{Country, Loader}

  test "loading of ES country" do
    assert [[{'ES', country}]] = Loader.load(["countries", "ES.yaml"])
    assert %Country{alpha2: "ES"} = Country.cast(country)
  end

  test "loading all of the countries" do
    assert [[_|_] = codes|_] = Loader.load(["countries.yaml"])
    assert [[{_code, _data}] | _] = countries = Enum.flat_map(codes, fn code -> Loader.load(["countries", "#{code}.yaml"]) end)

    countries = Enum.map(countries, fn [{_country, data}] -> Country.cast(data) end)

    assert Enum.all?(countries, &is_struct(&1, Country))
  end
end
