defmodule ExploringMars.DataNormalizeTest do
  use ExUnit.Case
  alias ExploringMars.DataNormalizer

  doctest ExploringMars.DataNormalizer

  test "When receiving input data, should return a list splitted" do
    expected = ["5 5", "1 2 N", "LMLMLMLMM"]
    input = "5 5\n 1 2 N\n LMLMLMLMM"

    result = DataNormalizer.normalize_input(input)

    assert expected == result
  end

  test "When command input data in lower case, should return expected list of commands" do
    expected = [:left, :right, :left, :right, :move, :move, :move, :move, :left, :right]
    input = "lrlrmmmmlr"
    result = DataNormalizer.normalize_command(input)

    assert expected == result
  end

  test "When invalid command input command, should return nil list" do
    expected = [nil]

    result = DataNormalizer.normalize_command("D")

    assert expected == result
  end
end
