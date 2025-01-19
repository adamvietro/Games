defmodule Games do
  @moduledoc """
  This will be a guessing game that will have a user guess a number from
  1 - 10

  added
  1. Re-Attempt
  2. Too Low/High
  3. Limited attempts
  """

  @doc """

  """
  def random_number() do
    Enum.random(1..10) |> Integer.to_string()
  end

  def user_guess do
    IO.gets("Guess a number between 1 and 10: ") |> String.trim()
  end

  def number_of_guesses do
    Enum.random(1..10)
  end

  # def user_input_incorrect do
  #   IO.gets("Incorrect!\nEnter your guess: ") |> String.trim()
  # end

  def too_low do
    IO.gets("Too low!\nEnter your guess: ") |> String.trim()
  end

  def too_high do
    IO.gets("Too high!\nEnter your guess: ") |> String.trim()
  end

  def test_guess(guess, answer, number_of) do
    cond do
      guess == answer ->
        IO.puts("You win!")

      number_of == 0 ->
        IO.puts("You lose! the answer was #{answer}")

      guess > answer and number_of > 0 ->
        guess = too_high()
        test_guess(guess, answer, number_of - 1)

      guess < answer and number_of > 0 ->
        guess = too_low()
        test_guess(guess, answer, number_of - 1)
    end
  end

  def play do
    IO.puts("Let's play a game. I'll pick a number and a random number of guesses, can you figure it out?")
    answer = random_number()
    number_of = number_of_guesses()
    guess = user_guess()


    test_guess(guess, answer, number_of)
  end
end
