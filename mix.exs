defmodule Countries.Mixfile do
  use Mix.Project

  @source_url "https://github.com/SebastianSzturo/countries"
  @version "1.6.0"

  def project do
    [
      app: :countries,
      version: @version,
      elixir: "~> 1.12",
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:yamerl, "~> 0.10"},
      {:ex_check, "~> 0.14", only: :dev, runtime: false},
      {:doctor, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false},
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
      description: "Collection of all sorts of useful information for every country (ISO-3166)",
      maintainers: ["Sebastian Szturo", "Manuel Rubio"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/SebastianSzturo/countries",
        "ISO-3166" => "https://de.wikipedia.org/wiki/ISO_3166"
      }
    ]
  end
end
