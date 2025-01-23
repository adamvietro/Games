defmodule Games.RockPaperScissors do
  @moduledoc """
  This will be a Rock Paper Scissors game, with input from the user
  and a random choice from the computer.
  """

  @doc """
  Picks a random choice for the computer.
  """
  @spec computer_choice() :: String.t()
  def computer_choice do
    Enum.random(["rock", "paper", "scissors"])
  end

  @doc """
  Asks a user for their choice and validates the choice.
  """
  @spec user_choice() :: String.t()
  def user_choice do
    valid_choices = ["rock", "paper", "scissors"]
    input = IO.gets("Choose rock, paper, or scissors: ") |> String.trim() |> String.downcase()

    if input in valid_choices do
      input
    else
      user_choice()
    end
  end

  @doc """
  Checks the users choice against a table of winning choice combinations.
  """
  @spec table_check(String.t(), String.t()) :: any()
  def table_check(player, computer) do
    winning_pairs = [["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]

    if [player, computer] in winning_pairs do
      IO.puts("You win! #{player} beats #{computer}.")
    else
      IO.puts("You lose! #{computer} beats #{player}.")
    end
  end

  @doc """
  Checks to see if the user choice and the computer choice are the same.
  or
  Tests the user choice against the computers choice.
  """
  @spec winner?(String.t(), String.t()) :: any()
  def winner?(equal, equal) do
    IO.puts("it's a tie!")
  end

  @spec winner?(String.t(), String.t()) :: any()
  def winner?(player, computer) do
    table_check(player, computer)
  end

  @doc """
  Starts the Rock Paper scissors game.
  """
  @spec play() :: any()
  def play do
    player = user_choice()
    computer = computer_choice()

    winner?(player, computer)
  end
end
