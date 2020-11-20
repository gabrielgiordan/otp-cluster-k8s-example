defmodule App.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  get "/nodes" do
    send_resp(
      conn,
      200,
      json(%{
        current_node: Node.self(),
        connected_nodes: Node.list()
      })
    )
  end

  get _ do
    send_resp(conn, 404, "")
  end

  defp json(term), do: Jason.encode!(term)
end
