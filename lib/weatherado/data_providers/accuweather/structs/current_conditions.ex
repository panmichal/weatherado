defmodule Weatherado.DataProviders.Accuweather.CurrentConditions do
    @derive [Poison.Encoder]
    defstruct [:Temperature]
end