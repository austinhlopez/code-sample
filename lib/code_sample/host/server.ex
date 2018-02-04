defmodule CodeSample.Host.Server do
  use GenServer
  alias Phoenix.Channel
  alias CodeSample.Mode

  defstruct [:socket]

  def start_link(socket, home_mode_module) do
    GenServer.start_link(__MODULE__, [ socket, home_mode_module ])
  end

  def init([socket, home_mode_module]) do
    {:ok, home_mode} = apply(home_mode_module, :new, [ CodeSample.Host, self() ])
    server_state = %CodeSample.Host.Server{ socket: socket, home_mode_module: home_mode_module }
    { :ok, server_state }
  end

  def handle_cast({:push_to_user, msg}, state) do
    send state.socket.channel_pid, {:push_to_user, %{ body: msg } }

    {:noreply, state}
  end

  def handle_call({:interpret_user_message, message}, _, state) do
    result = apply(state.home_mode_module, :eval, [message])
    {:reply, {:ok, result}, state }
  end  
end