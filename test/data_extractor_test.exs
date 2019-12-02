defmodule ExploringMars.DataExtractorTest do
  use ExUnit.Case
  alias ExploringMars.DataExtractor

  doctest ExploringMars.DataExtractor

  test "When receiving input data with two initial states and commands, should return extracted value" do
    expected = ["1 2 N LLMM", "3 3 E MMRR"]
    input = "1 2 N LLMM \n 3 3 E MMRR"
    result = DataExtractor.extract_probes_info(input)

    assert expected == result
  end

  test "When receiving input data with initial state and commands, should return extracted value" do
    expected = ["1 2 N", "LLMM"]
    input = "1 2 N LLMM"

    result = DataExtractor.extract_state_and_commands(input)

    assert expected == result
  end

  test "When receiving input data, should return a list splitted in three parts" do
    expected = ["5 5", "1 2 N\n LMLMLMLMM"]
    input = "5 5\n 1 2 N\n LMLMLMLMM"

    result = DataExtractor.extract_initial_data(input)

    assert expected == result
  end

  test "When receiving a command data in lower case, should return expected list of atoms" do
    expected = [:left, :right, :left, :right, :move, :move, :move, :move, :left, :right]
    input = "lrlrmmmmlr"
    result = DataExtractor.extract_command(input)

    assert expected == result
  end

  test "When receiving unknowing command, should return nil element" do
    expected = [nil]

    result = DataExtractor.extract_command("D")

    assert expected == result
  end
end
