defmodule Games.Wordle do
  @moduledoc """
  This is a wordle game. Start the game and you will be asked for a 5 letter word.

  There is a edge case that isnt part of the check yet. It will not check to see if
  you have more than the number of letters for a given character

  ie:
    iex> Games.Wordle.feedback("aaabb", "xaaaa")
    [:grey, :green, :green, :yellow, :yellow]
    instead of
    [:grey, :green, :green, :yellow, :grey]


  """

  @doc """
  iex> Games.Wordle.feedback("aaaaa", "aaaaa")
  [:green, :green, :green, :green, :green]

  iex> Games.Wordle.feedback("aaaaa", "aaaab")
  [:green, :green, :green, :green, :grey]

  iex> Games.Wordle.feedback("abdce", "edcba")
  [:yellow, :yellow, :yellow, :yellow, :yellow]
  """
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

  def user_guess do
    IO.gets("Please enter a 5 letter word: ")
    |> String.trim()
    |> String.downcase()
    |> guess_validation()
  end

  def guess_validation(guess) do
    if String.length(guess) != 5 do
      user_guess()
    else
      guess
    end
  end

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

  def play do
    answer = word_generator()
    guess = user_guess()
    guesses_left = 5
    play_loop(answer, guess, guesses_left)
  end

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
