defmodule Weatherado.DataProviders.Accuweather.Provider do
  @behaviour Weatherado.DataProvider

  alias Weatherado.DataProviders.Accuweather.CurrentConditions

  require Logger

  @apikey Application.get_env(:weatherado, Weatherado.DataProviders.Auccuweather)[:apikey]

  def current_conditions(location_id) when is_binary(location_id) do
    "http://dataservice.accuweather.com/currentconditions/v1/" <> location_id
    |> url_authentication(@apikey)
    |> HTTPoison.get!
    |> decode_response
  end

  def current_conditions(_), do: {:error, :location_id_not_string}

  defp url_authentication(base_url, apikey) do
    base_url <> "?apikey=" <> apikey
  end

  defp decode_response(%HTTPoison.Response{status_code: 200, body: body}) do
    case decoded = Poison.decode(body, as: [%CurrentConditions{}]) do
      {:ok, [%CurrentConditions{}]} -> decoded
      _ -> {:error, :err_accuweather_decode_response}
    end
  end
  
  defp decode_response(%HTTPoison.Response{status_code: code, body: body}) do
    Logger.error("An error ocurred when fetching current conditions from Accuweather. Status code: #{inspect code}. Body: #{inspect body}")
    {:error, :err_accuweather_get}
  end
  
end
