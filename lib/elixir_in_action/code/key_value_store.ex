defmodule ElixirInAction.Code.KeyValueStore do
  alias ElixirInAction.Code.ServerProcess

  def init do
    %{}
  end

  def start do
    ServerProcess.start(KeyValueStore)
  end

  @spec put(pid, atom, atom) :: any
  def put(pid, key, value) do
    ServerProcess.cast(pid, {:put, key, value})
  end

  @spec get(pid, atom) :: any
  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end

  @spec handle_call({:get, any} | {:put, any, any}, map) :: {any, map}
  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end
end
