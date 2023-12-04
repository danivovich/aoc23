defmodule Day02 do
  @max %{"red" => 12, "green" => 13, "blue" => 14}

  def part1 do
    "inputs/day02_input.txt"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.map(&max_cubes/1)
    |> Enum.reduce(0, fn {id, cubes}, acc ->
      possible? =
        Enum.reduce_while(cubes, true, fn {color, count}, _ ->
          if count > @max[color], do: {:halt, false}, else: {:cont, true}
        end)

      if possible?, do: acc + id, else: acc
    end)
  end

  def part2 do
    "inputs/day02_input.txt"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.map(&max_cubes/1)
    |> Enum.reduce(0, fn {_id, cubes}, acc_power ->
      power = Map.values(cubes) |> Enum.reduce(1, &Kernel.*/2)
      acc_power + power
    end)
  end

  defp max_cubes({id, sets}) do
    max_cubes =
      Enum.reduce(sets, %{}, fn set, acc ->
        Map.merge(set, acc, fn _color, count1, count2 -> max(count1, count2) end)
      end)

    {id, max_cubes}
  end

  defp parse_line(line) do
    ["Game " <> id, rest_of_line] = String.trim(line) |> String.split(": ")

    cube_sets =
      String.split(rest_of_line, "; ")
      |> Enum.map(fn cube_set ->
        String.split(cube_set, ", ")
        |> Enum.into(%{}, fn cubes ->
          [count, color] = String.split(cubes, " ")
          {color, String.to_integer(count)}
        end)
      end)

    {String.to_integer(id), cube_sets}
  end
end
