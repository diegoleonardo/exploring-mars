defmodule ExploringMars.ProbeController do
  @moduledoc """
  Provides function to control the probes.
  """
  alias ExploringMars.ProbeState
  alias ExploringMars.DataExtractor
  @name :probe_controller

  def start(id, current_facing, positionX, positionY) do
    state = %ProbeState{
      id: id,
      current_facing: ProbeState.get_cardinal_point(current_facing),
      positionX: String.to_integer(positionX),
      positionY: String.to_integer(positionY)
    }

    create_table(state)
  end

  def issue_command(id, input_data) do
    commands = DataExtractor.extract_command(input_data)

    Enum.each(commands, fn command -> handle({id, command}) end)

    get_state(id)
  end

  def get_state(id) do
    [{_, state}] = :ets.lookup(get_table_name(id), id)
    state
  end

  def handle({id, :left}) do
    state = get_state(id)

    new_facing = ProbeState.rotate_to_left(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    insert({id, new_state})
  end

  def handle({id, :right}) do
    state = get_state(id)

    new_facing = ProbeState.rotate_to_right(state.current_facing)

    new_state = %{state | current_facing: new_facing}

    insert({id, new_state})
  end

  def handle({id, :move}) do
    state = get_state(id)

    new_state = ProbeState.move(state)

    insert({id, new_state})
  end

  defp create_table(initial_state) do
    :ets.new(get_table_name(initial_state.id), [:named_table, read_concurrency: true])
    insert({initial_state.id, initial_state})
  end

  defp insert({id, new_state}) do
    :ets.insert(get_table_name(id), {id, new_state})
    new_state
  end

  defp get_table_name(id) do
    "#{@name}#{id}"
    |> String.to_atom()
  end
end
