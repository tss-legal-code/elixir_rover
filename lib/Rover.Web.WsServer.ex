defmodule Rover.Web.WsServer do
  @behaviour :cowboy_websocket_handler
  @timeout 5 * 60_000
  @registration_key "ws_server"

  def init(_, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def send_message_to_client(_rover, message) do
    Rover.Application.dispatch("#{@registration_key}", message)
  end

  def websocket_init(_type, req, _opts) do
    {:ok, _} = Registry.register(Socket.Registry, "#{@registration_key}", [])
    state = %{}
    {:ok, req, state, @timeout}
  end

  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
end
