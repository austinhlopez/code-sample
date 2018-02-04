defmodule CodeSample.Mode.Home.API do
  @callback new(host_pid :: pid(), host_module :: module()) :: {:ok, pid()}
  @callback eval(server :: pid(), input :: binary()) :: binary()
end