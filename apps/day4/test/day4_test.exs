defmodule Day4Test do
  use ExUnit.Case

  test "part1" do
    assert Day4.run("data/test", :part1) == 2
  end

  test "part2" do
    assert Day4.run("data/test", :part2) == 4
  end

end
