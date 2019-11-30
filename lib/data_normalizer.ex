defmodule ExploringMars.DataNormalizer do
  @moduledoc """
  Responsible for process and normalize input data.
  """
  @commands %{"L" => :left, "R" => :right, "M" => :move}

  @doc """
  Normalizes the input data to return more testable and workable structure. 

    ## Examples

      iex> ExploringMars.DataNormalizer.normalize("LRM")
      [:left, :right, :move]

      iex> ExploringMars.DataNormalizer.normalize("D")
      [nil]

  """
  def normalize(input) do
    String.upcase(input)
    |> String.split("", trim: true)
    |> Enum.map(fn command -> @commands[command] end)
  end
end
