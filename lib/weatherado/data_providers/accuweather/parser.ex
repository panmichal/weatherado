defmodule Weatherado.DataProviders.Accuweather.Parser do
  @behaviour Weatherado.DataParser

  alias Weatherado.DataProviders.Accuweather.CurrentConditions, as: AccuweatherCurrentConditions
  alias Weatherado.Structs.CurrentConditions
  alias Weatherado.Structs.Temperature

  def parse([%AccuweatherCurrentConditions{Temperature: %{} = temperature}]) do
    temperature_metric = Map.get(temperature, "Metric")
    %CurrentConditions{temperature: %Temperature{unit: Map.get(temperature_metric, "Unit"), value: Map.get(temperature_metric, "Value")}}
  end
end
