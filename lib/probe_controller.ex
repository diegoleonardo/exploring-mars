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

  @impl true
  def init(state) do
    :ets.new(@name, [:named_table, read_concurrency: true])
    :ets.insert(@name, {"state", state})
    {:ok, state}
  end

  def issue_command(input_data) do
    commands = DataNormalizer.normalize(input_data)
    Enum.map(commands, fn command -> GenServer.call(@name, command) end)

    get_state()
  end

  def get_state() do
    [{_, state}] = :ets.lookup(@name, "state")
    state
  end

  @impl true
  def handle_call(:left, _, _) do
    state = get_state()

    new_facing = rotate_to_left(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    :ets.insert(@name, {"state", new_state})

    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:right, _, _) do
    state = get_state()

    new_facing = rotate_to_right(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    :ets.insert(@name, {"state", new_state})

    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:move, _, _) do
    state = get_state()

    new_state =
      case state.current_facing do
        :east -> %{state | positionX: state.positionX + 1}
        :west -> %{state | positionX: state.positionX - 1}
        :north -> %{state | positionY: state.positionY + 1}
        :south -> %{state | positionY: state.positionY - 1}
      end

    :ets.insert(@name, {"state", new_state})

    {:reply, new_state, new_state}
  end

  defp rotate_to_left(current_facing) do
    @rotate_to_left[current_facing]
  end

  defp rotate_to_right(current_facing) do
    @rotate_to_right[current_facing]
  end
end
