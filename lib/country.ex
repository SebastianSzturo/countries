defmodule Countries.Country do
  defstruct [:number, :alpha2, :alpha3, :currency, :name, :names,
            :latitude, :longitude, :continent, :region, :subregion,
            :world_region, :country_code, :national_destination_code_lengths,
            :national_number_lengths, :international_prefix, :national_prefix,
            :address_format, :ioc, :gec, :un_locode, :languages, :nationality,
            :address_format, :dissolved_on, :eu_member, :alt_currency, :vat_rates,
            :postal_code, :min_longitude, :min_latitude, :max_longitude, :max_latitude,
            :latitude_dec, :longitude_dec]
end
