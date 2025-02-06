defmodule Games do
  @moduledoc """
  Start the hub with Games.start()

  This will be the hub for choosing a game.

  Current games are:
    RockPaperScissors
    GuessingGame
    Wordle
  """

  @spec game_validate(String.t()) :: :ok
  defp game_validate(choice) do
    current_games = ["1", "2", "3", "score", "stop"]

    if choice in current_games do
      choice
    else
      choose_game()
    end
  end

  @spec choose_game() :: String.t()
  defp choose_game do
    IO.gets("What game would you like to play?
    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    enter \"stop\" to exit
    enter \"score\" to view your current score
    \n")
    |> string_normalization()
    |> game_validate()
  end

  defp display_score() do
    current_score = ScoreTracker.get_score()
    IO.puts("==================================================\nYour score is #{current_score} \n================================================== \n")
  end

  @spec string_normalization(String.t()) :: String.t()
  defp string_normalization(string) do
    String.trim(string)
    |> String.downcase()
    |> String.replace(" ", "")
  end

  def main(_args) do
    if GenServer.whereis(__MODULE__) do
      0
    else
      ScoreTracker.start_link(0)
    end

    game = choose_game()
    game_validate(game)

    case game do
      "1" ->
        if Games.GuessingGame.play() do
          ScoreTracker.add_score(5)
        end

        main(nil)

      "2" ->
        if Games.RockPaperScissors.play() do
          ScoreTracker.add_score(10)
        end

        main(nil)

      "3" ->
        if Games.Wordle.play() do
          ScoreTracker.add_score(25)
        end

        main(nil)

      "score" ->
        display_score()
        main(nil)

      "stop" ->
        IO.puts("Thanks for playing")
    end
  end
end
