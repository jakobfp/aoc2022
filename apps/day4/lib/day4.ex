defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def run(data_file, part) do
    {:ok, data} = File.read(data_file)
    String.trim(data)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.filter(&(duplicate_work?(&1, part)))
    |> Enum.count()
  end

  defp duplicate_work?({sections1, sections2}, part) do
    {s1, e1} = section_range(sections1)
    {s2, e2} = section_range(sections2)
    overlap?(s1, e1, s2, e2, part)
  end

  defp overlap?(s1, e1, s2, e2, :part1) do
    (s2 <= s1 && e1 <= e2) || (s1 <= s2 && e2 <= e1)
  end

  defp overlap?(s1, e1, s2, e2, :part2) do
    (s1 <= e2 && s2 <= e1) || (s2 <= e1 && s1 <= e2)
  end

  defp section_range(sections) do
    String.split(sections, "-")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
