defmodule ExploringMarsTest do
  use ExUnit.Case
  alias ExploringMars
  alias ExploringMars.ProbeState

  test "When receive input data, should return state with facing to north, position x = 1 and position y = 3" do
    expected = %ProbeState{current_facing: :north, positionX: 1, positionY: 3}
    result = ExploringMars.issue_command("5 5\n 1 2 N\n LMLMLMLMM")

    assert expected == result
  end

  test "When receive input data, should return state with facing to east, position x = 5 and position y = 1" do
    expected = %ProbeState{current_facing: :east, positionX: 5, positionY: 1}
    result = ExploringMars.issue_command("5 5\n 3 3 E\n MMRMMRMRRM")

    assert expected == result
  end
end
