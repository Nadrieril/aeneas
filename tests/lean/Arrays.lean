-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [arrays]
import Base
open Primitives

namespace arrays

/- [arrays::AB]
   Source: 'tests/src/arrays.rs', lines 6:0-6:11 -/
inductive AB :=
| A : AB
| B : AB

/- [arrays::incr]:
   Source: 'tests/src/arrays.rs', lines 11:0-11:24 -/
def incr (x : U32) : Result U32 :=
  x + 1#u32

/- [arrays::array_to_shared_slice_]:
   Source: 'tests/src/arrays.rs', lines 19:0-19:53 -/
def array_to_shared_slice_
  (T : Type) (s : Array T 32#usize) : Result (Slice T) :=
  Array.to_slice T 32#usize s

/- [arrays::array_to_mut_slice_]:
   Source: 'tests/src/arrays.rs', lines 24:0-24:58 -/
def array_to_mut_slice_
  (T : Type) (s : Array T 32#usize) :
  Result ((Slice T) × (Slice T → Result (Array T 32#usize)))
  :=
  Array.to_slice_mut T 32#usize s

/- [arrays::array_len]:
   Source: 'tests/src/arrays.rs', lines 28:0-28:40 -/
def array_len (T : Type) (s : Array T 32#usize) : Result Usize :=
  do
  let s1 ← Array.to_slice T 32#usize s
  Result.ok (Slice.len T s1)

/- [arrays::shared_array_len]:
   Source: 'tests/src/arrays.rs', lines 32:0-32:48 -/
def shared_array_len (T : Type) (s : Array T 32#usize) : Result Usize :=
  do
  let s1 ← Array.to_slice T 32#usize s
  Result.ok (Slice.len T s1)

/- [arrays::shared_slice_len]:
   Source: 'tests/src/arrays.rs', lines 36:0-36:44 -/
def shared_slice_len (T : Type) (s : Slice T) : Result Usize :=
  Result.ok (Slice.len T s)

/- [arrays::index_array_shared]:
   Source: 'tests/src/arrays.rs', lines 40:0-40:57 -/
def index_array_shared
  (T : Type) (s : Array T 32#usize) (i : Usize) : Result T :=
  Array.index_usize T 32#usize s i

/- [arrays::index_array_u32]:
   Source: 'tests/src/arrays.rs', lines 47:0-47:53 -/
def index_array_u32 (s : Array U32 32#usize) (i : Usize) : Result U32 :=
  Array.index_usize U32 32#usize s i

/- [arrays::index_array_copy]:
   Source: 'tests/src/arrays.rs', lines 51:0-51:45 -/
def index_array_copy (x : Array U32 32#usize) : Result U32 :=
  Array.index_usize U32 32#usize x 0#usize

/- [arrays::index_mut_array]:
   Source: 'tests/src/arrays.rs', lines 55:0-55:62 -/
def index_mut_array
  (T : Type) (s : Array T 32#usize) (i : Usize) :
  Result (T × (T → Result (Array T 32#usize)))
  :=
  Array.index_mut_usize T 32#usize s i

/- [arrays::index_slice]:
   Source: 'tests/src/arrays.rs', lines 59:0-59:46 -/
def index_slice (T : Type) (s : Slice T) (i : Usize) : Result T :=
  Slice.index_usize T s i

/- [arrays::index_mut_slice]:
   Source: 'tests/src/arrays.rs', lines 63:0-63:58 -/
def index_mut_slice
  (T : Type) (s : Slice T) (i : Usize) :
  Result (T × (T → Result (Slice T)))
  :=
  Slice.index_mut_usize T s i

/- [arrays::slice_subslice_shared_]:
   Source: 'tests/src/arrays.rs', lines 67:0-67:70 -/
def slice_subslice_shared_
  (x : Slice U32) (y : Usize) (z : Usize) : Result (Slice U32) :=
  core.slice.index.Slice.index U32 (core.ops.range.Range Usize)
    (core.slice.index.SliceIndexRangeUsizeSliceTInst U32) x
    { start := y, end_ := z }

/- [arrays::slice_subslice_mut_]:
   Source: 'tests/src/arrays.rs', lines 71:0-71:75 -/
def slice_subslice_mut_
  (x : Slice U32) (y : Usize) (z : Usize) :
  Result ((Slice U32) × (Slice U32 → Result (Slice U32)))
  :=
  do
  let (s, index_mut_back) ←
    core.slice.index.Slice.index_mut U32 (core.ops.range.Range Usize)
      (core.slice.index.SliceIndexRangeUsizeSliceTInst U32) x
      { start := y, end_ := z }
  Result.ok (s, index_mut_back)

/- [arrays::array_to_slice_shared_]:
   Source: 'tests/src/arrays.rs', lines 75:0-75:54 -/
def array_to_slice_shared_ (x : Array U32 32#usize) : Result (Slice U32) :=
  Array.to_slice U32 32#usize x

/- [arrays::array_to_slice_mut_]:
   Source: 'tests/src/arrays.rs', lines 79:0-79:59 -/
def array_to_slice_mut_
  (x : Array U32 32#usize) :
  Result ((Slice U32) × (Slice U32 → Result (Array U32 32#usize)))
  :=
  Array.to_slice_mut U32 32#usize x

/- [arrays::array_subslice_shared_]:
   Source: 'tests/src/arrays.rs', lines 83:0-83:74 -/
def array_subslice_shared_
  (x : Array U32 32#usize) (y : Usize) (z : Usize) : Result (Slice U32) :=
  core.array.Array.index U32 (core.ops.range.Range Usize) 32#usize
    (core.ops.index.IndexSliceTIInst U32 (core.ops.range.Range Usize)
    (core.slice.index.SliceIndexRangeUsizeSliceTInst U32)) x
    { start := y, end_ := z }

/- [arrays::array_subslice_mut_]:
   Source: 'tests/src/arrays.rs', lines 87:0-87:79 -/
def array_subslice_mut_
  (x : Array U32 32#usize) (y : Usize) (z : Usize) :
  Result ((Slice U32) × (Slice U32 → Result (Array U32 32#usize)))
  :=
  do
  let (s, index_mut_back) ←
    core.array.Array.index_mut U32 (core.ops.range.Range Usize) 32#usize
      (core.ops.index.IndexMutSliceTIInst U32 (core.ops.range.Range Usize)
      (core.slice.index.SliceIndexRangeUsizeSliceTInst U32)) x
      { start := y, end_ := z }
  Result.ok (s, index_mut_back)

/- [arrays::index_slice_0]:
   Source: 'tests/src/arrays.rs', lines 91:0-91:38 -/
def index_slice_0 (T : Type) (s : Slice T) : Result T :=
  Slice.index_usize T s 0#usize

/- [arrays::index_array_0]:
   Source: 'tests/src/arrays.rs', lines 95:0-95:42 -/
def index_array_0 (T : Type) (s : Array T 32#usize) : Result T :=
  Array.index_usize T 32#usize s 0#usize

/- [arrays::index_index_array]:
   Source: 'tests/src/arrays.rs', lines 106:0-106:71 -/
def index_index_array
  (s : Array (Array U32 32#usize) 32#usize) (i : Usize) (j : Usize) :
  Result U32
  :=
  do
  let a ← Array.index_usize (Array U32 32#usize) 32#usize s i
  Array.index_usize U32 32#usize a j

/- [arrays::update_update_array]:
   Source: 'tests/src/arrays.rs', lines 117:0-117:70 -/
def update_update_array
  (s : Array (Array U32 32#usize) 32#usize) (i : Usize) (j : Usize) :
  Result Unit
  :=
  do
  let (a, index_mut_back) ←
    Array.index_mut_usize (Array U32 32#usize) 32#usize s i
  let (_, index_mut_back1) ← Array.index_mut_usize U32 32#usize a j
  let a1 ← index_mut_back1 0#u32
  let _ ← index_mut_back a1
  Result.ok ()

/- [arrays::array_local_deep_copy]:
   Source: 'tests/src/arrays.rs', lines 121:0-121:43 -/
def array_local_deep_copy (x : Array U32 32#usize) : Result Unit :=
  Result.ok ()

/- [arrays::take_array]:
   Source: 'tests/src/arrays.rs', lines 125:0-125:30 -/
def take_array (a : Array U32 2#usize) : Result Unit :=
  Result.ok ()

/- [arrays::take_array_borrow]:
   Source: 'tests/src/arrays.rs', lines 126:0-126:38 -/
def take_array_borrow (a : Array U32 2#usize) : Result Unit :=
  Result.ok ()

/- [arrays::take_slice]:
   Source: 'tests/src/arrays.rs', lines 127:0-127:28 -/
def take_slice (s : Slice U32) : Result Unit :=
  Result.ok ()

/- [arrays::take_mut_slice]:
   Source: 'tests/src/arrays.rs', lines 128:0-128:36 -/
def take_mut_slice (s : Slice U32) : Result (Slice U32) :=
  Result.ok s

/- [arrays::const_array]:
   Source: 'tests/src/arrays.rs', lines 130:0-130:32 -/
def const_array : Result (Array U32 2#usize) :=
  Result.ok (Array.make U32 2#usize [ 0#u32, 0#u32 ])

/- [arrays::const_slice]:
   Source: 'tests/src/arrays.rs', lines 134:0-134:20 -/
def const_slice : Result Unit :=
  do
  let _ ←
    Array.to_slice U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  Result.ok ()

/- [arrays::take_all]:
   Source: 'tests/src/arrays.rs', lines 144:0-144:17 -/
def take_all : Result Unit :=
  do
  let _ ← take_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let _ ← take_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let _ ← take_array_borrow (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let s ←
    Array.to_slice U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let _ ← take_slice s
  let (s1, to_slice_mut_back) ←
    Array.to_slice_mut U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let s2 ← take_mut_slice s1
  let _ ← to_slice_mut_back s2
  Result.ok ()

/- [arrays::index_array]:
   Source: 'tests/src/arrays.rs', lines 158:0-158:38 -/
def index_array (x : Array U32 2#usize) : Result U32 :=
  Array.index_usize U32 2#usize x 0#usize

/- [arrays::index_array_borrow]:
   Source: 'tests/src/arrays.rs', lines 161:0-161:46 -/
def index_array_borrow (x : Array U32 2#usize) : Result U32 :=
  Array.index_usize U32 2#usize x 0#usize

/- [arrays::index_slice_u32_0]:
   Source: 'tests/src/arrays.rs', lines 165:0-165:42 -/
def index_slice_u32_0 (x : Slice U32) : Result U32 :=
  Slice.index_usize U32 x 0#usize

/- [arrays::index_mut_slice_u32_0]:
   Source: 'tests/src/arrays.rs', lines 169:0-169:50 -/
def index_mut_slice_u32_0 (x : Slice U32) : Result (U32 × (Slice U32)) :=
  do
  let i ← Slice.index_usize U32 x 0#usize
  Result.ok (i, x)

/- [arrays::index_all]:
   Source: 'tests/src/arrays.rs', lines 173:0-173:25 -/
def index_all : Result U32 :=
  do
  let i ← index_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let i1 ← index_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let i2 ← i + i1
  let i3 ← index_array_borrow (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let i4 ← i2 + i3
  let s ←
    Array.to_slice U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let i5 ← index_slice_u32_0 s
  let i6 ← i4 + i5
  let (s1, to_slice_mut_back) ←
    Array.to_slice_mut U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let (i7, s2) ← index_mut_slice_u32_0 s1
  let i8 ← i6 + i7
  let _ ← to_slice_mut_back s2
  Result.ok i8

/- [arrays::update_array]:
   Source: 'tests/src/arrays.rs', lines 187:0-187:36 -/
def update_array (x : Array U32 2#usize) : Result Unit :=
  do
  let (_, index_mut_back) ← Array.index_mut_usize U32 2#usize x 0#usize
  let _ ← index_mut_back 1#u32
  Result.ok ()

/- [arrays::update_array_mut_borrow]:
   Source: 'tests/src/arrays.rs', lines 190:0-190:48 -/
def update_array_mut_borrow
  (x : Array U32 2#usize) : Result (Array U32 2#usize) :=
  do
  let (_, index_mut_back) ← Array.index_mut_usize U32 2#usize x 0#usize
  index_mut_back 1#u32

/- [arrays::update_mut_slice]:
   Source: 'tests/src/arrays.rs', lines 193:0-193:38 -/
def update_mut_slice (x : Slice U32) : Result (Slice U32) :=
  do
  let (_, index_mut_back) ← Slice.index_mut_usize U32 x 0#usize
  index_mut_back 1#u32

/- [arrays::update_all]:
   Source: 'tests/src/arrays.rs', lines 197:0-197:19 -/
def update_all : Result Unit :=
  do
  let _ ← update_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let _ ← update_array (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let x ← update_array_mut_borrow (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let (s, to_slice_mut_back) ← Array.to_slice_mut U32 2#usize x
  let s1 ← update_mut_slice s
  let _ ← to_slice_mut_back s1
  Result.ok ()

/- [arrays::range_all]:
   Source: 'tests/src/arrays.rs', lines 208:0-208:18 -/
def range_all : Result Unit :=
  do
  let (s, index_mut_back) ←
    core.array.Array.index_mut U32 (core.ops.range.Range Usize) 4#usize
      (core.ops.index.IndexMutSliceTIInst U32 (core.ops.range.Range Usize)
      (core.slice.index.SliceIndexRangeUsizeSliceTInst U32))
      (Array.make U32 4#usize [ 0#u32, 0#u32, 0#u32, 0#u32 ])
      { start := 1#usize, end_ := 3#usize }
  let s1 ← update_mut_slice s
  let _ ← index_mut_back s1
  Result.ok ()

/- [arrays::deref_array_borrow]:
   Source: 'tests/src/arrays.rs', lines 217:0-217:46 -/
def deref_array_borrow (x : Array U32 2#usize) : Result U32 :=
  Array.index_usize U32 2#usize x 0#usize

/- [arrays::deref_array_mut_borrow]:
   Source: 'tests/src/arrays.rs', lines 222:0-222:54 -/
def deref_array_mut_borrow
  (x : Array U32 2#usize) : Result (U32 × (Array U32 2#usize)) :=
  do
  let i ← Array.index_usize U32 2#usize x 0#usize
  Result.ok (i, x)

/- [arrays::take_array_t]:
   Source: 'tests/src/arrays.rs', lines 230:0-230:31 -/
def take_array_t (a : Array AB 2#usize) : Result Unit :=
  Result.ok ()

/- [arrays::non_copyable_array]:
   Source: 'tests/src/arrays.rs', lines 232:0-232:27 -/
def non_copyable_array : Result Unit :=
  take_array_t (Array.make AB 2#usize [ AB.A, AB.B ])

/- [arrays::sum]: loop 0:
   Source: 'tests/src/arrays.rs', lines 245:0-253:1 -/
divergent def sum_loop (s : Slice U32) (sum1 : U32) (i : Usize) : Result U32 :=
  let i1 := Slice.len U32 s
  if i < i1
  then
    do
    let i2 ← Slice.index_usize U32 s i
    let sum3 ← sum1 + i2
    let i3 ← i + 1#usize
    sum_loop s sum3 i3
  else Result.ok sum1

/- [arrays::sum]:
   Source: 'tests/src/arrays.rs', lines 245:0-245:28 -/
def sum (s : Slice U32) : Result U32 :=
  sum_loop s 0#u32 0#usize

/- [arrays::sum2]: loop 0:
   Source: 'tests/src/arrays.rs', lines 255:0-264:1 -/
divergent def sum2_loop
  (s : Slice U32) (s2 : Slice U32) (sum1 : U32) (i : Usize) : Result U32 :=
  let i1 := Slice.len U32 s
  if i < i1
  then
    do
    let i2 ← Slice.index_usize U32 s i
    let i3 ← Slice.index_usize U32 s2 i
    let i4 ← i2 + i3
    let sum3 ← sum1 + i4
    let i5 ← i + 1#usize
    sum2_loop s s2 sum3 i5
  else Result.ok sum1

/- [arrays::sum2]:
   Source: 'tests/src/arrays.rs', lines 255:0-255:41 -/
def sum2 (s : Slice U32) (s2 : Slice U32) : Result U32 :=
  let i := Slice.len U32 s
  let i1 := Slice.len U32 s2
  if ¬ (i = i1)
  then Result.fail .panic
  else sum2_loop s s2 0#u32 0#usize

/- [arrays::f0]:
   Source: 'tests/src/arrays.rs', lines 266:0-266:11 -/
def f0 : Result Unit :=
  do
  let (s, to_slice_mut_back) ←
    Array.to_slice_mut U32 2#usize (Array.make U32 2#usize [ 1#u32, 2#u32 ])
  let (_, index_mut_back) ← Slice.index_mut_usize U32 s 0#usize
  let s1 ← index_mut_back 1#u32
  let _ ← to_slice_mut_back s1
  Result.ok ()

/- [arrays::f1]:
   Source: 'tests/src/arrays.rs', lines 271:0-271:11 -/
def f1 : Result Unit :=
  do
  let (_, index_mut_back) ←
    Array.index_mut_usize U32 2#usize (Array.make U32 2#usize [ 1#u32, 2#u32 ])
      0#usize
  let _ ← index_mut_back 1#u32
  Result.ok ()

/- [arrays::f2]:
   Source: 'tests/src/arrays.rs', lines 276:0-276:17 -/
def f2 (i : U32) : Result Unit :=
  Result.ok ()

/- [arrays::f4]:
   Source: 'tests/src/arrays.rs', lines 285:0-285:54 -/
def f4 (x : Array U32 32#usize) (y : Usize) (z : Usize) : Result (Slice U32) :=
  core.array.Array.index U32 (core.ops.range.Range Usize) 32#usize
    (core.ops.index.IndexSliceTIInst U32 (core.ops.range.Range Usize)
    (core.slice.index.SliceIndexRangeUsizeSliceTInst U32)) x
    { start := y, end_ := z }

/- [arrays::f3]:
   Source: 'tests/src/arrays.rs', lines 278:0-278:18 -/
def f3 : Result U32 :=
  do
  let i ←
    Array.index_usize U32 2#usize (Array.make U32 2#usize [ 1#u32, 2#u32 ])
      0#usize
  let _ ← f2 i
  let b := Array.repeat U32 32#usize 0#u32
  let s ←
    Array.to_slice U32 2#usize (Array.make U32 2#usize [ 1#u32, 2#u32 ])
  let s1 ← f4 b 16#usize 18#usize
  sum2 s s1

/- [arrays::SZ]
   Source: 'tests/src/arrays.rs', lines 289:0-289:19 -/
def SZ_body : Result Usize := Result.ok 32#usize
def SZ : Usize := eval_global SZ_body

/- [arrays::f5]:
   Source: 'tests/src/arrays.rs', lines 292:0-292:31 -/
def f5 (x : Array U32 32#usize) : Result U32 :=
  Array.index_usize U32 32#usize x 0#usize

/- [arrays::ite]:
   Source: 'tests/src/arrays.rs', lines 297:0-297:12 -/
def ite : Result Unit :=
  do
  let (s, to_slice_mut_back) ←
    Array.to_slice_mut U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let (_, s1) ← index_mut_slice_u32_0 s
  let (s2, to_slice_mut_back1) ←
    Array.to_slice_mut U32 2#usize (Array.make U32 2#usize [ 0#u32, 0#u32 ])
  let (_, s3) ← index_mut_slice_u32_0 s2
  let _ ← to_slice_mut_back1 s3
  let _ ← to_slice_mut_back s1
  Result.ok ()

/- [arrays::zero_slice]: loop 0:
   Source: 'tests/src/arrays.rs', lines 306:0-313:1 -/
divergent def zero_slice_loop
  (a : Slice U8) (i : Usize) (len : Usize) : Result (Slice U8) :=
  if i < len
  then
    do
    let (_, index_mut_back) ← Slice.index_mut_usize U8 a i
    let i1 ← i + 1#usize
    let a1 ← index_mut_back 0#u8
    zero_slice_loop a1 i1 len
  else Result.ok a

/- [arrays::zero_slice]:
   Source: 'tests/src/arrays.rs', lines 306:0-306:31 -/
def zero_slice (a : Slice U8) : Result (Slice U8) :=
  let len := Slice.len U8 a
  zero_slice_loop a 0#usize len

/- [arrays::iter_mut_slice]: loop 0:
   Source: 'tests/src/arrays.rs', lines 315:0-321:1 -/
divergent def iter_mut_slice_loop (len : Usize) (i : Usize) : Result Unit :=
  if i < len
  then do
       let i1 ← i + 1#usize
       iter_mut_slice_loop len i1
  else Result.ok ()

/- [arrays::iter_mut_slice]:
   Source: 'tests/src/arrays.rs', lines 315:0-315:35 -/
def iter_mut_slice (a : Slice U8) : Result (Slice U8) :=
  do
  let len := Slice.len U8 a
  let _ ← iter_mut_slice_loop len 0#usize
  Result.ok a

/- [arrays::sum_mut_slice]: loop 0:
   Source: 'tests/src/arrays.rs', lines 323:0-331:1 -/
divergent def sum_mut_slice_loop
  (a : Slice U32) (i : Usize) (s : U32) : Result U32 :=
  let i1 := Slice.len U32 a
  if i < i1
  then
    do
    let i2 ← Slice.index_usize U32 a i
    let s1 ← s + i2
    let i3 ← i + 1#usize
    sum_mut_slice_loop a i3 s1
  else Result.ok s

/- [arrays::sum_mut_slice]:
   Source: 'tests/src/arrays.rs', lines 323:0-323:42 -/
def sum_mut_slice (a : Slice U32) : Result (U32 × (Slice U32)) :=
  do
  let i ← sum_mut_slice_loop a 0#usize 0#u32
  Result.ok (i, a)

end arrays
