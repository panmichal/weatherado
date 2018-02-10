defmodule Weatherado.DataProviders.Accuweather.Parser do
  @behaviour Weatherado.DataParser

  alias Weatherado.DataProviders.Accuweather.CurrentConditions, as: AccuweatherCurrentConditions
  alias Weatherado.Structs.CurrentConditions
  alias Weatherado.Structs.Temperature

  def parse(input) do
    case input do
      {:ok, [%AccuweatherCurrentConditions{Temperature: %{} = temperature}]} -> 
        temperature_metric = Map.get(temperature, "Metric")
        {:ok, %CurrentConditions{temperature: %Temperature{unit: Map.get(temperature_metric, "Unit"), value: Map.get(temperature_metric, "Value")}}}
      {:error, error} -> {:error, error}
    end
  end
end
