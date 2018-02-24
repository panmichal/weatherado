defmodule Weatherado.CLI do

  use Weatherado.Macros

  alias Weatherado.DataProviders.Accuweather.Provider
  alias Weatherado.DataProviders.Accuweather.Parser
  alias Weatherado.Reports.CurrentConditions

  info "Current weather", location_id do
    case CurrentConditions.get(location_id) do
      {:ok, %Weatherado.Structs.CurrentConditions{} = conditions} ->
        "Current temperature in #{inspect location_id}: #{inspect conditions.temperature.value}#{conditions.temperature.unit}"
      {:error, error} -> "Cannot show current temperature in #{location_id}: #{inspect error}"
    end
  end
end