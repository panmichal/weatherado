defmodule Weatherado.Worker.CurrentConditionsWorker do
@moduledoc """
    Worker that fetches current conditions in time interval and prints it to the console
"""
    use GenServer

    alias Weatherado.Reports.CurrentConditions

    @interval 5 * 1000
    
    def start_link do
        GenServer.start_link(__MODULE__, %{})
    end
    

    @impl true
    def init(state \\ %{}) do
        Process.send(self(), :print, [])
        {:ok, state}
    end

    @impl true
    def handle_info(:print, state) do
        print_conditions()
        Process.send_after(self(), :print, @interval)
        {:noreply, state}
    end

    defp print_conditions do
        location_id = "10"
        text = case CurrentConditions.get(location_id) do
            {:ok, %Weatherado.Structs.CurrentConditions{} = conditions} ->
                "Current temperature in #{inspect location_id}: #{inspect conditions.temperature.value}#{conditions.temperature.unit}"
            {:error, error} -> "Cannot show current temperature in #{location_id}: #{inspect error}"
        end
        IO.inspect text
    end
    
    
    
end
