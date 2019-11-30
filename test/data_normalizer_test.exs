defmodule ExploringMars.DataNormalizeTest do
  use ExUnit.Case
  alias ExploringMars.DataNormalizer

  test "When input data in lower case, should convert a list in upcase" do
    expected = [:left, :right, :left, :right, :move, :move, :move, :move, :left, :right]
    input = "lrlrmmmmlr"
    result = DataNormalizer.normalize(input)

    assert expected == result
  end
end
