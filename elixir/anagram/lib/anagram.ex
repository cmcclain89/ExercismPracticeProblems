defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.map(fn s -> {s, String.downcase(s, :greek)} end)
    |> Enum.reject(fn {_s, d} -> d == String.downcase(base, :greek) end)
    |> Enum.reject(fn {_s, d} -> String.length(d) != String.length(base) end)
    |> Enum.filter(fn {_s, d} ->
      base
      |> String.downcase(:greek)
      |> is_anagram(d)
    end)
    |> Enum.map(fn {s, _d} -> s end)
  end

  def is_anagram(base, candidate) do
    base_map = char_map(base)
    candidate_map = char_map(candidate)

    base_map == candidate_map
  end

  def char_map(word) do
    word
    |> String.graphemes()
    |> Enum.reduce(%{}, fn c, acc ->
      Map.update(acc, c, 0, fn x -> x + 1 end)
    end)
  end
end
