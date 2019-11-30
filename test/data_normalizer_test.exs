defmodule ExploringMars.DataNormalizeTest do
  use ExUnit.Case
  alias ExploringMars.DataNormalizer

  doctest ExploringMars.DataNormalizer

  test "When input data in lower case, should return expected list of commands" do
    expected = [:left, :right, :left, :right, :move, :move, :move, :move, :left, :right]
    input = "lrlrmmmmlr"
    result = DataNormalizer.normalize(input)

    assert expected == result
  end

  test "When invalid input command, should return nil list" do
    expected = [nil]

    result = DataNormalizer.normalize("D")

    assert expected == result
  end
end
