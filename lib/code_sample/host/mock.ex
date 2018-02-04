defmodule CodeSample.Host.Mock do
  @behaviour CodeSample.Host.API

  @impl true
  def new(socket, home_mode_module) do
    {:ok, spawn(fn -> end)}
  end

  @impl true
  def push_to_user(server, message) do
    send server, message
  end

  @impl true
  def interpret_user_message(server, message) do
    {:ok, "mock"}
  end
end