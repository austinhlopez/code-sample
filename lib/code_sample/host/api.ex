defmodule CodeSample.Host.API do
  @callback new(socket :: Phoenix.Socket.t(), mode_module :: module()) :: {:ok, pid()}
  @callback push_to_user(server :: pid(), message :: binary()) :: any()
  @callback interpret_user_message(server :: pid(), message :: binary()) :: any()
end
