defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    input = string |> String.replace("-", " ")

    Regex.replace(~r/([^a-zA-Z ])/, input, "")
    |> String.split(" ")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.reduce("", fn x, acc ->
      letter = String.first(x)
      acc <> letter
    end)
    |> String.upcase(:greek)
  end
end
