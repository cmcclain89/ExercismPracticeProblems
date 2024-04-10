defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)
    is_empty = input == ""

    is_yelling =
      input == String.upcase(input, :greek) and input != String.downcase(input, :greek)

    is_asking = String.last(input) == "?"

    cond do
      is_empty ->
        "Fine. Be that way!"

      is_yelling and is_asking ->
        "Calm down, I know what I'm doing!"

      is_asking ->
        "Sure."

      is_yelling ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
