defmodule App.Index do
  @moduledoc false

  def init(req, state) do
    req =
      :cowboy_req.reply(
        200,
        %{"content-type" => "plain/text"},
        "Current node: #{inspect(node())}\nConnected nodes: #{inspect(Node.list())}",
        req
      )

    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
