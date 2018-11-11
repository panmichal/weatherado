defmodule Weatherado.Reports.CurrentConditions do

alias Weatherado.DataProviders.Accuweather.Provider
alias Weatherado.DataProviders.Accuweather.Parser
alias Weatherado.Cache.Mnesia.Weather, as: Cache
alias Weatherado.Structs.Temperature

use Amnesia
use Weatherado.Cache.Mnesia.Weather
require Logger

    def get(location_id) do
        case get_from_cache(location_id) do
            [] -> location_id
                    |> Provider.current_conditions
                    |> Parser.parse
                    |> add_to_cache(location_id)
                    |> IO.inspect
            result -> {:ok, result}
        end            
    end

    defp get_from_cache(id) do
        cached = Amnesia.transaction do
          selection = Cache.CurrentConditions.where(location_id == id)
          selection |> Amnesia.Selection.values
        end

        case cached do
            [] -> []
            [conditions] -> %Weatherado.Structs.CurrentConditions{temperature: %Temperature{unit: Map.get(conditions, :unit), value: Map.get(conditions, :temperature)}}
            :badarg -> []
        end
    end

    defp add_to_cache({:ok, %Weatherado.Structs.CurrentConditions{} = conditions}, location_id) do
        Amnesia.transaction do
            cache_content = %Cache.CurrentConditions{
                temperature: conditions.temperature.value, 
                unit: conditions.temperature.unit, 
                location_id: location_id
            }
            
            Logger.info "Writing to cache #{inspect cache_content}"
            cache_content
            |> Cache.CurrentConditions.write
        end
        {:ok, conditions}
    end
    defp add_to_cache({status, result}, _location_id), do: {status, result}
    
    
end