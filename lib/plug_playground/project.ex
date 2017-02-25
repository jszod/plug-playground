defmodule PlugPlayground.Project do
  require Logger

  
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
