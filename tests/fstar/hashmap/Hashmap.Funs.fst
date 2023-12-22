(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap]: function definitions *)
module Hashmap.Funs
open Primitives
include Hashmap.Types
include Hashmap.Clauses

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [hashmap::hash_key]:
    Source: 'src/hashmap.rs', lines 27:0-27:32 *)
let hash_key (k : usize) : result usize =
  Return k

(** [hashmap::{hashmap::HashMap<T>}::allocate_slots]: loop 0:
    Source: 'src/hashmap.rs', lines 50:4-56:5 *)
let rec hashMap_allocate_slots_loop
  (t : Type0) (slots : alloc_vec_Vec (list_t t)) (n : usize) :
  Tot (result (alloc_vec_Vec (list_t t)))
  (decreases (hashMap_allocate_slots_loop_decreases t slots n))
  =
  if n > 0
  then
    let* v = alloc_vec_Vec_push (list_t t) slots List_Nil in
    let* n1 = usize_sub n 1 in
    hashMap_allocate_slots_loop t v n1
  else Return slots

(** [hashmap::{hashmap::HashMap<T>}::allocate_slots]:
    Source: 'src/hashmap.rs', lines 50:4-50:76 *)
let hashMap_allocate_slots
  (t : Type0) (slots : alloc_vec_Vec (list_t t)) (n : usize) :
  result (alloc_vec_Vec (list_t t))
  =
  hashMap_allocate_slots_loop t slots n

(** [hashmap::{hashmap::HashMap<T>}::new_with_capacity]:
    Source: 'src/hashmap.rs', lines 59:4-63:13 *)
let hashMap_new_with_capacity
  (t : Type0) (capacity : usize) (max_load_dividend : usize)
  (max_load_divisor : usize) :
  result (hashMap_t t)
  =
  let v = alloc_vec_Vec_new (list_t t) in
  let* slots = hashMap_allocate_slots t v capacity in
  let* i = usize_mul capacity max_load_dividend in
  let* i1 = usize_div i max_load_divisor in
  Return
    {
      num_entries = 0;
      max_load_factor = (max_load_dividend, max_load_divisor);
      max_load = i1;
      slots = slots
    }

(** [hashmap::{hashmap::HashMap<T>}::new]:
    Source: 'src/hashmap.rs', lines 75:4-75:24 *)
let hashMap_new (t : Type0) : result (hashMap_t t) =
  hashMap_new_with_capacity t 32 4 5

(** [hashmap::{hashmap::HashMap<T>}::clear]: loop 0:
    Source: 'src/hashmap.rs', lines 80:4-88:5 *)
let rec hashMap_clear_loop
  (t : Type0) (slots : alloc_vec_Vec (list_t t)) (i : usize) :
  Tot (result (alloc_vec_Vec (list_t t)))
  (decreases (hashMap_clear_loop_decreases t slots i))
  =
  let i1 = alloc_vec_Vec_len (list_t t) slots in
  if i < i1
  then
    let* (_, index_mut_back) =
      alloc_vec_Vec_index_mut (list_t t) usize
        (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) slots i in
    let* i2 = usize_add i 1 in
    let* slots1 = index_mut_back List_Nil in
    hashMap_clear_loop t slots1 i2
  else Return slots

(** [hashmap::{hashmap::HashMap<T>}::clear]:
    Source: 'src/hashmap.rs', lines 80:4-80:27 *)
let hashMap_clear (t : Type0) (self : hashMap_t t) : result (hashMap_t t) =
  let* back = hashMap_clear_loop t self.slots 0 in
  Return { self with num_entries = 0; slots = back }

(** [hashmap::{hashmap::HashMap<T>}::len]:
    Source: 'src/hashmap.rs', lines 90:4-90:30 *)
let hashMap_len (t : Type0) (self : hashMap_t t) : result usize =
  Return self.num_entries

(** [hashmap::{hashmap::HashMap<T>}::insert_in_list]: loop 0:
    Source: 'src/hashmap.rs', lines 97:4-114:5 *)
let rec hashMap_insert_in_list_loop
  (t : Type0) (key : usize) (value : t) (ls : list_t t) :
  Tot (result (bool & (list_t t)))
  (decreases (hashMap_insert_in_list_loop_decreases t key value ls))
  =
  begin match ls with
  | List_Cons ckey cvalue tl ->
    if ckey = key
    then Return (false, List_Cons ckey value tl)
    else
      let* (b, back) = hashMap_insert_in_list_loop t key value tl in
      Return (b, List_Cons ckey cvalue back)
  | List_Nil -> let l = List_Nil in Return (true, List_Cons key value l)
  end

(** [hashmap::{hashmap::HashMap<T>}::insert_in_list]:
    Source: 'src/hashmap.rs', lines 97:4-97:71 *)
let hashMap_insert_in_list
  (t : Type0) (key : usize) (value : t) (ls : list_t t) :
  result (bool & (list_t t))
  =
  hashMap_insert_in_list_loop t key value ls

(** [hashmap::{hashmap::HashMap<T>}::insert_no_resize]:
    Source: 'src/hashmap.rs', lines 117:4-117:54 *)
let hashMap_insert_no_resize
  (t : Type0) (self : hashMap_t t) (key : usize) (value : t) :
  result (hashMap_t t)
  =
  let* hash = hash_key key in
  let i = alloc_vec_Vec_len (list_t t) self.slots in
  let* hash_mod = usize_rem hash i in
  let* (l, index_mut_back) =
    alloc_vec_Vec_index_mut (list_t t) usize
      (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) self.slots
      hash_mod in
  let* (inserted, l1) = hashMap_insert_in_list t key value l in
  if inserted
  then
    let* i1 = usize_add self.num_entries 1 in
    let* v = index_mut_back l1 in
    Return { self with num_entries = i1; slots = v }
  else let* v = index_mut_back l1 in Return { self with slots = v }

(** [hashmap::{hashmap::HashMap<T>}::move_elements_from_list]: loop 0:
    Source: 'src/hashmap.rs', lines 183:4-196:5 *)
let rec hashMap_move_elements_from_list_loop
  (t : Type0) (ntable : hashMap_t t) (ls : list_t t) :
  Tot (result (hashMap_t t))
  (decreases (hashMap_move_elements_from_list_loop_decreases t ntable ls))
  =
  begin match ls with
  | List_Cons k v tl ->
    let* hm = hashMap_insert_no_resize t ntable k v in
    hashMap_move_elements_from_list_loop t hm tl
  | List_Nil -> Return ntable
  end

(** [hashmap::{hashmap::HashMap<T>}::move_elements_from_list]:
    Source: 'src/hashmap.rs', lines 183:4-183:72 *)
let hashMap_move_elements_from_list
  (t : Type0) (ntable : hashMap_t t) (ls : list_t t) : result (hashMap_t t) =
  hashMap_move_elements_from_list_loop t ntable ls

(** [hashmap::{hashmap::HashMap<T>}::move_elements]: loop 0:
    Source: 'src/hashmap.rs', lines 171:4-180:5 *)
let rec hashMap_move_elements_loop
  (t : Type0) (ntable : hashMap_t t) (slots : alloc_vec_Vec (list_t t))
  (i : usize) :
  Tot (result ((hashMap_t t) & (alloc_vec_Vec (list_t t))))
  (decreases (hashMap_move_elements_loop_decreases t ntable slots i))
  =
  let i1 = alloc_vec_Vec_len (list_t t) slots in
  if i < i1
  then
    let* (l, index_mut_back) =
      alloc_vec_Vec_index_mut (list_t t) usize
        (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) slots i in
    let (ls, l1) = core_mem_replace (list_t t) l List_Nil in
    let* hm = hashMap_move_elements_from_list t ntable ls in
    let* i2 = usize_add i 1 in
    let* slots1 = index_mut_back l1 in
    let* back_'a = hashMap_move_elements_loop t hm slots1 i2 in
    let (hm1, v) = back_'a in
    Return (hm1, v)
  else Return (ntable, slots)

(** [hashmap::{hashmap::HashMap<T>}::move_elements]:
    Source: 'src/hashmap.rs', lines 171:4-171:95 *)
let hashMap_move_elements
  (t : Type0) (ntable : hashMap_t t) (slots : alloc_vec_Vec (list_t t))
  (i : usize) :
  result ((hashMap_t t) & (alloc_vec_Vec (list_t t)))
  =
  let* back_'a = hashMap_move_elements_loop t ntable slots i in
  let (hm, v) = back_'a in
  Return (hm, v)

(** [hashmap::{hashmap::HashMap<T>}::try_resize]:
    Source: 'src/hashmap.rs', lines 140:4-140:28 *)
let hashMap_try_resize
  (t : Type0) (self : hashMap_t t) : result (hashMap_t t) =
  let* max_usize = scalar_cast U32 Usize core_u32_max in
  let capacity = alloc_vec_Vec_len (list_t t) self.slots in
  let* n1 = usize_div max_usize 2 in
  let (i, i1) = self.max_load_factor in
  let* i2 = usize_div n1 i in
  if capacity <= i2
  then
    let* i3 = usize_mul capacity 2 in
    let* ntable = hashMap_new_with_capacity t i3 i i1 in
    let* p = hashMap_move_elements t ntable self.slots 0 in
    let (ntable1, _) = p in
    Return
      { ntable1 with num_entries = self.num_entries; max_load_factor = (i, i1)
      }
  else Return { self with max_load_factor = (i, i1) }

(** [hashmap::{hashmap::HashMap<T>}::insert]:
    Source: 'src/hashmap.rs', lines 129:4-129:48 *)
let hashMap_insert
  (t : Type0) (self : hashMap_t t) (key : usize) (value : t) :
  result (hashMap_t t)
  =
  let* hm = hashMap_insert_no_resize t self key value in
  let* i = hashMap_len t hm in
  if i > hm.max_load then hashMap_try_resize t hm else Return hm

(** [hashmap::{hashmap::HashMap<T>}::contains_key_in_list]: loop 0:
    Source: 'src/hashmap.rs', lines 206:4-219:5 *)
let rec hashMap_contains_key_in_list_loop
  (t : Type0) (key : usize) (ls : list_t t) :
  Tot (result bool)
  (decreases (hashMap_contains_key_in_list_loop_decreases t key ls))
  =
  begin match ls with
  | List_Cons ckey _ tl ->
    if ckey = key
    then Return true
    else hashMap_contains_key_in_list_loop t key tl
  | List_Nil -> Return false
  end

(** [hashmap::{hashmap::HashMap<T>}::contains_key_in_list]:
    Source: 'src/hashmap.rs', lines 206:4-206:68 *)
let hashMap_contains_key_in_list
  (t : Type0) (key : usize) (ls : list_t t) : result bool =
  hashMap_contains_key_in_list_loop t key ls

(** [hashmap::{hashmap::HashMap<T>}::contains_key]:
    Source: 'src/hashmap.rs', lines 199:4-199:49 *)
let hashMap_contains_key
  (t : Type0) (self : hashMap_t t) (key : usize) : result bool =
  let* hash = hash_key key in
  let i = alloc_vec_Vec_len (list_t t) self.slots in
  let* hash_mod = usize_rem hash i in
  let* l =
    alloc_vec_Vec_index (list_t t) usize
      (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) self.slots
      hash_mod in
  hashMap_contains_key_in_list t key l

(** [hashmap::{hashmap::HashMap<T>}::get_in_list]: loop 0:
    Source: 'src/hashmap.rs', lines 224:4-237:5 *)
let rec hashMap_get_in_list_loop
  (t : Type0) (key : usize) (ls : list_t t) :
  Tot (result t) (decreases (hashMap_get_in_list_loop_decreases t key ls))
  =
  begin match ls with
  | List_Cons ckey cvalue tl ->
    if ckey = key then Return cvalue else hashMap_get_in_list_loop t key tl
  | List_Nil -> Fail Failure
  end

(** [hashmap::{hashmap::HashMap<T>}::get_in_list]:
    Source: 'src/hashmap.rs', lines 224:4-224:70 *)
let hashMap_get_in_list (t : Type0) (key : usize) (ls : list_t t) : result t =
  hashMap_get_in_list_loop t key ls

(** [hashmap::{hashmap::HashMap<T>}::get]:
    Source: 'src/hashmap.rs', lines 239:4-239:55 *)
let hashMap_get (t : Type0) (self : hashMap_t t) (key : usize) : result t =
  let* hash = hash_key key in
  let i = alloc_vec_Vec_len (list_t t) self.slots in
  let* hash_mod = usize_rem hash i in
  let* l =
    alloc_vec_Vec_index (list_t t) usize
      (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) self.slots
      hash_mod in
  hashMap_get_in_list t key l

(** [hashmap::{hashmap::HashMap<T>}::get_mut_in_list]: loop 0:
    Source: 'src/hashmap.rs', lines 245:4-254:5 *)
let rec hashMap_get_mut_in_list_loop
  (t : Type0) (ls : list_t t) (key : usize) :
  Tot (result (t & (t -> result (list_t t))))
  (decreases (hashMap_get_mut_in_list_loop_decreases t ls key))
  =
  begin match ls with
  | List_Cons ckey cvalue tl ->
    if ckey = key
    then
      let back_'a = fun ret -> Return (List_Cons ckey ret tl) in
      Return (cvalue, back_'a)
    else
      let* (x, back_'a) = hashMap_get_mut_in_list_loop t tl key in
      let back_'a1 =
        fun ret -> let* tl1 = back_'a ret in Return (List_Cons ckey cvalue tl1)
        in
      Return (x, back_'a1)
  | List_Nil -> Fail Failure
  end

(** [hashmap::{hashmap::HashMap<T>}::get_mut_in_list]:
    Source: 'src/hashmap.rs', lines 245:4-245:86 *)
let hashMap_get_mut_in_list
  (t : Type0) (ls : list_t t) (key : usize) :
  result (t & (t -> result (list_t t)))
  =
  let* (x, back_'a) = hashMap_get_mut_in_list_loop t ls key in
  let back_'a1 = fun ret -> back_'a ret in
  Return (x, back_'a1)

(** [hashmap::{hashmap::HashMap<T>}::get_mut]:
    Source: 'src/hashmap.rs', lines 257:4-257:67 *)
let hashMap_get_mut
  (t : Type0) (self : hashMap_t t) (key : usize) :
  result (t & (t -> result (hashMap_t t)))
  =
  let* hash = hash_key key in
  let i = alloc_vec_Vec_len (list_t t) self.slots in
  let* hash_mod = usize_rem hash i in
  let* (l, index_mut_back) =
    alloc_vec_Vec_index_mut (list_t t) usize
      (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) self.slots
      hash_mod in
  let* (x, get_mut_in_list_back) = hashMap_get_mut_in_list t l key in
  let back_'a =
    fun ret ->
      let* l1 = get_mut_in_list_back ret in
      let* v = index_mut_back l1 in
      Return { self with slots = v } in
  Return (x, back_'a)

(** [hashmap::{hashmap::HashMap<T>}::remove_from_list]: loop 0:
    Source: 'src/hashmap.rs', lines 265:4-291:5 *)
let rec hashMap_remove_from_list_loop
  (t : Type0) (key : usize) (ls : list_t t) :
  Tot (result ((option t) & (list_t t)))
  (decreases (hashMap_remove_from_list_loop_decreases t key ls))
  =
  begin match ls with
  | List_Cons ckey x tl ->
    if ckey = key
    then
      let (mv_ls, _) =
        core_mem_replace (list_t t) (List_Cons ckey x tl) List_Nil in
      begin match mv_ls with
      | List_Cons _ cvalue tl1 -> Return (Some cvalue, tl1)
      | List_Nil -> Fail Failure
      end
    else
      let* (o, back) = hashMap_remove_from_list_loop t key tl in
      Return (o, List_Cons ckey x back)
  | List_Nil -> Return (None, List_Nil)
  end

(** [hashmap::{hashmap::HashMap<T>}::remove_from_list]:
    Source: 'src/hashmap.rs', lines 265:4-265:69 *)
let hashMap_remove_from_list
  (t : Type0) (key : usize) (ls : list_t t) :
  result ((option t) & (list_t t))
  =
  hashMap_remove_from_list_loop t key ls

(** [hashmap::{hashmap::HashMap<T>}::remove]:
    Source: 'src/hashmap.rs', lines 294:4-294:52 *)
let hashMap_remove
  (t : Type0) (self : hashMap_t t) (key : usize) :
  result ((option t) & (hashMap_t t))
  =
  let* hash = hash_key key in
  let i = alloc_vec_Vec_len (list_t t) self.slots in
  let* hash_mod = usize_rem hash i in
  let* (l, index_mut_back) =
    alloc_vec_Vec_index_mut (list_t t) usize
      (core_slice_index_SliceIndexUsizeSliceTInst (list_t t)) self.slots
      hash_mod in
  let* (x, l1) = hashMap_remove_from_list t key l in
  begin match x with
  | None ->
    let* v = index_mut_back l1 in Return (None, { self with slots = v })
  | Some x1 ->
    let* i1 = usize_sub self.num_entries 1 in
    let* v = index_mut_back l1 in
    Return (Some x1, { self with num_entries = i1; slots = v })
  end

(** [hashmap::test1]:
    Source: 'src/hashmap.rs', lines 315:0-315:10 *)
let test1 : result unit =
  let* hm = hashMap_new u64 in
  let* hm1 = hashMap_insert u64 hm 0 42 in
  let* hm2 = hashMap_insert u64 hm1 128 18 in
  let* hm3 = hashMap_insert u64 hm2 1024 138 in
  let* hm4 = hashMap_insert u64 hm3 1056 256 in
  let* i = hashMap_get u64 hm4 128 in
  if not (i = 18)
  then Fail Failure
  else
    let* (_, get_mut_back) = hashMap_get_mut u64 hm4 1024 in
    let* hm5 = get_mut_back 56 in
    let* i1 = hashMap_get u64 hm5 1024 in
    if not (i1 = 56)
    then Fail Failure
    else
      let* (x, hm6) = hashMap_remove u64 hm5 1024 in
      begin match x with
      | None -> Fail Failure
      | Some x1 ->
        if not (x1 = 56)
        then Fail Failure
        else
          let* i2 = hashMap_get u64 hm6 0 in
          if not (i2 = 42)
          then Fail Failure
          else
            let* i3 = hashMap_get u64 hm6 128 in
            if not (i3 = 18)
            then Fail Failure
            else
              let* i4 = hashMap_get u64 hm6 1056 in
              if not (i4 = 256) then Fail Failure else Return ()
      end

