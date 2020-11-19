defmodule App.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  get "/health" do
    send_resp(
      conn,
      200,
      Jason.encode!(%{
        nodes: Node.list()
      })
    )
  end

  get _ do
    send_resp(conn, 404, "")
  end
end
