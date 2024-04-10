defmodule RationalNumbers do
  import Kernel, except: [abs: 1]

  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {a1, b1} = a
    {a2, b2} = b

    {a1 * b2 + a2 * b1, b1 * b2}
    |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {a1, b1} = a
    {a2, b2} = b

    {a1 * b2 - a2 * b1, b1 * b2}
    |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {a1, b1} = a
    {a2, b2} = b

    {a1 * a2, b1 * b2}
    |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
    {a1, b1} = num
    {a2, b2} = den

    {a1 * b2, a2 * b1}
    |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {a1, b1} = a
    abs_a1 = abs_integer(a1)
    abs_b1 = abs_integer(b1)

    {abs_a1, abs_b1}
    |> reduce()
  end

  def abs_integer(a) when is_integer(a), do: if(a < 0, do: a * -1, else: a)

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) when n < 0 do
    {a1, b1} = a

    m = abs_integer(n)

    {:math.pow(b1, m) |> round(), :math.pow(a1, m) |> round()}
    |> reduce()
  end

  def pow_rational(a, n) do
    {a1, b1} = a

    {:math.pow(a1, n) |> round(), :math.pow(b1, n) |> round()}
    |> reduce()
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = n

    :math.pow(x, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _} = _), do: {0, 1}

  def reduce({x, y} = _a) when y < 0, do: reduce({x * -1, y * -1})

  def reduce({x, y} = _a) when x == y, do: {1, 1}

  def reduce(a) do
    {a1, b1} = a
    abs_a = if a1 < 0, do: a1 * -1, else: a1
    abs_b = if b1 < 0, do: b1 * -1, else: b1
    lowest = min(abs_a, abs_b)
    reduce(a, lowest)
  end

  def reduce({x, y}, 1), do: {x, y}

  def reduce({x, y}, acc) do
    if rem(x, acc) == 0 and rem(y, acc) == 0 do
      {trunc(x / acc), trunc(y / acc)}
    else
      reduce({x, y}, acc - 1)
    end
  end
end
