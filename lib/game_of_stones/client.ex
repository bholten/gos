defmodule GameOfStones.Client do
  def main(argv) do
    parse(argv) |> play
  end

  def parse(arguments) do
    {opts, _, _} = OptionParser.parse(arguments, switches: [stones: :integer])
    opts |> Keyword.get(:stones, Application.get_env(:game_of_stones, :default_stones))
  end

  def play(initial_stones_num \\ 30) do
    # GameOfStones.Server.start(initial_stones_num)
    # start_game!()
    case GameOfStones.Server.set_stones(initial_stones_num) do
      {player, current_stones, :game_in_progress} ->
        IO.puts "Welcome! It's player #{player}'s turn. There are #{current_stones} stones." |> Colors.green
      {player, current_stones, :game_continue} ->
        IO.puts "Continuing the game. It's player #{player}'s turn! There are #{current_stones} stones left!"
    end

    take()
  end

  defp take() do
    case GameOfStones.Server.take(ask_stones()) do
      {:next_turn, next_player, stones_count} ->
        IO.puts "\nPlayer #{next_player}'s turn next. Stones: #{stones_count}"
        take()
      {:winner, winner} ->
        IO.puts "\nPlayer #{winner} has won!"
      {:error, reason} ->
        IO.puts "\nThere was an error: #{reason}"
        take()
    end
  end

  defp ask_stones do
    IO.gets("\nPlease take from 1 to 3 stones:\n") |>
      String.trim |>
      Integer.parse |>
      stones_to_take()
  end

  defp stones_to_take({count, _}), do: count
  defp stones_to_take(:error), do: 0

end
