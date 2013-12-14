defmodule ExagotchiServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exagotchi_server,
      version: "0.0.1",
      deps: deps(Mix.env)
    ]
  end

  def application do
    [
      applications: [],
      mod: {ExagotchiServer, []}
    ]
  end

  defp deps(:prod) do
    [
      { :exactor, github: "sasa1977/exactor" },
      { :exagotchi, github: "knewter/exagotchi" },
      { :uuid, github: "okeuday/uuid" },
      { :weber, github: "0xAX/weber" }
    ]
  end

  defp deps(:test) do
    deps(:prod) ++ [{ :hackney, github: "benoitc/hackney" }]
  end

  defp deps(_) do
    deps(:prod)
  end

end
