defmodule ElixirInAction.Code.ServerProcess do
  @doc """
  Starts the Generic Server.

  ### Example

  iex> ServerProcess.start(KeyValueStore)
  #PID<0.202.0>
  """
  @spec start(atom) :: pid
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()
      loop(callback_module, initial_state)
    end)
  end

  @doc """
  Sends a message to the server telling it to do something.

  ### Example

  iex> ServerProcess.call(pid, {:put, :some_key, :some_value})
  :ok
  iex> ServerProcess.call(pid, {:get, :some_key})
  :some_value
  """
  @spec call(pid, tuple) :: any
  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} ->
        response
    end
  end

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} =
          callback_module.handle_call(
            request,
            current_state
          )

        send(caller, {:response, response})
        loop(callback_module, new_state)
    end
  end
end
