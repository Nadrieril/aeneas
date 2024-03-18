(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [constants] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module Constants.

(** [constants::X0]
    Source: 'src/constants.rs', lines 5:0-5:17 *)
Definition x0_body : result u32 := Return 0%u32.
Definition x0 : u32 := x0_body%global.

(** [constants::X1]
    Source: 'src/constants.rs', lines 7:0-7:17 *)
Definition x1_body : result u32 := Return core_u32_max.
Definition x1 : u32 := x1_body%global.

(** [constants::X2]
    Source: 'src/constants.rs', lines 10:0-10:17 *)
Definition x2_body : result u32 := Return 3%u32.
Definition x2 : u32 := x2_body%global.

(** [constants::incr]:
    Source: 'src/constants.rs', lines 17:0-17:32 *)
Definition incr (n : u32) : result u32 :=
  u32_add n 1%u32.

(** [constants::X3]
    Source: 'src/constants.rs', lines 15:0-15:17 *)
Definition x3_body : result u32 := incr 32%u32.
Definition x3 : u32 := x3_body%global.

(** [constants::mk_pair0]:
    Source: 'src/constants.rs', lines 23:0-23:51 *)
Definition mk_pair0 (x : u32) (y1 : u32) : result (u32 * u32) :=
  Return (x, y1)
.

(** [constants::Pair]
    Source: 'src/constants.rs', lines 36:0-36:23 *)
Record Pair_t (T1 T2 : Type) := mkPair_t { pair_x : T1; pair_y : T2; }.

Arguments mkPair_t { _ _ }.
Arguments pair_x { _ _ }.
Arguments pair_y { _ _ }.

(** [constants::mk_pair1]:
    Source: 'src/constants.rs', lines 27:0-27:55 *)
Definition mk_pair1 (x : u32) (y1 : u32) : result (Pair_t u32 u32) :=
  Return {| pair_x := x; pair_y := y1 |}
.

(** [constants::P0]
    Source: 'src/constants.rs', lines 31:0-31:24 *)
Definition p0_body : result (u32 * u32) := mk_pair0 0%u32 1%u32.
Definition p0 : (u32 * u32) := p0_body%global.

(** [constants::P1]
    Source: 'src/constants.rs', lines 32:0-32:28 *)
Definition p1_body : result (Pair_t u32 u32) := mk_pair1 0%u32 1%u32.
Definition p1 : Pair_t u32 u32 := p1_body%global.

(** [constants::P2]
    Source: 'src/constants.rs', lines 33:0-33:24 *)
Definition p2_body : result (u32 * u32) := Return (0%u32, 1%u32).
Definition p2 : (u32 * u32) := p2_body%global.

(** [constants::P3]
    Source: 'src/constants.rs', lines 34:0-34:28 *)
Definition p3_body : result (Pair_t u32 u32) :=
  Return {| pair_x := 0%u32; pair_y := 1%u32 |}
.
Definition p3 : Pair_t u32 u32 := p3_body%global.

(** [constants::Wrap]
    Source: 'src/constants.rs', lines 49:0-49:18 *)
Record Wrap_t (T : Type) := mkWrap_t { wrap_value : T; }.

Arguments mkWrap_t { _ }.
Arguments wrap_value { _ }.

(** [constants::{constants::Wrap<T>}::new]:
    Source: 'src/constants.rs', lines 54:4-54:41 *)
Definition wrap_new (T : Type) (value : T) : result (Wrap_t T) :=
  Return {| wrap_value := value |}
.

(** [constants::Y]
    Source: 'src/constants.rs', lines 41:0-41:22 *)
Definition y_body : result (Wrap_t i32) := wrap_new i32 2%i32.
Definition y : Wrap_t i32 := y_body%global.

(** [constants::unwrap_y]:
    Source: 'src/constants.rs', lines 43:0-43:30 *)
Definition unwrap_y : result i32 :=
  Return y.(wrap_value).

(** [constants::YVAL]
    Source: 'src/constants.rs', lines 47:0-47:19 *)
Definition yval_body : result i32 := unwrap_y.
Definition yval : i32 := yval_body%global.

(** [constants::get_z1::Z1]
    Source: 'src/constants.rs', lines 62:4-62:17 *)
Definition get_z1_z1_body : result i32 := Return 3%i32.
Definition get_z1_z1 : i32 := get_z1_z1_body%global.

(** [constants::get_z1]:
    Source: 'src/constants.rs', lines 61:0-61:28 *)
Definition get_z1 : result i32 :=
  Return get_z1_z1.

(** [constants::add]:
    Source: 'src/constants.rs', lines 66:0-66:39 *)
Definition add (a : i32) (b : i32) : result i32 :=
  i32_add a b.

(** [constants::Q1]
    Source: 'src/constants.rs', lines 74:0-74:17 *)
Definition q1_body : result i32 := Return 5%i32.
Definition q1 : i32 := q1_body%global.

(** [constants::Q2]
    Source: 'src/constants.rs', lines 75:0-75:17 *)
Definition q2_body : result i32 := Return q1.
Definition q2 : i32 := q2_body%global.

(** [constants::Q3]
    Source: 'src/constants.rs', lines 76:0-76:17 *)
Definition q3_body : result i32 := add q2 3%i32.
Definition q3 : i32 := q3_body%global.

(** [constants::get_z2]:
    Source: 'src/constants.rs', lines 70:0-70:28 *)
Definition get_z2 : result i32 :=
  i <- get_z1; i1 <- add i q3; add q1 i1.

(** [constants::S1]
    Source: 'src/constants.rs', lines 80:0-80:18 *)
Definition s1_body : result u32 := Return 6%u32.
Definition s1 : u32 := s1_body%global.

(** [constants::S2]
    Source: 'src/constants.rs', lines 81:0-81:18 *)
Definition s2_body : result u32 := incr s1.
Definition s2 : u32 := s2_body%global.

(** [constants::S3]
    Source: 'src/constants.rs', lines 82:0-82:29 *)
Definition s3_body : result (Pair_t u32 u32) := Return p3.
Definition s3 : Pair_t u32 u32 := s3_body%global.

(** [constants::S4]
    Source: 'src/constants.rs', lines 83:0-83:29 *)
Definition s4_body : result (Pair_t u32 u32) := mk_pair1 7%u32 8%u32.
Definition s4 : Pair_t u32 u32 := s4_body%global.

(** [constants::V]
    Source: 'src/constants.rs', lines 86:0-86:31 *)
Record V_t (T : Type) (N : usize) := mkV_t { v_x : array T N; }.

Arguments mkV_t { _ _ }.
Arguments v_x { _ _ }.

(** [constants::{constants::V<T, N>#1}::LEN]
    Source: 'src/constants.rs', lines 91:4-91:24 *)
Definition v_len_body (T : Type) (N : usize) : result usize := Return N.
Definition v_len (T : Type) (N : usize) : usize := (v_len_body T N)%global.

(** [constants::use_v]:
    Source: 'src/constants.rs', lines 94:0-94:42 *)
Definition use_v (T : Type) (N : usize) : result usize :=
  Return (v_len T N).

End Constants.
