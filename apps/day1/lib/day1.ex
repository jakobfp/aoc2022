defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """
  def run(data_file) do
    {:ok, data} = File.read(data_file)
    elfs_sorted = String.split(data, "\n\n")
    |> Enum.map(&(String.split(&1, "\n")))
    |> Enum.map(&cal_sum/1)
    |> Enum.with_index()
    |> Enum.sort(&(sort_by_cal/2))

    {most_cals, elf_idx} = Enum.at(elfs_sorted, 0)

    {sum_three_most_cals, _three_elves} = Enum.take(elfs_sorted, 3)
    |> Enum.reduce({0, []}, &cals_of_elves/2)

    IO.puts("Elf #{elf_idx} carries the most calories: #{most_cals}")
    IO.puts("The three top elves carry #{sum_three_most_cals} calories in total")

  end

  defp cals_of_elves({cal, elf}, {cals_sum, elves}) do
    {cal + cals_sum, [elf | elves]}
  end

  defp sort_by_cal({cal1, _}, {cal2, _}) do
    cal1 >= cal2
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
