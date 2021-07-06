defmodule ElixirInAction.TodoList.MultiDict do
  @moduledoc """
  Handles map abstractions
  """

  @doc "Initiates a new map"
  @spec new :: %{}
  def new(), do: %{}

  @doc "Adds entry to map"
  @spec add(map, any, any) :: map
  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  @doc "Gets the value of a key"
  @spec get(map, any) :: any
  def get(dict, key) do
    Map.get(dict, key, [])
  end
end
