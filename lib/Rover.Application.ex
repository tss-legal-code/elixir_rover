defmodule Rover.Application do
  use Application

  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Registry, [keys: :unique, name: Rover.Registry]}, id: :rover_registry),
      Supervisor.child_spec({Registry, [keys: :duplicate, name: Socket.Registry]}, id: :socket_registry),
      Supervisor.child_spec({RoverSupervisor, []}, id: RoverSupervisor),
      Supervisor.child_spec({WorldMap, []}, []),
      Plug.Adapters.Cowboy.child_spec(:http, Rover.Web.Router, [],
        port: 3000,
        dispatch: dispatch()
      )
    ]

    opts = [strategy: :one_for_one, name: Application.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def dispatch(key, message) do
    Registry.dispatch(Socket.Registry, key, fn entries ->
      for {pid, _} <- entries do
        send(pid, message)
      end
    end)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws", Rover.Web.WsServer, []},
         {:_, Plug.Adapters.Cowboy.Handler, {Rover.Web.Router, []}}
       ]}
    ]
  end

end
