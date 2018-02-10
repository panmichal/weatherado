defmodule Weatherado.DataProvider do
@moduledoc """
Fetches different kinds of weather data
"""
  @callback current_conditions(location_id :: term) :: {:ok, conditions :: term} | {:error, reason :: term}
end
