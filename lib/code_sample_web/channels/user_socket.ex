defmodule CodeSampleWeb.UserSocket do
  use Phoenix.Socket

  channel "home", CodeSampleWeb.HomeChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
