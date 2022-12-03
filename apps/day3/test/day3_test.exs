defmodule Day3Test do
  use ExUnit.Case

  test "part1" do
    {sum_prio, _} = Day3.run("data/test", :part1)
    assert sum_prio == 157
  end

  test "part2" do
    {sum_prio, _} = Day3.run("data/test", :part2)
    assert sum_prio == 70
  end

end
