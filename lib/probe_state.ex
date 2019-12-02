defmodule ExploringMars.ProbeState do
  @moduledoc """
  Data-structure to handle probe`s state
  """
  @rotate_to_left %{:north => :west, :west => :south, :south => :east, :east => :north}
  @rotate_to_right %{:north => :east, :east => :south, :south => :west, :west => :north}
  @cardinal_points %{"N" => :north, "S" => :south, "E" => :east, "W" => :west}

  defstruct id: "", current_facing: :north, positionX: 0, positionY: 0

  @doc """
  Function that returns current facing in string format: "N", "S", "E", "W".

    ## Examples
    iex> ExploringMars.ProbeState.get_current_facing(:north)
    "N"
  """
  def get_current_facing(facing) do
    case facing do
      :north -> "N"
      :south -> "S"
      :east -> "E"
      :west -> "W"
    end
  end

  @doc """
  Function that returns next cardinal point(in atom format) turning around to left

    ## Examples
    iex> ExploringMars.ProbeState.rotate_to_left(:north)
    :west

  """
  def rotate_to_left(current_facing) do
    @rotate_to_left[current_facing]
  end

  @doc """
  Function that returns next cardinal point(in atom format) turning around to right

    ## Examples
    iex> ExploringMars.ProbeState.rotate_to_right(:north)
    :east

  """
  def rotate_to_right(current_facing) do
    @rotate_to_right[current_facing]
  end

  @doc """
  Function that receive parameter string value and returns the cardinal point in atom format.

    ## Examples
    iex> ExploringMars.ProbeState.get_cardinal_point("N")
    :north

  """
  def get_cardinal_point(point) do
    @cardinal_points[point]
  end

  @doc """
  Function that moves spacial probe.

    ## Examples
    iex(1)> state = %ProbeState{ current_facing: :east }
    iex> ExploringMars.ProbeState.move(state)
    %ProbeState{ current_facing: :east, positionX: 1, positionY: 0 }

  """
  def move(state) do
    case state.current_facing do
      :east -> %{state | positionX: state.positionX + 1}
      :west -> %{state | positionX: state.positionX - 1}
      :north -> %{state | positionY: state.positionY + 1}
      :south -> %{state | positionY: state.positionY - 1}
    end
  end
end
