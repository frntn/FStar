﻿(*
   Copyright 2008-2014 Nikhil Swamy and Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
#light "off"
// (c) Microsoft Corporation. All rights reserved
module FStar.Syntax.Free

open Prims
open FStar
open FStar.Util
open FStar.Syntax
open FStar.Syntax.Syntax

(********************************************************************************)
(************************* Free names and unif variables ************************)
(********************************************************************************)
let singleton_bv x = Util.set_add x (new_bv_set())
let singleton_uv x = Util.set_add x (new_uv_set())
let union_nm_uv (x1, y1) (x2, y2) = Util.set_union x1 x2, Util.set_union y1 y2

let rec free_names_and_uvars' tm =
    let aux_binders bs acc = 
        bs |> List.fold_left (fun n (x, _) -> union_nm_uv n (free_names_and_uvars x.sort)) acc in
    let t = Subst.compress tm in 
    match t.n with
      | Tm_delayed _ -> failwith "Impossible"

      | Tm_name x ->
        singleton_bv x, no_uvs

      | Tm_uvar (x, _) -> 
        no_names, singleton_uv x

      | Tm_bvar _
      | Tm_name _
      | Tm_fvar _ 
      | Tm_constant _
      | Tm_type _ 
      | Tm_unknown -> 
        no_names, no_uvs
        
      | Tm_uinst(t, _) -> 
        free_names_and_uvars t

      | Tm_abs(bs, t) -> 
        aux_binders bs (free_names_and_uvars t)

      | Tm_arrow (bs, c) -> 
        aux_binders bs (free_names_and_uvars_comp c)

      | Tm_refine(bv, t) -> 
        aux_binders [bv, None] (free_names_and_uvars t)
      
      | Tm_app(t, args) -> 
        free_names_and_uvars_args args (free_names_and_uvars t)

      | Tm_match(t, pats) -> 
        pats |> List.fold_left (fun n (p, wopt, t) -> 
            let n1 = match wopt with 
                | None -> no_names, no_uvs 
                | Some w -> free_names_and_uvars w in 
            let n2 = free_names_and_uvars t in
            let n = union_nm_uv n1 (union_nm_uv n2 n) in
            pat_bvs p |> List.fold_left (fun n x -> union_nm_uv n (free_names_and_uvars x.sort)) n)
            (free_names_and_uvars t)
      
      | Tm_ascribed(t1, t2, _) -> 
        union_nm_uv (free_names_and_uvars t1) (free_names_and_uvars t2)

      | Tm_let(lbs, t) -> 
        snd lbs |> List.fold_left (fun n lb -> 
          union_nm_uv n (union_nm_uv (free_names_and_uvars lb.lbtyp) (free_names_and_uvars lb.lbdef)))
          (free_names_and_uvars t)
          
      | Tm_meta(t, Meta_pattern args) -> 
        List.fold_right free_names_and_uvars_args args (free_names_and_uvars t)

      | Tm_meta(t, _) -> 
        free_names_and_uvars t

and free_names_and_uvars t = 
    let t = Subst.compress t in 
    match !t.vars with 
        | Some n -> n 
        | _ -> 
        let n = free_names_and_uvars' t in
        t.vars := Some n;
        n

and free_names_and_uvars_args args acc = 
        args |> List.fold_left (fun n (x, _) -> union_nm_uv n (free_names_and_uvars x)) acc
 
and free_names_and_uvars_binders bs acc = 
        bs |> List.fold_left (fun n (x, _) -> union_nm_uv n (free_names_and_uvars x.sort)) acc 
              
and free_names_and_uvars_comp c = 
    match !c.vars with 
        | Some n -> n
        | _ -> 
         let n = match c.n with 
            | Total t -> 
              free_names_and_uvars t
            | Comp ct -> 
              free_names_and_uvars_args ct.effect_args (free_names_and_uvars ct.result_typ) in
         c.vars := Some n;
         n
         
let names t = fst (free_names_and_uvars t)
let names_of_binders (bs:binders) = fst (free_names_and_uvars_binders bs (no_names, no_uvs))
let uvars t = snd (free_names_and_uvars t)