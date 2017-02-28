defmodule PlugPlaygroundTest do
  
  use ExUnit.Case, async: true
  use Plug.Test

  doctest PlugPlayground

  @opts PlugPlayground.Router.init([])
  @valid_id 123
  @invalid_id "abc"
  @out_of_range_id 9999


  test "/ returns index" do
    # Create test connections
    conn = conn(:get, "/")

    # Invoke the plug
    conn = PlugPlayground.Router.call(conn, @opts)

    # Assert response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Welcome"
  end


  test "bad route returns 404" do
    conn = conn(:get, "/sfaasldj")
    conn = PlugPlayground.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end


  test "valid project id returns project info" do
    conn = conn(:get, "project/#{@valid_id}")
    conn = PlugPlayground.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Got project with id: #{@valid_id}"
  end
  

  test "not found project id returns 404" do
    id = @out_of_range_id
    conn = conn(:get, "project/#{id}")
    conn = PlugPlayground.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Project with id: #{id} not found"
  end
  
    
  test "invalid id returns 404 and error message" do
    conn = conn(:get, "/project/#{@invalid_id}")
    conn = PlugPlayground.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end


  test "api urls return json" do
    conn = conn(:get, "/api/v1/projects")
    conn = PlugPlayground.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    {"content-type", value} = List.keyfind(conn.resp_headers, "content-type", 0)
    assert value == "application/json; charset=utf-8"
  end
  
    
   
  
  
end
