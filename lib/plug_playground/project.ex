defmodule PlugPlayground.Project do
  require Logger

  @module __MODULE__
  @max_id 999

  @spec get_project(pos_integer) :: map
  def get_project(project_id) when project_id > @max_id do
    Logger.info("#{@module}: get_project(#{project_id}) - error")
    {:error, "Project with id: #{project_id} not found"}
  end


  @spec get_project(pos_integer) :: map
  def get_project(project_id) when project_id < @max_id do
    Logger.info("#{@module}: get_project({project_id})") 
    {:ok, "Got project with ids: #{project_id}"}
  end


  @spec get_projects() :: list
  def get_projects() do
    projects = 
    [
      %{id: 1, name: "project 1"},
      %{id: 2, name: "project 2"},
      %{id: 3, name: "project 3"}
    ]
    {:ok, projects}
  end
  

end
