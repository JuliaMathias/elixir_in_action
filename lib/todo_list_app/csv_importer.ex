defmodule ElixirInAction.TodoListApp.CsvImporter do
  @moduledoc """
  Adds entries from a csv file.
  """

  def import(file) do
    File.stream!(file)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map_every(1, fn line -> String.split(line) end)
    |> Stream.map_every(1, fn element -> process_entry(element) end)
    |> Enum.to_list()
    |> ElixirInAction.TodoListApp.TodoList.new()
  end

  @spec process_entry(binary) :: %{date: Date.t(), title: binary}
  defp process_entry(entry) do
    <<year::binary-size(4), "/", month::binary-size(2), "/", day::binary-size(2), ",",
      task::binary>> = <<"#{entry}">>

    date = Date.from_iso8601("#{year}-#{month}-#{day}") |> elem(1)

    %{date: date, title: task}
  end
end
