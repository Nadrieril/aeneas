-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [no_nested_borrows]
import Base
open Primitives

namespace no_nested_borrows

/- [no_nested_borrows::Pair]
   Source: 'tests/src/no_nested_borrows.rs', lines 7:0-7:23 -/
structure Pair (T1 T2 : Type) where
  x : T1
  y : T2

/- [no_nested_borrows::List]
   Source: 'tests/src/no_nested_borrows.rs', lines 12:0-12:16 -/
inductive List (T : Type) :=
| Cons : T → List T → List T
| Nil : List T

/- [no_nested_borrows::One]
   Source: 'tests/src/no_nested_borrows.rs', lines 23:0-23:16 -/
inductive One (T1 : Type) :=
| One : T1 → One T1

/- [no_nested_borrows::EmptyEnum]
   Source: 'tests/src/no_nested_borrows.rs', lines 29:0-29:18 -/
inductive EmptyEnum :=
| Empty : EmptyEnum

/- [no_nested_borrows::Enum]
   Source: 'tests/src/no_nested_borrows.rs', lines 35:0-35:13 -/
inductive Enum :=
| Variant1 : Enum
| Variant2 : Enum

/- [no_nested_borrows::EmptyStruct]
   Source: 'tests/src/no_nested_borrows.rs', lines 42:0-42:22 -/
@[reducible] def EmptyStruct := Unit

/- [no_nested_borrows::Sum]
   Source: 'tests/src/no_nested_borrows.rs', lines 44:0-44:20 -/
inductive Sum (T1 T2 : Type) :=
| Left : T1 → Sum T1 T2
| Right : T2 → Sum T1 T2

/- [no_nested_borrows::cast_u32_to_i32]:
   Source: 'tests/src/no_nested_borrows.rs', lines 49:0-49:37 -/
def cast_u32_to_i32 (x : U32) : Result I32 :=
  Scalar.cast .I32 x

/- [no_nested_borrows::cast_bool_to_i32]:
   Source: 'tests/src/no_nested_borrows.rs', lines 53:0-53:39 -/
def cast_bool_to_i32 (x : Bool) : Result I32 :=
  Scalar.cast_bool .I32 x

/- [no_nested_borrows::cast_bool_to_bool]:
   Source: 'tests/src/no_nested_borrows.rs', lines 58:0-58:41 -/
def cast_bool_to_bool (x : Bool) : Result Bool :=
  Result.ok x

/- [no_nested_borrows::test2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 63:0-63:14 -/
def test2 : Result Unit :=
  do
  let _ ← 23#u32 + 44#u32
  Result.ok ()

/- Unit test for [no_nested_borrows::test2] -/
#assert (test2 == Result.ok ())

/- [no_nested_borrows::get_max]:
   Source: 'tests/src/no_nested_borrows.rs', lines 75:0-75:37 -/
def get_max (x : U32) (y : U32) : Result U32 :=
  if x >= y
  then Result.ok x
  else Result.ok y

/- [no_nested_borrows::test3]:
   Source: 'tests/src/no_nested_borrows.rs', lines 83:0-83:14 -/
def test3 : Result Unit :=
  do
  let x ← get_max 4#u32 3#u32
  let y ← get_max 10#u32 11#u32
  let z ← x + y
  if z = 15#u32
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test3] -/
#assert (test3 == Result.ok ())

/- [no_nested_borrows::test_neg1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 90:0-90:18 -/
def test_neg1 : Result Unit :=
  do
  let y ← -. 3#i32
  if y = (-3)#i32
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_neg1] -/
#assert (test_neg1 == Result.ok ())

/- [no_nested_borrows::refs_test1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 97:0-97:19 -/
def refs_test1 : Result Unit :=
  if 1#i32 = 1#i32
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::refs_test1] -/
#assert (refs_test1 == Result.ok ())

/- [no_nested_borrows::refs_test2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 108:0-108:19 -/
def refs_test2 : Result Unit :=
  if 2#i32 = 2#i32
  then
    if 0#i32 = 0#i32
    then
      if 2#i32 = 2#i32
      then if 2#i32 = 2#i32
           then Result.ok ()
           else Result.fail .panic
      else Result.fail .panic
    else Result.fail .panic
  else Result.fail .panic

/- Unit test for [no_nested_borrows::refs_test2] -/
#assert (refs_test2 == Result.ok ())

/- [no_nested_borrows::test_list1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 124:0-124:19 -/
def test_list1 : Result Unit :=
  Result.ok ()

/- Unit test for [no_nested_borrows::test_list1] -/
#assert (test_list1 == Result.ok ())

/- [no_nested_borrows::test_box1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 129:0-129:18 -/
def test_box1 : Result Unit :=
  do
  let (_, deref_mut_back) ← alloc.boxed.Box.deref_mut I32 0#i32
  let b ← deref_mut_back 1#i32
  let x ← alloc.boxed.Box.deref I32 b
  if x = 1#i32
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_box1] -/
#assert (test_box1 == Result.ok ())

/- [no_nested_borrows::copy_int]:
   Source: 'tests/src/no_nested_borrows.rs', lines 139:0-139:30 -/
def copy_int (x : I32) : Result I32 :=
  Result.ok x

/- [no_nested_borrows::test_unreachable]:
   Source: 'tests/src/no_nested_borrows.rs', lines 145:0-145:32 -/
def test_unreachable (b : Bool) : Result Unit :=
  if b
  then Result.fail .panic
  else Result.ok ()

/- [no_nested_borrows::test_panic]:
   Source: 'tests/src/no_nested_borrows.rs', lines 153:0-153:26 -/
def test_panic (b : Bool) : Result Unit :=
  if b
  then Result.fail .panic
  else Result.ok ()

/- [no_nested_borrows::test_copy_int]:
   Source: 'tests/src/no_nested_borrows.rs', lines 160:0-160:22 -/
def test_copy_int : Result Unit :=
  do
  let y ← copy_int 0#i32
  if 0#i32 = y
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_copy_int] -/
#assert (test_copy_int == Result.ok ())

/- [no_nested_borrows::is_cons]:
   Source: 'tests/src/no_nested_borrows.rs', lines 167:0-167:38 -/
def is_cons (T : Type) (l : List T) : Result Bool :=
  match l with
  | List.Cons _ _ => Result.ok true
  | List.Nil => Result.ok false

/- [no_nested_borrows::test_is_cons]:
   Source: 'tests/src/no_nested_borrows.rs', lines 174:0-174:21 -/
def test_is_cons : Result Unit :=
  do
  let b ← is_cons I32 (List.Cons 0#i32 List.Nil)
  if b
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_is_cons] -/
#assert (test_is_cons == Result.ok ())

/- [no_nested_borrows::split_list]:
   Source: 'tests/src/no_nested_borrows.rs', lines 180:0-180:48 -/
def split_list (T : Type) (l : List T) : Result (T × (List T)) :=
  match l with
  | List.Cons hd tl => Result.ok (hd, tl)
  | List.Nil => Result.fail .panic

/- [no_nested_borrows::test_split_list]:
   Source: 'tests/src/no_nested_borrows.rs', lines 188:0-188:24 -/
def test_split_list : Result Unit :=
  do
  let p ← split_list I32 (List.Cons 0#i32 List.Nil)
  let (hd, _) := p
  if hd = 0#i32
  then Result.ok ()
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_split_list] -/
#assert (test_split_list == Result.ok ())

/- [no_nested_borrows::choose]:
   Source: 'tests/src/no_nested_borrows.rs', lines 195:0-195:70 -/
def choose
  (T : Type) (b : Bool) (x : T) (y : T) :
  Result (T × (T → Result (T × T)))
  :=
  if b
  then let back := fun ret => Result.ok (ret, y)
       Result.ok (x, back)
  else let back := fun ret => Result.ok (x, ret)
       Result.ok (y, back)

/- [no_nested_borrows::choose_test]:
   Source: 'tests/src/no_nested_borrows.rs', lines 203:0-203:20 -/
def choose_test : Result Unit :=
  do
  let (z, choose_back) ← choose I32 true 0#i32 0#i32
  let z1 ← z + 1#i32
  if z1 = 1#i32
  then
    do
    let (x, y) ← choose_back z1
    if x = 1#i32
    then if y = 0#i32
         then Result.ok ()
         else Result.fail .panic
    else Result.fail .panic
  else Result.fail .panic

/- Unit test for [no_nested_borrows::choose_test] -/
#assert (choose_test == Result.ok ())

/- [no_nested_borrows::test_char]:
   Source: 'tests/src/no_nested_borrows.rs', lines 215:0-215:26 -/
def test_char : Result Char :=
  Result.ok 'a'

/- [no_nested_borrows::panic_mut_borrow]:
   Source: 'tests/src/no_nested_borrows.rs', lines 220:0-220:36 -/
def panic_mut_borrow (i : U32) : Result U32 :=
  Result.fail .panic

mutual

/- [no_nested_borrows::Tree]
   Source: 'tests/src/no_nested_borrows.rs', lines 225:0-225:16 -/
inductive Tree (T : Type) :=
| Leaf : T → Tree T
| Node : T → NodeElem T → Tree T → Tree T

/- [no_nested_borrows::NodeElem]
   Source: 'tests/src/no_nested_borrows.rs', lines 230:0-230:20 -/
inductive NodeElem (T : Type) :=
| Cons : Tree T → NodeElem T → NodeElem T
| Nil : NodeElem T

end

/- [no_nested_borrows::list_length]:
   Source: 'tests/src/no_nested_borrows.rs', lines 265:0-265:48 -/
divergent def list_length (T : Type) (l : List T) : Result U32 :=
  match l with
  | List.Cons _ l1 => do
                      let i ← list_length T l1
                      1#u32 + i
  | List.Nil => Result.ok 0#u32

/- [no_nested_borrows::list_nth_shared]:
   Source: 'tests/src/no_nested_borrows.rs', lines 273:0-273:62 -/
divergent def list_nth_shared (T : Type) (l : List T) (i : U32) : Result T :=
  match l with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ok x
    else do
         let i1 ← i - 1#u32
         list_nth_shared T tl i1
  | List.Nil => Result.fail .panic

/- [no_nested_borrows::list_nth_mut]:
   Source: 'tests/src/no_nested_borrows.rs', lines 289:0-289:67 -/
divergent def list_nth_mut
  (T : Type) (l : List T) (i : U32) : Result (T × (T → Result (List T))) :=
  match l with
  | List.Cons x tl =>
    if i = 0#u32
    then
      let back := fun ret => Result.ok (List.Cons ret tl)
      Result.ok (x, back)
    else
      do
      let i1 ← i - 1#u32
      let (t, list_nth_mut_back) ← list_nth_mut T tl i1
      let back :=
        fun ret =>
          do
          let tl1 ← list_nth_mut_back ret
          Result.ok (List.Cons x tl1)
      Result.ok (t, back)
  | List.Nil => Result.fail .panic

/- [no_nested_borrows::list_rev_aux]:
   Source: 'tests/src/no_nested_borrows.rs', lines 305:0-305:63 -/
divergent def list_rev_aux
  (T : Type) (li : List T) (lo : List T) : Result (List T) :=
  match li with
  | List.Cons hd tl => list_rev_aux T tl (List.Cons hd lo)
  | List.Nil => Result.ok lo

/- [no_nested_borrows::list_rev]:
   Source: 'tests/src/no_nested_borrows.rs', lines 319:0-319:42 -/
def list_rev (T : Type) (l : List T) : Result (List T) :=
  let (li, _) := core.mem.replace (List T) l List.Nil
  list_rev_aux T li List.Nil

/- [no_nested_borrows::test_list_functions]:
   Source: 'tests/src/no_nested_borrows.rs', lines 324:0-324:28 -/
def test_list_functions : Result Unit :=
  do
  let l := List.Cons 2#i32 List.Nil
  let l1 := List.Cons 1#i32 l
  let i ← list_length I32 (List.Cons 0#i32 l1)
  if i = 3#u32
  then
    do
    let i1 ← list_nth_shared I32 (List.Cons 0#i32 l1) 0#u32
    if i1 = 0#i32
    then
      do
      let i2 ← list_nth_shared I32 (List.Cons 0#i32 l1) 1#u32
      if i2 = 1#i32
      then
        do
        let i3 ← list_nth_shared I32 (List.Cons 0#i32 l1) 2#u32
        if i3 = 2#i32
        then
          do
          let (_, list_nth_mut_back) ←
            list_nth_mut I32 (List.Cons 0#i32 l1) 1#u32
          let ls ← list_nth_mut_back 3#i32
          let i4 ← list_nth_shared I32 ls 0#u32
          if i4 = 0#i32
          then
            do
            let i5 ← list_nth_shared I32 ls 1#u32
            if i5 = 3#i32
            then
              do
              let i6 ← list_nth_shared I32 ls 2#u32
              if i6 = 2#i32
              then Result.ok ()
              else Result.fail .panic
            else Result.fail .panic
          else Result.fail .panic
        else Result.fail .panic
      else Result.fail .panic
    else Result.fail .panic
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_list_functions] -/
#assert (test_list_functions == Result.ok ())

/- [no_nested_borrows::id_mut_pair1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 340:0-340:89 -/
def id_mut_pair1
  (T1 T2 : Type) (x : T1) (y : T2) :
  Result ((T1 × T2) × ((T1 × T2) → Result (T1 × T2)))
  :=
  Result.ok ((x, y), Result.ok)

/- [no_nested_borrows::id_mut_pair2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 344:0-344:88 -/
def id_mut_pair2
  (T1 T2 : Type) (p : (T1 × T2)) :
  Result ((T1 × T2) × ((T1 × T2) → Result (T1 × T2)))
  :=
  let (t, t1) := p
  Result.ok ((t, t1), Result.ok)

/- [no_nested_borrows::id_mut_pair3]:
   Source: 'tests/src/no_nested_borrows.rs', lines 348:0-348:93 -/
def id_mut_pair3
  (T1 T2 : Type) (x : T1) (y : T2) :
  Result ((T1 × T2) × (T1 → Result T1) × (T2 → Result T2))
  :=
  Result.ok ((x, y), Result.ok, Result.ok)

/- [no_nested_borrows::id_mut_pair4]:
   Source: 'tests/src/no_nested_borrows.rs', lines 352:0-352:92 -/
def id_mut_pair4
  (T1 T2 : Type) (p : (T1 × T2)) :
  Result ((T1 × T2) × (T1 → Result T1) × (T2 → Result T2))
  :=
  let (t, t1) := p
  Result.ok ((t, t1), Result.ok, Result.ok)

/- [no_nested_borrows::StructWithTuple]
   Source: 'tests/src/no_nested_borrows.rs', lines 359:0-359:34 -/
structure StructWithTuple (T1 T2 : Type) where
  p : (T1 × T2)

/- [no_nested_borrows::new_tuple1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 363:0-363:48 -/
def new_tuple1 : Result (StructWithTuple U32 U32) :=
  Result.ok { p := (1#u32, 2#u32) }

/- [no_nested_borrows::new_tuple2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 367:0-367:48 -/
def new_tuple2 : Result (StructWithTuple I16 I16) :=
  Result.ok { p := (1#i16, 2#i16) }

/- [no_nested_borrows::new_tuple3]:
   Source: 'tests/src/no_nested_borrows.rs', lines 371:0-371:48 -/
def new_tuple3 : Result (StructWithTuple U64 I64) :=
  Result.ok { p := (1#u64, 2#i64) }

/- [no_nested_borrows::StructWithPair]
   Source: 'tests/src/no_nested_borrows.rs', lines 376:0-376:33 -/
structure StructWithPair (T1 T2 : Type) where
  p : Pair T1 T2

/- [no_nested_borrows::new_pair1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 380:0-380:46 -/
def new_pair1 : Result (StructWithPair U32 U32) :=
  Result.ok { p := { x := 1#u32, y := 2#u32 } }

/- [no_nested_borrows::test_constants]:
   Source: 'tests/src/no_nested_borrows.rs', lines 388:0-388:23 -/
def test_constants : Result Unit :=
  do
  let swt ← new_tuple1
  let (i, _) := swt.p
  if i = 1#u32
  then
    do
    let swt1 ← new_tuple2
    let (i1, _) := swt1.p
    if i1 = 1#i16
    then
      do
      let swt2 ← new_tuple3
      let (i2, _) := swt2.p
      if i2 = 1#u64
      then
        do
        let swp ← new_pair1
        if swp.p.x = 1#u32
        then Result.ok ()
        else Result.fail .panic
      else Result.fail .panic
    else Result.fail .panic
  else Result.fail .panic

/- Unit test for [no_nested_borrows::test_constants] -/
#assert (test_constants == Result.ok ())

/- [no_nested_borrows::test_weird_borrows1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 397:0-397:28 -/
def test_weird_borrows1 : Result Unit :=
  Result.ok ()

/- Unit test for [no_nested_borrows::test_weird_borrows1] -/
#assert (test_weird_borrows1 == Result.ok ())

/- [no_nested_borrows::test_mem_replace]:
   Source: 'tests/src/no_nested_borrows.rs', lines 407:0-407:37 -/
def test_mem_replace (px : U32) : Result U32 :=
  let (y, _) := core.mem.replace U32 px 1#u32
  if y = 0#u32
  then Result.ok 2#u32
  else Result.fail .panic

/- [no_nested_borrows::test_shared_borrow_bool1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 414:0-414:47 -/
def test_shared_borrow_bool1 (b : Bool) : Result U32 :=
  if b
  then Result.ok 0#u32
  else Result.ok 1#u32

/- [no_nested_borrows::test_shared_borrow_bool2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 427:0-427:40 -/
def test_shared_borrow_bool2 : Result U32 :=
  Result.ok 0#u32

/- [no_nested_borrows::test_shared_borrow_enum1]:
   Source: 'tests/src/no_nested_borrows.rs', lines 442:0-442:52 -/
def test_shared_borrow_enum1 (l : List U32) : Result U32 :=
  match l with
  | List.Cons _ _ => Result.ok 1#u32
  | List.Nil => Result.ok 0#u32

/- [no_nested_borrows::test_shared_borrow_enum2]:
   Source: 'tests/src/no_nested_borrows.rs', lines 454:0-454:40 -/
def test_shared_borrow_enum2 : Result U32 :=
  Result.ok 0#u32

/- [no_nested_borrows::incr]:
   Source: 'tests/src/no_nested_borrows.rs', lines 465:0-465:24 -/
def incr (x : U32) : Result U32 :=
  x + 1#u32

/- [no_nested_borrows::call_incr]:
   Source: 'tests/src/no_nested_borrows.rs', lines 469:0-469:35 -/
def call_incr (x : U32) : Result U32 :=
  incr x

/- [no_nested_borrows::read_then_incr]:
   Source: 'tests/src/no_nested_borrows.rs', lines 474:0-474:41 -/
def read_then_incr (x : U32) : Result (U32 × U32) :=
  do
  let x1 ← x + 1#u32
  Result.ok (x, x1)

/- [no_nested_borrows::Tuple]
   Source: 'tests/src/no_nested_borrows.rs', lines 480:0-480:24 -/
def Tuple (T1 T2 : Type) := T1 × T2

/- [no_nested_borrows::read_tuple]:
   Source: 'tests/src/no_nested_borrows.rs', lines 482:0-482:40 -/
def read_tuple (x : (U32 × U32)) : Result U32 :=
  let (i, _) := x
  Result.ok i

/- [no_nested_borrows::update_tuple]:
   Source: 'tests/src/no_nested_borrows.rs', lines 486:0-486:39 -/
def update_tuple (x : (U32 × U32)) : Result (U32 × U32) :=
  let (_, i) := x
  Result.ok (1#u32, i)

/- [no_nested_borrows::read_tuple_struct]:
   Source: 'tests/src/no_nested_borrows.rs', lines 490:0-490:52 -/
def read_tuple_struct (x : Tuple U32 U32) : Result U32 :=
  let (i, _) := x
  Result.ok i

/- [no_nested_borrows::update_tuple_struct]:
   Source: 'tests/src/no_nested_borrows.rs', lines 494:0-494:51 -/
def update_tuple_struct (x : Tuple U32 U32) : Result (Tuple U32 U32) :=
  let (_, i) := x
  Result.ok (1#u32, i)

/- [no_nested_borrows::create_tuple_struct]:
   Source: 'tests/src/no_nested_borrows.rs', lines 498:0-498:61 -/
def create_tuple_struct (x : U32) (y : U64) : Result (Tuple U32 U64) :=
  Result.ok (x, y)

/- [no_nested_borrows::IdType]
   Source: 'tests/src/no_nested_borrows.rs', lines 503:0-503:20 -/
@[reducible] def IdType (T : Type) := T

/- [no_nested_borrows::use_id_type]:
   Source: 'tests/src/no_nested_borrows.rs', lines 505:0-505:40 -/
def use_id_type (T : Type) (x : IdType T) : Result T :=
  Result.ok x

/- [no_nested_borrows::create_id_type]:
   Source: 'tests/src/no_nested_borrows.rs', lines 509:0-509:43 -/
def create_id_type (T : Type) (x : T) : Result (IdType T) :=
  Result.ok x

end no_nested_borrows
