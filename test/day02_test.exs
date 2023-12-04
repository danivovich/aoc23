defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "checks part 1" do
    assert Day02.part1() == 2_105
  end

  test "checks part 2" do
    assert Day02.part2() == 72_422
  end
end
