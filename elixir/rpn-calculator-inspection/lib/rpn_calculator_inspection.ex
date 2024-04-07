defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    current = self()
    child = spawn_link(fn -> send(current, {self(), calculator.(input)}) end)
    %{pid: child, input: input}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    old_value = Process.flag(:trap_exit, true)

    results =
      Enum.map(inputs, fn input -> start_reliability_check(calculator, input) end)
      |> Enum.reduce(%{}, fn process, acc ->
        %{pid: pid} = process
        send(pid, {:EXIT, pid, :ok})
        await_reliability_check_result(process, acc)
      end)

    Process.flag(:trap_exit, old_value)

    results
  end

  def correctness_check(calculator, inputs) do
    old_value = Process.flag(:trap_exit, true)

    results =
      Enum.map(inputs, fn input -> Task.async(fn -> calculator.(input) end) end)
      |> Task.await_many(100)

    Process.flag(:trap_exit, old_value)

    results
  end
end
