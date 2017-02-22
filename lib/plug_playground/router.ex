defmodule PlugPlayground.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/", do: send_resp(conn, 200, "Welcome")

  get "/storymap/:project_id" do
    conn
    |> get_story_map(project_id)
    |> respond
  end
  
  match _, do: send_resp(conn, 404, "Oops")



  defp get_story_map(conn, project_id) do
    Plug.Conn.assign(conn, :response, "get story map with id: #{project_id}")
  end


  defp respond(conn) do
    body = conn.assigns[:response]
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, body)
  end
  
  
end
