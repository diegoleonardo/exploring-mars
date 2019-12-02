defmodule ExploringMars.ProbeStateTest do
  use ExUnit.Case
  alias ExploringMars.ProbeState
  doctest ExploringMars.ProbeState

  test "When rotate to left, should return the right facing to cardinal point" do
    expected = [:north, :south, :east, :west]
    input = [:east, :west, :south, :north]

    result = Enum.map(input, fn point -> ProbeState.rotate_to_left(point) end)

    assert expected == result
  end

  test "When rotate to righ, should return the right facing to cardinal point" do
    expected = [:east, :south, :west, :north]
    input = [:north, :east, :south, :west]

    result = Enum.map(input, fn point -> ProbeState.rotate_to_right(point) end)

    assert expected == result
  end

  test "When parse to string, should return in the right format (N, S, E, W)" do
    expected = ["N", "S", "E", "W"]

    cardinal_points = [:north, :south, :east, :west]

    result =
      Enum.map(cardinal_points, fn cardinal_point ->
        ProbeState.get_current_facing(cardinal_point)
      end)

    assert expected == result
  end

  describe "Probe receiving move" do
    test "when facing east, should increase Position X" do
      expected = get_space_probe(:east, 1, 0)
      input = get_space_probe(:east, 0, 0)

      result = ProbeState.move(input)

      assert expected == result
    end

    test "when facing west, should decrease Position X" do
      expected = get_space_probe(:west, -1, 0)
      input = get_space_probe(:west, 0, 0)

      result = ProbeState.move(input)

      assert expected == result
    end

    test "when facing north, should increase Position Y" do
      expected = get_space_probe(:north, 0, 1)
      input = get_space_probe(:north, 0, 0)

      result = ProbeState.move(input)

      assert expected == result
    end

    test "when facing south, should decrease position Y" do
      expected = get_space_probe(:south, 0, -1)
      input = get_space_probe(:south, 0, 0)

      result = ProbeState.move(input)

      assert expected == result
    end
  end

  defp get_space_probe(facing, positionX \\ 0, positionY \\ 0) do
    %ProbeState{current_facing: facing, positionX: positionX, positionY: positionY}
  end
end
