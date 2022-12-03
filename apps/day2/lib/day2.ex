defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  def run(data_file, part) do
    {:ok, data} = File.read(data_file)
    String.trim(data)
    |> String.split("\n")
    |> Enum.map(&parse_round(&1, part))
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
  defp points(:draw) do 3 end
  defp points(:loose) do 0 end
  defp points(:rock) do 1 end
  defp points(:paper) do 2 end
  defp points(:scissors) do 3 end

  defp calc_point(%{op: :rock, me: :draw}) do points(:draw) + points(:rock) end
  defp calc_point(%{op: :paper, me: :draw}) do points(:draw) + points(:paper) end
  defp calc_point(%{op: :scissors, me: :draw}) do points(:draw) + points(:scissors) end
  defp calc_point(%{op: :rock, me: :loose}) do points(:loose) + points(:scissors) end
  defp calc_point(%{op: :paper, me: :loose}) do points(:loose) + points(:rock) end
  defp calc_point(%{op: :scissors, me: :loose}) do points(:loose) + points(:paper) end
  defp calc_point(%{op: :rock, me: :win}) do points(:win) + points(:paper) end
  defp calc_point(%{op: :paper, me: :win}) do points(:win) + points(:scissors) end
  defp calc_point(%{op: :scissors, me: :win}) do points(:win) + points(:rock) end

  defp calc_point(%{op: :rock, me: :rock}) do points(:draw) + points(:rock) end
  defp calc_point(%{op: :paper, me: :rock}) do points(:loose) + points(:rock) end
  defp calc_point(%{op: :scissors, me: :rock}) do points(:win) + points(:rock) end
  defp calc_point(%{op: :rock, me: :paper}) do points(:win) + points(:paper) end
  defp calc_point(%{op: :paper, me: :paper}) do points(:draw) + points(:paper) end
  defp calc_point(%{op: :scissors, me: :paper}) do points(:loose) + points(:paper) end
  defp calc_point(%{op: :rock, me: :scissors}) do points(:loose) + points(:scissors) end
  defp calc_point(%{op: :paper, me: :scissors}) do points(:win) + points(:scissors) end
  defp calc_point(%{op: :scissors, me: :scissors}) do points(:draw) + points(:scissors) end

  defp parse_round(round, part) do
    [op, me] = String.split(round, " ")
    %{op: parse_op(op), me: parse_me(me, part)}
  end

  defp parse_op("A") do :rock end
  defp parse_op("B") do :paper end
  defp parse_op("C") do :scissors end
  defp parse_me("X", :part1) do :rock end
  defp parse_me("Y", :part1) do :paper end
  defp parse_me("Z", :part1) do :scissors end
  defp parse_me("X", :part2) do :loose end
  defp parse_me("Y", :part2) do :draw end
  defp parse_me("Z", :part2) do :win end

end
