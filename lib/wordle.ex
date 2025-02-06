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

  @spec user_guess() :: String.t()
  defp user_guess do
    IO.gets("\nPlease enter a 5 letter word: ")
    |> String.trim()
    |> String.downcase()
    |> guess_validation()
  end

  @spec guess_validation(String.t()) :: String.t()
  defp guess_validation(guess) do
    if String.length(guess) != 5 do
      user_guess()
    else
      guess
    end
  end

  @spec feedback(String.t(), String.t()) :: [atom()]
  defp feedback(answer, guess) do
    answer =
      answer
      |> String.codepoints()

    answer_pair =
      answer
      |> Enum.with_index()

    guess =
      guess
      |> String.codepoints()
      |> Enum.with_index()

    Enum.reduce(guess, [], fn {letter, index}, acc ->
      cond do
        {letter, index} in answer_pair ->
          [:green | acc]

        letter in answer ->
          [:yellow | acc]

        true ->
          [:grey | acc]
      end
    end)
    |> Enum.reverse()
    |> IO.inspect()
  end

  @spec play_loop(String.t(), String.t(), integer()) :: binary()
  defp play_loop(answer, guess, guesses_left) do
    cond do
      guesses_left > 0 and answer != guess ->
        feedback(answer, guess)
        guess = user_guess()
        play_loop(answer, guess, guesses_left - 1)

      guesses_left > 0 and answer == guess ->
        feedback(answer, guess)
        true

      guesses_left <= 0 and answer != guess ->
        IO.puts("Ran out of guesses... The word was #{answer}.")
        false
    end
  end

  @doc """
  Starts the Wordle game.
  """
  @spec play() :: binary()
  def play do
    answer = word_generator()
    guess = user_guess()
    play_loop(answer, guess, 4)
  end
end
