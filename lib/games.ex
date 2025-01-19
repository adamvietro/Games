defmodule Games do
  @moduledoc """
  This will be a guessing game that will have a user guess a number from
  1 - 10
  """
  alias Logger.Backends.Internal

  @doc """

  """
  def random_number() do
    Enum.random(1..10) |> Integer.to_string()
  end

  def user_input do
    IO.gets("Guess a number between 1 and 10: ") |> String.trim()
  end

  def user_input_incorrect do
    IO.gets("Incorrect!\nEnter your guess: ") |> String.trim()
  end

  def too_low do
    IO.gets("Too low!\nEnter your guess: ") |> String.trim()
  end

  def too_high do
    IO.gets("Too high!\nEnter your guess: ") |> String.trim()
  end

  def test_guess(guess, answer) do
    cond do
      guess == answer -> "You win!"
      guess > answer ->
        guess = too_high()
        test_guess(guess, answer)
      guess < answer ->
        guess = too_low()
        test_guess(guess, answer)
    end
  end

  def play do
    answer = random_number()
    guess = user_input()
    # IO.inspect(answer, label: "answer")
    # IO.inspect(guess, label: "guess")

    test_guess(guess, answer)
  end
end
