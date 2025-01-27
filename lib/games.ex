defmodule Games do
  @moduledoc """
  Start the hub with Games.start()

  This will be the hub for choosing a game.

  Current games are:
    RockPaperScissors
    GuessingGame
    Wordle
  """

  @doc """
  Not sure what to put here...
  """
  @spec game_validate(String.t()) :: :ok
  defp game_validate(choice) do
    current_games = ["rockpaperscissors", "guessinggame", "wordle"]

    if choice in current_games do
      choice
    else
      choose_game()
    end
  end

  @spec choose_game() :: String.t()
  defp choose_game do
    IO.gets("Please choose a game:
    Rock Paper Scissors
    Wordle
    Guessing Game\n")
    |> string_normalization()
    |> game_validate()
  end

  @spec again_validate(String.t()) :: :ok
  defp again_validate(choice) do
    again_choices = ["y", "n"]

    if choice in again_choices do
      choice
    else
      play_again?()
    end
  end

  @spec play_again?() :: :ok
  def play_again? do
    choice = IO.gets("Would you like to play an other game? y/n\n")
    choice = string_normalization(choice)
    choice = again_validate(choice)

    if choice == "y" do
      main(nil)
    end
  end

  @spec string_normalization(String.t()) :: String.t()
  defp string_normalization(string) do
    String.trim(string)
    |> String.downcase()
    |> String.replace(" ", "")
  end

  def main(_args) do
    game = choose_game()
    game_validate(game)
    cond do
      game == "guessinggame" -> Games.GuessingGame.play()
      game == "rockpaperscissors" -> Games.RockPaperScissors.play()
      game == "wordle" -> Games.Wordle.play()

    end
    play_again?()
  end
end
