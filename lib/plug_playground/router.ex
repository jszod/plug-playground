defmodule PlugPlayground.Router do
  use Plug.Router
  require Logger

  alias PlugPlayground.ProjectController

  plug :match
  plug :dispatch

  @module __MODULE__
  
  #
  # Routes
  #
  get "/", do: send_resp(conn, 200, "Welcome")

  get "/project/:project_id", do: ProjectController.get_project(conn, project_id)

  get "/project/:project_id/error" do
    ProjectController.get_project(conn, project_id, :return_error)
  end
  
  match _ do
    Logger.info("#{@module}: no route for #{conn.request_path}")
    send_resp(conn, 404, "Oops")
  end

  
  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp
  end


  #
  # mock  external app/module functions
  #
  def get_project(project_id, opts \\ [])
  def get_project(project_id, opts) when opts == :return_error do
    Logger.info("#{@module}: get_project: :return_error")
    {:error, "Project with id: #{project_id} not found"}
  end


  def get_project(project_id, opts) do
    Logger.info("#{@module}: get_project - project_id: #{project_id}") 
    {:ok, "Got project with ids: #{project_id}"}
  end


end
