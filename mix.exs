defmodule ExploringMars.MixProject do
  use Mix.Project

  def project do
    [
      app: :exploring_mars,
      version: "0.1.0",
      elixir: "~> 1.9",
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
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev]},
      {:uuid, "~> 1.1"}
    ]
  end
end
