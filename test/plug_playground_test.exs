defmodule PlugPlaygroundTest do
  use ExUnit.Case, async: true
  use Plug.Test

  doctest PlugPlayground

  @opts PlugPlayground.Router.init([])

  test "the truth" do
    assert 1 + 1 == 2
  end

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
  
end
