defmodule PlugPlayground.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  @module __MODULE__
  
  #
  # Routes
  #
  get "/", do: send_resp(conn, 200, "Welcome")

  get "/project/:project_id" do
    try do
      id = String.to_integer(project_id)
	conn
	|> controller_get_project(id)
	|> respond
    rescue
      e in ArgumentError -> send_resp(conn, 404, "Oops, project id should be an integer")
    end
  end


  get "/project/:project_id/error" do
    conn
    |> controller_get_project(project_id, :return_error)
    |> respond
  end

  
  match _ do
    Logger.info("#{@module}: no route for #{conn.request_path}")
    send_resp(conn, 404, "Oops")
  end
  


  #
  # Controller functions
  #
  defp controller_get_project(conn, project_id, opts \\ [])  do
    conn = 
      case get_project(project_id, opts) do
	{:ok, _} ->
	  Plug.Conn.resp(conn, 200, "Got project with id: #{project_id}")
	{:error, message} ->
    	  Plug.Conn.resp(conn, 404, message)
      end
  end

  
  defp respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp
  end


  #
  # mock  external app/module functions
  #
  defp get_project(project_id, opts \\ [])
  defp get_project(project_id, opts) when opts == :return_error do
    Logger.info("#{@module}: get_project: :return_error")
    {:error, "Project with id: #{project_id} not found"}
  end
  
  defp get_project(project_id, opts) do
    Logger.info("#{@module}: get_project - project_id: #{project_id}") 
    {:ok, "Got project with ids: #{project_id}"}
  end


end
