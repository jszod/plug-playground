defmodule PlugPlayground do
  @moduledoc """
  Documentation for PlugPlayground.
  """

  use Application
  require Logger

  @module __MODULE__
  
  @doc """
  """

  def start(_type, _args) do
    port = Application.get_env(:plug_playground, :cowboy_port)
    
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, PlugPlayground.Router, [], port: port)
    ]

    Logger.info("#{@module}: Started on port #{port}")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
  
end
