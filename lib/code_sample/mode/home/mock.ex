defmodule CodeSample.Mode.Home.Mock do
  use GenServer

  @behaviour CodeSample.Mode.Home.API

  @moduledoc """
  Echo simply returns the input command.

  It's a very useful test or mock, and
  may serve production purposes.
  """

  @impl true
  def new(host_pid, host_module) do
    {:ok, :mock}
  end

  @impl true
  def eval(server, input) do
    input
  end
end