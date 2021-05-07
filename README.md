# Countries

[![Build Status](https://travis-ci.org/SebastianSzturo/countries.svg?branch=master)](https://travis-ci.org/SebastianSzturo/countries)
[![Module Version](https://img.shields.io/hexpm/v/countries.svg)](https://hex.pm/packages/countries)
[![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/countries/)
[![Total Download](https://img.shields.io/hexpm/dt/countries.svg)](https://hex.pm/packages/countries)
[![License](https://img.shields.io/hexpm/l/countries.svg)](https://github.com/yyy/countries/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/SebastianSzturo/countries.svg)](https://github.com/SebastianSzturo/countries/commits/master)

Countries is a collection of all sorts of useful information for every country in the [ISO 3166](https://en.wikipedia.org/wiki/ISO_3166) standard.
It is based on the data from the Ruby Gem [Countries](https://github.com/hexorx/countries).

## Installation

```elixir
defp deps do
  [
    {:countries, "~> 1.6"}
  ]
end
```

After you are done, run ```mix deps.get``` in your shell to fetch and compile countries.

## Usage

Find country by attribute:

```elixir
country = Countries.filter_by(:alpha2, "DE")
# [%Countries.Country{alpha2: 'DE', alpha3: 'DEU', continent: 'Europe',
#	 country_code: '49', currency: 'EUR', ...]

countries = Countries.filter_by(:region, "Europe")
Enum.count(countries)
# 51
```

Get all countries:

```elixir
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

## Copyright and License

Copyright (c) 2015 Sebastian Szturo

This software is licensed under [the MIT license](./LICENSE.md).
