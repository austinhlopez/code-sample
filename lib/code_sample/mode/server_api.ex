defmodule CodeSample.Mode.Server.API do
  @callback handle_call({:eval, input :: any}, from :: pid(), state :: any) :: {:reply, reply :: any, state :: any}
end
