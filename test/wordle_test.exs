ExUnit.start(auto_run: false)

defmodule WordleTest do
  use ExUnit.Case

  describe "feedback/2" do
    test "correct guess" do
      assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
    end

    test "partial test" do
      assert Games.Wordle.feedback("aaaaa", "aaaab") == [:green, :green, :green, :green, :grey]
    end

    test "within but not full match" do
      assert Games.Wordle.feedback("abdce", "edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    end
  end
end
