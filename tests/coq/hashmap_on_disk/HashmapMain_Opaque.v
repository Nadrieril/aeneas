(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap_main]: external function declarations *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Require Export HashmapMain_Types.
Import HashmapMain_Types.
Module HashmapMain_Opaque.

(** [hashmap_main::hashmap_utils::deserialize]: forward function *)
Axiom hashmap_utils_deserialize
  : state -> result (state * (hashmap_HashMap_t u64))
.

(** [hashmap_main::hashmap_utils::serialize]: forward function *)
Axiom hashmap_utils_serialize
  : hashmap_HashMap_t u64 -> state -> result (state * unit)
.

End HashmapMain_Opaque .
