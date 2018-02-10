defmodule Weatherado.Structs.Temperature do
    @derive [Poison.Encoder]
    defstruct [:unit, :value]
end