defmodule ExploringMars.DataNormalizer do
  @moduledoc """
  Responsible for process and normalize input data.
  """
  @commands %{"L" => :left, "R" => :right, "M" => :move}

  @doc """
  Normalizes the input data to return more testable and workable structure.
  """
  def normalize_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn element -> String.trim_leading(element) end)
  end

  @doc """
  Normalizes the command to the structure that will be a base of commands to probe. 

    ## Examples

      iex> ExploringMars.DataNormalizer.normalize_command("LRM")
      [:left, :right, :move]

      iex> ExploringMars.DataNormalizer.normalize_command("D")
      [nil]
  """
  def normalize_command(input) do
    String.upcase(input)
    |> String.split("", trim: true)
    |> Enum.map(fn command -> @commands[command] end)
  end
end
