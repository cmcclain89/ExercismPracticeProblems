defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(term) do
      case term do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> term}
      end
    end
  end

  def divide(stack) do
    if Enum.count(stack) < 2 do
      raise StackUnderflowError, "when dividing"
    end

    if hd(stack) == 0 do
      raise DivisionByZeroError
    end

    [divisor, dividend] = stack
    dividend / divisor
  end
end
