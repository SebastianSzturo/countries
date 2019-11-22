defmodule CountriesTest do
  use ExUnit.Case, async: true

  describe "all/0" do
    test "get all countries" do
      countries = Countries.all()
      assert Enum.count(countries) == 250
    end
  end

  describe "get/1" do
    test "gets one country" do
      %{alpha2: "GB"} = Countries.get("GB")
    end
  end

  describe "exists?/2" do
    test "checks if country exists" do
      country_exists = Countries.exists?(:name, "Poland")
      assert country_exists == true

      country_exists = Countries.exists?(:name, "Polande")
      assert country_exists == false
    end
  end

  describe "filter_by/2" do
    test "return empty list when there are no results" do
      countries = Countries.filter_by(:region, "Azeroth")
      assert countries == []
    end

    test "filters countries by alpha2" do
      country = Countries.filter_by(:alpha2, "DE")
      assert Enum.count(country) == 1
    end

    test "filters countries by alpha3" do
      country = Countries.filter_by(:alpha3, "VCT")
      assert Enum.count(country) == 1
    end

    test "filters countries by name" do
      country = Countries.filter_by(:name, "Aruba")
      assert Enum.count(country) == 1
    end

    test "filter countries by unofficial names" do
      assert [_] = Countries.filter_by(:unofficial_names, "Reino Unido")
      assert [_] = Countries.filter_by(:unofficial_names, "The United Kingdom")
      assert [_] = Countries.filter_by(:unofficial_names, "États-Unis")
      assert [_] = Countries.filter_by(:unofficial_names, "アメリカ合衆国")
      assert [_] = Countries.filter_by(:unofficial_names, "Россия")
      assert [_] = Countries.filter_by(:unofficial_names, "لبنان")
    end

    test "filters countries with basic string sanitization" do
      assert [_] = Countries.filter_by(:name, "\npuerto    rico \n   ")

      countries = Countries.filter_by(:subregion, "WESTERNEUROPE")
      assert Enum.count(countries) == 9
    end

    test "filters many countries by region" do
      countries = Countries.filter_by(:region, "Europe")
      assert Enum.count(countries) == 51
    end

    test "filters by official language" do
      countries = Countries.filter_by(:languages_official, "EN")
      assert Enum.count(countries) == 48
    end

    test "filters by integer attributes" do
      countries = Countries.filter_by(:national_number_lengths, 10)
      assert Enum.count(countries) == 59

      countries = Countries.filter_by(:national_destination_code_lengths, "2")
      assert Enum.count(countries) == 200
    end
  end

  test "get country subdivisions" do
    country = List.first(Countries.filter_by(:alpha2, "BR"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 27

    country = List.first(Countries.filter_by(:alpha2, "AD"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 7

    country = List.first(Countries.filter_by(:alpha2, "AI"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 14
  end
end
