defmodule Weatherado.DataProviders.Accuweather.Provider do
  @behaviour Weatherado.DataProvider

  alias Weatherado.DataProviders.Accuweather.CurrentConditions

  require Logger

  @apikey Application.get_env(:weatherado, Weatherado.DataProviders.Auccuweather)[:apikey]

  def current_conditions(location_id) do
    "http://dataservice.accuweather.com/currentconditions/v1/" <> location_id
    |> url_authentication(@apikey)
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Poison.decode!(as: [%CurrentConditions{}])
  end

  defp url_authentication(base_url, apikey) do
    base_url <> "?apikey=" <> apikey
  end
  
end
