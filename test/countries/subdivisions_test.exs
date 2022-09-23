defmodule Countries.SubdivisionsTest do
  use ExUnit.Case, async: true

  test "get country subdivisions" do
    country = List.first(Countries.filter_by(:alpha2, "BR"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 27

    country = List.first(Countries.filter_by(:alpha2, "AD"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 7

    country = List.first(Countries.filter_by(:alpha2, "AI"))
    assert Enum.count(Countries.Subdivisions.all(country)) == 14
  end
end
