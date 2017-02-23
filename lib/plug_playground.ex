defmodule PlugPlayground do
  @moduledoc """
  Documentation for PlugPlayground.
  """

  use Application
  require Logger

  @module __MODULE__
  
  @doc """
  Hello world.

  ## Examples

      iex> PlugPlayground.hello
      :world

  """
  def hello do
    :world
  end

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, PlugPlayground.Router, [], port: 8080)
    ]

    Logger.info("#{@module}: Started")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
  
end
