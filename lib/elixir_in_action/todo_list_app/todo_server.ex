defmodule ElixirInAction.TodoListApp.TodoServer do
  @moduledoc """
  This module creates a Server that holds state for our TodoListApp.
  """
  alias ElixirInAction.TodoListApp.TodoList

  @spec start :: pid
  def start do
    spawn(fn -> loop(TodoList.new()) end)
  end

  @doc """
  Adds an entry to the server

  ### Example

  iex> TodoServer.add_entry(todo_server, %{date: ~D[2018-12-19], title: "Dentist"})
  {:add_entry, %{date: ~D[2018-12-19], title: "Dentist"}}
  """
  def add_entry(todo_server, new_entry) do
    send(todo_server, {:add_entry, new_entry})
  end

  @doc """
  Removes an entry from the server

  ### Example

  iex> TodoServer.entries(todo_server, ~D[2018-12-19])
  [
  %{date: ~D[2018-12-19], id: 3, title: "Movies"},
  %{date: ~D[2018-12-19], id: 1, title: "Dentist"}
  ]
  """
  def entries(todo_server, date) do
    send(todo_server, {:entries, self(), date})

    receive do
      {:todo_entries, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end

  @doc """
  Updates an entry on the server

  ### Example

  iex> TodoServer.entries(todo_server, ~D[2018-12-19])
  [
  %{date: ~D[2018-12-19], id: 3, title: "Movies"},
  %{date: ~D[2018-12-19], id: 1, title: "Dentist"}
  ]
  iex> TodoServer.update_entry(todo_server, %{date: ~D[2018-12-20], id: 3, title: "Supermarket"})
  {:update_entry, %{date: ~D[2018-12-20], id: 3, title: "Supermarket"}}
  """
  def update_entry(todo_server, new_entry) do
    send(todo_server, {:update_entry, new_entry})
  end

  def delete_entry(todo_server, entry) do
    send(todo_server, {:delete_entry, entry})
  end

  defp loop(todo_list) do
    new_todo_list =
      receive do
        message -> process_message(todo_list, message)
      end

    loop(new_todo_list)
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    TodoList.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:update_entry, new_entry}) do
    TodoList.update_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:todo_entries, TodoList.entries(todo_list, date)})
    todo_list
  end

  defp process_message(todo_list, {:delete_entry, entry}) do
    TodoList.delete_entry(todo_list, entry)
  end
end
