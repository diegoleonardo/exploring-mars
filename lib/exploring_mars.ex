defmodule ExploringMars do
  @moduledoc """
  Responsible for act such as public api to send commands to mars probe.
  """
  alias ExploringMars.ProbeController
  alias ExploringMars.DataNormalizer

  def start(current_facing, positionX, positionY) do
    ProbeController.start_link(current_facing, positionX, positionY)
  end

  def issue_command(input_data) do
    [limits, init_state, commands] = DataNormalizer.normalize_input(input_data)
    [position_x, position_y, current_facing] = String.split(init_state)

    start(current_facing, position_x, position_y)

    ProbeController.issue_command(commands)
  end
end
