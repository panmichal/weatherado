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
            result -> {:ok, result}
        end            
    end

    def get_all() do
        Amnesia.transaction do
            keys = Cache.CurrentConditions.keys
            Enum.map(keys, fn key -> get_struct(Cache.CurrentConditions.read(key)) |> Map.get(:temperature) end)
        end
    end

    defp get_struct(conditions), do: %Weatherado.Structs.CurrentConditions{temperature: %Temperature{unit: Map.get(conditions, :unit), value: Map.get(conditions, :temperature)}}

    defp get_from_cache(id) do
        cached = Amnesia.transaction do
           Cache.CurrentConditions.match([location_id: id]) |> Amnesia.Selection.values
        end
        case cached do
            [] -> []
            nil -> []
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
            
            #Logger.info "Writing to cache #{inspect cache_content}"
            cache_content
            |> Cache.CurrentConditions.write
        end
        {:ok, conditions}
    end
    defp add_to_cache({status, result}, _location_id), do: {status, result}
    
    
end