defmodule Weatherado.Structs.CurrentConditions do
    alias Weatherado.Structs.Temperature

    @derive [Poison.Encoder]
    defstruct [temperature: %Temperature{}]
end