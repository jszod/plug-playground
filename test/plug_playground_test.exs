defmodule PlugPlaygroundTest do
  
  use ExUnit.Case, async: true
  use Plug.Test

  doctest PlugPlayground

  @opts PlugPlayground.Router.init([])
  @valid_id 123
  @invalid_id "abc"


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
    id = @valid_id
    conn = conn(:get, "project/#{id}/error")
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
  
   
  
  
end
