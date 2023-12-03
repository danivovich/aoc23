defmodule Aoc2023 do
  @moduledoc """
  Initial module for Advent of Code 2023
  """

  @doc """
  Welcome to AOC 2023

  ## Examples

      iex> Aoc2023.year()
      2023

  """
  def year do
    2023
  end

  defmodule SharedMap do
    use GenServer

    @name __MODULE__

    def start_link(_info) do
      start()
    end

    def start(default \\ %{}) do
      GenServer.start(__MODULE__, default, name: @name)
    end

    def set(key, value) do
      GenServer.cast(@name, {:set, key, value})
    end

    def get(key) do
      GenServer.call(@name, {:get, key})
    end

    def keys do
      GenServer.call(@name, {:keys})
    end

    def clear do
      GenServer.cast(@name, {:clear})
    end

    def print(width, height) do
      GenServer.cast(@name, {:print, width, height})
    end

    def print(x, xprime, y, yprime) do
      GenServer.cast(@name, {:print, x, xprime, y, yprime})
    end

    def init(args) do
      {:ok, Enum.into(args, %{})}
    end

    def handle_cast({:set, key, value}, state) do
      {:noreply, Map.put(state, key, value)}
    end

    def handle_cast({:clear}, _state) do
      {:noreply, %{}}
    end

    def handle_cast({:print, width, height}, state) do
      IO.puts("")

      Range.new(0, height - 1)
      |> Enum.map(fn row ->
        Range.new(0, width - 1)
        |> Enum.map(fn col ->
          state[{row, col}]
        end)
        |> Enum.join(",")
      end)
      |> Enum.join("\n")
      |> IO.puts()

      {:noreply, state}
    end

    def handle_cast({:print, x, xprime, y, yprime}, state) do
      IO.puts("")

      Range.new(y, yprime)
      |> Enum.each(fn row ->
        Range.new(x, xprime)
        |> Enum.map(fn col ->
          state[{col, row}] || "."
        end)
        |> Enum.join("")
        |> IO.puts()
      end)

      {:noreply, state}
    end

    def handle_call({:get, key}, _from, state) do
      {:reply, state[key], state}
    end

    def handle_call({:keys}, _from, state) do
      {:reply, Map.keys(state), state}
    end
  end
end
