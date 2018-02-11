defmodule Weatherado.CLI do

  use Weatherado.Macros

  alias Weatherado.DataProviders.Accuweather.Provider
  alias Weatherado.DataProviders.Accuweather.Parser

  info "Current weather", location_id do
    current =
      location_id
      |> Provider.current_conditions
      |> Parser.parse

    case current do
      {:ok, %Weatherado.Structs.CurrentConditions{} = conditions} ->
        "Current temperature in #{inspect location_id}: #{inspect conditions.temperature.value}#{conditions.temperature.unit}"
      {:error, error} -> "Cannot show current temperature in #{location_id}: #{inspect error}"
    end
  end

  def print_current_weather(location_id) do
    current = 
      location_id
      |> Provider.current_conditions
      |> Parser.parse

    case current do
      {:ok, %Weatherado.Structs.CurrentConditions{} = conditions} ->
        "Current temperature in #{inspect location_id}: #{inspect conditions.temperature.value}#{conditions.temperature.unit}"
      {:error, error} -> "Cannot show current temperature in #{location_id}: #{inspect error}"
    end
  end
end