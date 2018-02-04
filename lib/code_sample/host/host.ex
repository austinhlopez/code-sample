defmodule CodeSample.Host do
  @behaviour CodeSample.Host.API

  @moduledoc """
    A Host is an Agent which corresponds between a User (via
    messages passed over the User's Home Channel) and deeper
    CodeSample functionality.

    A Host forwards calls to various Modes to respond to the commands
    of Users, decoupling the mechanism for passing commands between
    User and CodeSample from the evaluation of the commands themselves.
  """

  @impl true
  def new(socket, home_mode_module \\ Mode.Home) do
    CodeSample.Host.Server.start_link(socket, home_mode_module)
  end

  @impl true
  def push_to_user(server, message) do
    GenServer.cast(server, {:push_to_user, message})
  end

  @impl true
  def interpret_user_message(server, message) do
    GenServer.call(server, {:interpret_user_message, message})
  end
end