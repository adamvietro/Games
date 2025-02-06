defmodule Games.RockPaperScissors do
  @moduledoc """
  This will be a Rock Paper Scissors game, with input from the user
  and a random choice from the computer.
  """

  @spec computer_choice() :: String.t()
  defp computer_choice do
    Enum.random(["rock", "paper", "scissors"])
  end

  @spec user_choice() :: String.t()
  defp user_choice do
    valid_choices = ["rock", "paper", "scissors"]
    input = IO.gets("Choose rock, paper, or scissors: ") |> String.trim() |> String.downcase()

    if input in valid_choices do
      input
    else
      user_choice()
    end
  end

  @spec table_check(String.t(), String.t()) :: binary()
  defp table_check(player, computer) do
    winning_pairs = [["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]

    if [player, computer] in winning_pairs do
      IO.puts("You win! #{player} beats #{computer}.\n")
      true
    else
      IO.puts("You lose! #{computer} beats #{player}.\n")
      false
    end
  end

  @spec winner?(String.t(), String.t()) :: binary()
  defp winner?(equal, equal) do
    IO.puts("it's a tie!\n")
    false
  end

  @spec winner?(String.t(), String.t()) :: binary()
  defp winner?(player, computer) do
    table_check(player, computer)
  end

  @doc """
  Starts the Rock Paper scissors game.
  """
  @spec play() :: binary()
  def play do
    player = user_choice()
    computer = computer_choice()

    winner?(player, computer)
  end
end
