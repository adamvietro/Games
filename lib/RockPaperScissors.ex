defmodule Games.RockPaperScissors do
  @moduledoc """
  This will be a Rock Paper Scissors game, with input from the user
  and random input from the computer.
  """

  @doc """
  # Ai Choice: Paper
  Choose rock, paper, or scissors: scissors
  "You win! scissors beats paper."

  # Ai Choice: Scissors
  Choose rock, paper, or scissors: paper
  "You lose! scissors beats paper."

  # Ai Choice: Rock
  Choose rock, paper, or scissors: rock
  "It's a tie!"
  """
  def computer_choice do
    Enum.random(["rock", "paper", "scissors"])
  end

  def user_choice do
    valid_choices = ["rock", "paper", "scissors"]
    input = IO.gets("Choose rock, paper, or scissors: ") |> String.trim() |> String.downcase()

    if input in valid_choices do
      input
    else
      user_choice()
    end
  end

  def table_check(player, computer) do
    winning_pairs = [["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]

    if [player, computer] in winning_pairs do
      IO.puts("You win! #{player} beats #{computer}.")
    else
      IO.puts("You lose! #{computer} beats #{player}.")
    end
  end

  def winner?(equal, equal) do
    IO.puts("it's a tie!")
  end

  def winner?(player, computer) do
    table_check(player, computer)
  end

  def play do
    player = user_choice()
    computer = computer_choice()

    winner?(player, computer)
  end
end
