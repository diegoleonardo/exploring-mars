defmodule ExploringMars.ProbeControllerTest do
  use ExUnit.Case
  alias ExploringMars.ProbeController
  alias ExploringMars.ProbeState

  setup do
    registry = start_supervised!(ProbeController)
    %{registry: registry}
  end

  describe "Probe facing to north" do
    test "when turn left, should change facing to west" do
      expected_result = get_space_probe(:west)
      result = ProbeController.issue_command("L")

      assert expected_result == result
    end

    test "when turn right, should change facing to east" do
      expected_result = get_space_probe(:east)
      result = ProbeController.issue_command("R")

      assert expected_result == result
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
      expected_result = get_space_probe(:south)
      result = ProbeController.issue_command("LL")

      assert expected_result == result
    end
  end

  defp get_space_probe(facing) do
    %ProbeState{current_facing: facing, positionX: 0, positionY: 0}
  end
end
