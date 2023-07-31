(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [loops] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Local Open Scope Primitives_scope.
Module Loops.

(** [loops::sum]: loop 0: forward function *)
Fixpoint sum_loop_fwd (n : nat) (max : u32) (i : u32) (s : u32) : result u32 :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    if i s< max
    then (s0 <- u32_add s i; i0 <- u32_add i 1%u32; sum_loop_fwd n0 max i0 s0)
    else u32_mul s 2%u32
  end
.

(** [loops::sum]: forward function *)
Definition sum_fwd (n : nat) (max : u32) : result u32 :=
  sum_loop_fwd n max 0%u32 0%u32
.

(** [loops::sum_with_mut_borrows]: loop 0: forward function *)
Fixpoint sum_with_mut_borrows_loop_fwd
  (n : nat) (max : u32) (mi : u32) (ms : u32) : result u32 :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    if mi s< max
    then (
      ms0 <- u32_add ms mi;
      mi0 <- u32_add mi 1%u32;
      sum_with_mut_borrows_loop_fwd n0 max mi0 ms0)
    else u32_mul ms 2%u32
  end
.

(** [loops::sum_with_mut_borrows]: forward function *)
Definition sum_with_mut_borrows_fwd (n : nat) (max : u32) : result u32 :=
  sum_with_mut_borrows_loop_fwd n max 0%u32 0%u32
.

(** [loops::sum_with_shared_borrows]: loop 0: forward function *)
Fixpoint sum_with_shared_borrows_loop_fwd
  (n : nat) (max : u32) (i : u32) (s : u32) : result u32 :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    if i s< max
    then (
      i0 <- u32_add i 1%u32;
      s0 <- u32_add s i0;
      sum_with_shared_borrows_loop_fwd n0 max i0 s0)
    else u32_mul s 2%u32
  end
.

(** [loops::sum_with_shared_borrows]: forward function *)
Definition sum_with_shared_borrows_fwd (n : nat) (max : u32) : result u32 :=
  sum_with_shared_borrows_loop_fwd n max 0%u32 0%u32
.

(** [loops::clear]: loop 0: merged forward/backward function
    (there is a single backward function, and the forward function returns ()) *)
Fixpoint clear_loop_fwd_back
  (n : nat) (v : vec u32) (i : usize) : result (vec u32) :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    let i0 := vec_len u32 v in
    if i s< i0
    then (
      i1 <- usize_add i 1%usize;
      v0 <- vec_index_mut_back u32 v i 0%u32;
      clear_loop_fwd_back n0 v0 i1)
    else Return v
  end
.

(** [loops::clear]: merged forward/backward function
    (there is a single backward function, and the forward function returns ()) *)
Definition clear_fwd_back (n : nat) (v : vec u32) : result (vec u32) :=
  clear_loop_fwd_back n v 0%usize
.

(** [loops::List] *)
Inductive List_t (T : Type) :=
| ListCons : T -> List_t T -> List_t T
| ListNil : List_t T
.

Arguments ListCons {T} _ _.
Arguments ListNil {T}.

(** [loops::list_mem]: loop 0: forward function *)
Fixpoint list_mem_loop_fwd
  (n : nat) (x : u32) (ls : List_t u32) : result bool :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons y tl =>
      if y s= x then Return true else list_mem_loop_fwd n0 x tl
    | ListNil => Return false
    end
  end
.

(** [loops::list_mem]: forward function *)
Definition list_mem_fwd (n : nat) (x : u32) (ls : List_t u32) : result bool :=
  list_mem_loop_fwd n x ls
.

(** [loops::list_nth_mut_loop]: loop 0: forward function *)
Fixpoint list_nth_mut_loop_loop_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return x
      else (i0 <- u32_sub i 1%u32; list_nth_mut_loop_loop_fwd T n0 tl i0)
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop]: forward function *)
Definition list_nth_mut_loop_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  list_nth_mut_loop_loop_fwd T n ls i
.

(** [loops::list_nth_mut_loop]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_loop_loop_back
  (T : Type) (n : nat) (ls : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return (ListCons ret tl)
      else (
        i0 <- u32_sub i 1%u32;
        tl0 <- list_nth_mut_loop_loop_back T n0 tl i0 ret;
        Return (ListCons x tl0))
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop]: backward function 0 *)
Definition list_nth_mut_loop_back
  (T : Type) (n : nat) (ls : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_mut_loop_loop_back T n ls i ret
.

(** [loops::list_nth_shared_loop]: loop 0: forward function *)
Fixpoint list_nth_shared_loop_loop_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return x
      else (i0 <- u32_sub i 1%u32; list_nth_shared_loop_loop_fwd T n0 tl i0)
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_loop]: forward function *)
Definition list_nth_shared_loop_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  list_nth_shared_loop_loop_fwd T n ls i
.

(** [loops::get_elem_mut]: loop 0: forward function *)
Fixpoint get_elem_mut_loop_fwd
  (n : nat) (x : usize) (ls : List_t usize) : result usize :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons y tl =>
      if y s= x then Return y else get_elem_mut_loop_fwd n0 x tl
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::get_elem_mut]: forward function *)
Definition get_elem_mut_fwd
  (n : nat) (slots : vec (List_t usize)) (x : usize) : result usize :=
  l <- vec_index_mut_fwd (List_t usize) slots 0%usize;
  get_elem_mut_loop_fwd n x l
.

(** [loops::get_elem_mut]: loop 0: backward function 0 *)
Fixpoint get_elem_mut_loop_back
  (n : nat) (x : usize) (ls : List_t usize) (ret : usize) :
  result (List_t usize)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons y tl =>
      if y s= x
      then Return (ListCons ret tl)
      else (tl0 <- get_elem_mut_loop_back n0 x tl ret; Return (ListCons y tl0))
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::get_elem_mut]: backward function 0 *)
Definition get_elem_mut_back
  (n : nat) (slots : vec (List_t usize)) (x : usize) (ret : usize) :
  result (vec (List_t usize))
  :=
  l <- vec_index_mut_fwd (List_t usize) slots 0%usize;
  l0 <- get_elem_mut_loop_back n x l ret;
  vec_index_mut_back (List_t usize) slots 0%usize l0
.

(** [loops::get_elem_shared]: loop 0: forward function *)
Fixpoint get_elem_shared_loop_fwd
  (n : nat) (x : usize) (ls : List_t usize) : result usize :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons y tl =>
      if y s= x then Return y else get_elem_shared_loop_fwd n0 x tl
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::get_elem_shared]: forward function *)
Definition get_elem_shared_fwd
  (n : nat) (slots : vec (List_t usize)) (x : usize) : result usize :=
  l <- vec_index_fwd (List_t usize) slots 0%usize;
  get_elem_shared_loop_fwd n x l
.

(** [loops::id_mut]: forward function *)
Definition id_mut_fwd (T : Type) (ls : List_t T) : result (List_t T) :=
  Return ls
.

(** [loops::id_mut]: backward function 0 *)
Definition id_mut_back
  (T : Type) (ls : List_t T) (ret : List_t T) : result (List_t T) :=
  Return ret
.

(** [loops::id_shared]: forward function *)
Definition id_shared_fwd (T : Type) (ls : List_t T) : result (List_t T) :=
  Return ls
.

(** [loops::list_nth_mut_loop_with_id]: loop 0: forward function *)
Fixpoint list_nth_mut_loop_with_id_loop_fwd
  (T : Type) (n : nat) (i : u32) (ls : List_t T) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return x
      else (
        i0 <- u32_sub i 1%u32; list_nth_mut_loop_with_id_loop_fwd T n0 i0 tl)
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_with_id]: forward function *)
Definition list_nth_mut_loop_with_id_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  ls0 <- id_mut_fwd T ls; list_nth_mut_loop_with_id_loop_fwd T n i ls0
.

(** [loops::list_nth_mut_loop_with_id]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_loop_with_id_loop_back
  (T : Type) (n : nat) (i : u32) (ls : List_t T) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return (ListCons ret tl)
      else (
        i0 <- u32_sub i 1%u32;
        tl0 <- list_nth_mut_loop_with_id_loop_back T n0 i0 tl ret;
        Return (ListCons x tl0))
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_with_id]: backward function 0 *)
Definition list_nth_mut_loop_with_id_back
  (T : Type) (n : nat) (ls : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  ls0 <- id_mut_fwd T ls;
  l <- list_nth_mut_loop_with_id_loop_back T n i ls0 ret;
  id_mut_back T ls l
.

(** [loops::list_nth_shared_loop_with_id]: loop 0: forward function *)
Fixpoint list_nth_shared_loop_with_id_loop_fwd
  (T : Type) (n : nat) (i : u32) (ls : List_t T) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | ListCons x tl =>
      if i s= 0%u32
      then Return x
      else (
        i0 <- u32_sub i 1%u32; list_nth_shared_loop_with_id_loop_fwd T n0 i0 tl)
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_loop_with_id]: forward function *)
Definition list_nth_shared_loop_with_id_fwd
  (T : Type) (n : nat) (ls : List_t T) (i : u32) : result T :=
  ls0 <- id_shared_fwd T ls; list_nth_shared_loop_with_id_loop_fwd T n i ls0
.

(** [loops::list_nth_mut_loop_pair]: loop 0: forward function *)
Fixpoint list_nth_mut_loop_pair_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_mut_loop_pair_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_pair]: forward function *)
Definition list_nth_mut_loop_pair_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_mut_loop_pair_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_loop_pair]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_loop_pair_loop_back'a
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl0)
        else (
          i0 <- u32_sub i 1%u32;
          tl00 <- list_nth_mut_loop_pair_loop_back'a T n0 tl0 tl1 i0 ret;
          Return (ListCons x0 tl00))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_pair]: backward function 0 *)
Definition list_nth_mut_loop_pair_back'a
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_mut_loop_pair_loop_back'a T n ls0 ls1 i ret
.

(** [loops::list_nth_mut_loop_pair]: loop 0: backward function 1 *)
Fixpoint list_nth_mut_loop_pair_loop_back'b
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl1)
        else (
          i0 <- u32_sub i 1%u32;
          tl10 <- list_nth_mut_loop_pair_loop_back'b T n0 tl0 tl1 i0 ret;
          Return (ListCons x1 tl10))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_pair]: backward function 1 *)
Definition list_nth_mut_loop_pair_back'b
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_mut_loop_pair_loop_back'b T n ls0 ls1 i ret
.

(** [loops::list_nth_shared_loop_pair]: loop 0: forward function *)
Fixpoint list_nth_shared_loop_pair_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_shared_loop_pair_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_loop_pair]: forward function *)
Definition list_nth_shared_loop_pair_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_shared_loop_pair_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_loop_pair_merge]: loop 0: forward function *)
Fixpoint list_nth_mut_loop_pair_merge_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_mut_loop_pair_merge_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_pair_merge]: forward function *)
Definition list_nth_mut_loop_pair_merge_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_mut_loop_pair_merge_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_loop_pair_merge]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_loop_pair_merge_loop_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32)
  (ret : (T * T)) :
  result ((List_t T) * (List_t T))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then let (t, t0) := ret in Return (ListCons t tl0, ListCons t0 tl1)
        else (
          i0 <- u32_sub i 1%u32;
          p <- list_nth_mut_loop_pair_merge_loop_back T n0 tl0 tl1 i0 ret;
          let (tl00, tl10) := p in
          Return (ListCons x0 tl00, ListCons x1 tl10))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_loop_pair_merge]: backward function 0 *)
Definition list_nth_mut_loop_pair_merge_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32)
  (ret : (T * T)) :
  result ((List_t T) * (List_t T))
  :=
  list_nth_mut_loop_pair_merge_loop_back T n ls0 ls1 i ret
.

(** [loops::list_nth_shared_loop_pair_merge]: loop 0: forward function *)
Fixpoint list_nth_shared_loop_pair_merge_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_shared_loop_pair_merge_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_loop_pair_merge]: forward function *)
Definition list_nth_shared_loop_pair_merge_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_shared_loop_pair_merge_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_shared_loop_pair]: loop 0: forward function *)
Fixpoint list_nth_mut_shared_loop_pair_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_mut_shared_loop_pair_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_shared_loop_pair]: forward function *)
Definition list_nth_mut_shared_loop_pair_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_mut_shared_loop_pair_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_shared_loop_pair]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_shared_loop_pair_loop_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl0)
        else (
          i0 <- u32_sub i 1%u32;
          tl00 <- list_nth_mut_shared_loop_pair_loop_back T n0 tl0 tl1 i0 ret;
          Return (ListCons x0 tl00))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_shared_loop_pair]: backward function 0 *)
Definition list_nth_mut_shared_loop_pair_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_mut_shared_loop_pair_loop_back T n ls0 ls1 i ret
.

(** [loops::list_nth_mut_shared_loop_pair_merge]: loop 0: forward function *)
Fixpoint list_nth_mut_shared_loop_pair_merge_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_mut_shared_loop_pair_merge_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_shared_loop_pair_merge]: forward function *)
Definition list_nth_mut_shared_loop_pair_merge_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_mut_shared_loop_pair_merge_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_mut_shared_loop_pair_merge]: loop 0: backward function 0 *)
Fixpoint list_nth_mut_shared_loop_pair_merge_loop_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl0)
        else (
          i0 <- u32_sub i 1%u32;
          tl00 <-
            list_nth_mut_shared_loop_pair_merge_loop_back T n0 tl0 tl1 i0 ret;
          Return (ListCons x0 tl00))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_mut_shared_loop_pair_merge]: backward function 0 *)
Definition list_nth_mut_shared_loop_pair_merge_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_mut_shared_loop_pair_merge_loop_back T n ls0 ls1 i ret
.

(** [loops::list_nth_shared_mut_loop_pair]: loop 0: forward function *)
Fixpoint list_nth_shared_mut_loop_pair_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_shared_mut_loop_pair_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_mut_loop_pair]: forward function *)
Definition list_nth_shared_mut_loop_pair_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_shared_mut_loop_pair_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_shared_mut_loop_pair]: loop 0: backward function 1 *)
Fixpoint list_nth_shared_mut_loop_pair_loop_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl1)
        else (
          i0 <- u32_sub i 1%u32;
          tl10 <- list_nth_shared_mut_loop_pair_loop_back T n0 tl0 tl1 i0 ret;
          Return (ListCons x1 tl10))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_mut_loop_pair]: backward function 1 *)
Definition list_nth_shared_mut_loop_pair_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_shared_mut_loop_pair_loop_back T n ls0 ls1 i ret
.

(** [loops::list_nth_shared_mut_loop_pair_merge]: loop 0: forward function *)
Fixpoint list_nth_shared_mut_loop_pair_merge_loop_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (x0, x1)
        else (
          i0 <- u32_sub i 1%u32;
          list_nth_shared_mut_loop_pair_merge_loop_fwd T n0 tl0 tl1 i0)
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_mut_loop_pair_merge]: forward function *)
Definition list_nth_shared_mut_loop_pair_merge_fwd
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) :
  result (T * T)
  :=
  list_nth_shared_mut_loop_pair_merge_loop_fwd T n ls0 ls1 i
.

(** [loops::list_nth_shared_mut_loop_pair_merge]: loop 0: backward function 0 *)
Fixpoint list_nth_shared_mut_loop_pair_merge_loop_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls0 with
    | ListCons x0 tl0 =>
      match ls1 with
      | ListCons x1 tl1 =>
        if i s= 0%u32
        then Return (ListCons ret tl1)
        else (
          i0 <- u32_sub i 1%u32;
          tl10 <-
            list_nth_shared_mut_loop_pair_merge_loop_back T n0 tl0 tl1 i0 ret;
          Return (ListCons x1 tl10))
      | ListNil => Fail_ Failure
      end
    | ListNil => Fail_ Failure
    end
  end
.

(** [loops::list_nth_shared_mut_loop_pair_merge]: backward function 0 *)
Definition list_nth_shared_mut_loop_pair_merge_back
  (T : Type) (n : nat) (ls0 : List_t T) (ls1 : List_t T) (i : u32) (ret : T) :
  result (List_t T)
  :=
  list_nth_shared_mut_loop_pair_merge_loop_back T n ls0 ls1 i ret
.

End Loops .
