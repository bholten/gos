defmodule GameOfStones.MixProject do
  use Mix.Project

  def project do
    [
      app: :game_of_stones,
      version: "0.1.0",
      elixir: "~> 1.7",
      escript: [
        main_module: GameOfStones.Client
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: { GameOfStones.Application, [] } # Callback module
    ]
  end

  defp deps do
    [
      {:colors, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end
end
