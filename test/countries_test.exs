defmodule CountriesTest do
  use ExUnit.Case, async: true
  doctest Countries

  describe "all/0" do
    test "get all countries" do
      countries = Countries.all()
      assert Enum.count(countries) == 250
    end
  end

  describe "get_by_alpha2/1" do
    test "gets one country" do
      assert %{alpha2: "GB"} = Countries.get_by_alpha2("GB")
    end

    test "not found country" do
      assert is_nil(Countries.get_by_alpha2(""))
    end
  end

  describe "exists?/2" do
    test "checks if country exists" do
      assert Countries.exists?(:name, "Poland")
      refute Countries.exists?(:name, "Polande")
    end
  end

  describe "filter_by/2" do
    test "return empty list when there are no results" do
      countries = Countries.filter_by(:region, "Azeroth")
      assert countries == []
    end

    test "filters countries by alpha2" do
      [%{alpha3: "DEU"}] = Countries.filter_by(:alpha2, "DE")
      [%{alpha3: "SMR"}] = Countries.filter_by(:alpha2, "sm")
    end

    test "filters countries by alpha3" do
      [%{alpha2: "VC"}] = Countries.filter_by(:alpha3, "VCT")
      [%{alpha2: "HU"}] = Countries.filter_by(:alpha3, "hun")
    end

    test "filters countries by name" do
      [%{alpha2: "AW"}] = Countries.filter_by(:name, "Aruba")
      [%{alpha2: "EE"}] = Countries.filter_by(:name, "estonia")
    end

    test "filter countries by unofficial names" do
      [%{alpha2: "GB"}] = Countries.filter_by(:unofficial_names, "Reino Unido")
      [%{alpha2: "GB"}] = Countries.filter_by(:unofficial_names, "The United Kingdom")
      [%{alpha2: "US"}] = Countries.filter_by(:unofficial_names, "États-Unis")
      [%{alpha2: "US"}] = Countries.filter_by(:unofficial_names, "アメリカ合衆国")
      [%{alpha2: "RU"}] = Countries.filter_by(:unofficial_names, "Россия")
      [%{alpha2: "LB"}] = Countries.filter_by(:unofficial_names, "لبنان")
    end

    test "filters countries with basic string sanitization" do
      [%{alpha2: "PR"}] = Countries.filter_by(:name, "\npuerto    rico \n   ")

      countries = Countries.filter_by(:subregion, "WESTERNEUROPE")
      assert Enum.count(countries) == 9
    end

    test "filters many countries by region" do
      countries = Countries.filter_by(:region, "Europe")
      assert Enum.count(countries) == 51
    end

    test "filters by official language" do
      countries = Countries.filter_by(:languages_official, "EN")
      assert Enum.count(countries) == 92
    end

    test "filters by integer attributes" do
      countries = Countries.filter_by(:national_number_lengths, 10)
      assert Enum.count(countries) == 59

      countries = Countries.filter_by(:national_destination_code_lengths, "2")
      assert Enum.count(countries) == 200
    end
  end
end
