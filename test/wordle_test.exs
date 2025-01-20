ExUnit.start(auto_run: false)

defmodule WordleTest do
  use ExUnit.Case

  describe "feedback/2" do
    test "\"aaaaa\", \"aaaaa\"" do
      Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
    end

    test "\"aaaaa\", \"aaaab\"" do
      Games.Wordle.feedback("aaaaa", "aaaab") == [:green, :green, :green, :green, :grey]
    end

    test "\"abdce\", \"edcba\"" do
      Games.Wordle.feedback("abdce", "edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    end
  end

end
