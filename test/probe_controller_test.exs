defmodule ExploringMars.ProbeControllerTest do
  use ExUnit.Case, async: false
  alias ExploringMars.ProbeController
  alias ExploringMars.ProbeState

  doctest ExploringMars.ProbeController

  setup do
    ExploringMars.ProbeController.start_link("N", "0", "0")
    :ok
  end

  describe "Probe facing to north" do
    test "when turn left, should change facing to west" do
      expected = get_space_probe(:west)
      result = ProbeController.issue_command("L")

      assert expected == result
    end

    test "when turn right, should change facing to east" do
      expected = get_space_probe(:east)
      result = ProbeController.issue_command("R")

      assert expected == result
    end

    test "when turn left four times, should facing to north" do
      expected = get_space_probe(:north)

      result = ProbeController.issue_command("llll")

      assert expected == result
    end

    test "when turn right four times, should facing to north" do
      expected = get_space_probe(:north)

      result = ProbeController.issue_command("rrrr")

      assert expected == result
    end
  end

  describe "Probe facing to east" do
    test "when turn left, should change facing to south" do
      expected = get_space_probe(:south)
      result = ProbeController.issue_command("LL")

      assert expected == result
    end
  end

  describe "Probe receiving move" do
    test "when facing east, should increase Position X" do
      expected = get_space_probe(:east, 1, 0)

      result = ProbeController.issue_command("RM")

      assert expected == result
    end

    test "when facing west, should decrease Position X" do
      expected = get_space_probe(:west, -1, 0)

      result = ProbeController.issue_command("LM")

      assert expected == result
    end

    test "when facing north, should increase Position Y" do
      expected = get_space_probe(:north, 0, 1)

      result = ProbeController.issue_command("M")

      assert expected == result
    end

    test "when facing south, should decrease position Y" do
      expected = get_space_probe(:south, 0, -1)

      result = ProbeController.issue_command("LLM")

      assert expected == result
    end
  end

  defp get_space_probe(facing, positionX \\ 0, positionY \\ 0) do
    %ProbeState{current_facing: facing, positionX: positionX, positionY: positionY}
  end
end
