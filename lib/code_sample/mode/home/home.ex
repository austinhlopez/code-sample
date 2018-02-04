defmodule CodeSample.Mode.Home do
  @behaviour CodeSample.Mode.Home.API

  @moduledoc """
    A Mode handles a specific set of commands. It evaluates a
    string input passed to it from the Host. It may create
    some side effect along the way, like adding a record to
    a database or rendering a map tile. Its result is packaged
    and returned to the Host, and it returns messages that
    teach and guide the User.
  """

  @impl true
  def new(host_pid, host_module \\ CodeSample.Host) do
    CodeSample.Mode.Home.Server.start_link()
  end

  @impl true
  def eval(server, input) do
    GenServer.call(server, {:eval, input})
  end
end