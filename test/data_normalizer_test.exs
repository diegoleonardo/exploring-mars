defmodule ExploringMars.DataNormalizeTest do
  use ExUnit.Case
  alias ExploringMars.DataNormalizer

  test "When input data in lower case, should convert a list in upcase" do
    expected = ["L", "R", "L", "R", "M", "M", "M", "M", "L", "R"]
    input = "lrlrmmmmlr"
    result = DataNormalizer.normalize(input)

    assert expected == result
  end
end
