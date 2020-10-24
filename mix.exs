defmodule ExorBechmark.MixProject do
  use Mix.Project

  def project do
    [
      app: :exor_bechmark,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bloomex, "~> 1.2.0"},
      {:blex, "~> 0.2"},
      {:erbloom, "~> 2.1.0-rc.2"},
      {:exor_filter, github: "mpope9/exor_filter", tag: "v0.5.2"},
      {:benchee, github: "bencheeorg/benchee", branch: "main", override: true},
      {:benchee_html, "~> 1.0", only: :dev}

      ## TODO: ebloom, nif, is too out of date to compile?
      #{:ebloom, github: "basho/ebloom"},
    ]
  end
end
