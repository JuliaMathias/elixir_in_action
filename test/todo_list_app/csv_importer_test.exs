defmodule ElixirInAction.TodoListApp.CsvImporterTest do
  use ExUnit.Case

  alias ElixirInAction.TodoListApp.CsvImporter
  alias ElixirInAction.TodoListApp.TodoList

  describe "import/1" do
    test "should import entries from file when given a valid file" do
      assert CsvImporter.import("todos.csv") == %ElixirInAction.TodoListApp.TodoList{
               auto_id: 4,
               entries: %{
                 1 => %{date: ~D[2018-12-19], id: 1, title: "Dentist"},
                 2 => %{date: ~D[2018-12-20], id: 2, title: "Shopping"},
                 3 => %{date: ~D[2018-12-19], id: 3, title: "Movies"}
               }
             }
    end
  end
end
