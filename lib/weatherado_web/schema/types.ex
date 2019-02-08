defmodule WeatheradoWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :temperature do
    field :location_id, :string
    field :unit, :string
    field :value, :string
  end
end