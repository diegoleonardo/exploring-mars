defmodule ExploringMars.DataNormalizer do
  def normalize(input) do
    String.upcase(input)
    |> String.split("", trim: true)
  end
end
