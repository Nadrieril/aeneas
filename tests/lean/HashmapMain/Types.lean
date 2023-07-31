-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [hashmap_main]: type definitions
import Base
open Primitives
namespace hashmap_main

/- [hashmap_main::hashmap::List] -/
inductive hashmap.List (T : Type) :=
| Cons : Usize → T → hashmap.List T → hashmap.List T
| Nil : hashmap.List T

/- [hashmap_main::hashmap::HashMap] -/
structure hashmap.HashMap (T : Type) where
  num_entries : Usize
  max_load_factor : (Usize × Usize)
  max_load : Usize
  slots : Vec (hashmap.List T)

/- The state type used in the state-error monad -/
axiom State : Type

end hashmap_main
