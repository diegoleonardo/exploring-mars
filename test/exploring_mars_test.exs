defmodule ExploringMarsTest do
  use ExUnit.Case
  alias ExploringMars

  doctest ExploringMars

  test "When receive input data, should return state with facing to north, position x = 1 and position y = 3" do
    expected = "1 3 N\n"
    result = ExploringMars.issue_command("5 5\n 1 2 N\n LMLMLMLMM")

    assert expected == result
  end

  test "When receive input data, should return state with facing to east, position x = 5 and position y = 1" do
    expected = "5 1 E\n"
    result = ExploringMars.issue_command("5 5\n 3 3 E\n MMRMMRMRRM")

    assert expected == result
  end

  test "When receive input data, should return state for two probes." do
    expected = "1 3 N\n5 1 E\n"
    result = ExploringMars.issue_command("5 5\n 1 2 N LMLMLMLMM\n3 3 E\n MMRMMRMRRM")

    assert expected == result
  end
end
