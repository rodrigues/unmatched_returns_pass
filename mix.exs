defmodule UnmatchedReturnsPass.MixProject do
  use Mix.Project

  def project do
    [
      app: :unmatched_returns_pass,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer()
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
      {:dialyxir, "~> 1.0", only: [:dev, :test]}
    ]
  end

  defp dialyzer do
    [
      plt_add_deps: :apps_direct,
      plt_add_apps: [:ex_unit],
      flags: [
        :error_handling,
        :race_conditions,
        :specdiffs,
        :unmatched_returns,
        :underspecs
      ]
    ]
  end
end
