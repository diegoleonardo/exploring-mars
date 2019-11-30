defmodule ExploringMars.DataNormalizer do
  @commands %{"L" => :left, "R" => :right, "M" => :move}

  def normalize(input) do
    String.upcase(input)
    |> String.split("", trim: true)
    |> Enum.map(fn command -> @commands[command] end)
  end
end
