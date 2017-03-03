defmodule PlugPlayground.Router do
  @moduledoc """
  Router for incoming requests
  """
  
  use Plug.Router
  require Logger

  alias PlugPlayground.ProjectController
  alias PlugPlayground.APIRouter

  @module __MODULE__
  
  plug :match
  plug :dispatch


  #
  # Routes
  #
  get "/", do: send_resp(conn, 200, "Welcome")

  get "/project/:project_id" do
    conn
    |> ProjectController.get_project(project_id)
    |> respond
  end
  

  forward "/api/v1", to: APIRouter
  
  match _ do
    Logger.info("#{@module}: no route for #{conn.request_path}")
    send_resp(conn, 404, "Oops")
  end

  
  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp
  end


end
