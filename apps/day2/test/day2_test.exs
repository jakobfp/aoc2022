defmodule Day2Test do
  use ExUnit.Case

  test "part1" do
    assert Day2.run("data/test", :part1) == 15
  end

  test "part2" do
    assert Day2.run("data/test", :part2) == 12
  end

end
