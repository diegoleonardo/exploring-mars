defmodule ExploringMars.ProbeControllerTest do
  use ExUnit.Case
  alias ExploringMars.ProbeController
  alias ExploringMars.ProbeState

  setup do
    id = UUID.uuid1()
    ExploringMars.ProbeController.start(id, "N", "0", "0")
    {:ok, id: id}
  end

  describe "Probe facing to north" do
    test "when turn left, should change facing to west", %{id: id} = _context do
      expected = get_space_probe(:west, 0, 0, id)
      result = ProbeController.issue_command(id, "L")

      assert expected == result
    end

    test "when turn right, should change facing to east", %{id: id} = _context do
      expected = get_space_probe(:east, 0, 0, id)
      result = ProbeController.issue_command(id, "R")

      assert expected == result
    end

    test "when turn left four times, should facing to north", %{id: id} = _context do
      expected = get_space_probe(:north, 0, 0, id)

      result = ProbeController.issue_command(id, "llll")

      assert expected == result
    end

    test "when turn right four times, should facing to north", %{id: id} = _context do
      expected = get_space_probe(:north, 0, 0, id)

      result = ProbeController.issue_command(id, "rrrr")

      assert expected == result
    end
  end

  describe "Probe facing to east" do
    test "when turn left, should change facing to south", %{id: id} = _context do
      expected = get_space_probe(:south, 0, 0, id)
      result = ProbeController.issue_command(id, "LL")

      assert expected == result
    end
  end

  describe "Probe receiving move" do
    test "when facing east, should increase Position X", %{id: id} = _context do
      expected = get_space_probe(:east, 1, 0, id)

      result = ProbeController.issue_command(id, "RM")

      assert expected == result
    end

    test "when facing west, should decrease Position X", %{id: id} = _context do
      expected = get_space_probe(:west, -1, 0, id)

      result = ProbeController.issue_command(id, "LM")

      assert expected == result
    end

    test "when facing north, should increase Position Y", %{id: id} = _context do
      expected = get_space_probe(:north, 0, 1, id)

      result = ProbeController.issue_command(id, "M")

      assert expected == result
    end

    test "when facing south, should decrease position Y", %{id: id} = _context do
      expected = get_space_probe(:south, 0, -1, id)

      result = ProbeController.issue_command(id, "LLM")

      assert expected == result
    end
  end

  defp get_space_probe(facing, positionX \\ 0, positionY \\ 0, id \\ "") do
    %ProbeState{current_facing: facing, positionX: positionX, positionY: positionY, id: id}
  end
end
