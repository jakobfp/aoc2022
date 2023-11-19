defmodule Day5Test do
  use ExUnit.Case

  test "part1" do
    assert Day5.run("data/test", :part1) == 'CMZ'
  end

  test "part2" do
    assert Day5.run("data/test", :part2) == 'MCD'
  end
end
