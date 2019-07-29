defmodule WebSocketChat do
  
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: WebSocketChat.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      ),
      Registry.child_spec(
          keys: :duplicate,
          name: Registry.WebSocketChat
        )
    ]

    opts = [strategy: :one_for_one, name: WebSocketChat.Application]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
        [
          {"/ws/[...]", WebSocketChat.SocketHandler, []},
          {:_, Plug.Cowboy.Handler, {WebSocketChat.Router, []}}
        ]
      }
    ]
  end
end
