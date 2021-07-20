defmodule ElixirInAction.TodoListApp.TodoList do
  @moduledoc """
  A simple to-do list
  """

  alias __MODULE__

  @doc """
  Defines the to-do struct
  """
  defstruct auto_id: 1, entries: %{}

  @doc """
  Initiates a new to-do list
  """
  def new(), do: %TodoList{}

  @doc """
  Adds entry to the to-do list
  """
  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries =
      Map.put(
        todo_list.entries,
        todo_list.auto_id,
        entry
      )

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  @doc "Lists all to-do list entries"
  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end
