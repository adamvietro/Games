defmodule Games.Wordle do
  @moduledoc """
  This is a Wordle game. Start the game and you will be asked for a 5 letter word.

  There is a edge case that isn't part of the check yet. It will not check to see if
  you have more than the number of letters for a given character

  ie:
    iex> Games.Wordle.feedback("aaabb", "xaaaa")
    [:grey, :green, :green, :yellow, :yellow]
    instead of
    [:grey, :green, :green, :yellow, :grey]


  """

  @doc """
  Generates the random word for the Wordle game.
  """
  @spec word_generator() :: String.t()
  def word_generator do
    Enum.random([
      "rimer",
      "hemal",
      "barde",
      "soree",
      "clown",
      "menow",
      "stoke",
      "bruin",
      "vault",
      "posse",
      "sable",
      "saiva",
      "loups",
      "amain",
      "faint",
      "fanon",
      "poulp",
      "lowly",
      "hyads"
    ])
  end

  @doc """
  Asks for a user input and validates the input.
  """
  @spec user_guess() :: String.t()
  def user_guess do
    IO.gets("Please enter a 5 letter word: ")
    |> String.trim()
    |> String.downcase()
    |> guess_validation()
  end

  @doc """
  Checks to make sure the user has entered a 5 letter word.
  """
  @spec guess_validation(String.t()) :: String.t()
  def guess_validation(guess) do
    if String.length(guess) != 5 do
      user_guess()
    else
      guess
    end
  end

  @doc """
  Creates a list of :green, :yellow: :grey for each letter compared to the answer.
  """
  @spec feedback(String.t(), String.t()) :: [atom()]
  def feedback(answer, guess) do
    answer =
      answer
      |> String.codepoints()
      |> Enum.with_index()

    guess =
      guess
      |> String.codepoints()
      |> Enum.with_index()

    Enum.reduce(guess, [], fn {letter, index}, acc ->
      cond do
        {letter, index} in answer ->
          [:green | acc]

        {letter} in answer ->
          [:yellow | acc]

        true ->
          [:grey | acc]
      end
    end)
    |> Enum.reverse()
    |> IO.inspect()
  end

  @doc """
  Starts the Wordle game.
  """
  @spec play() :: :ok
  def play do
    answer = word_generator()
    guess = user_guess()
    guesses_left = 5
    play_loop(answer, guess, guesses_left)
  end

  @doc """
  Starts the loop to keep asking for a 5-letter word will guesses left run out or
  user guesses the right word.
  """
  @spec play_loop(String.t(), String.t(), integer()) :: any()
  def play_loop(answer, guess, guesses_left) do
    cond do
      guesses_left > 0 and answer != guess ->
        feedback(answer, guess)
        guess = user_guess()
        play_loop(answer, guess, guesses_left - 1)

      guesses_left > 0 and answer == guess ->
        feedback(answer, guess)

      guesses_left == 0 ->
        IO.puts("Ran out of guesses... The word was #{answer}.")
    end
  end
end
