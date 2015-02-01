defmodule CountriesTest do
  use ExUnit.Case, async: true

  test "filter countries by alpha2" do
    country = Countries.filter_by(:alpha2, "DE")
    assert Enum.count(country) == 1
  end
  
  test "filter many countries by region" do
    countries = Countries.filter_by(:region, "Europe")
    assert Enum.count(countries) == 51
  end

  test "get all countries" do 
    countries = Countries.all
    assert Enum.count(countries) == 250
  end
end
