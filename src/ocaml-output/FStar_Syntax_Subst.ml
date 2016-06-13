
open Prims

let rec force_uvar : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, _35_11) -> begin
(match ((FStar_Unionfind.find uv)) with
| FStar_Syntax_Syntax.Fixed (t') -> begin
(force_uvar t')
end
| _35_17 -> begin
t
end)
end
| _35_19 -> begin
t
end))


let rec force_delayed_thunk : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (f, m) -> begin
(match ((FStar_ST.read m)) with
| None -> begin
(match (f) with
| FStar_Util.Inr (c) -> begin
(

let t' = (let _125_8 = (c ())
in (force_delayed_thunk _125_8))
in (

let _35_29 = (FStar_ST.op_Colon_Equals m (Some (t')))
in t'))
end
| _35_32 -> begin
t
end)
end
| Some (t') -> begin
(

let t' = (force_delayed_thunk t')
in (

let _35_36 = (FStar_ST.op_Colon_Equals m (Some (t')))
in t'))
end)
end
| _35_39 -> begin
t
end))


let rec compress_univ : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun u -> (match (u) with
| FStar_Syntax_Syntax.U_unif (u') -> begin
(match ((FStar_Unionfind.find u')) with
| Some (u) -> begin
(compress_univ u)
end
| _35_46 -> begin
u
end)
end
| _35_48 -> begin
u
end))


let subst_to_string = (fun s -> (let _125_15 = (FStar_All.pipe_right s (FStar_List.map (fun _35_53 -> (match (_35_53) with
| (b, _35_52) -> begin
b.FStar_Syntax_Syntax.ppname.FStar_Ident.idText
end))))
in (FStar_All.pipe_right _125_15 (FStar_String.concat ", "))))


let subst_bv : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.term Prims.option = (fun a s -> (FStar_Util.find_map s (fun _35_1 -> (match (_35_1) with
| FStar_Syntax_Syntax.DB (i, x) when (i = a.FStar_Syntax_Syntax.index) -> begin
(let _125_23 = (let _125_22 = (let _125_21 = (FStar_Syntax_Syntax.range_of_bv a)
in (FStar_Syntax_Syntax.set_range_of_bv x _125_21))
in (FStar_Syntax_Syntax.bv_to_name _125_22))
in Some (_125_23))
end
| _35_62 -> begin
None
end))))


let subst_nm : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.term Prims.option = (fun a s -> (FStar_Util.find_map s (fun _35_2 -> (match (_35_2) with
| FStar_Syntax_Syntax.NM (x, i) when (FStar_Syntax_Syntax.bv_eq a x) -> begin
(let _125_29 = (FStar_Syntax_Syntax.bv_to_tm (

let _35_70 = a
in {FStar_Syntax_Syntax.ppname = _35_70.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = i; FStar_Syntax_Syntax.sort = _35_70.FStar_Syntax_Syntax.sort}))
in Some (_125_29))
end
| FStar_Syntax_Syntax.NT (x, t) when (FStar_Syntax_Syntax.bv_eq a x) -> begin
Some (t)
end
| _35_77 -> begin
None
end))))


let subst_univ_bv : Prims.int  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.universe Prims.option = (fun x s -> (FStar_Util.find_map s (fun _35_3 -> (match (_35_3) with
| FStar_Syntax_Syntax.UN (y, t) when (x = y) -> begin
Some (t)
end
| _35_86 -> begin
None
end))))


let subst_univ_nm : FStar_Syntax_Syntax.univ_name  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.universe Prims.option = (fun x s -> (FStar_Util.find_map s (fun _35_4 -> (match (_35_4) with
| FStar_Syntax_Syntax.UD (y, i) when (x.FStar_Ident.idText = y.FStar_Ident.idText) -> begin
Some (FStar_Syntax_Syntax.U_bvar (i))
end
| _35_95 -> begin
None
end))))


let rec apply_until_some = (fun f s -> (match (s) with
| [] -> begin
None
end
| (s0)::rest -> begin
(match ((f s0)) with
| None -> begin
(apply_until_some f rest)
end
| Some (st) -> begin
Some ((rest, st))
end)
end))


let map_some_curry = (fun f x _35_5 -> (match (_35_5) with
| None -> begin
x
end
| Some (a, b) -> begin
(f a b)
end))


let apply_until_some_then_map = (fun f s g t -> (let _125_67 = (apply_until_some f s)
in (FStar_All.pipe_right _125_67 (map_some_curry g t))))


let rec subst_univ : FStar_Syntax_Syntax.subst_elt Prims.list Prims.list  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun s u -> (

let u = (compress_univ u)
in (match (u) with
| FStar_Syntax_Syntax.U_bvar (x) -> begin
(apply_until_some_then_map (subst_univ_bv x) s subst_univ u)
end
| FStar_Syntax_Syntax.U_name (x) -> begin
(apply_until_some_then_map (subst_univ_nm x) s subst_univ u)
end
| (FStar_Syntax_Syntax.U_zero) | (FStar_Syntax_Syntax.U_unknown) | (FStar_Syntax_Syntax.U_unif (_)) -> begin
u
end
| FStar_Syntax_Syntax.U_succ (u) -> begin
(let _125_72 = (subst_univ s u)
in FStar_Syntax_Syntax.U_succ (_125_72))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(let _125_73 = (FStar_List.map (subst_univ s) us)
in FStar_Syntax_Syntax.U_max (_125_73))
end)))


let rec subst' : FStar_Syntax_Syntax.subst_ts  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun s t -> (match (s) with
| ([]) | (([])::[]) -> begin
t
end
| _35_139 -> begin
(

let t0 = (force_delayed_thunk t)
in (match (t0.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) -> begin
t0
end
| FStar_Syntax_Syntax.Tm_delayed (FStar_Util.Inl (t', s'), m) -> begin
(FStar_Syntax_Syntax.mk_Tm_delayed (FStar_Util.Inl ((t', (FStar_List.append s' s)))) t.FStar_Syntax_Syntax.pos)
end
| FStar_Syntax_Syntax.Tm_delayed (FStar_Util.Inr (_35_158), _35_161) -> begin
(FStar_All.failwith "Impossible: force_delayed_thunk removes lazy delayed nodes")
end
| FStar_Syntax_Syntax.Tm_bvar (a) -> begin
(apply_until_some_then_map (subst_bv a) s subst' t0)
end
| FStar_Syntax_Syntax.Tm_name (a) -> begin
(apply_until_some_then_map (subst_nm a) s subst' t0)
end
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(let _125_89 = (let _125_88 = (subst_univ s u)
in FStar_Syntax_Syntax.Tm_type (_125_88))
in (FStar_Syntax_Syntax.mk _125_89 None t0.FStar_Syntax_Syntax.pos))
end
| _35_171 -> begin
(FStar_Syntax_Syntax.mk_Tm_delayed (FStar_Util.Inl ((t0, s))) t.FStar_Syntax_Syntax.pos)
end))
end))
and subst_flags' : FStar_Syntax_Syntax.subst_ts  ->  FStar_Syntax_Syntax.cflags Prims.list  ->  FStar_Syntax_Syntax.cflags Prims.list = (fun s flags -> (FStar_All.pipe_right flags (FStar_List.map (fun _35_6 -> (match (_35_6) with
| FStar_Syntax_Syntax.DECREASES (a) -> begin
(let _125_94 = (subst' s a)
in FStar_Syntax_Syntax.DECREASES (_125_94))
end
| f -> begin
f
end)))))
and subst_comp_typ' : FStar_Syntax_Syntax.subst_elt Prims.list Prims.list  ->  FStar_Syntax_Syntax.comp_typ  ->  FStar_Syntax_Syntax.comp_typ = (fun s t -> (match (s) with
| ([]) | (([])::[]) -> begin
t
end
| _35_184 -> begin
(

let _35_185 = t
in (let _125_101 = (subst' s t.FStar_Syntax_Syntax.result_typ)
in (let _125_100 = (FStar_List.map (fun _35_189 -> (match (_35_189) with
| (t, imp) -> begin
(let _125_98 = (subst' s t)
in (_125_98, imp))
end)) t.FStar_Syntax_Syntax.effect_args)
in (let _125_99 = (subst_flags' s t.FStar_Syntax_Syntax.flags)
in {FStar_Syntax_Syntax.effect_name = _35_185.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = _125_101; FStar_Syntax_Syntax.effect_args = _125_100; FStar_Syntax_Syntax.flags = _125_99}))))
end))
and subst_comp' : FStar_Syntax_Syntax.subst_elt Prims.list Prims.list  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax = (fun s t -> (match (s) with
| ([]) | (([])::[]) -> begin
t
end
| _35_196 -> begin
(match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t) -> begin
(let _125_104 = (subst' s t)
in (FStar_Syntax_Syntax.mk_Total _125_104))
end
| FStar_Syntax_Syntax.GTotal (t) -> begin
(let _125_105 = (subst' s t)
in (FStar_Syntax_Syntax.mk_GTotal _125_105))
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
(let _125_106 = (subst_comp_typ' s ct)
in (FStar_Syntax_Syntax.mk_Comp _125_106))
end)
end))
and compose_subst : FStar_Syntax_Syntax.subst_ts  ->  FStar_Syntax_Syntax.subst_ts  ->  FStar_Syntax_Syntax.subst_elt Prims.list Prims.list = (fun s1 s2 -> (FStar_List.append s1 s2))


let shift : Prims.int  ->  FStar_Syntax_Syntax.subst_elt  ->  FStar_Syntax_Syntax.subst_elt = (fun n s -> (match (s) with
| FStar_Syntax_Syntax.DB (i, t) -> begin
FStar_Syntax_Syntax.DB (((i + n), t))
end
| FStar_Syntax_Syntax.UN (i, t) -> begin
FStar_Syntax_Syntax.UN (((i + n), t))
end
| FStar_Syntax_Syntax.NM (x, i) -> begin
FStar_Syntax_Syntax.NM ((x, (i + n)))
end
| FStar_Syntax_Syntax.UD (x, i) -> begin
FStar_Syntax_Syntax.UD ((x, (i + n)))
end
| FStar_Syntax_Syntax.NT (_35_224) -> begin
s
end))


let shift_subst : Prims.int  ->  FStar_Syntax_Syntax.subst_t  ->  FStar_Syntax_Syntax.subst_t = (fun n s -> (FStar_List.map (shift n) s))


let shift_subst' : Prims.int  ->  FStar_Syntax_Syntax.subst_t Prims.list  ->  FStar_Syntax_Syntax.subst_t Prims.list = (fun n s -> (FStar_All.pipe_right s (FStar_List.map (shift_subst n))))


let subst_binder' = (fun s _35_233 -> (match (_35_233) with
| (x, imp) -> begin
(let _125_124 = (

let _35_234 = x
in (let _125_123 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_234.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_234.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_123}))
in (_125_124, imp))
end))


let subst_binders' = (fun s bs -> (FStar_All.pipe_right bs (FStar_List.mapi (fun i b -> if (i = 0) then begin
(subst_binder' s b)
end else begin
(let _125_129 = (shift_subst' i s)
in (subst_binder' _125_129 b))
end))))


let subst_binders : FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders = (fun s bs -> (subst_binders' ((s)::[]) bs))


let subst_arg' = (fun s _35_245 -> (match (_35_245) with
| (t, imp) -> begin
<<<<<<< HEAD
(let _124_136 = (subst' s t)
in (_124_136, imp))
=======
(let _125_132 = (subst' s t)
in (_125_132, imp))
>>>>>>> master
end))


let subst_args' = (fun s -> (FStar_List.map (subst_arg' s)))


let subst_pat' : FStar_Syntax_Syntax.subst_t Prims.list  ->  (FStar_Syntax_Syntax.pat', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.withinfo_t  ->  (FStar_Syntax_Syntax.pat * Prims.int) = (fun s p -> (

let rec aux = (fun n p -> (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible: empty disjunction")
end
| FStar_Syntax_Syntax.Pat_constant (_35_255) -> begin
(p, n)
end
| FStar_Syntax_Syntax.Pat_disj ((p)::ps) -> begin
(

let _35_263 = (aux n p)
in (match (_35_263) with
| (p, m) -> begin
(

<<<<<<< HEAD
let ps = (FStar_List.map (fun p -> (let _124_149 = (aux n p)
in (Prims.fst _124_149))) ps)
=======
let ps = (FStar_List.map (fun p -> (let _125_145 = (aux n p)
in (Prims.fst _125_145))) ps)
>>>>>>> master
in ((

let _35_266 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_disj ((p)::ps); FStar_Syntax_Syntax.ty = _35_266.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_266.FStar_Syntax_Syntax.p}), m))
end))
end
| FStar_Syntax_Syntax.Pat_cons (fv, pats) -> begin
(

let _35_283 = (FStar_All.pipe_right pats (FStar_List.fold_left (fun _35_274 _35_277 -> (match ((_35_274, _35_277)) with
| ((pats, n), (p, imp)) -> begin
(

let _35_280 = (aux n p)
in (match (_35_280) with
| (p, m) -> begin
(((p, imp))::pats, m)
end))
end)) ([], n)))
in (match (_35_283) with
| (pats, n) -> begin
((

let _35_284 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_cons ((fv, (FStar_List.rev pats))); FStar_Syntax_Syntax.ty = _35_284.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_284.FStar_Syntax_Syntax.p}), n)
end))
end
| FStar_Syntax_Syntax.Pat_var (x) -> begin
(

let s = (shift_subst' n s)
in (

let x = (

<<<<<<< HEAD
let _35_289 = x
in (let _124_152 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_289.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_289.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_152}))
=======
let _35_287 = x
in (let _125_148 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_287.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_287.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_148}))
>>>>>>> master
in ((

let _35_292 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_var (x); FStar_Syntax_Syntax.ty = _35_292.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_292.FStar_Syntax_Syntax.p}), (n + 1))))
end
| FStar_Syntax_Syntax.Pat_wild (x) -> begin
(

let s = (shift_subst' n s)
in (

let x = (

<<<<<<< HEAD
let _35_297 = x
in (let _124_153 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_297.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_297.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_153}))
=======
let _35_295 = x
in (let _125_149 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_295.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_295.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_149}))
>>>>>>> master
in ((

let _35_300 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild (x); FStar_Syntax_Syntax.ty = _35_300.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_300.FStar_Syntax_Syntax.p}), (n + 1))))
end
| FStar_Syntax_Syntax.Pat_dot_term (x, t0) -> begin
(

let s = (shift_subst' n s)
in (

let x = (

<<<<<<< HEAD
let _35_307 = x
in (let _124_154 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_307.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_307.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_154}))
=======
let _35_305 = x
in (let _125_150 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_305.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_305.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_150}))
>>>>>>> master
in (

let t0 = (subst' s t0)
in ((

let _35_311 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_dot_term ((x, t0)); FStar_Syntax_Syntax.ty = _35_311.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_311.FStar_Syntax_Syntax.p}), n))))
end))
in (aux 0 p)))


let push_subst_lcomp = (fun s lopt -> (match (lopt) with
| (None) | (Some (FStar_Util.Inr (_))) -> begin
lopt
end
| Some (FStar_Util.Inl (l)) -> begin
<<<<<<< HEAD
(let _124_161 = (let _124_160 = (

let _35_323 = l
in (let _124_159 = (subst' s l.FStar_Syntax_Syntax.res_typ)
in {FStar_Syntax_Syntax.eff_name = _35_323.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _124_159; FStar_Syntax_Syntax.cflags = _35_323.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _35_325 -> (match (()) with
| () -> begin
(let _124_158 = (l.FStar_Syntax_Syntax.comp ())
in (subst_comp' s _124_158))
end))}))
in FStar_Util.Inl (_124_160))
in Some (_124_161))
=======
(let _125_157 = (let _125_156 = (

let _35_321 = l
in (let _125_155 = (subst' s l.FStar_Syntax_Syntax.res_typ)
in {FStar_Syntax_Syntax.eff_name = _35_321.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _125_155; FStar_Syntax_Syntax.cflags = _35_321.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _35_323 -> (match (()) with
| () -> begin
(let _125_154 = (l.FStar_Syntax_Syntax.comp ())
in (subst_comp' s _125_154))
end))}))
in FStar_Util.Inl (_125_156))
in Some (_125_157))
>>>>>>> master
end))


let push_subst : FStar_Syntax_Syntax.subst_ts  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun s t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (_35_329) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_unknown) | (FStar_Syntax_Syntax.Tm_uvar (_)) -> begin
t
end
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) -> begin
(subst' s t)
end
| FStar_Syntax_Syntax.Tm_uinst (t', us) -> begin
(

let us = (FStar_List.map (subst_univ s) us)
in (FStar_Syntax_Syntax.mk_Tm_uinst t' us))
end
| FStar_Syntax_Syntax.Tm_app (t0, args) -> begin
<<<<<<< HEAD
(let _124_172 = (let _124_171 = (let _124_170 = (subst' s t0)
in (let _124_169 = (subst_args' s args)
in (_124_170, _124_169)))
in FStar_Syntax_Syntax.Tm_app (_124_171))
in (FStar_Syntax_Syntax.mk _124_172 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_ascribed (t0, FStar_Util.Inl (t1), lopt) -> begin
(let _124_177 = (let _124_176 = (let _124_175 = (subst' s t0)
in (let _124_174 = (let _124_173 = (subst' s t1)
in FStar_Util.Inl (_124_173))
in (_124_175, _124_174, lopt)))
in FStar_Syntax_Syntax.Tm_ascribed (_124_176))
in (FStar_Syntax_Syntax.mk _124_177 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_ascribed (t0, FStar_Util.Inr (c), lopt) -> begin
(let _124_182 = (let _124_181 = (let _124_180 = (subst' s t0)
in (let _124_179 = (let _124_178 = (subst_comp' s c)
in FStar_Util.Inr (_124_178))
in (_124_180, _124_179, lopt)))
in FStar_Syntax_Syntax.Tm_ascribed (_124_181))
in (FStar_Syntax_Syntax.mk _124_182 None t.FStar_Syntax_Syntax.pos))
=======
(let _125_168 = (let _125_167 = (let _125_166 = (subst' s t0)
in (let _125_165 = (subst_args' s args)
in (_125_166, _125_165)))
in FStar_Syntax_Syntax.Tm_app (_125_167))
in (FStar_Syntax_Syntax.mk _125_168 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_ascribed (t0, FStar_Util.Inl (t1), lopt) -> begin
(let _125_173 = (let _125_172 = (let _125_171 = (subst' s t0)
in (let _125_170 = (let _125_169 = (subst' s t1)
in FStar_Util.Inl (_125_169))
in (_125_171, _125_170, lopt)))
in FStar_Syntax_Syntax.Tm_ascribed (_125_172))
in (FStar_Syntax_Syntax.mk _125_173 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_ascribed (t0, FStar_Util.Inr (c), lopt) -> begin
(let _125_178 = (let _125_177 = (let _125_176 = (subst' s t0)
in (let _125_175 = (let _125_174 = (subst_comp' s c)
in FStar_Util.Inr (_125_174))
in (_125_176, _125_175, lopt)))
in FStar_Syntax_Syntax.Tm_ascribed (_125_177))
in (FStar_Syntax_Syntax.mk _125_178 None t.FStar_Syntax_Syntax.pos))
>>>>>>> master
end
| FStar_Syntax_Syntax.Tm_abs (bs, body, lopt) -> begin
(

let n = (FStar_List.length bs)
in (

let s' = (shift_subst' n s)
<<<<<<< HEAD
in (let _124_187 = (let _124_186 = (let _124_185 = (subst_binders' s bs)
in (let _124_184 = (subst' s' body)
in (let _124_183 = (push_subst_lcomp s' lopt)
in (_124_185, _124_184, _124_183))))
in FStar_Syntax_Syntax.Tm_abs (_124_186))
in (FStar_Syntax_Syntax.mk _124_187 None t.FStar_Syntax_Syntax.pos))))
=======
in (let _125_183 = (let _125_182 = (let _125_181 = (subst_binders' s bs)
in (let _125_180 = (subst' s' body)
in (let _125_179 = (push_subst_lcomp s' lopt)
in (_125_181, _125_180, _125_179))))
in FStar_Syntax_Syntax.Tm_abs (_125_182))
in (FStar_Syntax_Syntax.mk _125_183 None t.FStar_Syntax_Syntax.pos))))
>>>>>>> master
end
| FStar_Syntax_Syntax.Tm_arrow (bs, comp) -> begin
(

let n = (FStar_List.length bs)
<<<<<<< HEAD
in (let _124_192 = (let _124_191 = (let _124_190 = (subst_binders' s bs)
in (let _124_189 = (let _124_188 = (shift_subst' n s)
in (subst_comp' _124_188 comp))
in (_124_190, _124_189)))
in FStar_Syntax_Syntax.Tm_arrow (_124_191))
in (FStar_Syntax_Syntax.mk _124_192 None t.FStar_Syntax_Syntax.pos)))
=======
in (let _125_188 = (let _125_187 = (let _125_186 = (subst_binders' s bs)
in (let _125_185 = (let _125_184 = (shift_subst' n s)
in (subst_comp' _125_184 comp))
in (_125_186, _125_185)))
in FStar_Syntax_Syntax.Tm_arrow (_125_187))
in (FStar_Syntax_Syntax.mk _125_188 None t.FStar_Syntax_Syntax.pos)))
>>>>>>> master
end
| FStar_Syntax_Syntax.Tm_refine (x, phi) -> begin
(

let x = (

<<<<<<< HEAD
let _35_387 = x
in (let _124_193 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_387.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_387.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_193}))
in (

let phi = (let _124_194 = (shift_subst' 1 s)
in (subst' _124_194 phi))
=======
let _35_385 = x
in (let _125_189 = (subst' s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_385.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_385.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_189}))
in (

let phi = (let _125_190 = (shift_subst' 1 s)
in (subst' _125_190 phi))
>>>>>>> master
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_refine ((x, phi))) None t.FStar_Syntax_Syntax.pos)))
end
| FStar_Syntax_Syntax.Tm_match (t0, pats) -> begin
(

let t0 = (subst' s t0)
in (

let pats = (FStar_All.pipe_right pats (FStar_List.map (fun _35_399 -> (match (_35_399) with
| (pat, wopt, branch) -> begin
(

let _35_402 = (subst_pat' s pat)
in (match (_35_402) with
| (pat, n) -> begin
(

let s = (shift_subst' n s)
in (

let wopt = (match (wopt) with
| None -> begin
None
end
| Some (w) -> begin
<<<<<<< HEAD
(let _124_196 = (subst' s w)
in Some (_124_196))
=======
(let _125_192 = (subst' s w)
in Some (_125_192))
>>>>>>> master
end)
in (

let branch = (subst' s branch)
in (pat, wopt, branch))))
end))
end))))
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_match ((t0, pats))) None t.FStar_Syntax_Syntax.pos)))
end
| FStar_Syntax_Syntax.Tm_let ((is_rec, lbs), body) -> begin
(

let n = (FStar_List.length lbs)
in (

let sn = (shift_subst' n s)
in (

let body = (subst' sn body)
in (

let lbs = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (

let lbt = (subst' s lb.FStar_Syntax_Syntax.lbtyp)
in (

let lbd = if (is_rec && (FStar_Util.is_left lb.FStar_Syntax_Syntax.lbname)) then begin
(subst' sn lb.FStar_Syntax_Syntax.lbdef)
end else begin
(subst' s lb.FStar_Syntax_Syntax.lbdef)
end
in (

let lbname = (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inl (x) -> begin
FStar_Util.Inl ((

let _35_424 = x
in {FStar_Syntax_Syntax.ppname = _35_424.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_424.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = lbt}))
end
| FStar_Util.Inr (fv) -> begin
FStar_Util.Inr ((

let _35_428 = fv
in {FStar_Syntax_Syntax.fv_name = (

let _35_430 = fv.FStar_Syntax_Syntax.fv_name
in {FStar_Syntax_Syntax.v = _35_430.FStar_Syntax_Syntax.v; FStar_Syntax_Syntax.ty = lbt; FStar_Syntax_Syntax.p = _35_430.FStar_Syntax_Syntax.p}); FStar_Syntax_Syntax.fv_delta = _35_428.FStar_Syntax_Syntax.fv_delta; FStar_Syntax_Syntax.fv_qual = _35_428.FStar_Syntax_Syntax.fv_qual}))
end)
in (

let _35_433 = lb
in {FStar_Syntax_Syntax.lbname = lbname; FStar_Syntax_Syntax.lbunivs = _35_433.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = lbt; FStar_Syntax_Syntax.lbeff = _35_433.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = lbd})))))))
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((is_rec, lbs), body))) None t.FStar_Syntax_Syntax.pos)))))
end
| FStar_Syntax_Syntax.Tm_meta (t0, FStar_Syntax_Syntax.Meta_pattern (ps)) -> begin
<<<<<<< HEAD
(let _124_202 = (let _124_201 = (let _124_200 = (subst' s t0)
in (let _124_199 = (let _124_198 = (FStar_All.pipe_right ps (FStar_List.map (subst_args' s)))
in FStar_Syntax_Syntax.Meta_pattern (_124_198))
in (_124_200, _124_199)))
in FStar_Syntax_Syntax.Tm_meta (_124_201))
in (FStar_Syntax_Syntax.mk _124_202 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_meta (t, m) -> begin
(let _124_205 = (let _124_204 = (let _124_203 = (subst' s t)
in (_124_203, m))
in FStar_Syntax_Syntax.Tm_meta (_124_204))
in (FStar_Syntax_Syntax.mk _124_205 None t.FStar_Syntax_Syntax.pos))
=======
(let _125_198 = (let _125_197 = (let _125_196 = (subst' s t0)
in (let _125_195 = (let _125_194 = (FStar_All.pipe_right ps (FStar_List.map (subst_args' s)))
in FStar_Syntax_Syntax.Meta_pattern (_125_194))
in (_125_196, _125_195)))
in FStar_Syntax_Syntax.Tm_meta (_125_197))
in (FStar_Syntax_Syntax.mk _125_198 None t.FStar_Syntax_Syntax.pos))
end
| FStar_Syntax_Syntax.Tm_meta (t, m) -> begin
(let _125_201 = (let _125_200 = (let _125_199 = (subst' s t)
in (_125_199, m))
in FStar_Syntax_Syntax.Tm_meta (_125_200))
in (FStar_Syntax_Syntax.mk _125_201 None t.FStar_Syntax_Syntax.pos))
>>>>>>> master
end))


let rec compress : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun t -> (

let t = (force_delayed_thunk t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (FStar_Util.Inl (t, s), memo) -> begin
(

<<<<<<< HEAD
let t' = (let _124_208 = (push_subst s t)
in (compress _124_208))
=======
let t' = (let _125_204 = (push_subst s t)
in (compress _125_204))
>>>>>>> master
in (

let _35_455 = (FStar_Unionfind.update_in_tx memo (Some (t')))
in t'))
end
| _35_458 -> begin
(force_uvar t)
end)))


let subst : FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun s t -> (subst' ((s)::[]) t))


let subst_comp : FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun s t -> (subst_comp' ((s)::[]) t))


<<<<<<< HEAD
let closing_subst = (fun bs -> (let _124_220 = (FStar_List.fold_right (fun _35_467 _35_470 -> (match ((_35_467, _35_470)) with
| ((x, _35_466), (subst, n)) -> begin
((FStar_Syntax_Syntax.NM ((x, n)))::subst, (n + 1))
end)) bs ([], 0))
in (FStar_All.pipe_right _124_220 Prims.fst)))
=======
let closing_subst = (fun bs -> (let _125_216 = (FStar_List.fold_right (fun _35_465 _35_468 -> (match ((_35_465, _35_468)) with
| ((x, _35_464), (subst, n)) -> begin
((FStar_Syntax_Syntax.NM ((x, n)))::subst, (n + 1))
end)) bs ([], 0))
in (FStar_All.pipe_right _125_216 Prims.fst)))
>>>>>>> master


let open_binders' = (fun bs -> (

let rec aux = (fun bs o -> (match (bs) with
| [] -> begin
([], o)
end
| ((x, imp))::bs' -> begin
(

let x' = (

<<<<<<< HEAD
let _35_481 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _124_226 = (subst o x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_481.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_481.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_226}))
in (

let o = (let _124_227 = (shift_subst 1 o)
in (FStar_Syntax_Syntax.DB ((0, x')))::_124_227)
=======
let _35_479 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _125_222 = (subst o x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_479.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_479.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_222}))
in (

let o = (let _125_223 = (shift_subst 1 o)
in (FStar_Syntax_Syntax.DB ((0, x')))::_125_223)
>>>>>>> master
in (

let _35_487 = (aux bs' o)
in (match (_35_487) with
| (bs', o) -> begin
(((x', imp))::bs', o)
end))))
end))
in (aux bs [])))


<<<<<<< HEAD
let open_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders = (fun bs -> (let _124_230 = (open_binders' bs)
in (Prims.fst _124_230)))
=======
let open_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders = (fun bs -> (let _125_226 = (open_binders' bs)
in (Prims.fst _125_226)))
>>>>>>> master


let open_term' : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.subst_t) = (fun bs t -> (

let _35_493 = (open_binders' bs)
in (match (_35_493) with
| (bs', opening) -> begin
<<<<<<< HEAD
(let _124_235 = (subst opening t)
in (bs', _124_235, opening))
=======
(let _125_231 = (subst opening t)
in (bs', _125_231, opening))
>>>>>>> master
end)))


let open_term : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term) = (fun bs t -> (

let _35_500 = (open_term' bs t)
in (match (_35_500) with
| (b, t, _35_499) -> begin
(b, t)
end)))


let open_comp : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) = (fun bs t -> (

let _35_505 = (open_binders' bs)
in (match (_35_505) with
| (bs', opening) -> begin
<<<<<<< HEAD
(let _124_244 = (subst_comp opening t)
in (bs', _124_244))
=======
(let _125_240 = (subst_comp opening t)
in (bs', _125_240))
>>>>>>> master
end)))


let open_pat : FStar_Syntax_Syntax.pat  ->  (FStar_Syntax_Syntax.pat * FStar_Syntax_Syntax.subst_t) = (fun p -> (

let rec aux_disj = (fun sub renaming p -> (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj (_35_512) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Syntax_Syntax.Pat_constant (_35_515) -> begin
p
end
| FStar_Syntax_Syntax.Pat_cons (fv, pats) -> begin
(

<<<<<<< HEAD
let _35_521 = p
in (let _124_257 = (let _124_256 = (let _124_255 = (FStar_All.pipe_right pats (FStar_List.map (fun _35_525 -> (match (_35_525) with
| (p, b) -> begin
(let _124_254 = (aux_disj sub renaming p)
in (_124_254, b))
end))))
in (fv, _124_255))
in FStar_Syntax_Syntax.Pat_cons (_124_256))
in {FStar_Syntax_Syntax.v = _124_257; FStar_Syntax_Syntax.ty = _35_521.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_521.FStar_Syntax_Syntax.p}))
=======
let _35_519 = p
in (let _125_253 = (let _125_252 = (let _125_251 = (FStar_All.pipe_right pats (FStar_List.map (fun _35_523 -> (match (_35_523) with
| (p, b) -> begin
(let _125_250 = (aux_disj sub renaming p)
in (_125_250, b))
end))))
in (fv, _125_251))
in FStar_Syntax_Syntax.Pat_cons (_125_252))
in {FStar_Syntax_Syntax.v = _125_253; FStar_Syntax_Syntax.ty = _35_519.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_519.FStar_Syntax_Syntax.p}))
>>>>>>> master
end
| FStar_Syntax_Syntax.Pat_var (x) -> begin
(

let yopt = (FStar_Util.find_map renaming (fun _35_7 -> (match (_35_7) with
| (x', y) when (x.FStar_Syntax_Syntax.ppname.FStar_Ident.idText = x'.FStar_Syntax_Syntax.ppname.FStar_Ident.idText) -> begin
Some (y)
end
| _35_533 -> begin
None
end)))
in (

let y = (match (yopt) with
| None -> begin
(

<<<<<<< HEAD
let _35_536 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _124_259 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_536.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_536.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_259}))
=======
let _35_534 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _125_255 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_534.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_534.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_255}))
>>>>>>> master
end
| Some (y) -> begin
y
end)
in (

let _35_541 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_var (y); FStar_Syntax_Syntax.ty = _35_541.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_541.FStar_Syntax_Syntax.p})))
end
| FStar_Syntax_Syntax.Pat_wild (x) -> begin
(

let x' = (

<<<<<<< HEAD
let _35_545 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _124_260 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_545.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_545.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_260}))
=======
let _35_543 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _125_256 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_543.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_543.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_256}))
>>>>>>> master
in (

let _35_548 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild (x'); FStar_Syntax_Syntax.ty = _35_548.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_548.FStar_Syntax_Syntax.p}))
end
| FStar_Syntax_Syntax.Pat_dot_term (x, t0) -> begin
(

let x = (

<<<<<<< HEAD
let _35_554 = x
in (let _124_261 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_554.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_554.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_261}))
=======
let _35_552 = x
in (let _125_257 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_552.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_552.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_257}))
>>>>>>> master
in (

let t0 = (subst sub t0)
in (

let _35_558 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_dot_term ((x, t0)); FStar_Syntax_Syntax.ty = _35_558.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_558.FStar_Syntax_Syntax.p})))
end))
in (

let rec aux = (fun sub renaming p -> (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible: empty disjunction")
end
| FStar_Syntax_Syntax.Pat_constant (_35_567) -> begin
(p, sub, renaming)
end
| FStar_Syntax_Syntax.Pat_disj ((p)::ps) -> begin
(

let _35_576 = (aux sub renaming p)
in (match (_35_576) with
| (p, sub, renaming) -> begin
(

let ps = (FStar_List.map (aux_disj sub renaming) ps)
in ((

let _35_578 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_disj ((p)::ps); FStar_Syntax_Syntax.ty = _35_578.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_578.FStar_Syntax_Syntax.p}), sub, renaming))
end))
end
| FStar_Syntax_Syntax.Pat_cons (fv, pats) -> begin
(

let _35_598 = (FStar_All.pipe_right pats (FStar_List.fold_left (fun _35_587 _35_590 -> (match ((_35_587, _35_590)) with
| ((pats, sub, renaming), (p, imp)) -> begin
(

let _35_594 = (aux sub renaming p)
in (match (_35_594) with
| (p, sub, renaming) -> begin
(((p, imp))::pats, sub, renaming)
end))
end)) ([], sub, renaming)))
in (match (_35_598) with
| (pats, sub, renaming) -> begin
((

let _35_599 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_cons ((fv, (FStar_List.rev pats))); FStar_Syntax_Syntax.ty = _35_599.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_599.FStar_Syntax_Syntax.p}), sub, renaming)
end))
end
| FStar_Syntax_Syntax.Pat_var (x) -> begin
(

let x' = (

<<<<<<< HEAD
let _35_603 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _124_270 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_603.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_603.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_270}))
in (

let sub = (let _124_271 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.DB ((0, x')))::_124_271)
=======
let _35_601 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _125_266 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_601.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_601.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_266}))
in (

let sub = (let _125_267 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.DB ((0, x')))::_125_267)
>>>>>>> master
in ((

let _35_607 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_var (x'); FStar_Syntax_Syntax.ty = _35_607.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_607.FStar_Syntax_Syntax.p}), sub, ((x, x'))::renaming)))
end
| FStar_Syntax_Syntax.Pat_wild (x) -> begin
(

let x' = (

<<<<<<< HEAD
let _35_611 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _124_272 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_611.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_611.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_272}))
in (

let sub = (let _124_273 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.DB ((0, x')))::_124_273)
=======
let _35_609 = (FStar_Syntax_Syntax.freshen_bv x)
in (let _125_268 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_609.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_609.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_268}))
in (

let sub = (let _125_269 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.DB ((0, x')))::_125_269)
>>>>>>> master
in ((

let _35_615 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild (x'); FStar_Syntax_Syntax.ty = _35_615.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_615.FStar_Syntax_Syntax.p}), sub, ((x, x'))::renaming)))
end
| FStar_Syntax_Syntax.Pat_dot_term (x, t0) -> begin
(

let x = (

<<<<<<< HEAD
let _35_621 = x
in (let _124_274 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_621.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_621.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_274}))
=======
let _35_619 = x
in (let _125_270 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_619.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_619.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_270}))
>>>>>>> master
in (

let t0 = (subst sub t0)
in ((

let _35_625 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_dot_term ((x, t0)); FStar_Syntax_Syntax.ty = _35_625.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_625.FStar_Syntax_Syntax.p}), sub, renaming)))
end))
in (

let _35_631 = (aux [] [] p)
in (match (_35_631) with
| (p, sub, _35_630) -> begin
(p, sub)
end)))))


let open_branch : FStar_Syntax_Syntax.branch  ->  FStar_Syntax_Syntax.branch = (fun _35_635 -> (match (_35_635) with
| (p, wopt, e) -> begin
(

let _35_638 = (open_pat p)
in (match (_35_638) with
| (p, opening) -> begin
(

let wopt = (match (wopt) with
| None -> begin
None
end
| Some (w) -> begin
<<<<<<< HEAD
(let _124_277 = (subst opening w)
in Some (_124_277))
=======
(let _125_273 = (subst opening w)
in Some (_125_273))
>>>>>>> master
end)
in (

let e = (subst opening e)
in (p, wopt, e)))
end))
end))


<<<<<<< HEAD
let close : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun bs t -> (let _124_282 = (closing_subst bs)
in (subst _124_282 t)))


let close_comp : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun bs c -> (let _124_287 = (closing_subst bs)
in (subst_comp _124_287 c)))
=======
let close : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun bs t -> (let _125_278 = (closing_subst bs)
in (subst _125_278 t)))


let close_comp : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun bs c -> (let _125_283 = (closing_subst bs)
in (subst_comp _125_283 c)))
>>>>>>> master


let close_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders = (fun bs -> (

let rec aux = (fun s bs -> (match (bs) with
| [] -> begin
[]
end
| ((x, imp))::tl -> begin
(

let x = (

<<<<<<< HEAD
let _35_658 = x
in (let _124_294 = (subst s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_658.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_658.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_294}))
in (

let s' = (let _124_295 = (shift_subst 1 s)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_124_295)
in (let _124_296 = (aux s' tl)
in ((x, imp))::_124_296)))
=======
let _35_656 = x
in (let _125_290 = (subst s x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_656.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_656.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_290}))
in (

let s' = (let _125_291 = (shift_subst 1 s)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_125_291)
in (let _125_292 = (aux s' tl)
in ((x, imp))::_125_292)))
>>>>>>> master
end))
in (aux [] bs)))


let close_lcomp : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.lcomp  ->  FStar_Syntax_Syntax.lcomp = (fun bs lc -> (

let s = (closing_subst bs)
in (

<<<<<<< HEAD
let _35_665 = lc
in (let _124_303 = (subst s lc.FStar_Syntax_Syntax.res_typ)
in {FStar_Syntax_Syntax.eff_name = _35_665.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _124_303; FStar_Syntax_Syntax.cflags = _35_665.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _35_667 -> (match (()) with
| () -> begin
(let _124_302 = (lc.FStar_Syntax_Syntax.comp ())
in (subst_comp s _124_302))
=======
let _35_663 = lc
in (let _125_299 = (subst s lc.FStar_Syntax_Syntax.res_typ)
in {FStar_Syntax_Syntax.eff_name = _35_663.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _125_299; FStar_Syntax_Syntax.cflags = _35_663.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _35_665 -> (match (()) with
| () -> begin
(let _125_298 = (lc.FStar_Syntax_Syntax.comp ())
in (subst_comp s _125_298))
>>>>>>> master
end))}))))


let close_pat : (FStar_Syntax_Syntax.pat', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.withinfo_t  ->  ((FStar_Syntax_Syntax.pat', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.withinfo_t * FStar_Syntax_Syntax.subst_elt Prims.list) = (fun p -> (

let rec aux = (fun sub p -> (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible: empty disjunction")
end
| FStar_Syntax_Syntax.Pat_constant (_35_675) -> begin
(p, sub)
end
| FStar_Syntax_Syntax.Pat_disj ((p)::ps) -> begin
(

let _35_683 = (aux sub p)
in (match (_35_683) with
| (p, sub) -> begin
(

<<<<<<< HEAD
let ps = (FStar_List.map (fun p -> (let _124_311 = (aux sub p)
in (Prims.fst _124_311))) ps)
=======
let ps = (FStar_List.map (fun p -> (let _125_307 = (aux sub p)
in (Prims.fst _125_307))) ps)
>>>>>>> master
in ((

let _35_686 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_disj ((p)::ps); FStar_Syntax_Syntax.ty = _35_686.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_686.FStar_Syntax_Syntax.p}), sub))
end))
end
| FStar_Syntax_Syntax.Pat_cons (fv, pats) -> begin
(

let _35_703 = (FStar_All.pipe_right pats (FStar_List.fold_left (fun _35_694 _35_697 -> (match ((_35_694, _35_697)) with
| ((pats, sub), (p, imp)) -> begin
(

let _35_700 = (aux sub p)
in (match (_35_700) with
| (p, sub) -> begin
(((p, imp))::pats, sub)
end))
end)) ([], sub)))
in (match (_35_703) with
| (pats, sub) -> begin
((

let _35_704 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_cons ((fv, (FStar_List.rev pats))); FStar_Syntax_Syntax.ty = _35_704.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_704.FStar_Syntax_Syntax.p}), sub)
end))
end
| FStar_Syntax_Syntax.Pat_var (x) -> begin
(

let x = (

<<<<<<< HEAD
let _35_708 = x
in (let _124_314 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_708.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_708.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_314}))
in (

let sub = (let _124_315 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_124_315)
=======
let _35_706 = x
in (let _125_310 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_706.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_706.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_310}))
in (

let sub = (let _125_311 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_125_311)
>>>>>>> master
in ((

let _35_712 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_var (x); FStar_Syntax_Syntax.ty = _35_712.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_712.FStar_Syntax_Syntax.p}), sub)))
end
| FStar_Syntax_Syntax.Pat_wild (x) -> begin
(

let x = (

<<<<<<< HEAD
let _35_716 = x
in (let _124_316 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_716.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_716.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_316}))
in (

let sub = (let _124_317 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_124_317)
=======
let _35_714 = x
in (let _125_312 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_714.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_714.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_312}))
in (

let sub = (let _125_313 = (shift_subst 1 sub)
in (FStar_Syntax_Syntax.NM ((x, 0)))::_125_313)
>>>>>>> master
in ((

let _35_720 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild (x); FStar_Syntax_Syntax.ty = _35_720.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_720.FStar_Syntax_Syntax.p}), sub)))
end
| FStar_Syntax_Syntax.Pat_dot_term (x, t0) -> begin
(

let x = (

<<<<<<< HEAD
let _35_726 = x
in (let _124_318 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_726.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_726.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _124_318}))
=======
let _35_724 = x
in (let _125_314 = (subst sub x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _35_724.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _35_724.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _125_314}))
>>>>>>> master
in (

let t0 = (subst sub t0)
in ((

let _35_730 = p
in {FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_dot_term ((x, t0)); FStar_Syntax_Syntax.ty = _35_730.FStar_Syntax_Syntax.ty; FStar_Syntax_Syntax.p = _35_730.FStar_Syntax_Syntax.p}), sub)))
end))
in (aux [] p)))


let close_branch : FStar_Syntax_Syntax.branch  ->  FStar_Syntax_Syntax.branch = (fun _35_735 -> (match (_35_735) with
| (p, wopt, e) -> begin
(

let _35_738 = (close_pat p)
in (match (_35_738) with
| (p, closing) -> begin
(

let wopt = (match (wopt) with
| None -> begin
None
end
| Some (w) -> begin
<<<<<<< HEAD
(let _124_321 = (subst closing w)
in Some (_124_321))
=======
(let _125_317 = (subst closing w)
in Some (_125_317))
>>>>>>> master
end)
in (

let e = (subst closing e)
in (p, wopt, e)))
end))
end))


let univ_var_opening : FStar_Syntax_Syntax.univ_names  ->  (FStar_Syntax_Syntax.subst_elt Prims.list * FStar_Syntax_Syntax.univ_name Prims.list) = (fun us -> (

let n = ((FStar_List.length us) - 1)
in (

<<<<<<< HEAD
let _35_751 = (let _124_326 = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> (

let u' = (FStar_Syntax_Syntax.new_univ_name (Some (u.FStar_Ident.idRange)))
in (FStar_Syntax_Syntax.UN (((n - i), FStar_Syntax_Syntax.U_name (u'))), u')))))
in (FStar_All.pipe_right _124_326 FStar_List.unzip))
in (match (_35_751) with
=======
let _35_749 = (let _125_322 = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> (

let u' = (FStar_Syntax_Syntax.new_univ_name (Some (u.FStar_Ident.idRange)))
in (FStar_Syntax_Syntax.UN (((n - i), FStar_Syntax_Syntax.U_name (u'))), u')))))
in (FStar_All.pipe_right _125_322 FStar_List.unzip))
in (match (_35_749) with
>>>>>>> master
| (s, us') -> begin
(s, us')
end))))


let open_univ_vars : FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term) = (fun us t -> (

let _35_756 = (univ_var_opening us)
in (match (_35_756) with
| (s, us') -> begin
(

let t = (subst s t)
in (us', t))
end)))


let open_univ_vars_comp : FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.comp) = (fun us c -> (

let _35_762 = (univ_var_opening us)
in (match (_35_762) with
| (s, us') -> begin
<<<<<<< HEAD
(let _124_335 = (subst_comp s c)
in (us', _124_335))
=======
(let _125_331 = (subst_comp s c)
in (us', _125_331))
>>>>>>> master
end)))


let close_univ_vars : FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun us t -> (

let n = ((FStar_List.length us) - 1)
in (

let s = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> FStar_Syntax_Syntax.UD ((u, (n - i))))))
in (subst s t))))


let close_univ_vars_comp : FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun us c -> (

let n = ((FStar_List.length us) - 1)
in (

let s = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> FStar_Syntax_Syntax.UD ((u, (n - i))))))
in (subst_comp s c))))


let open_let_rec : FStar_Syntax_Syntax.letbinding Prims.list  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_Syntax_Syntax.term) = (fun lbs t -> if (FStar_Syntax_Syntax.is_top_level lbs) then begin
(lbs, t)
end else begin
(

let _35_788 = (FStar_List.fold_right (fun lb _35_781 -> (match (_35_781) with
| (i, lbs, out) -> begin
(

<<<<<<< HEAD
let x = (let _124_354 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in (FStar_Syntax_Syntax.freshen_bv _124_354))
=======
let x = (let _125_350 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in (FStar_Syntax_Syntax.freshen_bv _125_350))
>>>>>>> master
in ((i + 1), ((

let _35_783 = lb
in {FStar_Syntax_Syntax.lbname = FStar_Util.Inl (x); FStar_Syntax_Syntax.lbunivs = _35_783.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _35_783.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _35_783.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _35_783.FStar_Syntax_Syntax.lbdef}))::lbs, (FStar_Syntax_Syntax.DB ((i, x)))::out))
end)) lbs (0, [], []))
in (match (_35_788) with
| (n_let_recs, lbs, let_rec_opening) -> begin
(

let lbs = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (

let _35_800 = (FStar_List.fold_right (fun u _35_794 -> (match (_35_794) with
| (i, us, out) -> begin
(

let u = (FStar_Syntax_Syntax.new_univ_name None)
in ((i + 1), (u)::us, (FStar_Syntax_Syntax.UN ((i, FStar_Syntax_Syntax.U_name (u))))::out))
end)) lb.FStar_Syntax_Syntax.lbunivs (n_let_recs, [], let_rec_opening))
in (match (_35_800) with
| (_35_797, us, u_let_rec_opening) -> begin
(

<<<<<<< HEAD
let _35_801 = lb
in (let _124_358 = (subst u_let_rec_opening lb.FStar_Syntax_Syntax.lbdef)
in {FStar_Syntax_Syntax.lbname = _35_801.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = us; FStar_Syntax_Syntax.lbtyp = _35_801.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _35_801.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _124_358}))
=======
let _35_799 = lb
in (let _125_354 = (subst u_let_rec_opening lb.FStar_Syntax_Syntax.lbdef)
in {FStar_Syntax_Syntax.lbname = _35_799.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = us; FStar_Syntax_Syntax.lbtyp = _35_799.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _35_799.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _125_354}))
>>>>>>> master
end)))))
in (

let t = (subst let_rec_opening t)
in (lbs, t)))
end))
end)


let close_let_rec : FStar_Syntax_Syntax.letbinding Prims.list  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_Syntax_Syntax.term) = (fun lbs t -> if (FStar_Syntax_Syntax.is_top_level lbs) then begin
(lbs, t)
end else begin
(

let _35_813 = (FStar_List.fold_right (fun lb _35_810 -> (match (_35_810) with
| (i, out) -> begin
<<<<<<< HEAD
(let _124_368 = (let _124_367 = (let _124_366 = (let _124_365 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in (_124_365, i))
in FStar_Syntax_Syntax.NM (_124_366))
in (_124_367)::out)
in ((i + 1), _124_368))
=======
(let _125_364 = (let _125_363 = (let _125_362 = (let _125_361 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in (_125_361, i))
in FStar_Syntax_Syntax.NM (_125_362))
in (_125_363)::out)
in ((i + 1), _125_364))
>>>>>>> master
end)) lbs (0, []))
in (match (_35_813) with
| (n_let_recs, let_rec_closing) -> begin
(

let lbs = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (

let _35_822 = (FStar_List.fold_right (fun u _35_818 -> (match (_35_818) with
| (i, out) -> begin
((i + 1), (FStar_Syntax_Syntax.UD ((u, i)))::out)
end)) lb.FStar_Syntax_Syntax.lbunivs (n_let_recs, let_rec_closing))
in (match (_35_822) with
| (_35_820, u_let_rec_closing) -> begin
(

<<<<<<< HEAD
let _35_823 = lb
in (let _124_372 = (subst u_let_rec_closing lb.FStar_Syntax_Syntax.lbdef)
in {FStar_Syntax_Syntax.lbname = _35_823.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _35_823.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _35_823.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _35_823.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _124_372}))
=======
let _35_821 = lb
in (let _125_368 = (subst u_let_rec_closing lb.FStar_Syntax_Syntax.lbdef)
in {FStar_Syntax_Syntax.lbname = _35_821.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _35_821.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _35_821.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _35_821.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _125_368}))
>>>>>>> master
end)))))
in (

let t = (subst let_rec_closing t)
in (lbs, t)))
end))
end)


let close_tscheme : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.tscheme = (fun binders _35_830 -> (match (_35_830) with
| (us, t) -> begin
(

let n = ((FStar_List.length binders) - 1)
in (

let k = (FStar_List.length us)
in (

let s = (FStar_List.mapi (fun i _35_837 -> (match (_35_837) with
| (x, _35_836) -> begin
FStar_Syntax_Syntax.NM ((x, (k + (n - i))))
end)) binders)
in (

let t = (subst s t)
in (us, t)))))
end))


let close_univ_vars_tscheme : FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.tscheme = (fun us _35_843 -> (match (_35_843) with
| (us', t) -> begin
(

let n = ((FStar_List.length us) - 1)
in (

let k = (FStar_List.length us')
in (

let s = (FStar_List.mapi (fun i x -> FStar_Syntax_Syntax.UD ((x, (k + (n - i))))) us)
<<<<<<< HEAD
in (let _124_385 = (subst s t)
in (us', _124_385)))))
=======
in (let _125_381 = (subst s t)
in (us', _125_381)))))
>>>>>>> master
end))


let opening_of_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.subst_t = (fun bs -> (

let n = ((FStar_List.length bs) - 1)
in (FStar_All.pipe_right bs (FStar_List.mapi (fun i _35_855 -> (match (_35_855) with
| (x, _35_854) -> begin
FStar_Syntax_Syntax.DB (((n - i), x))
end))))))




