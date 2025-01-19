defmodule Games do
  @moduledoc """
  This will be the hub for choosing a game.

  Current games are:
    RockPaperScissors
    GuessingGame
  """

  @doc """

  """
  def game_validate(choice) do
    current_games = ["rockpaperscissors", "guessinggame"]

    if choice in current_games do
      choice
    else
      choose_game()
    end
  end

  def choose_game do
    IO.gets("Please choose a game:
    Rock Paper Scissors
    Guessing Game\n")
    |> string_normalization()
    |> game_validate()
  end

  def again_validate(choice) do
    again_choices = ["y", "n"]

    if choice in again_choices do
      choice
    else
      play_again?()
    end
  end

  def play_again? do
    choice = IO.gets("Would you like to play an other game? y/n\n")
    choice = string_normalization(choice)
    choice = again_validate(choice)

    if choice == "y" do
      start()
    end
  end

  def string_normalization(string) do
    String.trim(string)
    |> String.downcase()
    |> String.replace(" ", "")
  end

  def start do
    game = choose_game()
    game_validate(game)
    cond do
      game == "guessinggame" -> Games.GuessingGame.play()
      game == "rockpaperscissors" -> Games.RockPaperScissors.play()

    end
    play_again?()
  end
end
