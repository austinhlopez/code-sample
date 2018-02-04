defmodule CodeSample.Mode.HomeTest do
  use CodeSampleWeb.ConnCase

  alias CodeSample.Mode.Home

  test "The home mode returns some message of some format" do
    {:ok, host} = CodeSample.Host.Mock.new("fake_socket", 
    {:ok, home} = Home.new(host, CodeSample.Host.Mock)

    {:reply, evaluation, []} =  Home.eval("home")

    assert evaluation == "Hi! Here's the code sample. Type in #commands and enter."
  end
end