defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  def run(data_file, :part2) do
    {:ok, data} = File.read(data_file)
    String.trim(data)
    |> String.split("\n")
    |> Enum.map(&item_set/1)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [items1, items2, items3] ->
      MapSet.intersection(items1, items2)
      |> MapSet.intersection(items3)
      |> MapSet.to_list()
    end)
    |> List.flatten()
    |> Enum.reduce({0, []}, &sum_prio/2)
  end

  def run(data_file, :part1) do
    {:ok, data} = File.read(data_file)
    String.trim(data)
    |> String.split("\n")
    |> Enum.map(&separate_items_per_compartment/1)
    |> Enum.map(fn {items1, items2} -> MapSet.intersection(items1, items2) |> MapSet.to_list() end)
    |> List.flatten()
    |> Enum.reduce({0, []}, &sum_prio/2)
  end

  defp sum_prio({prio, item}, {prio_sum, items}) do
    {prio_sum + prio, [item | items]}
  end
 
  defp separate_items_per_compartment(items) when rem(byte_size(items), 2) == 0 do
    l = String.length(items)
    {items1, items2} = String.split_at(items, div(l,2))
    {item_set(items1), item_set(items2)}
  end

  defp separate_items_per_compartment(items) do
    raise "#{items} not separatable into two compartments"
  end

  defp item_set(items) do
    String.to_charlist(items)
    |> Enum.map(&prioritize_item/1)
    |> MapSet.new()
  end

  defp prioritize_item(item) when item in ?a..?z do
    {item - ?a + 1, List.to_string([item])}
  end

  defp prioritize_item(item) when item in ?A..?Z do
    {item - ?A + 27, List.to_string([item])}
  end

end
