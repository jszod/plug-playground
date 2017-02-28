defmodule APIRouter do
  @moduledoc """
  Routing for API urls
  """

  use Plug.Router

  alias PlugPlayground.ProjectController

  plug :match
  plug :dispatch

  get "/projects" do
    conn
    |> ProjectController.get_projects(:json)
    |> respond
  end


  defp respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp
  end

end

  
