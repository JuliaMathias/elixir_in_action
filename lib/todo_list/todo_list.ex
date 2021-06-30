defmodule ElixirInAction.TodoList do
  @moduledoc """
  A simple to-do list
  """

  @doc "Initiates a new to-do list"
  @spec new :: %{}
  def new(), do: %{}

  @doc "Adds entry to the to-do list"
  @spec add_entry(map, Calendar.date(), String.t()) :: map
  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,
      date,
      [title],
      fn titles -> [title | titles] end
    )
  end

  @doc "Lists all to-do list entries"
  @spec entries(map, Calendar.date()) :: list
  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end
