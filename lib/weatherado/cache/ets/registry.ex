defmodule Weatherado.Cache.ETS.Registry do
    use GenServer

    @table_name :"weather_cache"

    def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, @table_name, opts)
    end

    def get(location_id) do
        case :ets.lookup(@table_name, location_id) do
            [] -> :error
            result -> result
        end
        
    end
    
    

    def init(_) do
        table = :ets.new(@table_name, [:named_table, :set, read_concurrency: true])

        {:ok, table}
    end
    
end
