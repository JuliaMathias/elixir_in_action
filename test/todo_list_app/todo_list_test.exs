defmodule ElixirInAction.TodoListApp.TodoListTest do
  use ExUnit.Case

  alias ElixirInAction.TodoListApp.TodoList

  describe "new" do
    test "creates an entry" do
      assert TodoList.new() == %TodoList{}
    end
  end

  describe "add_entry/2" do
    test "adds a new entry" do
      todo_list = TodoList.new()

      assert TodoList.add_entry(todo_list, %{date: ~D[2018-12-19], title: "Dentist"}) ==
               %TodoList{
                 auto_id: 2,
                 entries: %{1 => %{date: ~D[2018-12-19], id: 1, title: "Dentist"}}
               }
    end
  end
end
