defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  def run(data_file, part) do
    {:ok, {procedure, stack_pids}} = parse(data_file)

    procedure
    |> String.split("\n")
    |> Enum.each(&procedure_step(&1, stack_pids, part))

    stack_pids
    |> Enum.map(fn {_k, pid} ->
      pid
      |> :sys.get_state()
      |> List.last()
    end)
  end

  defp parse(data_file) do
    {:ok, data} = File.read(data_file)
    {stacks, procedure} =
      data
      |> String.split("\n\n")
      |> List.to_tuple()

    stack_pids =
      stacks
      |> parse_stack_state()
      |> Enum.with_index()
      |> Enum.map(fn {stack, idx} ->
        {:ok, pid} = GenServer.start_link(Stack, [])
        GenServer.call(pid, {:receive, stack})
        {"#{idx+1}", pid}
      end)
      |> Enum.into(%{})

    {:ok, {procedure, stack_pids}}
  end

  defp procedure_step("", _, _), do: :ok
  defp procedure_step(order, stack_pids, part) do
    ["move", how_many, "from", from, "to", to] = String.split(order, " ")
    {how_many, ""} = Integer.parse(how_many)
    from = stack_pids[from]
    to = stack_pids[to]
    move_crates(from, to, how_many, part)
  end

  defp move_crates(from, to, how_many, :part1) do
    for _x <- 1..how_many, do: GenServer.call(from, {:move, to, 1})
  end
  defp move_crates(from, to, how_many, :part2) do
    GenServer.call(from, {:move, to, how_many})
  end

  defp parse_stack_state(stacks) do
    stacks =
      stacks
      |> String.split("\n")
    number_of_stacks =
      stacks
      |> List.last()
      |> String.trim()
      |> String.last()
      |> String.to_integer()

    empty_stacks = List.duplicate([], number_of_stacks)

    stacks
    |> Enum.drop(-1)
    |> Enum.map(&(:binary.bin_to_list(&1)))
    |> Enum.reduce(empty_stacks, &parse_elements/2)
  end

  defp parse_elements(elements, stacks) do
    {stacks, _idx} =
      elements
      |> Enum.chunk_every(4)
      |> Enum.reduce({stacks, 0}, &parse_crate/2)
    stacks
  end

  defp parse_crate('   ', {stacks, idx}) do
    {stacks, idx+1}
  end
  defp parse_crate('    ', {stacks, idx}) do
    {stacks, idx+1}
  end
  defp parse_crate(crate, {stacks, idx}) do
    {
      List.update_at(stacks, idx, fn stack ->
        [Enum.take(crate, 3) |> Enum.at(1) | stack]
      end),
      idx+1
    }
  end
end
