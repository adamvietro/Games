defmodule Games do
  @moduledoc """
  This will be a guessing game that will have a user guess a number from
  1 - 10
  """

  @doc """

  """
  def user_input do
    IO.gets("Guess a number between 1 and 10:")
  end

  # def user_input(false) do
  #   IO.gets("Incorrect!\n Enter your guess:")
  # end

  def user_input(false) do
    "Inncorrect!"
  end

  def user_input(true) do
    "You win!"
  end

  def random_number() do
    Enum.random(1..10)
  end

  def play do
    answer = random_number()
    guess = user_input()

    cond do
      guess == answer -> user_input(true)
      true -> user_input(false)
    end
  end
end
