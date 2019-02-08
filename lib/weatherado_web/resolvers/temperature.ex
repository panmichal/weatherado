defmodule WeatheradoWeb.Resolvers.Temperature do

  def list_temperatures(_parent, _args, _resolution) do
    {:ok, Weatherado.Reports.CurrentConditions.get_all()}
  end

end