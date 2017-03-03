defmodule PlugPlayground.APIRouter do
  @moduledoc """
  Routing for API urls
  """

  use Plug.Router
  require Logger

  alias PlugPlayground.ProjectController

  @module __MODULE__

  plug :match
  plug :dispatch

  get "/projects" do
    conn
    |> ProjectController.get_projects(:json)
    |> respond
  end


  match _ do
    Logger.info("#{@module}: no route for #{conn.request_path}")
    send_resp(conn, 404, "Oops")
  end

  
  defp respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp
  end

end

  
