defmodule ElixirInAction.Streams do
  @moduledoc """
  Stream exercises
  """
  @doc "function takes a file path and returns a list of numbers, with
  each number representing the length of the corresponding line from the file"
  def lines_lengths!(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.replace(&1, "\n", ""))

    # |> Enum.map([a: 1, b: 2], fn {k, v} -> {k, -v} end)
  end

  #   @doc "function that returns the length of the longest line in a file."
  #   def longest_line_length!(file) do
  #   end

  @doc "function that returns the contents of the longest line in a file."
  def longest_line!(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.sort_by(&String.length(&1))
    |> Enum.reverse()
    |> Enum.take(1)
  end

  #   @doc "function that returns a list of numbers, with each number rep-
  # resenting the word count in a file. Hint: to get the word count of a line, use
  # length(String.split(line)) ."
  #   def words_per_line!(file) do
  #   end
end
