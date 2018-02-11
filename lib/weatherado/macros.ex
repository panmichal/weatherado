defmodule Weatherado.Macros do
    @doc false
    defmacro __using__(_opts) do
        quote do
            import Weatherado.Macros
        end
    end
    @doc false
    defmacro info(name, context, do: block) do
        function_name = String.to_atom(name <> " info")
        quote do
            def unquote(function_name)(unquote(context)), do: unquote(block)
        end
    end  
end
