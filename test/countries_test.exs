defmodule CountriesTest do
  use ExUnit.Case, async: true

  test "filter countries by alpha2" do
    country = Countries.filter_by(:alpha2, "DE")
    assert Enum.count(country) == 1
  end

  test "filter countries by name" do
    countries = Countries.filter_by(:name, "United Kingdom of Great Britain and Northern Ireland")
    assert Enum.count(countries) == 1
  end

  test "filter countries by alternative names" do
    assert [_] = Countries.filter_by(:unofficial_names, "Reino Unido")

    assert [_] = Countries.filter_by(:unofficial_names, "The United Kingdom")
  end

  test "get one country" do
    %{alpha2: "GB"} = Countries.get("GB")
  end

  test "filter many countries by region" do
    countries = Countries.filter_by(:region, "Europe")
    assert Enum.count(countries) == 51
  end

  test "return empty list when there are no results" do
    countries = Countries.filter_by(:region, "Azeroth")
    assert countries == []
  end

  test "get all countries" do
    countries = Countries.all()
    assert Enum.count(countries) == 250
  end

  test "get country subdivisions" do
    country = List.first(Countries.filter_by(:alpha2, "BR"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 27

    country = List.first(Countries.filter_by(:alpha2, "AD"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 7

    country = List.first(Countries.filter_by(:alpha2, "AI"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 14
  end

  test "checks if country exists" do
    country_exists = Countries.exists?(:name, "Poland")
    assert country_exists == true

    country_exists = Countries.exists?(:name, "Polande")
    assert country_exists == false
  end
end
