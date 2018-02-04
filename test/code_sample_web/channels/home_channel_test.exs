defmodule CodeSample.HomeChannelTest do
  use CodeSampleWeb.ChannelCase

  alias Phoenix.Socket
  alias CodeSampleWeb.HomeChannel
  alias CodeSample.Host
  alias CodeSample.Mode

  setup do
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(HomeChannel, "home", %{ host: Host.Mock })

      # we need to clear the mailbox of the first 'push', which 'subscribe_and_join' engenders
      event = "new:msg"
      assert_push event, %{ body: "mock" }
      
    {:ok, socket: socket}
  end

  # testing 'join'
  test "join should assign host to the socket", %{socket: socket} do
    {:noreply, connected} = HomeChannel.handle_info({:after_join, Host.Mock}, socket)

    event = "new:msg"
    msg = %{ body: "home" }

    assert_push event, msg
    assert_push event, %{ body: "mock" }
    
    assert connected.assigns[:host_server] != nil
  end

  test "incoming host message, forwarded to client", %{socket: socket} do
    event = "new:msg"
    msg = %{ body: "home" }

    HomeChannel.handle_info({:push_to_user, msg}, socket)
  end
  
  test "client msg body is returned to client from process, then message is passed to host for evaluation, then evaluation result is pushed to client", %{socket: socket} do
    event = "new:msg"
    msg = %{ body: "#home" }
    ref = push socket, event, msg

    assert_push event, msg
    assert_push event, msg

    assert_reply ref, :ok
  end
end