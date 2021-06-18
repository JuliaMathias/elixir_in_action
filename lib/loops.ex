defmodule ElixirInAction.Loops do
  @moduledoc """
  Loop exercises
  """
  @doc "function that calculates the length of a list"
  @spec list_len(list :: list()) :: non_neg_integer
  def list_len(list) do
    Kernel.length(list)
  end

  @doc "function that takes two integers, from and to , and returns a list of all
numbers in the given range"
  def range(_from, _to) do
  end

  @doc "function that takes a list and returns another list that contains only
the positive numbers from the input list"
  def positive(_list) do
  end
end
