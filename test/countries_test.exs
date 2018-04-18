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
    countries = Countries.filter_by(:unofficial_names, "Reino Unido")
    assert Enum.count(countries) == 1

    countries = Countries.filter_by(:unofficial_names, "Vereinigtes Königreich")
    assert Enum.count(countries) == 1
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
    countries = Countries.all
    assert Enum.count(countries) == 249
  end

  test "get country subdivisions" do
    country = List.first(Countries.filter_by(:alpha2, "BR"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 27

    country = List.first(Countries.filter_by(:alpha2, "AD"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 7

    country = List.first(Countries.filter_by(:alpha2, "AI"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 0
  end

  test "checks if country exists" do
    country_exists = Countries.exists?(:name, "Poland")
    assert country_exists == true

    country_exists = Countries.exists?(:name, "Polande")
    assert country_exists == false
  end
end
