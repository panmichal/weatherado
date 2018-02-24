defmodule Weatherado.Reports.CurrentConditions do

alias Weatherado.DataProviders.Accuweather.Provider
alias Weatherado.DataProviders.Accuweather.Parser
alias Weatherado.Cache.Mnesia.Weather, as: Cache

use Amnesia
use Weatherado.Cache.Mnesia.Weather
require Logger

    def get(location_id) do
        case get_from_cache(location_id) do
            nil -> location_id
                    |> Provider.current_conditions
                    |> Parser.parse
                    |> add_to_cache
            result -> {:ok, result}
        end            
    end

    defp get_from_cache(location_id) do
        Amnesia.transaction do
          selection = Cache.CurrentConditions.where location_id == location_id,
          select: [temperature, unit]

          selection |> Amnesia.Selection.values |> Enum.each &IO.inspect(&1)
        end
        nil
    end

    defp add_to_cache({:ok, %Weatherado.Structs.CurrentConditions{} = conditions}) do
        Amnesia.transaction do
            cache_content = %Cache.CurrentConditions{
                temperature: conditions.temperature.value, 
                unit: conditions.temperature.unit, 
                location_id: "13"
            }
            
            Logger.info "Writing to cache #{inspect cache_content}"
            cache_content
            |> Cache.CurrentConditions.write
        end
        {:ok, conditions}
    end
    defp add_to_cache({status, result}), do: {status, result}
    
    
end