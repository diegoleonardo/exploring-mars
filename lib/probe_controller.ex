defmodule ExploringMars.ProbeController do
  use GenServer
  alias ExploringMars.ProbeState
  alias ExploringMars.DataNormalizer
  @name :probe_controller
  @rotate_to_left %{:north => :west, :west => :south, :south => :east, :east => :north}
  @rotate_to_right %{:north => :east, :east => :south, :south => :west, :west => :north}

  def start_link(_) do
    GenServer.start_link(
      __MODULE__,
      %ProbeState{current_facing: :north, positionX: 0, positionY: 0},
      name: @name
    )
  end

  def init(state) do
    {:ok, state}
  end

  def issue_command(input_data) do
    commands = DataNormalizer.normalize(input_data)
    Enum.map(commands, fn command -> GenServer.call(@name, command) end)

    get_state()
  end

  def get_state() do
    GenServer.call(@name, :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply,
     %ProbeState{
       current_facing: state.current_facing,
       positionX: state.positionX,
       positionY: state.positionY
     }, state}
  end

  def handle_call(:left, _from, state) do
    new_facing = rotate_to_left(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    {:reply, new_state, new_state}
  end

  def handle_call(:right, _from, state) do
    new_facing = rotate_to_right(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    {:reply, new_state, new_state}
  end

  defp rotate_to_left(current_facing) do
    @rotate_to_left[current_facing]
  end

  defp rotate_to_right(current_facing) do
    @rotate_to_right[current_facing]
  end
end
