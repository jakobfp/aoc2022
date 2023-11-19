defmodule Stack do
  use GenServer

  def init(_opts) do
    {:ok, []}
  end

  def handle_call({:move, to, how_many}, _from, stack) do
    to_send = Enum.take(stack, -how_many)
    GenServer.call(to, {:receive, to_send})
    {:reply, :ok, Enum.drop(stack, -how_many)}
  end

  def handle_call({:receive, crates}, _from, stack) do
    {:reply, :ok, stack ++ crates}
  end
end
