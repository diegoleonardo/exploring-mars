defmodule ExploringMars.DataExtractor do
  @moduledoc """
  Responsible for process and extract more workable struct from input data.
  """
  @commands %{"L" => :left, "R" => :right, "M" => :move}

  @doc """
  Extracts limit and probes info (e.g initial state and commands).
  """
  def extract_initial_data(input) do
    String.split(input, "\n", parts: 2)
    |> Enum.map(fn element -> String.trim_leading(element) end)
  end

  @doc """
  Extracts probes data by line
  """
  def extract_probes_info(input) do
    String.split(input, ~r{[0-9]\s[0-9]\s[NSEW][\\n\s](L|R|M)+}, include_captures: true)
    |> filter_result
  end

  @doc """
  Extracts the initial state and commands
  """
  def extract_state_and_commands(input) do
    String.split(input, ~r{[1-9]\s[0-9]*\s[NSEW]\s}, include_captures: true)
    |> filter_result
  end

  @doc """
  Extracts the command to the structure that will be a base of commands to probe. 

    ## Examples

      iex> ExploringMars.DataExtractor.extract_command("LRM")
      [:left, :right, :move]

      iex> ExploringMars.DataExtractor.extract_command("D")
      [nil]
  """
  def extract_command(input) do
    String.upcase(input)
    |> String.split("", trim: true)
    |> Enum.map(fn command -> @commands[command] end)
  end

  defp filter_result(value) do
    Enum.map(value, fn x -> String.replace(x, "\n", "") end)
    |> Enum.map(fn x -> String.trim_leading(x) end)
    |> Enum.map(fn x -> String.trim_trailing(x) end)
    |> Enum.filter(fn x -> x != " " && x != "" end)
  end
end
