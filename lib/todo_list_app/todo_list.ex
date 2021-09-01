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
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      fn entry, todo_list_acc ->
        add_entry(todo_list_acc, entry)
      end
    )
  end

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

  @doc """
  Updates entry. In case an entry doesn't exist, it doesn't do anything
  """
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def delete_entry(todo_list, entry) do
    entries_map = Map.fetch!(todo_list, :entries)

    entry_key =
      entries_map
      |> Enum.find(fn {_, v} -> entry.date == v.date && entry.title == v.title end)
      |> elem(0)

    new_entries = entries_map |> Map.delete(entry_key)

    %TodoList{todo_list | entries: new_entries}
  end

  defp update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end
end
