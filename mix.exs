defmodule Countries.Mixfile do
  use Mix.Project

  @source_url "https://github.com/SebastianSzturo/countries"
  @version "1.6.0"

  def project do
    [
      app: :countries,
      version: @version,
      elixir: "~> 1.3",
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger, :yamerl]]
  end

  defp deps do
    [
      {:yamerl, "~> 0.7"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end

  defp package do
    [
      description:
        "Countries is a collection of all sorts of useful information for every country " <>
          "in the [ISO 3166](https://de.wikipedia.org/wiki/ISO_3166) standard.",
      maintainers: ["Sebastian Szturo"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/SebastianSzturo/countries"}
    ]
  end
end
