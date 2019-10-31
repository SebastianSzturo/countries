defmodule Countries.Mixfile do
  use Mix.Project

  @version "1.6.0"

  def project do
    [
      app: :countries,
      version: @version,
      elixir: "~> 1.3",
      deps: deps(),

      # Hex
      source_url: "https://github.com/SebastianSzturo/countries",
      description: description(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger, :yamerl]]
  end

  defp deps do
    [
      {:yamerl, "~> 0.7"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Countries is a collection of all sorts of useful information for every country in the [ISO 3166](https://de.wikipedia.org/wiki/ISO_3166) standard.
    """
  end

  defp package do
    [
      maintainers: ["Sebastian Szturo"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/SebastianSzturo/countries"}
    ]
  end
end
