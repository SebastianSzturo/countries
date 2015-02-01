defmodule Countries.Mixfile do
  use Mix.Project
  
  @version "1.0.1"
  
  def project do
    [app: :countries,
     version: @version,
     elixir: "~> 1.0",
     deps: deps,
     
     # Hex
     description: description,
     package: package]
  end
  
  def application do
    [applications: [:logger, :yamerl]]
  end
  
  defp deps do
    [{:yamerl, git: "https://github.com/yakaz/yamerl.git"}]
  end
  
  defp description do
    """
    Countries is a collection of all sorts of useful information for every country in the [ISO 3166](https://de.wikipedia.org/wiki/ISO_3166) standard.
    """
  end
  
  defp package do
    [contributors: ["Sebastian Szturo"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/SebastianSzturo/countries"}]
  end
end
