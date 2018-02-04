defmodule CodeSample.Mode.Home do
  use GenServer

  @behaviour CodeSample.Mode.Server.API

  @moduledoc """
    The Home Mode is the Root, Origin, or Default Mode.
    When a User first requests content from CodeSample,
    that User is presented with a Host who offers
    the list of commands that make up the Home Mode.

    The Home mode provides top-level commands for
    traversing CodeSample.
  """

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    {:ok, state}
  end

  @impl true
  def handle_call({:eval, input}, from, state) do
    {:reply, eval(input), state}
  end  

  @home "Hi! Here's the code sample. Type in #commands and enter."  
  @commands "Type #home to repeat the home message. Try #join:codesample to enter a chatroom entitled 'chatroom'"
  
  def eval(input) do
    reply = case input do
	      "#home" ->
		@home
	      "#commands" ->
		@commands
              "#join:" <> chatroom ->
		 "Welcome to " <> chatroom
	      _ ->
		"Sorry, I don't understand that command. Type  #commands, then enter."	
    end
  end
end