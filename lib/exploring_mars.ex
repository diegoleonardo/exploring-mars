defmodule ExploringMars do
  @moduledoc """
  Responsible for act such as public api to send commands to mars probe.
  """
  alias ExploringMars.ProbeController
  alias ExploringMars.DataExtractor
  alias ExploringMars.ProbeState

  def start(id, current_facing, positionX, positionY) do
    ProbeController.start(id, current_facing, positionX, positionY)
  end

  def issue_command(input_data) do
    [_limits, probe_info] = DataExtractor.extract_initial_data(input_data)

    list_of_probes = DataExtractor.extract_probes_info(probe_info)

    Enum.map(list_of_probes, fn probe -> process_probe(probe) end)
    |> parse_result_to_string
    |> Enum.reduce("", fn probe, acc -> acc <> probe <> "\n" end)
  end

  defp process_probe(probe) do
    [init_state, commands] = DataExtractor.extract_state_and_commands(probe)
    [position_x, position_y, current_facing] = String.split(init_state)
    id = UUID.uuid1()

    start(id, current_facing, position_x, position_y)

    result = ProbeController.issue_command(id, commands)

    result
  end

  def parse_result_to_string(probes) do
    Enum.map(probes, fn probe ->
      "#{probe.positionX} #{probe.positionY} #{
        ProbeState.get_current_facing(probe.current_facing)
      }"
    end)
  end
end
