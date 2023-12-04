defmodule Day01 do
  @moduledoc """
  AOC2023 Day 1
  """

  def part1 do
    "inputs/day01_input.txt"
    |> File.stream!()
    |> Stream.map(fn line ->
      matches =
        Regex.scan(~r/\d/, line)
        |> List.flatten()

      String.to_integer(List.first(matches) <> List.last(matches))
    end)
    |> Enum.sum()
  end

  def part2 do
    matcher = ~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/

    "inputs/day01_input.txt"
    |> File.stream!()
    |> Stream.map(fn line ->
      matches =
        Regex.scan(matcher, line, capture: :all_but_first)
        |> List.flatten()
        |> Enum.map(fn
          "one" -> "1"
          "two" -> "2"
          "three" -> "3"
          "four" -> "4"
          "five" -> "5"
          "six" -> "6"
          "seven" -> "7"
          "eight" -> "8"
          "nine" -> "9"
          input -> input
        end)

      String.to_integer(List.first(matches) <> List.last(matches))
    end)
    |> Enum.sum()
  end
end
