defmodule ElixirInAction.Streams do
  @moduledoc """
  Stream exercises
  """
  @doc ~S"""
  function takes a file path and returns a list of numbers, with
  each number representing the length of the corresponding line from the file

  ## Examples
    iex> ElixirInAction.Streams.lines_lengths!("text.txt")
    [82, 85, 82, 88, 85, 93, 0, 80, 93, 87, 86, 89, 89, 55, 0, 2, 3, 4, 5, 6]

  """
  def lines_lengths!(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map_every(1, fn line -> String.length(line) end)
    |> Enum.to_list()
  end

  @doc ~S"""
  function that returns the length of the longest line in a file.

   ## Examples
    iex> ElixirInAction.Streams.longest_line_length!("text.txt")
    93
  """
  def longest_line_length!(file) do
    file
    |> lines_lengths!()
    |> Enum.sort()
    |> Enum.reverse()
    |> List.first()
  end

  @doc ~S"""
  function that returns the contents of the longest line in a file.

   ## Examples
    iex> ElixirInAction.Streams.longest_line!("text.txt")
    "returns a stream of its lines. Because the result is a stream, the iteration through the file"
  """
  def longest_line!(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.sort_by(&String.length(&1))
    |> Enum.reverse()
    |> List.first()
  end

  @doc ~S"""
  function that returns a list of numbers, with each number rep-
  resenting the word count in a file.

   ## Examples
    iex> ElixirInAction.Streams.words_per_line!("text.txt")
    [13, 17, 15, 15, 15, 17, 0, 15, 17, 15, 15, 15, 15, 9, 0, 1, 1, 1, 1, 1]
  """
  def words_per_line!(file) do
    File.stream!(file)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map_every(1, fn line -> length(String.split(line)) end)
    |> Enum.to_list()
  end
end
