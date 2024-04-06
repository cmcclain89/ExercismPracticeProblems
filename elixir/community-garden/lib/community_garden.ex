# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{counter: 1, plots: []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{plot_id: state.counter, registered_to: register_to}

      {plot,
       %{
         counter: state.counter + 1,
         plots: [plot | state.plots]
       }}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      remainder = state.plots |> Enum.reject(fn x -> x.plot_id == plot_id end)

      %{state | plots: remainder}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      plot = Enum.find(state.plots, nil, fn x -> x.plot_id == plot_id end)

      if plot == nil do
        {:not_found, "plot is unregistered"}
      else
        plot
      end
    end)
  end
end
