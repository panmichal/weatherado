# needed to get defdatabase and other macros
use Amnesia

# defines a database called Database, it's basically a defmodule with
# some additional magic
defdatabase Weatherado.Cache.Mnesia.Weather do
  # this is just a forward declaration of the table, otherwise you'd have
  # to fully scope User.read in Message functions

  # this defines a table with other attributes as ordered set, and defines an
  # additional index as email, this improves lookup operations
  deftable CurrentConditions, [{ :id, autoincrement }, :temperature, :unit, :location_id], type: :ordered_set, index: [:location_id] do
    # again not needed, but nice to have
    @type t :: %CurrentConditions{id: non_neg_integer, temperature: String.t, unit: String.t, location_id: String.t}
  end
end