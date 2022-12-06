defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  def run(data_file, :part1) do
    {:ok, data} = File.read(data_file)
    l = String.to_charlist(data)
    signal(l, 0, Enum.take(l, 4), 4)
  end

  def run(data_file, :part2) do
    {:ok, data} = File.read(data_file)
    l = String.to_charlist(data)
    signal(l, 0, Enum.take(l, 14), 14)
  end

  defp signal([], _c, _marker, _m_length) do
    raise "No signal found"
  end

  defp signal([_el | rest], c, marker, m_length) do
    case Enum.uniq(marker) do
      ^marker -> c+length(marker)
      _ -> signal(rest, c+1, Enum.take(rest, m_length), m_length)
    end
  end
end
