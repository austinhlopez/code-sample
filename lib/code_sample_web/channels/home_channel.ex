defmodule CodeSampleWeb.HomeChannel do
  use Phoenix.Channel

  @moduledoc """
  HomeChannel is how a User talks to CodeSample.

  It handles input from the client and passes the message along
  to the host.

  It handles input from the host and passes the message along to the client.
  """

  alias CodeSample.Host
  alias CodeSample.Mode

  import Ecto
  require Logger

  def join("home", _message, socket) do
    send(self, {:after_join, Host})
    {:ok, socket}
  end
  
  # For the purposes of testing, the mode dependency can be passed
  # explicitly
  def join("home", %{ host: host_module }, socket) do
    send(self, {:after_join, host_module})
    {:ok, socket}
  end
  

  def handle_info({:after_join, host_module}, socket) do
    {:ok, host_server} = apply(host_module, :new, [socket])

    connected = socket |>
    assign(:host_module, host_module)
    |> assign(:host_server, host_server)

    read_eval_print(connected, %{ "body" => "#home" })
     
    {:noreply, connected}
  end

  @doc "incoming message from host. push to user"
  def handle_info({:push_to_user, msg}, socket) do
    push socket, "new:msg", msg
    {:noreply, socket}
  end

  @doc "called when the client terminates the websocket connection"
  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  @doc "handling host message, printing result to client"
  def handle_in(:host_msg, msg, socket) do
    push socket, "new:msg", %{ "body" => msg }
    {:reply, {:ok, %{msg: msg}}, socket }
  end

  @doc "incoming message from client. print command, forward to host"
  def handle_in("new:msg", msg, socket) do
    read_eval_print(socket, msg)
    {:reply, :ok, socket}
  end

  defp read_eval_print(socket, msg) do
    # read |> stout
    push socket, "new:msg", %{body: msg["body"]}
    
    # eval
    {:ok, evaluation} = apply(socket.assigns[:host_module], :interpret_user_message, [socket.assigns[:host_server], msg["body"]])

    # |> stdout
    push socket, "new:msg", %{body: evaluation}
  end
end