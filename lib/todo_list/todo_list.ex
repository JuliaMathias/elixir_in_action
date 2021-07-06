defmodule ElixirInAction.TodoList.TodoList do
  @moduledoc """
  A simple to-do list
  """

  alias ElixirInAction.TodoList.MultiDict

  @doc """
  Initiates a new to-do list
  """
  @spec new :: %{}
  def new(), do: MultiDict.new()

  @doc """
  Adds entry to the to-do list
  """
  @spec add_entry(map, map) :: map
  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  @doc "Lists all to-do list entries"
  @spec entries(map, Calendar.date()) :: list
  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end
