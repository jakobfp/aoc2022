defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """
  def run(data_file) do
    {:ok, data} = File.read(data_file)
    String.split(data, "\n\n")
    |> Enum.map(&(String.split(&1, "\n")))
    |> Enum.map(&cal_sum/1)
    |> Enum.with_index()
    |> Enum.reduce({0,0}, &(cal_max(&1, &2)))
  end

  defp cal_max(el = {val, _}, {m, _}) when val > m do
    el
  end

  defp cal_max({val, _}, curr = {m, _}) when val <= m do
    curr
  end

  defp cal_sum([]) do
    0
  end

  defp cal_sum(["" | tail]) do
    0 + cal_sum(tail)
  end

  defp cal_sum([head | tail]) do
    String.to_integer(head) + cal_sum(tail)
  end
end
