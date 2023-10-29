defmodule TopSecret do
  def to_ast(string) do
    {_, ast} = Code.string_to_quoted(string)
    ast
  end

  def args_substring(_val, args) when args == nil, do: ""

  def args_substring(val, _args) when val == nil, do: ""

  def args_substring(val, args) do
    String.slice(val, 0, length(args))
  end

  def pull_name({:when, _, [head | _]}) do
    pull_name(head)
  end

  def pull_name({value, _, args}) do
    Atom.to_string(value)
    |> args_substring(args)
  end

  def pull_def({:def, _, [head | _]}) do
    pull_name(head)
  end

  def pull_def({:defp, _, [head | _]}) do
    pull_name(head)
  end

  def pull_def(_) do
    nil
  end

  def decode_secret_message_part(ast, acc) do
    case pull_def(ast) do
      nil -> {ast, acc}
      value -> {ast, [value | acc]}
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc
    |> Enum.reverse()
    |> Enum.join("")
  end
end
