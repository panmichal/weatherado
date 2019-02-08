defmodule WeatheradoWeb.Schema do
  use Absinthe.Schema
  import_types WeatheradoWeb.Schema.Types

  alias WeatheradoWeb.Resolvers

  query do
      @desc "Get temperature for all stored locations"
      field :temperatures, list_of(:temperature) do
          resolve &Resolvers.Temperature.list_temperatures/3
      end
  end
end
