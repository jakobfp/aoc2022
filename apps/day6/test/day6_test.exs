defmodule Day6Test do
  use ExUnit.Case

  test "part1" do
    assert Day6.run("data/test", :part1) == 7
  end

  test "part2" do
    assert Day6.run("data/test", :part2) == 19
  end
end
