defmodule ElixirInAction.Loops do
  @moduledoc """
  Loop exercises
  """
  @doc "function that calculates the length of a list"
  @spec list_len(list) :: non_neg_integer
  def list_len(list) do
    Kernel.length(list)
  end

  @doc "function that takes two integers, from and to , and returns a list of all
  numbers in the given range"
  @spec range(from :: integer, to :: integer) :: list
  def range(from, to) when from > to do
    []
  end

  def range(from, to) do
    [from | range(from + 1, to)]
  end

  @doc "function that takes a list and returns another list that contains only
  the positive numbers from the input list"
  @spec positive(list) :: list
  def positive([]), do: []

  def positive([head | tail]) when head > 0 do
    [head | positive(tail)]
  end

  def positive([_ | tail]) do
    positive(tail)
  end
end
