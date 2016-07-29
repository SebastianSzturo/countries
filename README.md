## Countries :earth_africa:
[![Build Status](https://travis-ci.org/SebastianSzturo/countries.svg?branch=master)](https://travis-ci.org/SebastianSzturo/countries)

Countries is a collection of all sorts of useful information for every country in the [ISO 3166](https://en.wikipedia.org/wiki/ISO_3166) standard.
It is based on the data from the ruby gem [Countries](https://github.com/hexorx/countries).

## Installation
As the current version of ``yamerl`` at hex.pm is not working correctly, we have to add the dependencies ``yamerl`` and ``countries`` manually from github to our ``mix.exs``.

```Elixir
defp deps do
  [{:yamerl, github: "yakaz/yamerl"},
   {:countries, github: "SebastianSzturo/countries"}]
end
```

After you are done, run ```mix deps.get``` in your shell to fetch and compile countries.

## Usage

Find country by attribute.

```Elixir
country = Countries.filter_by(:alpha2, "DE")
# [%Countries.Country{alpha2: 'DE', alpha3: 'DEU', continent: 'Europe',
#	 country_code: '49', currency: 'EUR', ...]

countries = Countries.filter_by(:region, "Europe")
Enum.count(countries)
# 51
```

Get all Countries.

```Elixir
countries = Countries.all
Enum.count(countries)
# 250
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
