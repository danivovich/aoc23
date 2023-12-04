defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "checks part 1" do
    assert Day01.part1() == 55_447
  end

  test "checks part 2" do
    assert Day01.part2() == 54_706
  end
end
