defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG|INFO|WARNING|ERROR\]/
  end

  def split_line(line) do
    line
    |> String.split(~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    line
    |> String.replace(~r/end-of-line\d+/i, "")
  end

  # couldn't figure out this regex, unfortunately,
  # so had to look up the answer
  # otherwise, everything else was mine
  def tag_with_user_name(line) do
    case ~r/User\s+(\S+)/ |> Regex.run(line) do
      nil -> line
      [_, username] ->
        "[USER] #{username} " <> line
    end
  end
end
