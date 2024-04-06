defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      32 -> 0
      65 -> 1
      67 -> 2
      71 -> 4
      84 -> 8
      _ -> nil
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> 32
      1 -> 65
      2 -> 67
      4 -> 71
      8 -> 84
      _ -> nil
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc

  defp do_encode([head | tail], acc) do
    do_encode(tail, <<acc::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna) do
    do_decode(dna, ~c'')
  end

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<head::4, rest::bitstring>>, acc) do
    do_decode(rest, acc ++ [decode_nucleotide(head)])
  end
end
