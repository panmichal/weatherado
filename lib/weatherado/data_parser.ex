defmodule Weatherado.DataParser do
@moduledoc """
Parser for translating api response to common format
"""
  @callback parse(data :: term) :: {:ok, conditions :: term} | {:error, reason :: term}
end
