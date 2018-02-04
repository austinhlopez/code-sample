defmodule CodeSample.HostTest do
  use CodeSampleWeb.ChannelCase

  alias CodeSample.Host
  alias CodeSample.Mode

  test "Host new returns a pid" do
    socket = socket("user_id", %{})    
    {:ok, hid} = Host.new(socket, Mode.Home.Mock)
    
    assert hid != nil
  end

  test "Host push_to_user function sends a :forward_to_client message to the socket channel_id" do
    socket = %{ socket("user_id", %{}) | channel_pid: self() }
    {:ok, hid} = Host.new(socket)

    Host.push_to_user(hid, "Hello")

    assert_receive {:push_to_user, %{ body: "Hello" } }
  end

  test "The interpret_user_message method passes the message along to the mode's evaluate function" do
    socket = socket("user_id", %{})
    {:ok, hid} = Host.new(socket, Mode.Home.Mock)

    reply = Host.interpret_user_message(hid, "#commands")

    assert reply == {:ok, "#commands"}
  end
end