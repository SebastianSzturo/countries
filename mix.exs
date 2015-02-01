defmodule Countries.Mixfile do
  use Mix.Project
  
  def project do
    [app: :country,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end
  
  def application do
    [applications: [:logger, :yamerl]]
  end
  
  defp deps do
    [{:yamerl, git: "https://github.com/yakaz/yamerl.git"}]
  end
end
