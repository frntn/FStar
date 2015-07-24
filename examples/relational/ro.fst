(*--build-config
    options:--admit_fsi Set;
    variables:LIB=../../lib;
    other-files:$LIB/ext.fst $LIB/set.fsi $LIB/heap.fst $LIB/st.fst $LIB/st2.fst $LIB/bytes.fst $LIB/list.fst  

  --*)

module Ro

open Comp
open Heap
open List
open Bytes

type map (a:Type) (b:Type) = list (a * b)

let eta = 16

type key = b:bytes{length(b)=eta}
type tag = b:bytes{length(b)=eta}

(* TODO? *)
(* an abstract relational predicate on correctly-generated entries *) 
assume logic type safe (k:key) (k':key) (t:tag) (t':tag)  


type alloc = 
  | Hon: alloc
  | Adv: alloc (* a "ghost" field recording the first allocator for a given key *) 

type log = map key (alloc * tag)

type state =
  { bad: bool; (* set iff any allocation has failed, e.g. bumped into the other's table *) 
    l:log }    (* the map ensures at most one entry per key *)

type Ok : log -> log -> Type = 
  | Null: Ok [] [] 
  | ConsH: k0:key -> k1:key-> t0:tag -> t1:tag { safe k0 k1 t0 t1 } 
           -> log0:log -> log1:log { Ok log0 log1 } 
           -> Ok ((k0,(Hon,t0))::log0) ((k1,(Hon,t1))::log1)
  | ConsA: k:key -> t:tag 
           -> log0:log -> log1:log { Ok log0 log1 } 
           -> Ok ((k ,(Adv,t ))::log0) ((k, (Adv,t ))::log1)

type goodstate (s1:state) (s2:state) = 
            s1.bad = true \/ s2.bad = true \/ Ok s1.l s2.l

assume val s : ref state 
assume val sample_hon : k0:key -> k1:key -> 
                 ST2 (tag * tag)
                   (requires (fun _ -> True))
                   (ensures (fun _ p _ -> safe k0 k1 (fst p) (snd p)))
assume val sample_adv : unit -> 
                 ST2 (tag * tag)
                   (requires (fun _ -> True))
                   (ensures (fun _ p _ -> fst p = snd p))

val hash_hon:  k0:key -> k1:key ->
               ST2 (option tag * option tag)
               (requires (fun h2 -> goodstate (sel (fst h2) s) (sel (snd h2) s)))
               (ensures (fun _ p h2 -> (sel (fst h2) s).bad \/ 
                                       (sel (snd h2) s).bad \/ 
                                       is_Some (fst p) /\ is_Some (snd p) /\ 
                                          safe k0 k1 (Some.v(fst p)) (Some.v(snd p))))

val hash_adv:  k:key -> 
               ST2 (option tag * option tag)
               (requires (fun h2 -> goodstate (sel (fst h2) s) (sel (snd h2) s)))
               (ensures (fun _ p h2 -> (sel (fst h2) s).bad \/ 
                                       (sel (snd h2) s).bad \/ 
                                       is_Some (fst p) /\ is_Some (snd p) /\ 
                                          Some.v(fst p) = Some.v(snd p)))
                                      
(* circumvent some typing problems... *)
val add_some : tag -> Tot (option tag)
let add_some t = Some t

let hash_hon' k r =  match assoc k (!s).l with 
  | Some (Hon,t) (* TODO ->  add_some t *) 
  | Some (Adv,t) -> s := {bad = true; l = (!s).l}; None
  | None         -> let t = r in 
                    s := {bad = (!s).bad; l= (k,(Hon,t))::(!s).l} ; 
                    add_some t 

let hash_hon k0 k1  = let r0, r1 = sample_hon k0 k1 in 
                      (compose2 (fun k -> hash_hon' k r0) 
                                (fun k -> hash_hon' k r1) 
                                k0 k1)

let hash_adv' k r =  match assoc k (!s).l with 
  | Some (Adv,t) (* TODO -> add_some t *)
  | Some (Hon,t) -> s := {bad = true; l = (!s).l}; None
  | None         -> let t = r in 
                    s := {bad = (!s).bad; l= (k,(Adv,t))::(!s).l} ; 
                    add_some t 

let hash_adv k  = let r0, r1 = sample_adv () in 
                  (compose2 (fun k -> hash_adv' k r0) 
                            (fun k -> hash_adv' k r1) 
                            k k)
