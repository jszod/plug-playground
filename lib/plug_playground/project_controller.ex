defmodule PlugPlayground.ProjectController do
  @moduledoc """
  Controller to handle Project routes
  """

  alias PlugPlayground.Project
  alias Plug.Conn
  

  @doc """
  Simplistic expamle of getting some kind of project from an external Project module
  """
  @spec get_project(Plug.Conn.t, String.t) :: Plug.Conn
  def get_project(conn, project_id) do
    case is_valid_project_id_format(project_id) do
      true ->
	_get_project(conn, String.to_integer(project_id))

      false ->
	Conn.resp(conn, 404, "Oops, project id should be an integer")
    end
  end


  def get_projects(conn, :json) do
    case Project.get_projects() do
      {:ok, projects} ->
	{:ok, projects_json} = Poison.encode(projects)
	Conn.resp(conn, 200, projects_json)

      {:error, message} -> Conn.resp(conn, 404, message)
    end
  end
  
    


  #
  # Private functions
  #
  defp _get_project(conn, project_id) do
    case Project.get_project(project_id) do
      {:ok, _} ->
	Conn.resp(conn, 200, "Got project with id: #{project_id}")

      {:error, message} ->
	Conn.resp(conn, 404, message)
    end
  end
  
  
  defp is_valid_project_id_format(string) do
    string =~ ~r/^[0-9]*$/ 
  end
  
end

