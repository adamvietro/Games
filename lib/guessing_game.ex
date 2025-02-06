defmodule Games.GuessingGame do
  @moduledoc """
  This is the module for the Guessing game.

  This is meant to have a user guess a random number from
  1 - 10
  """

  @spec random_number() :: integer()
  defp random_number() do
    Enum.random(1..10)
  end

  @doc """
  Asks the user for a number from 1 - 10.
  """
  @spec user_guess() :: integer()
  def user_guess do
    IO.gets("Guess a number between 1 and 10: ") |> String.trim() |> String.to_integer()
  end

  @spec number_of_guesses() :: integer()
  defp number_of_guesses do
    Enum.random(1..5)
  end

  @spec too_low() :: integer()
  defp too_low do
    IO.gets("Too low!\nEnter your guess: ") |> String.trim() |> String.to_integer()
  end

  @spec too_high() :: integer()
  defp too_high do
    IO.gets("Too high!\nEnter your guess: ") |> String.trim() |> String.to_integer()
  end

  @spec test_guess(String.t(), String.t(), integer()) :: binary()
  defp test_guess(guess, answer, number_of) do
    cond do
      guess == answer ->
        IO.puts("You win!\n")
        true

      number_of == 0 ->
        IO.puts("You lose! the answer was #{answer}\n")
        false

      guess > answer and number_of > 0 ->
        guess = too_high()
        test_guess(guess, answer, number_of - 1)

      guess < answer and number_of > 0 ->
        guess = too_low()
        test_guess(guess, answer, number_of - 1)
    end
  end

  @doc """
  Starts the guessing game.
  """
  @spec play() :: binary()
  def play do
    IO.puts(
      "Let's play a game. I'll pick a number and a random number of guesses, can you figure it out?\n"
    )

    answer = random_number()
    number_of = number_of_guesses()
    guess = user_guess()

    test_guess(guess, answer, number_of)

  end
end
