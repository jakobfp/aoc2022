defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  def run(data_file) do
    {:ok, data} = File.read(data_file)
    String.trim(data)
    |> String.split("\n")
    |> Enum.map(&parse_round/1)
    |> Enum.map(&calc_point/1)
    |> calc_sum()
  end

  defp calc_sum([]) do
    0
  end

  defp calc_sum([head | tail]) do
    head + calc_sum(tail)
  end

  defp points(:win) do 6 end
  defp points(:tie) do 3 end
  defp points(:loose) do 0 end

  defp weapon(:rock) do 1 end
  defp weapon(:paper) do 2 end
  defp weapon(:scissors) do 3 end

  defp calc_point(%{op: :rock, me: :rock}) do points(:tie) + weapon(:rock) end
  defp calc_point(%{op: :paper, me: :rock}) do points(:loose) + weapon(:rock) end
  defp calc_point(%{op: :scissors, me: :rock}) do points(:win) + weapon(:rock) end
  defp calc_point(%{op: :rock, me: :paper}) do points(:win) + weapon(:paper) end
  defp calc_point(%{op: :paper, me: :paper}) do points(:tie) + weapon(:paper) end
  defp calc_point(%{op: :scissors, me: :paper}) do points(:loose) + weapon(:paper) end
  defp calc_point(%{op: :rock, me: :scissors}) do points(:loose) + weapon(:scissors) end
  defp calc_point(%{op: :paper, me: :scissors}) do points(:win) + weapon(:scissors) end
  defp calc_point(%{op: :scissors, me: :scissors}) do points(:tie) + weapon(:scissors) end

  defp parse_round(round) do
    [op, me] = String.split(round, " ")
    %{op: parse_op(op), me: parse_me(me)}
  end

  defp parse_op("A") do :rock end
  defp parse_op("B") do :paper end
  defp parse_op("C") do :scissors end
  defp parse_me("X") do :rock end
  defp parse_me("Y") do :paper end
  defp parse_me("Z") do :scissors end

end
