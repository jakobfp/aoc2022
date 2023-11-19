defmodule Day7 do
  @moduledoc """
  Documentation for `Day7`.
  """
  def run(data_file, :part1) do
    {:ok, data} = File.read(data_file)
    {directories, _} =
      String.trim(data)
      |> String.split("\n")
      |> Enum.reduce({%{}, []}, &operation/2)
    IO.inspect(directories)
    directories
    |> Enum.filter(fn {_dir, size} -> size < 100000 end)
    |> Enum.reduce(0, fn {_dir, size}, acc -> acc + size end)
  end

  defp operation("$ ls", acc) do
    IO.puts("ls")
    acc
  end
  defp operation("$ cd ..", {dir_sizes, [_current_dir | rest]}) do
    IO.puts("cd ..")
    {dir_sizes, rest}
  end
  defp operation(op, {dir_sizes, []}) do
    {:ok, cd_r} = Regex.compile("cd \([[:alnum:]/]+\)$")
    case Regex.run(cd_r, op) do
      [_, dir] ->
        IO.puts("cd #{dir}")
        case Map.has_key?(dir_sizes, dir) do
          true -> {dir_sizes, [dir]}
          false -> {Map.put(dir_sizes, dir, 0), [dir]}
        end
      nil -> raise "expecting 'cd' command"
    end
  end
  defp operation(op, {dir_sizes, dirs}) do
    {:ok, cd_r} = Regex.compile("cd \([[:alnum:]/]+\)$")
    case Regex.run(cd_r, op) do
      [_, dir] ->
        IO.puts("cd #{dir}")
        case Map.has_key?(dir_sizes, dir) do
          true -> {dir_sizes, [dir | dirs]}
          false -> {Map.put(dir_sizes, dir, 0), [dir | dirs]}
        end
      nil ->
        IO.puts(op)
        case String.starts_with?(op, "dir") do
          true -> {dir_sizes, dirs}
          false ->
            [size_str, _name] = String.split(op, " ")
            size = String.to_integer(size_str)
            dir_sizes = Enum.reduce(dirs, dir_sizes, fn dir, dir_sizes -> Map.update!(dir_sizes, dir, &(&1+size)) end)
            {dir_sizes, dirs}
        end
    end
  end
end
