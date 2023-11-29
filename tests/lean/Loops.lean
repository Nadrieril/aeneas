-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [loops]
import Base
open Primitives

namespace loops

/- [loops::sum]: loop 0: forward function
   Source: 'src/loops.rs', lines 4:0-14:1 -/
divergent def sum_loop (max : U32) (i : U32) (s : U32) : Result U32 :=
  if i < max
  then do
         let s0 ← s + i
         let i0 ← i + 1#u32
         sum_loop max i0 s0
  else s * 2#u32

/- [loops::sum]: forward function
   Source: 'src/loops.rs', lines 4:0-4:27 -/
def sum (max : U32) : Result U32 :=
  sum_loop max 0#u32 0#u32

/- [loops::sum_with_mut_borrows]: loop 0: forward function
   Source: 'src/loops.rs', lines 19:0-31:1 -/
divergent def sum_with_mut_borrows_loop
  (max : U32) (mi : U32) (ms : U32) : Result U32 :=
  if mi < max
  then
    do
      let ms0 ← ms + mi
      let mi0 ← mi + 1#u32
      sum_with_mut_borrows_loop max mi0 ms0
  else ms * 2#u32

/- [loops::sum_with_mut_borrows]: forward function
   Source: 'src/loops.rs', lines 19:0-19:44 -/
def sum_with_mut_borrows (max : U32) : Result U32 :=
  sum_with_mut_borrows_loop max 0#u32 0#u32

/- [loops::sum_with_shared_borrows]: loop 0: forward function
   Source: 'src/loops.rs', lines 34:0-48:1 -/
divergent def sum_with_shared_borrows_loop
  (max : U32) (i : U32) (s : U32) : Result U32 :=
  if i < max
  then
    do
      let i0 ← i + 1#u32
      let s0 ← s + i0
      sum_with_shared_borrows_loop max i0 s0
  else s * 2#u32

/- [loops::sum_with_shared_borrows]: forward function
   Source: 'src/loops.rs', lines 34:0-34:47 -/
def sum_with_shared_borrows (max : U32) : Result U32 :=
  sum_with_shared_borrows_loop max 0#u32 0#u32

/- [loops::clear]: loop 0: merged forward/backward function
   (there is a single backward function, and the forward function returns ())
   Source: 'src/loops.rs', lines 52:0-58:1 -/
divergent def clear_loop
  (v : alloc.vec.Vec U32) (i : Usize) : Result (alloc.vec.Vec U32) :=
  let i0 := alloc.vec.Vec.len U32 v
  if i < i0
  then
    do
      let i1 ← i + 1#usize
      let v0 ←
        alloc.vec.Vec.index_mut_back U32 Usize
          (core.slice.index.SliceIndexUsizeSliceTInst U32) v i 0#u32
      clear_loop v0 i1
  else Result.ret v

/- [loops::clear]: merged forward/backward function
   (there is a single backward function, and the forward function returns ())
   Source: 'src/loops.rs', lines 52:0-52:30 -/
def clear (v : alloc.vec.Vec U32) : Result (alloc.vec.Vec U32) :=
  clear_loop v 0#usize

/- [loops::List]
   Source: 'src/loops.rs', lines 60:0-60:16 -/
inductive List (T : Type) :=
| Cons : T → List T → List T
| Nil : List T

/- [loops::list_mem]: loop 0: forward function
   Source: 'src/loops.rs', lines 66:0-75:1 -/
divergent def list_mem_loop (x : U32) (ls : List U32) : Result Bool :=
  match ls with
  | List.Cons y tl => if y = x
                      then Result.ret true
                      else list_mem_loop x tl
  | List.Nil => Result.ret false

/- [loops::list_mem]: forward function
   Source: 'src/loops.rs', lines 66:0-66:52 -/
def list_mem (x : U32) (ls : List U32) : Result Bool :=
  list_mem_loop x ls

/- [loops::list_nth_mut_loop]: loop 0: forward function
   Source: 'src/loops.rs', lines 78:0-88:1 -/
divergent def list_nth_mut_loop_loop
  (T : Type) (ls : List T) (i : U32) : Result T :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret x
    else do
           let i0 ← i - 1#u32
           list_nth_mut_loop_loop T tl i0
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop]: forward function
   Source: 'src/loops.rs', lines 78:0-78:71 -/
def list_nth_mut_loop (T : Type) (ls : List T) (i : U32) : Result T :=
  list_nth_mut_loop_loop T ls i

/- [loops::list_nth_mut_loop]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 78:0-88:1 -/
divergent def list_nth_mut_loop_loop_back
  (T : Type) (ls : List T) (i : U32) (ret : T) : Result (List T) :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret (List.Cons ret tl)
    else
      do
        let i0 ← i - 1#u32
        let tl0 ← list_nth_mut_loop_loop_back T tl i0 ret
        Result.ret (List.Cons x tl0)
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop]: backward function 0
   Source: 'src/loops.rs', lines 78:0-78:71 -/
def list_nth_mut_loop_back
  (T : Type) (ls : List T) (i : U32) (ret : T) : Result (List T) :=
  list_nth_mut_loop_loop_back T ls i ret

/- [loops::list_nth_shared_loop]: loop 0: forward function
   Source: 'src/loops.rs', lines 91:0-101:1 -/
divergent def list_nth_shared_loop_loop
  (T : Type) (ls : List T) (i : U32) : Result T :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret x
    else do
           let i0 ← i - 1#u32
           list_nth_shared_loop_loop T tl i0
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_loop]: forward function
   Source: 'src/loops.rs', lines 91:0-91:66 -/
def list_nth_shared_loop (T : Type) (ls : List T) (i : U32) : Result T :=
  list_nth_shared_loop_loop T ls i

/- [loops::get_elem_mut]: loop 0: forward function
   Source: 'src/loops.rs', lines 103:0-117:1 -/
divergent def get_elem_mut_loop (x : Usize) (ls : List Usize) : Result Usize :=
  match ls with
  | List.Cons y tl => if y = x
                      then Result.ret y
                      else get_elem_mut_loop x tl
  | List.Nil => Result.fail .panic

/- [loops::get_elem_mut]: forward function
   Source: 'src/loops.rs', lines 103:0-103:73 -/
def get_elem_mut
  (slots : alloc.vec.Vec (List Usize)) (x : Usize) : Result Usize :=
  do
    let l ←
      alloc.vec.Vec.index_mut (List Usize) Usize
        (core.slice.index.SliceIndexUsizeSliceTInst (List Usize)) slots 0#usize
    get_elem_mut_loop x l

/- [loops::get_elem_mut]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 103:0-117:1 -/
divergent def get_elem_mut_loop_back
  (x : Usize) (ls : List Usize) (ret : Usize) : Result (List Usize) :=
  match ls with
  | List.Cons y tl =>
    if y = x
    then Result.ret (List.Cons ret tl)
    else
      do
        let tl0 ← get_elem_mut_loop_back x tl ret
        Result.ret (List.Cons y tl0)
  | List.Nil => Result.fail .panic

/- [loops::get_elem_mut]: backward function 0
   Source: 'src/loops.rs', lines 103:0-103:73 -/
def get_elem_mut_back
  (slots : alloc.vec.Vec (List Usize)) (x : Usize) (ret : Usize) :
  Result (alloc.vec.Vec (List Usize))
  :=
  do
    let l ←
      alloc.vec.Vec.index_mut (List Usize) Usize
        (core.slice.index.SliceIndexUsizeSliceTInst (List Usize)) slots 0#usize
    let l0 ← get_elem_mut_loop_back x l ret
    alloc.vec.Vec.index_mut_back (List Usize) Usize
      (core.slice.index.SliceIndexUsizeSliceTInst (List Usize)) slots 0#usize
      l0

/- [loops::get_elem_shared]: loop 0: forward function
   Source: 'src/loops.rs', lines 119:0-133:1 -/
divergent def get_elem_shared_loop
  (x : Usize) (ls : List Usize) : Result Usize :=
  match ls with
  | List.Cons y tl => if y = x
                      then Result.ret y
                      else get_elem_shared_loop x tl
  | List.Nil => Result.fail .panic

/- [loops::get_elem_shared]: forward function
   Source: 'src/loops.rs', lines 119:0-119:68 -/
def get_elem_shared
  (slots : alloc.vec.Vec (List Usize)) (x : Usize) : Result Usize :=
  do
    let l ←
      alloc.vec.Vec.index (List Usize) Usize
        (core.slice.index.SliceIndexUsizeSliceTInst (List Usize)) slots 0#usize
    get_elem_shared_loop x l

/- [loops::id_mut]: forward function
   Source: 'src/loops.rs', lines 135:0-135:50 -/
def id_mut (T : Type) (ls : List T) : Result (List T) :=
  Result.ret ls

/- [loops::id_mut]: backward function 0
   Source: 'src/loops.rs', lines 135:0-135:50 -/
def id_mut_back (T : Type) (ls : List T) (ret : List T) : Result (List T) :=
  Result.ret ret

/- [loops::id_shared]: forward function
   Source: 'src/loops.rs', lines 139:0-139:45 -/
def id_shared (T : Type) (ls : List T) : Result (List T) :=
  Result.ret ls

/- [loops::list_nth_mut_loop_with_id]: loop 0: forward function
   Source: 'src/loops.rs', lines 144:0-155:1 -/
divergent def list_nth_mut_loop_with_id_loop
  (T : Type) (i : U32) (ls : List T) : Result T :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret x
    else do
           let i0 ← i - 1#u32
           list_nth_mut_loop_with_id_loop T i0 tl
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_with_id]: forward function
   Source: 'src/loops.rs', lines 144:0-144:75 -/
def list_nth_mut_loop_with_id (T : Type) (ls : List T) (i : U32) : Result T :=
  do
    let ls0 ← id_mut T ls
    list_nth_mut_loop_with_id_loop T i ls0

/- [loops::list_nth_mut_loop_with_id]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 144:0-155:1 -/
divergent def list_nth_mut_loop_with_id_loop_back
  (T : Type) (i : U32) (ls : List T) (ret : T) : Result (List T) :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret (List.Cons ret tl)
    else
      do
        let i0 ← i - 1#u32
        let tl0 ← list_nth_mut_loop_with_id_loop_back T i0 tl ret
        Result.ret (List.Cons x tl0)
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_with_id]: backward function 0
   Source: 'src/loops.rs', lines 144:0-144:75 -/
def list_nth_mut_loop_with_id_back
  (T : Type) (ls : List T) (i : U32) (ret : T) : Result (List T) :=
  do
    let ls0 ← id_mut T ls
    let l ← list_nth_mut_loop_with_id_loop_back T i ls0 ret
    id_mut_back T ls l

/- [loops::list_nth_shared_loop_with_id]: loop 0: forward function
   Source: 'src/loops.rs', lines 158:0-169:1 -/
divergent def list_nth_shared_loop_with_id_loop
  (T : Type) (i : U32) (ls : List T) : Result T :=
  match ls with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret x
    else do
           let i0 ← i - 1#u32
           list_nth_shared_loop_with_id_loop T i0 tl
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_loop_with_id]: forward function
   Source: 'src/loops.rs', lines 158:0-158:70 -/
def list_nth_shared_loop_with_id
  (T : Type) (ls : List T) (i : U32) : Result T :=
  do
    let ls0 ← id_shared T ls
    list_nth_shared_loop_with_id_loop T i ls0

/- [loops::list_nth_mut_loop_pair]: loop 0: forward function
   Source: 'src/loops.rs', lines 174:0-195:1 -/
divergent def list_nth_mut_loop_pair_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else do
             let i0 ← i - 1#u32
             list_nth_mut_loop_pair_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_pair]: forward function
   Source: 'src/loops.rs', lines 174:0-178:27 -/
def list_nth_mut_loop_pair
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_mut_loop_pair_loop T ls0 ls1 i

/- [loops::list_nth_mut_loop_pair]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 174:0-195:1 -/
divergent def list_nth_mut_loop_pair_loop_back'a
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl0)
      else
        do
          let i0 ← i - 1#u32
          let tl00 ← list_nth_mut_loop_pair_loop_back'a T tl0 tl1 i0 ret
          Result.ret (List.Cons x0 tl00)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_pair]: backward function 0
   Source: 'src/loops.rs', lines 174:0-178:27 -/
def list_nth_mut_loop_pair_back'a
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_mut_loop_pair_loop_back'a T ls0 ls1 i ret

/- [loops::list_nth_mut_loop_pair]: loop 0: backward function 1
   Source: 'src/loops.rs', lines 174:0-195:1 -/
divergent def list_nth_mut_loop_pair_loop_back'b
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl1)
      else
        do
          let i0 ← i - 1#u32
          let tl10 ← list_nth_mut_loop_pair_loop_back'b T tl0 tl1 i0 ret
          Result.ret (List.Cons x1 tl10)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_pair]: backward function 1
   Source: 'src/loops.rs', lines 174:0-178:27 -/
def list_nth_mut_loop_pair_back'b
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_mut_loop_pair_loop_back'b T ls0 ls1 i ret

/- [loops::list_nth_shared_loop_pair]: loop 0: forward function
   Source: 'src/loops.rs', lines 198:0-219:1 -/
divergent def list_nth_shared_loop_pair_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else do
             let i0 ← i - 1#u32
             list_nth_shared_loop_pair_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_loop_pair]: forward function
   Source: 'src/loops.rs', lines 198:0-202:19 -/
def list_nth_shared_loop_pair
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_shared_loop_pair_loop T ls0 ls1 i

/- [loops::list_nth_mut_loop_pair_merge]: loop 0: forward function
   Source: 'src/loops.rs', lines 223:0-238:1 -/
divergent def list_nth_mut_loop_pair_merge_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_mut_loop_pair_merge_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_pair_merge]: forward function
   Source: 'src/loops.rs', lines 223:0-227:27 -/
def list_nth_mut_loop_pair_merge
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_mut_loop_pair_merge_loop T ls0 ls1 i

/- [loops::list_nth_mut_loop_pair_merge]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 223:0-238:1 -/
divergent def list_nth_mut_loop_pair_merge_loop_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : (T × T)) :
  Result ((List T) × (List T))
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then let (t, t0) := ret
           Result.ret (List.Cons t tl0, List.Cons t0 tl1)
      else
        do
          let i0 ← i - 1#u32
          let (tl00, tl10) ←
            list_nth_mut_loop_pair_merge_loop_back T tl0 tl1 i0 ret
          Result.ret (List.Cons x0 tl00, List.Cons x1 tl10)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_loop_pair_merge]: backward function 0
   Source: 'src/loops.rs', lines 223:0-227:27 -/
def list_nth_mut_loop_pair_merge_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : (T × T)) :
  Result ((List T) × (List T))
  :=
  list_nth_mut_loop_pair_merge_loop_back T ls0 ls1 i ret

/- [loops::list_nth_shared_loop_pair_merge]: loop 0: forward function
   Source: 'src/loops.rs', lines 241:0-256:1 -/
divergent def list_nth_shared_loop_pair_merge_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_shared_loop_pair_merge_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_loop_pair_merge]: forward function
   Source: 'src/loops.rs', lines 241:0-245:19 -/
def list_nth_shared_loop_pair_merge
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_shared_loop_pair_merge_loop T ls0 ls1 i

/- [loops::list_nth_mut_shared_loop_pair]: loop 0: forward function
   Source: 'src/loops.rs', lines 259:0-274:1 -/
divergent def list_nth_mut_shared_loop_pair_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_mut_shared_loop_pair_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_shared_loop_pair]: forward function
   Source: 'src/loops.rs', lines 259:0-263:23 -/
def list_nth_mut_shared_loop_pair
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_mut_shared_loop_pair_loop T ls0 ls1 i

/- [loops::list_nth_mut_shared_loop_pair]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 259:0-274:1 -/
divergent def list_nth_mut_shared_loop_pair_loop_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl0)
      else
        do
          let i0 ← i - 1#u32
          let tl00 ← list_nth_mut_shared_loop_pair_loop_back T tl0 tl1 i0 ret
          Result.ret (List.Cons x0 tl00)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_shared_loop_pair]: backward function 0
   Source: 'src/loops.rs', lines 259:0-263:23 -/
def list_nth_mut_shared_loop_pair_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_mut_shared_loop_pair_loop_back T ls0 ls1 i ret

/- [loops::list_nth_mut_shared_loop_pair_merge]: loop 0: forward function
   Source: 'src/loops.rs', lines 278:0-293:1 -/
divergent def list_nth_mut_shared_loop_pair_merge_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_mut_shared_loop_pair_merge_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_shared_loop_pair_merge]: forward function
   Source: 'src/loops.rs', lines 278:0-282:23 -/
def list_nth_mut_shared_loop_pair_merge
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_mut_shared_loop_pair_merge_loop T ls0 ls1 i

/- [loops::list_nth_mut_shared_loop_pair_merge]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 278:0-293:1 -/
divergent def list_nth_mut_shared_loop_pair_merge_loop_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl0)
      else
        do
          let i0 ← i - 1#u32
          let tl00 ←
            list_nth_mut_shared_loop_pair_merge_loop_back T tl0 tl1 i0 ret
          Result.ret (List.Cons x0 tl00)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_mut_shared_loop_pair_merge]: backward function 0
   Source: 'src/loops.rs', lines 278:0-282:23 -/
def list_nth_mut_shared_loop_pair_merge_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_mut_shared_loop_pair_merge_loop_back T ls0 ls1 i ret

/- [loops::list_nth_shared_mut_loop_pair]: loop 0: forward function
   Source: 'src/loops.rs', lines 297:0-312:1 -/
divergent def list_nth_shared_mut_loop_pair_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_shared_mut_loop_pair_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_mut_loop_pair]: forward function
   Source: 'src/loops.rs', lines 297:0-301:23 -/
def list_nth_shared_mut_loop_pair
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_shared_mut_loop_pair_loop T ls0 ls1 i

/- [loops::list_nth_shared_mut_loop_pair]: loop 0: backward function 1
   Source: 'src/loops.rs', lines 297:0-312:1 -/
divergent def list_nth_shared_mut_loop_pair_loop_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl1)
      else
        do
          let i0 ← i - 1#u32
          let tl10 ← list_nth_shared_mut_loop_pair_loop_back T tl0 tl1 i0 ret
          Result.ret (List.Cons x1 tl10)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_mut_loop_pair]: backward function 1
   Source: 'src/loops.rs', lines 297:0-301:23 -/
def list_nth_shared_mut_loop_pair_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_shared_mut_loop_pair_loop_back T ls0 ls1 i ret

/- [loops::list_nth_shared_mut_loop_pair_merge]: loop 0: forward function
   Source: 'src/loops.rs', lines 316:0-331:1 -/
divergent def list_nth_shared_mut_loop_pair_merge_loop
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (x0, x1)
      else
        do
          let i0 ← i - 1#u32
          list_nth_shared_mut_loop_pair_merge_loop T tl0 tl1 i0
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_mut_loop_pair_merge]: forward function
   Source: 'src/loops.rs', lines 316:0-320:23 -/
def list_nth_shared_mut_loop_pair_merge
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) : Result (T × T) :=
  list_nth_shared_mut_loop_pair_merge_loop T ls0 ls1 i

/- [loops::list_nth_shared_mut_loop_pair_merge]: loop 0: backward function 0
   Source: 'src/loops.rs', lines 316:0-331:1 -/
divergent def list_nth_shared_mut_loop_pair_merge_loop_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  match ls0 with
  | List.Cons x0 tl0 =>
    match ls1 with
    | List.Cons x1 tl1 =>
      if i = 0#u32
      then Result.ret (List.Cons ret tl1)
      else
        do
          let i0 ← i - 1#u32
          let tl10 ←
            list_nth_shared_mut_loop_pair_merge_loop_back T tl0 tl1 i0 ret
          Result.ret (List.Cons x1 tl10)
    | List.Nil => Result.fail .panic
  | List.Nil => Result.fail .panic

/- [loops::list_nth_shared_mut_loop_pair_merge]: backward function 0
   Source: 'src/loops.rs', lines 316:0-320:23 -/
def list_nth_shared_mut_loop_pair_merge_back
  (T : Type) (ls0 : List T) (ls1 : List T) (i : U32) (ret : T) :
  Result (List T)
  :=
  list_nth_shared_mut_loop_pair_merge_loop_back T ls0 ls1 i ret

end loops
