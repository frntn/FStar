
open Prims

let add_fuel = (fun x tl -> if (FStar_Options.unthrottle_inductives ()) then begin
tl
end else begin
(x)::tl
end)


let withenv = (fun c _50_40 -> (match (_50_40) with
| (a, b) -> begin
(a, b, c)
end))


let vargs = (fun args -> (FStar_List.filter (fun _50_1 -> (match (_50_1) with
| (FStar_Util.Inl (_50_44), _50_47) -> begin
false
end
| _50_50 -> begin
true
end)) args))


let escape : Prims.string  ->  Prims.string = (fun s -> (FStar_Util.replace_char s '\'' '_'))


let escape_null_name = (fun a -> if (a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = "_") then begin
(Prims.strcat a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText a.FStar_Absyn_Syntax.realname.FStar_Ident.idText)
end else begin
a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText
end)


let mk_typ_projector_name : FStar_Ident.lident  ->  FStar_Absyn_Syntax.btvdef  ->  Prims.string = (fun lid a -> (let _140_14 = (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str (escape_null_name a))
in (FStar_All.pipe_left escape _140_14)))


let mk_term_projector_name : FStar_Ident.lident  ->  FStar_Absyn_Syntax.bvvdef  ->  Prims.string = (fun lid a -> (

let a = (let _140_19 = (FStar_Absyn_Util.unmangle_field_name a.FStar_Absyn_Syntax.ppname)
in {FStar_Absyn_Syntax.ppname = _140_19; FStar_Absyn_Syntax.realname = a.FStar_Absyn_Syntax.realname})
in (let _140_20 = (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str (escape_null_name a))
in (FStar_All.pipe_left escape _140_20))))


let primitive_projector_by_pos : FStar_Tc_Env.env  ->  FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun env lid i -> (

let fail = (fun _50_62 -> (match (()) with
| () -> begin
(let _140_30 = (let _140_29 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "Projector %s on data constructor %s not found" _140_29 lid.FStar_Ident.str))
in (FStar_All.failwith _140_30))
end))
in (

let t = (FStar_Tc_Env.lookup_datacon env lid)
in (match ((let _140_31 = (FStar_Absyn_Util.compress_typ t)
in _140_31.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_fun (binders, _50_66) -> begin
if ((i < 0) || (i >= (FStar_List.length binders))) then begin
(fail ())
end else begin
(

let b = (FStar_List.nth binders i)
in (match ((Prims.fst b)) with
| FStar_Util.Inl (a) -> begin
(mk_typ_projector_name lid a.FStar_Absyn_Syntax.v)
end
| FStar_Util.Inr (x) -> begin
(mk_term_projector_name lid x.FStar_Absyn_Syntax.v)
end))
end
end
| _50_75 -> begin
(fail ())
end))))


let mk_term_projector_name_by_pos : FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun lid i -> (let _140_37 = (let _140_36 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str _140_36))
in (FStar_All.pipe_left escape _140_37)))


let mk_typ_projector : FStar_Ident.lident  ->  FStar_Absyn_Syntax.btvdef  ->  FStar_ToSMT_Term.term = (fun lid a -> (let _140_43 = (let _140_42 = (mk_typ_projector_name lid a)
in (_140_42, FStar_ToSMT_Term.Arrow ((FStar_ToSMT_Term.Term_sort, FStar_ToSMT_Term.Type_sort))))
in (FStar_ToSMT_Term.mkFreeV _140_43)))


let mk_term_projector : FStar_Ident.lident  ->  FStar_Absyn_Syntax.bvvdef  ->  FStar_ToSMT_Term.term = (fun lid a -> (let _140_49 = (let _140_48 = (mk_term_projector_name lid a)
in (_140_48, FStar_ToSMT_Term.Arrow ((FStar_ToSMT_Term.Term_sort, FStar_ToSMT_Term.Term_sort))))
in (FStar_ToSMT_Term.mkFreeV _140_49)))


let mk_term_projector_by_pos : FStar_Ident.lident  ->  Prims.int  ->  FStar_ToSMT_Term.term = (fun lid i -> (let _140_55 = (let _140_54 = (mk_term_projector_name_by_pos lid i)
in (_140_54, FStar_ToSMT_Term.Arrow ((FStar_ToSMT_Term.Term_sort, FStar_ToSMT_Term.Term_sort))))
in (FStar_ToSMT_Term.mkFreeV _140_55)))


let mk_data_tester = (fun env l x -> (FStar_ToSMT_Term.mk_tester (escape l.FStar_Ident.str) x))


type varops_t =
{push : Prims.unit  ->  Prims.unit; pop : Prims.unit  ->  Prims.unit; mark : Prims.unit  ->  Prims.unit; reset_mark : Prims.unit  ->  Prims.unit; commit_mark : Prims.unit  ->  Prims.unit; new_var : FStar_Ident.ident  ->  FStar_Ident.ident  ->  Prims.string; new_fvar : FStar_Ident.lident  ->  Prims.string; fresh : Prims.string  ->  Prims.string; string_const : Prims.string  ->  FStar_ToSMT_Term.term; next_id : Prims.unit  ->  Prims.int}


let is_Mkvarops_t : varops_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkvarops_t"))))


let varops : varops_t = (

let initial_ctr = 10
in (

let ctr = (FStar_Util.mk_ref initial_ctr)
in (

let new_scope = (fun _50_101 -> (match (()) with
| () -> begin
(let _140_159 = (FStar_Util.smap_create 100)
in (let _140_158 = (FStar_Util.smap_create 100)
in (_140_159, _140_158)))
end))
in (

let scopes = (let _140_161 = (let _140_160 = (new_scope ())
in (_140_160)::[])
in (FStar_Util.mk_ref _140_161))
in (

let mk_unique = (fun y -> (

let y = (escape y)
in (

let y = (match ((let _140_165 = (FStar_ST.read scopes)
in (FStar_Util.find_map _140_165 (fun _50_109 -> (match (_50_109) with
| (names, _50_108) -> begin
(FStar_Util.smap_try_find names y)
end))))) with
| None -> begin
y
end
| Some (_50_112) -> begin
(

let _50_114 = (FStar_Util.incr ctr)
in (let _140_167 = (let _140_166 = (FStar_ST.read ctr)
in (FStar_Util.string_of_int _140_166))
in (Prims.strcat (Prims.strcat y "__") _140_167)))
end)
in (

let top_scope = (let _140_169 = (let _140_168 = (FStar_ST.read scopes)
in (FStar_List.hd _140_168))
in (FStar_All.pipe_left Prims.fst _140_169))
in (

let _50_118 = (FStar_Util.smap_add top_scope y true)
in y)))))
in (

let new_var = (fun pp rn -> (let _140_175 = (let _140_174 = (FStar_All.pipe_left mk_unique pp.FStar_Ident.idText)
in (Prims.strcat _140_174 "__"))
in (Prims.strcat _140_175 rn.FStar_Ident.idText)))
in (

let new_fvar = (fun lid -> (mk_unique lid.FStar_Ident.str))
in (

let next_id = (fun _50_126 -> (match (()) with
| () -> begin
(

let _50_127 = (FStar_Util.incr ctr)
in (FStar_ST.read ctr))
end))
in (

let fresh = (fun pfx -> (let _140_183 = (let _140_182 = (next_id ())
in (FStar_All.pipe_left FStar_Util.string_of_int _140_182))
in (FStar_Util.format2 "%s_%s" pfx _140_183)))
in (

let string_const = (fun s -> (match ((let _140_187 = (FStar_ST.read scopes)
in (FStar_Util.find_map _140_187 (fun _50_136 -> (match (_50_136) with
| (_50_134, strings) -> begin
(FStar_Util.smap_try_find strings s)
end))))) with
| Some (f) -> begin
f
end
| None -> begin
(

let id = (next_id ())
in (

let f = (let _140_188 = (FStar_ToSMT_Term.mk_String_const id)
in (FStar_All.pipe_left FStar_ToSMT_Term.boxString _140_188))
in (

let top_scope = (let _140_190 = (let _140_189 = (FStar_ST.read scopes)
in (FStar_List.hd _140_189))
in (FStar_All.pipe_left Prims.snd _140_190))
in (

let _50_143 = (FStar_Util.smap_add top_scope s f)
in f))))
end))
in (

let push = (fun _50_146 -> (match (()) with
| () -> begin
(let _140_195 = (let _140_194 = (new_scope ())
in (let _140_193 = (FStar_ST.read scopes)
in (_140_194)::_140_193))
in (FStar_ST.op_Colon_Equals scopes _140_195))
end))
in (

let pop = (fun _50_148 -> (match (()) with
| () -> begin
(let _140_199 = (let _140_198 = (FStar_ST.read scopes)
in (FStar_List.tl _140_198))
in (FStar_ST.op_Colon_Equals scopes _140_199))
end))
in (

let mark = (fun _50_150 -> (match (()) with
| () -> begin
(push ())
end))
in (

let reset_mark = (fun _50_152 -> (match (()) with
| () -> begin
(pop ())
end))
in (

let commit_mark = (fun _50_154 -> (match (()) with
| () -> begin
(match ((FStar_ST.read scopes)) with
| ((hd1, hd2))::((next1, next2))::tl -> begin
(

let _50_167 = (FStar_Util.smap_fold hd1 (fun key value v -> (FStar_Util.smap_add next1 key value)) ())
in (

let _50_172 = (FStar_Util.smap_fold hd2 (fun key value v -> (FStar_Util.smap_add next2 key value)) ())
in (FStar_ST.op_Colon_Equals scopes (((next1, next2))::tl))))
end
| _50_175 -> begin
(FStar_All.failwith "Impossible")
end)
end))
in {push = push; pop = pop; mark = mark; reset_mark = reset_mark; commit_mark = commit_mark; new_var = new_var; new_fvar = new_fvar; fresh = fresh; string_const = string_const; next_id = next_id})))))))))))))))


let unmangle = (fun x -> (let _140_215 = (let _140_214 = (FStar_Absyn_Util.unmangle_field_name x.FStar_Absyn_Syntax.ppname)
in (let _140_213 = (FStar_Absyn_Util.unmangle_field_name x.FStar_Absyn_Syntax.realname)
in (_140_214, _140_213)))
in (FStar_Absyn_Util.mkbvd _140_215)))


type binding =
| Binding_var of (FStar_Absyn_Syntax.bvvdef * FStar_ToSMT_Term.term)
| Binding_tvar of (FStar_Absyn_Syntax.btvdef * FStar_ToSMT_Term.term)
| Binding_fvar of (FStar_Ident.lident * Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option)
| Binding_ftvar of (FStar_Ident.lident * Prims.string * FStar_ToSMT_Term.term Prims.option)


let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_tvar = (fun _discr_ -> (match (_discr_) with
| Binding_tvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_fvar = (fun _discr_ -> (match (_discr_) with
| Binding_fvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_ftvar = (fun _discr_ -> (match (_discr_) with
| Binding_ftvar (_) -> begin
true
end
| _ -> begin
false
end))


let ___Binding_var____0 = (fun projectee -> (match (projectee) with
| Binding_var (_50_180) -> begin
_50_180
end))


let ___Binding_tvar____0 = (fun projectee -> (match (projectee) with
| Binding_tvar (_50_183) -> begin
_50_183
end))


let ___Binding_fvar____0 = (fun projectee -> (match (projectee) with
| Binding_fvar (_50_186) -> begin
_50_186
end))


let ___Binding_ftvar____0 = (fun projectee -> (match (projectee) with
| Binding_ftvar (_50_189) -> begin
_50_189
end))


let binder_of_eithervar = (fun v -> (v, None))


type env_t =
{bindings : binding Prims.list; depth : Prims.int; tcenv : FStar_Tc_Env.env; warn : Prims.bool; cache : (Prims.string * FStar_ToSMT_Term.sort Prims.list * FStar_ToSMT_Term.decl Prims.list) FStar_Util.smap; nolabels : Prims.bool; use_zfuel_name : Prims.bool; encode_non_total_function_typ : Prims.bool}


let is_Mkenv_t : env_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv_t"))))


let print_env : env_t  ->  Prims.string = (fun e -> (let _140_301 = (FStar_All.pipe_right e.bindings (FStar_List.map (fun _50_2 -> (match (_50_2) with
| Binding_var (x, t) -> begin
(FStar_Absyn_Print.strBvd x)
end
| Binding_tvar (a, t) -> begin
(FStar_Absyn_Print.strBvd a)
end
| Binding_fvar (l, s, t, _50_214) -> begin
(FStar_Absyn_Print.sli l)
end
| Binding_ftvar (l, s, t) -> begin
(FStar_Absyn_Print.sli l)
end))))
in (FStar_All.pipe_right _140_301 (FStar_String.concat ", "))))


let lookup_binding = (fun env f -> (FStar_Util.find_map env.bindings f))


let caption_t : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.string Prims.option = (fun env t -> if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_311 = (FStar_Absyn_Print.typ_to_string t)
in Some (_140_311))
end else begin
None
end)


let fresh_fvar : Prims.string  ->  FStar_ToSMT_Term.sort  ->  (Prims.string * FStar_ToSMT_Term.term) = (fun x s -> (

let xsym = (varops.fresh x)
in (let _140_316 = (FStar_ToSMT_Term.mkFreeV (xsym, s))
in (xsym, _140_316))))


let gen_term_var : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (let _140_321 = (FStar_Util.string_of_int env.depth)
in (Prims.strcat "@x" _140_321))
in (

let y = (FStar_ToSMT_Term.mkFreeV (ysym, FStar_ToSMT_Term.Term_sort))
in (ysym, y, (

let _50_233 = env
in {bindings = (Binding_var ((x, y)))::env.bindings; depth = (env.depth + 1); tcenv = _50_233.tcenv; warn = _50_233.warn; cache = _50_233.cache; nolabels = _50_233.nolabels; use_zfuel_name = _50_233.use_zfuel_name; encode_non_total_function_typ = _50_233.encode_non_total_function_typ})))))


let new_term_constant : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (varops.new_var x.FStar_Absyn_Syntax.ppname x.FStar_Absyn_Syntax.realname)
in (

let y = (FStar_ToSMT_Term.mkApp (ysym, []))
in (ysym, y, (

let _50_239 = env
in {bindings = (Binding_var ((x, y)))::env.bindings; depth = _50_239.depth; tcenv = _50_239.tcenv; warn = _50_239.warn; cache = _50_239.cache; nolabels = _50_239.nolabels; use_zfuel_name = _50_239.use_zfuel_name; encode_non_total_function_typ = _50_239.encode_non_total_function_typ})))))


let push_term_var : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  FStar_ToSMT_Term.term  ->  env_t = (fun env x t -> (

let _50_244 = env
in {bindings = (Binding_var ((x, t)))::env.bindings; depth = _50_244.depth; tcenv = _50_244.tcenv; warn = _50_244.warn; cache = _50_244.cache; nolabels = _50_244.nolabels; use_zfuel_name = _50_244.use_zfuel_name; encode_non_total_function_typ = _50_244.encode_non_total_function_typ}))


let lookup_term_var = (fun env a -> (match ((lookup_binding env (fun _50_3 -> (match (_50_3) with
| Binding_var (b, t) when (FStar_Absyn_Util.bvd_eq b a.FStar_Absyn_Syntax.v) -> begin
Some ((b, t))
end
| _50_254 -> begin
None
end)))) with
| None -> begin
(let _140_336 = (let _140_335 = (FStar_Absyn_Print.strBvd a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Bound term variable not found: %s" _140_335))
in (FStar_All.failwith _140_336))
end
| Some (b, t) -> begin
t
end))


let gen_typ_var : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (let _140_341 = (FStar_Util.string_of_int env.depth)
in (Prims.strcat "@a" _140_341))
in (

let y = (FStar_ToSMT_Term.mkFreeV (ysym, FStar_ToSMT_Term.Type_sort))
in (ysym, y, (

let _50_264 = env
in {bindings = (Binding_tvar ((x, y)))::env.bindings; depth = (env.depth + 1); tcenv = _50_264.tcenv; warn = _50_264.warn; cache = _50_264.cache; nolabels = _50_264.nolabels; use_zfuel_name = _50_264.use_zfuel_name; encode_non_total_function_typ = _50_264.encode_non_total_function_typ})))))


let new_typ_constant : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (varops.new_var x.FStar_Absyn_Syntax.ppname x.FStar_Absyn_Syntax.realname)
in (

let y = (FStar_ToSMT_Term.mkApp (ysym, []))
in (ysym, y, (

let _50_270 = env
in {bindings = (Binding_tvar ((x, y)))::env.bindings; depth = _50_270.depth; tcenv = _50_270.tcenv; warn = _50_270.warn; cache = _50_270.cache; nolabels = _50_270.nolabels; use_zfuel_name = _50_270.use_zfuel_name; encode_non_total_function_typ = _50_270.encode_non_total_function_typ})))))


let push_typ_var : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  FStar_ToSMT_Term.term  ->  env_t = (fun env x t -> (

let _50_275 = env
in {bindings = (Binding_tvar ((x, t)))::env.bindings; depth = _50_275.depth; tcenv = _50_275.tcenv; warn = _50_275.warn; cache = _50_275.cache; nolabels = _50_275.nolabels; use_zfuel_name = _50_275.use_zfuel_name; encode_non_total_function_typ = _50_275.encode_non_total_function_typ}))


let lookup_typ_var = (fun env a -> (match ((lookup_binding env (fun _50_4 -> (match (_50_4) with
| Binding_tvar (b, t) when (FStar_Absyn_Util.bvd_eq b a.FStar_Absyn_Syntax.v) -> begin
Some ((b, t))
end
| _50_285 -> begin
None
end)))) with
| None -> begin
(let _140_356 = (let _140_355 = (FStar_Absyn_Print.strBvd a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Bound type variable not found: %s" _140_355))
in (FStar_All.failwith _140_356))
end
| Some (b, t) -> begin
t
end))


let new_term_constant_and_tok_from_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * Prims.string * env_t) = (fun env x -> (

let fname = (varops.new_fvar x)
in (

let ftok = (Prims.strcat fname "@tok")
in (let _140_367 = (

let _50_295 = env
in (let _140_366 = (let _140_365 = (let _140_364 = (let _140_363 = (let _140_362 = (FStar_ToSMT_Term.mkApp (ftok, []))
in (FStar_All.pipe_left (fun _140_361 -> Some (_140_361)) _140_362))
in (x, fname, _140_363, None))
in Binding_fvar (_140_364))
in (_140_365)::env.bindings)
in {bindings = _140_366; depth = _50_295.depth; tcenv = _50_295.tcenv; warn = _50_295.warn; cache = _50_295.cache; nolabels = _50_295.nolabels; use_zfuel_name = _50_295.use_zfuel_name; encode_non_total_function_typ = _50_295.encode_non_total_function_typ}))
in (fname, ftok, _140_367)))))


let try_lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option) Prims.option = (fun env a -> (lookup_binding env (fun _50_5 -> (match (_50_5) with
| Binding_fvar (b, t1, t2, t3) when (FStar_Ident.lid_equals b a) -> begin
Some ((t1, t2, t3))
end
| _50_307 -> begin
None
end))))


let lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option) = (fun env a -> (match ((try_lookup_lid env a)) with
| None -> begin
(let _140_378 = (let _140_377 = (FStar_Absyn_Print.sli a)
in (FStar_Util.format1 "Name not found: %s" _140_377))
in (FStar_All.failwith _140_378))
end
| Some (s) -> begin
s
end))


let push_free_var : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option  ->  env_t = (fun env x fname ftok -> (

let _50_317 = env
in {bindings = (Binding_fvar ((x, fname, ftok, None)))::env.bindings; depth = _50_317.depth; tcenv = _50_317.tcenv; warn = _50_317.warn; cache = _50_317.cache; nolabels = _50_317.nolabels; use_zfuel_name = _50_317.use_zfuel_name; encode_non_total_function_typ = _50_317.encode_non_total_function_typ}))


let push_zfuel_name : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  env_t = (fun env x f -> (

let _50_326 = (lookup_lid env x)
in (match (_50_326) with
| (t1, t2, _50_325) -> begin
(

let t3 = (let _140_395 = (let _140_394 = (let _140_393 = (FStar_ToSMT_Term.mkApp ("ZFuel", []))
in (_140_393)::[])
in (f, _140_394))
in (FStar_ToSMT_Term.mkApp _140_395))
in (

let _50_328 = env
in {bindings = (Binding_fvar ((x, t1, t2, Some (t3))))::env.bindings; depth = _50_328.depth; tcenv = _50_328.tcenv; warn = _50_328.warn; cache = _50_328.cache; nolabels = _50_328.nolabels; use_zfuel_name = _50_328.use_zfuel_name; encode_non_total_function_typ = _50_328.encode_non_total_function_typ}))
end)))


let lookup_free_var = (fun env a -> (

let _50_335 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_335) with
| (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some (f) when env.use_zfuel_name -> begin
f
end
| _50_339 -> begin
(match (sym) with
| Some (t) -> begin
(match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (_50_343, (fuel)::[]) -> begin
if (let _140_399 = (let _140_398 = (FStar_ToSMT_Term.fv_of_term fuel)
in (FStar_All.pipe_right _140_398 Prims.fst))
in (FStar_Util.starts_with _140_399 "fuel")) then begin
(let _140_400 = (FStar_ToSMT_Term.mkFreeV (name, FStar_ToSMT_Term.Term_sort))
in (FStar_ToSMT_Term.mk_ApplyEF _140_400 fuel))
end else begin
t
end
end
| _50_349 -> begin
t
end)
end
| _50_351 -> begin
(let _140_402 = (let _140_401 = (FStar_Absyn_Print.sli a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Name not found: %s" _140_401))
in (FStar_All.failwith _140_402))
end)
end)
end)))


let lookup_free_var_name = (fun env a -> (

let _50_359 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_359) with
| (x, _50_356, _50_358) -> begin
x
end)))


let lookup_free_var_sym = (fun env a -> (

let _50_365 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_365) with
| (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some ({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.App (g, zf); FStar_ToSMT_Term.hash = _50_369; FStar_ToSMT_Term.freevars = _50_367}) when env.use_zfuel_name -> begin
(g, zf)
end
| _50_377 -> begin
(match (sym) with
| None -> begin
(FStar_ToSMT_Term.Var (name), [])
end
| Some (sym) -> begin
(match (sym.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (g, (fuel)::[]) -> begin
(g, (fuel)::[])
end
| _50_387 -> begin
(FStar_ToSMT_Term.Var (name), [])
end)
end)
end)
end)))


let new_typ_constant_and_tok_from_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * Prims.string * env_t) = (fun env x -> (

let fname = (varops.new_fvar x)
in (

let ftok = (Prims.strcat fname "@tok")
in (let _140_417 = (

let _50_392 = env
in (let _140_416 = (let _140_415 = (let _140_414 = (let _140_413 = (let _140_412 = (FStar_ToSMT_Term.mkApp (ftok, []))
in (FStar_All.pipe_left (fun _140_411 -> Some (_140_411)) _140_412))
in (x, fname, _140_413))
in Binding_ftvar (_140_414))
in (_140_415)::env.bindings)
in {bindings = _140_416; depth = _50_392.depth; tcenv = _50_392.tcenv; warn = _50_392.warn; cache = _50_392.cache; nolabels = _50_392.nolabels; use_zfuel_name = _50_392.use_zfuel_name; encode_non_total_function_typ = _50_392.encode_non_total_function_typ}))
in (fname, ftok, _140_417)))))


let lookup_tlid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option) = (fun env a -> (match ((lookup_binding env (fun _50_6 -> (match (_50_6) with
| Binding_ftvar (b, t1, t2) when (FStar_Ident.lid_equals b a) -> begin
Some ((t1, t2))
end
| _50_403 -> begin
None
end)))) with
| None -> begin
(let _140_424 = (let _140_423 = (FStar_Absyn_Print.sli a)
in (FStar_Util.format1 "Type name not found: %s" _140_423))
in (FStar_All.failwith _140_424))
end
| Some (s) -> begin
s
end))


let push_free_tvar : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option  ->  env_t = (fun env x fname ftok -> (

let _50_411 = env
in {bindings = (Binding_ftvar ((x, fname, ftok)))::env.bindings; depth = _50_411.depth; tcenv = _50_411.tcenv; warn = _50_411.warn; cache = _50_411.cache; nolabels = _50_411.nolabels; use_zfuel_name = _50_411.use_zfuel_name; encode_non_total_function_typ = _50_411.encode_non_total_function_typ}))


let lookup_free_tvar = (fun env a -> (match ((let _140_435 = (lookup_tlid env a.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _140_435 Prims.snd))) with
| None -> begin
(let _140_437 = (let _140_436 = (FStar_Absyn_Print.sli a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Type name not found: %s" _140_436))
in (FStar_All.failwith _140_437))
end
| Some (t) -> begin
t
end))


let lookup_free_tvar_name = (fun env a -> (let _140_440 = (lookup_tlid env a.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _140_440 Prims.fst)))


let tok_of_name : env_t  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option = (fun env nm -> (FStar_Util.find_map env.bindings (fun _50_7 -> (match (_50_7) with
| (Binding_fvar (_, nm', tok, _)) | (Binding_ftvar (_, nm', tok)) when (nm = nm') -> begin
tok
end
| _50_436 -> begin
None
end))))


let mkForall_fuel' = (fun n _50_441 -> (match (_50_441) with
| (pats, vars, body) -> begin
(

let fallback = (fun _50_443 -> (match (()) with
| () -> begin
(FStar_ToSMT_Term.mkForall (pats, vars, body))
end))
in if (FStar_Options.unthrottle_inductives ()) then begin
(fallback ())
end else begin
(

let _50_446 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_446) with
| (fsym, fterm) -> begin
(

let add_fuel = (fun tms -> (FStar_All.pipe_right tms (FStar_List.map (fun p -> (match (p.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Var ("HasType"), args) -> begin
(FStar_ToSMT_Term.mkApp ("HasTypeFuel", (fterm)::args))
end
| _50_456 -> begin
p
end)))))
in (

let pats = (FStar_List.map add_fuel pats)
in (

let body = (match (body.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Imp, (guard)::(body')::[]) -> begin
(

let guard = (match (guard.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.And, guards) -> begin
(let _140_453 = (add_fuel guards)
in (FStar_ToSMT_Term.mk_and_l _140_453))
end
| _50_469 -> begin
(let _140_454 = (add_fuel ((guard)::[]))
in (FStar_All.pipe_right _140_454 FStar_List.hd))
end)
in (FStar_ToSMT_Term.mkImp (guard, body')))
end
| _50_472 -> begin
body
end)
in (

let vars = ((fsym, FStar_ToSMT_Term.Fuel_sort))::vars
in (FStar_ToSMT_Term.mkForall (pats, vars, body))))))
end))
end)
end))


let mkForall_fuel : (FStar_ToSMT_Term.pat Prims.list Prims.list * FStar_ToSMT_Term.fvs * FStar_ToSMT_Term.term)  ->  FStar_ToSMT_Term.term = (mkForall_fuel' 1)


let head_normal : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.bool = (fun env t -> (

let t = (FStar_Absyn_Util.unmeta_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_refine (_)) | (FStar_Absyn_Syntax.Typ_btvar (_)) | (FStar_Absyn_Syntax.Typ_uvar (_)) | (FStar_Absyn_Syntax.Typ_lam (_)) -> begin
true
end
| (FStar_Absyn_Syntax.Typ_const (v)) | (FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (v); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _)) -> begin
(let _140_460 = (FStar_Tc_Env.lookup_typ_abbrev env.tcenv v.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _140_460 FStar_Option.isNone))
end
| _50_510 -> begin
false
end)))


let whnf : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t -> if (head_normal env t) then begin
t
end else begin
(FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.WHNF)::(FStar_Tc_Normalize.DeltaHard)::[]) env.tcenv t)
end)


let whnf_e : env_t  ->  FStar_Absyn_Syntax.exp  ->  FStar_Absyn_Syntax.exp = (fun env e -> (FStar_Tc_Normalize.norm_exp ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.WHNF)::[]) env.tcenv e))


let norm_t : env_t  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun env t -> (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::[]) env.tcenv t))


let norm_k : env_t  ->  FStar_Absyn_Syntax.knd  ->  FStar_Absyn_Syntax.knd = (fun env k -> (FStar_Tc_Normalize.normalize_kind env.tcenv k))


let trivial_post : FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun t -> (let _140_482 = (let _140_481 = (let _140_479 = (FStar_Absyn_Syntax.null_v_binder t)
in (_140_479)::[])
in (let _140_480 = (FStar_Absyn_Util.ftv FStar_Absyn_Const.true_lid FStar_Absyn_Syntax.ktype)
in (_140_481, _140_480)))
in (FStar_Absyn_Syntax.mk_Typ_lam _140_482 None t.FStar_Absyn_Syntax.pos)))


let mk_ApplyE : FStar_ToSMT_Term.term  ->  (Prims.string * FStar_ToSMT_Term.sort) Prims.list  ->  FStar_ToSMT_Term.term = (fun e vars -> (FStar_All.pipe_right vars (FStar_List.fold_left (fun out var -> (match ((Prims.snd var)) with
| FStar_ToSMT_Term.Type_sort -> begin
(let _140_489 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyET out _140_489))
end
| FStar_ToSMT_Term.Fuel_sort -> begin
(let _140_490 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyEF out _140_490))
end
| _50_527 -> begin
(let _140_491 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyEE out _140_491))
end)) e)))


let mk_ApplyE_args : FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list  ->  FStar_ToSMT_Term.term = (fun e args -> (FStar_All.pipe_right args (FStar_List.fold_left (fun out arg -> (match (arg) with
| FStar_Util.Inl (t) -> begin
(FStar_ToSMT_Term.mk_ApplyET out t)
end
| FStar_Util.Inr (e) -> begin
(FStar_ToSMT_Term.mk_ApplyEE out e)
end)) e)))


let mk_ApplyT : FStar_ToSMT_Term.term  ->  (Prims.string * FStar_ToSMT_Term.sort) Prims.list  ->  FStar_ToSMT_Term.term = (fun t vars -> (FStar_All.pipe_right vars (FStar_List.fold_left (fun out var -> (match ((Prims.snd var)) with
| FStar_ToSMT_Term.Type_sort -> begin
(let _140_504 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyTT out _140_504))
end
| _50_542 -> begin
(let _140_505 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyTE out _140_505))
end)) t)))


let mk_ApplyT_args : FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list  ->  FStar_ToSMT_Term.term = (fun t args -> (FStar_All.pipe_right args (FStar_List.fold_left (fun out arg -> (match (arg) with
| FStar_Util.Inl (t) -> begin
(FStar_ToSMT_Term.mk_ApplyTT out t)
end
| FStar_Util.Inr (e) -> begin
(FStar_ToSMT_Term.mk_ApplyTE out e)
end)) t)))


let is_app : FStar_ToSMT_Term.op  ->  Prims.bool = (fun _50_8 -> (match (_50_8) with
| (FStar_ToSMT_Term.Var ("ApplyTT")) | (FStar_ToSMT_Term.Var ("ApplyTE")) | (FStar_ToSMT_Term.Var ("ApplyET")) | (FStar_ToSMT_Term.Var ("ApplyEE")) -> begin
true
end
| _50_561 -> begin
false
end))


let is_eta : env_t  ->  FStar_ToSMT_Term.fv Prims.list  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term Prims.option = (fun env vars t -> (

let rec aux = (fun t xs -> (match ((t.FStar_ToSMT_Term.tm, xs)) with
| (FStar_ToSMT_Term.App (app, (f)::({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.FreeV (y); FStar_ToSMT_Term.hash = _50_572; FStar_ToSMT_Term.freevars = _50_570})::[]), (x)::xs) when ((is_app app) && (FStar_ToSMT_Term.fv_eq x y)) -> begin
(aux f xs)
end
| (FStar_ToSMT_Term.App (FStar_ToSMT_Term.Var (f), args), _50_590) -> begin
if (((FStar_List.length args) = (FStar_List.length vars)) && (FStar_List.forall2 (fun a v -> (match (a.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.FreeV (fv) -> begin
(FStar_ToSMT_Term.fv_eq fv v)
end
| _50_597 -> begin
false
end)) args vars)) then begin
(tok_of_name env f)
end else begin
None
end
end
| (_50_599, []) -> begin
(

let fvs = (FStar_ToSMT_Term.free_variables t)
in if (FStar_All.pipe_right fvs (FStar_List.for_all (fun fv -> (not ((FStar_Util.for_some (FStar_ToSMT_Term.fv_eq fv) vars)))))) then begin
Some (t)
end else begin
None
end)
end
| _50_605 -> begin
None
end))
in (aux t (FStar_List.rev vars))))


type label =
(FStar_ToSMT_Term.fv * Prims.string * FStar_Range.range)


type labels =
label Prims.list


type pattern =
{pat_vars : (FStar_Absyn_Syntax.either_var * FStar_ToSMT_Term.fv) Prims.list; pat_term : Prims.unit  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t); guard : FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term; projections : FStar_ToSMT_Term.term  ->  (FStar_Absyn_Syntax.either_var * FStar_ToSMT_Term.term) Prims.list}


let is_Mkpattern : pattern  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkpattern"))))


exception Let_rec_unencodeable


let is_Let_rec_unencodeable = (fun _discr_ -> (match (_discr_) with
| Let_rec_unencodeable (_) -> begin
true
end
| _ -> begin
false
end))


let constructor_string_of_int_qualifier : (FStar_Const.signedness * FStar_Const.width)  ->  Prims.string = (fun _50_9 -> (match (_50_9) with
| (FStar_Const.Unsigned, FStar_Const.Int8) -> begin
"FStar.UInt8.UInt8"
end
| (FStar_Const.Signed, FStar_Const.Int8) -> begin
"FStar.Int8.Int8"
end
| (FStar_Const.Unsigned, FStar_Const.Int16) -> begin
"FStar.UInt16.UInt16"
end
| (FStar_Const.Signed, FStar_Const.Int16) -> begin
"FStar.Int16.Int16"
end
| (FStar_Const.Unsigned, FStar_Const.Int32) -> begin
"FStar.UInt32.UInt32"
end
| (FStar_Const.Signed, FStar_Const.Int32) -> begin
"FStar.Int32.Int32"
end
| (FStar_Const.Unsigned, FStar_Const.Int64) -> begin
"FStar.UInt64.UInt64"
end
| (FStar_Const.Signed, FStar_Const.Int64) -> begin
"FStar.Int64.Int64"
end))


let encode_const : FStar_Const.sconst  ->  FStar_ToSMT_Term.term = (fun _50_10 -> (match (_50_10) with
| FStar_Const.Const_unit -> begin
FStar_ToSMT_Term.mk_Term_unit
end
| FStar_Const.Const_bool (true) -> begin
(FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkTrue)
end
| FStar_Const.Const_bool (false) -> begin
(FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkFalse)
end
| FStar_Const.Const_char (c) -> begin
(let _140_566 = (let _140_565 = (let _140_564 = (let _140_563 = (FStar_ToSMT_Term.mkInteger' (FStar_Util.int_of_char c))
in (FStar_ToSMT_Term.boxInt _140_563))
in (_140_564)::[])
in ("FStar.Char.Char", _140_565))
in (FStar_ToSMT_Term.mkApp _140_566))
end
| FStar_Const.Const_int (i, None) -> begin
(let _140_567 = (FStar_ToSMT_Term.mkInteger i)
in (FStar_ToSMT_Term.boxInt _140_567))
end
| FStar_Const.Const_int (i, Some (q)) -> begin
(let _140_571 = (let _140_570 = (let _140_569 = (let _140_568 = (FStar_ToSMT_Term.mkInteger i)
in (FStar_ToSMT_Term.boxInt _140_568))
in (_140_569)::[])
in ((constructor_string_of_int_qualifier q), _140_570))
in (FStar_ToSMT_Term.mkApp _140_571))
end
| FStar_Const.Const_string (bytes, _50_655) -> begin
(let _140_572 = (FStar_All.pipe_left FStar_Util.string_of_bytes bytes)
in (varops.string_const _140_572))
end
| c -> begin
(let _140_574 = (let _140_573 = (FStar_Absyn_Print.const_to_string c)
in (FStar_Util.format1 "Unhandled constant: %s\n" _140_573))
in (FStar_All.failwith _140_574))
end))


let as_function_typ : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t0 -> (

let rec aux = (fun norm t -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (_50_666) -> begin
t
end
| FStar_Absyn_Syntax.Typ_refine (_50_669) -> begin
(let _140_583 = (FStar_Absyn_Util.unrefine t)
in (aux true _140_583))
end
| _50_672 -> begin
if norm then begin
(let _140_584 = (whnf env t)
in (aux false _140_584))
end else begin
(let _140_587 = (let _140_586 = (FStar_Range.string_of_range t0.FStar_Absyn_Syntax.pos)
in (let _140_585 = (FStar_Absyn_Print.typ_to_string t0)
in (FStar_Util.format2 "(%s) Expected a function typ; got %s" _140_586 _140_585)))
in (FStar_All.failwith _140_587))
end
end)))
in (aux true t0)))


let rec encode_knd_term : FStar_Absyn_Syntax.knd  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun k env -> (match ((let _140_624 = (FStar_Absyn_Util.compress_kind k)
in _140_624.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Kind_type -> begin
(FStar_ToSMT_Term.mk_Kind_type, [])
end
| FStar_Absyn_Syntax.Kind_abbrev (_50_677, k0) -> begin
(

let _50_681 = if (FStar_Tc_Env.debug env.tcenv (FStar_Options.Other ("Encoding"))) then begin
(let _140_626 = (FStar_Absyn_Print.kind_to_string k)
in (let _140_625 = (FStar_Absyn_Print.kind_to_string k0)
in (FStar_Util.print2 "Encoding kind abbrev %s, expanded to %s\n" _140_626 _140_625)))
end else begin
()
end
in (encode_knd_term k0 env))
end
| FStar_Absyn_Syntax.Kind_uvar (uv, _50_685) -> begin
(let _140_628 = (let _140_627 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Kind_uvar _140_627))
in (_140_628, []))
end
| FStar_Absyn_Syntax.Kind_arrow (bs, kbody) -> begin
(

let tsym = (let _140_629 = (varops.fresh "t")
in (_140_629, FStar_ToSMT_Term.Type_sort))
in (

let t = (FStar_ToSMT_Term.mkFreeV tsym)
in (

let _50_700 = (encode_binders None bs env)
in (match (_50_700) with
| (vars, guards, env', decls, _50_699) -> begin
(

let app = (mk_ApplyT t vars)
in (

let _50_704 = (encode_knd kbody env' app)
in (match (_50_704) with
| (kbody, decls') -> begin
(

let rec aux = (fun app vars guards -> (match ((vars, guards)) with
| ([], []) -> begin
kbody
end
| ((x)::vars, (g)::guards) -> begin
(

let app = (mk_ApplyT app ((x)::[]))
in (

let body = (aux app vars guards)
in (

let body = (match (vars) with
| [] -> begin
body
end
| _50_723 -> begin
(let _140_638 = (let _140_637 = (let _140_636 = (FStar_ToSMT_Term.mk_PreKind app)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _140_636))
in (_140_637, body))
in (FStar_ToSMT_Term.mkAnd _140_638))
end)
in (let _140_640 = (let _140_639 = (FStar_ToSMT_Term.mkImp (g, body))
in (((app)::[])::[], (x)::[], _140_639))
in (FStar_ToSMT_Term.mkForall _140_640)))))
end
| _50_726 -> begin
(FStar_All.failwith "Impossible: vars and guards are in 1-1 correspondence")
end))
in (

let k_interp = (aux t vars guards)
in (

let cvars = (let _140_642 = (FStar_ToSMT_Term.free_variables k_interp)
in (FStar_All.pipe_right _140_642 (FStar_List.filter (fun _50_731 -> (match (_50_731) with
| (x, _50_730) -> begin
(x <> (Prims.fst tsym))
end)))))
in (

let tkey = (FStar_ToSMT_Term.mkForall ([], (tsym)::cvars, k_interp))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (k', sorts, _50_737) -> begin
(let _140_645 = (let _140_644 = (let _140_643 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in (k', _140_643))
in (FStar_ToSMT_Term.mkApp _140_644))
in (_140_645, []))
end
| None -> begin
(

let ksym = (varops.fresh "Kind_arrow")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let caption = if (FStar_Options.log_queries ()) then begin
(let _140_646 = (FStar_Tc_Normalize.kind_norm_to_string env.tcenv k)
in Some (_140_646))
end else begin
None
end
in (

let kdecl = FStar_ToSMT_Term.DeclFun ((ksym, cvar_sorts, FStar_ToSMT_Term.Kind_sort, caption))
in (

let k = (let _140_648 = (let _140_647 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (ksym, _140_647))
in (FStar_ToSMT_Term.mkApp _140_648))
in (

let t_has_k = (FStar_ToSMT_Term.mk_HasKind t k)
in (

let k_interp = (let _140_657 = (let _140_656 = (let _140_655 = (let _140_654 = (let _140_653 = (let _140_652 = (let _140_651 = (let _140_650 = (let _140_649 = (FStar_ToSMT_Term.mk_PreKind t)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _140_649))
in (_140_650, k_interp))
in (FStar_ToSMT_Term.mkAnd _140_651))
in (t_has_k, _140_652))
in (FStar_ToSMT_Term.mkIff _140_653))
in (((t_has_k)::[])::[], (tsym)::cvars, _140_654))
in (FStar_ToSMT_Term.mkForall _140_655))
in (_140_656, Some ((Prims.strcat ksym " interpretation"))))
in FStar_ToSMT_Term.Assume (_140_657))
in (

let k_decls = (FStar_List.append (FStar_List.append decls decls') ((kdecl)::(k_interp)::[]))
in (

let _50_749 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash (ksym, cvar_sorts, k_decls))
in (k, k_decls))))))))))
end)))))
end)))
end))))
end
| _50_752 -> begin
(let _140_659 = (let _140_658 = (FStar_Absyn_Print.kind_to_string k)
in (FStar_Util.format1 "Unknown kind: %s" _140_658))
in (FStar_All.failwith _140_659))
end))
and encode_knd : FStar_Absyn_Syntax.knd  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decl Prims.list) = (fun k env t -> (

let _50_758 = (encode_knd_term k env)
in (match (_50_758) with
| (k, decls) -> begin
(let _140_663 = (FStar_ToSMT_Term.mk_HasKind t k)
in (_140_663, decls))
end)))
and encode_binders : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.binders  ->  env_t  ->  (FStar_ToSMT_Term.fv Prims.list * FStar_ToSMT_Term.term Prims.list * env_t * FStar_ToSMT_Term.decls_t * (FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either Prims.list) = (fun fuel_opt bs env -> (

let _50_762 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_667 = (FStar_Absyn_Print.binders_to_string ", " bs)
in (FStar_Util.print1 "Encoding binders %s\n" _140_667))
end else begin
()
end
in (

let _50_812 = (FStar_All.pipe_right bs (FStar_List.fold_left (fun _50_769 b -> (match (_50_769) with
| (vars, guards, env, decls, names) -> begin
(

let _50_806 = (match ((Prims.fst b)) with
| FStar_Util.Inl ({FStar_Absyn_Syntax.v = a; FStar_Absyn_Syntax.sort = k; FStar_Absyn_Syntax.p = _50_772}) -> begin
(

let a = (unmangle a)
in (

let _50_781 = (gen_typ_var env a)
in (match (_50_781) with
| (aasym, aa, env') -> begin
(

let _50_782 = if (FStar_Tc_Env.debug env.tcenv (FStar_Options.Other ("Encoding"))) then begin
(let _140_671 = (FStar_Absyn_Print.strBvd a)
in (let _140_670 = (FStar_Absyn_Print.kind_to_string k)
in (FStar_Util.print3 "Encoding type binder %s (%s) at kind %s\n" _140_671 aasym _140_670)))
end else begin
()
end
in (

let _50_786 = (encode_knd k env aa)
in (match (_50_786) with
| (guard_a_k, decls') -> begin
((aasym, FStar_ToSMT_Term.Type_sort), guard_a_k, env', decls', FStar_Util.Inl (a))
end)))
end)))
end
| FStar_Util.Inr ({FStar_Absyn_Syntax.v = x; FStar_Absyn_Syntax.sort = t; FStar_Absyn_Syntax.p = _50_788}) -> begin
(

let x = (unmangle x)
in (

let _50_797 = (gen_term_var env x)
in (match (_50_797) with
| (xxsym, xx, env') -> begin
(

let _50_800 = (let _140_672 = (norm_t env t)
in (encode_typ_pred fuel_opt _140_672 env xx))
in (match (_50_800) with
| (guard_x_t, decls') -> begin
((xxsym, FStar_ToSMT_Term.Term_sort), guard_x_t, env', decls', FStar_Util.Inr (x))
end))
end)))
end)
in (match (_50_806) with
| (v, g, env, decls', n) -> begin
((v)::vars, (g)::guards, env, (FStar_List.append decls decls'), (n)::names)
end))
end)) ([], [], env, [], [])))
in (match (_50_812) with
| (vars, guards, env, decls, names) -> begin
((FStar_List.rev vars), (FStar_List.rev guards), env, decls, (FStar_List.rev names))
end))))
and encode_typ_pred : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun fuel_opt t env e -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (

let _50_820 = (encode_typ_term t env)
in (match (_50_820) with
| (t, decls) -> begin
(let _140_677 = (FStar_ToSMT_Term.mk_HasTypeWithFuel fuel_opt e t)
in (_140_677, decls))
end))))
and encode_typ_pred' : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun fuel_opt t env e -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (

let _50_828 = (encode_typ_term t env)
in (match (_50_828) with
| (t, decls) -> begin
(match (fuel_opt) with
| None -> begin
(let _140_682 = (FStar_ToSMT_Term.mk_HasTypeZ e t)
in (_140_682, decls))
end
| Some (f) -> begin
(let _140_683 = (FStar_ToSMT_Term.mk_HasTypeFuel f e t)
in (_140_683, decls))
end)
end))))
and encode_typ_term : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun t env -> (

let t0 = (FStar_Absyn_Util.compress_typ t)
in (match (t0.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
(let _140_686 = (lookup_typ_var env a)
in (_140_686, []))
end
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(let _140_687 = (lookup_free_tvar env fv)
in (_140_687, []))
end
| FStar_Absyn_Syntax.Typ_fun (binders, res) -> begin
if ((env.encode_non_total_function_typ && (FStar_Absyn_Util.is_pure_or_ghost_comp res)) || (FStar_Absyn_Util.is_tot_or_gtot_comp res)) then begin
(

let _50_849 = (encode_binders None binders env)
in (match (_50_849) with
| (vars, guards, env', decls, _50_848) -> begin
(

let fsym = (let _140_688 = (varops.fresh "f")
in (_140_688, FStar_ToSMT_Term.Term_sort))
in (

let f = (FStar_ToSMT_Term.mkFreeV fsym)
in (

let app = (mk_ApplyE f vars)
in (

let _50_855 = (FStar_Tc_Util.pure_or_ghost_pre_and_post env.tcenv res)
in (match (_50_855) with
| (pre_opt, res_t) -> begin
(

let _50_858 = (encode_typ_pred None res_t env' app)
in (match (_50_858) with
| (res_pred, decls') -> begin
(

let _50_867 = (match (pre_opt) with
| None -> begin
(let _140_689 = (FStar_ToSMT_Term.mk_and_l guards)
in (_140_689, decls))
end
| Some (pre) -> begin
(

let _50_864 = (encode_formula pre env')
in (match (_50_864) with
| (guard, decls0) -> begin
(let _140_690 = (FStar_ToSMT_Term.mk_and_l ((guard)::guards))
in (_140_690, (FStar_List.append decls decls0)))
end))
end)
in (match (_50_867) with
| (guards, guard_decls) -> begin
(

let t_interp = (let _140_692 = (let _140_691 = (FStar_ToSMT_Term.mkImp (guards, res_pred))
in (((app)::[])::[], vars, _140_691))
in (FStar_ToSMT_Term.mkForall _140_692))
in (

let cvars = (let _140_694 = (FStar_ToSMT_Term.free_variables t_interp)
in (FStar_All.pipe_right _140_694 (FStar_List.filter (fun _50_872 -> (match (_50_872) with
| (x, _50_871) -> begin
(x <> (Prims.fst fsym))
end)))))
in (

let tkey = (FStar_ToSMT_Term.mkForall ([], (fsym)::cvars, t_interp))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t', sorts, _50_878) -> begin
(let _140_697 = (let _140_696 = (let _140_695 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in (t', _140_695))
in (FStar_ToSMT_Term.mkApp _140_696))
in (_140_697, []))
end
| None -> begin
(

let tsym = (varops.fresh "Typ_fun")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let caption = if (FStar_Options.log_queries ()) then begin
(let _140_698 = (FStar_Tc_Normalize.typ_norm_to_string env.tcenv t0)
in Some (_140_698))
end else begin
None
end
in (

let tdecl = FStar_ToSMT_Term.DeclFun ((tsym, cvar_sorts, FStar_ToSMT_Term.Type_sort, caption))
in (

let t = (let _140_700 = (let _140_699 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (tsym, _140_699))
in (FStar_ToSMT_Term.mkApp _140_700))
in (

let t_has_kind = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in (

let k_assumption = (let _140_702 = (let _140_701 = (FStar_ToSMT_Term.mkForall (((t_has_kind)::[])::[], cvars, t_has_kind))
in (_140_701, Some ((Prims.strcat tsym " kinding"))))
in FStar_ToSMT_Term.Assume (_140_702))
in (

let f_has_t = (FStar_ToSMT_Term.mk_HasType f t)
in (

let f_has_t_z = (FStar_ToSMT_Term.mk_HasTypeZ f t)
in (

let pre_typing = (let _140_709 = (let _140_708 = (let _140_707 = (let _140_706 = (let _140_705 = (let _140_704 = (let _140_703 = (FStar_ToSMT_Term.mk_PreType f)
in (FStar_ToSMT_Term.mk_tester "Typ_fun" _140_703))
in (f_has_t, _140_704))
in (FStar_ToSMT_Term.mkImp _140_705))
in (((f_has_t)::[])::[], (fsym)::cvars, _140_706))
in (mkForall_fuel _140_707))
in (_140_708, Some ("pre-typing for functions")))
in FStar_ToSMT_Term.Assume (_140_709))
in (

let t_interp = (let _140_713 = (let _140_712 = (let _140_711 = (let _140_710 = (FStar_ToSMT_Term.mkIff (f_has_t_z, t_interp))
in (((f_has_t_z)::[])::[], (fsym)::cvars, _140_710))
in (FStar_ToSMT_Term.mkForall _140_711))
in (_140_712, Some ((Prims.strcat tsym " interpretation"))))
in FStar_ToSMT_Term.Assume (_140_713))
in (

let t_decls = (FStar_List.append (FStar_List.append decls decls') ((tdecl)::(k_assumption)::(pre_typing)::(t_interp)::[]))
in (

let _50_894 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash (tsym, cvar_sorts, t_decls))
in (t, t_decls))))))))))))))
end))))
end))
end))
end)))))
end))
end else begin
(

let tsym = (varops.fresh "Non_total_Typ_fun")
in (

let tdecl = FStar_ToSMT_Term.DeclFun ((tsym, [], FStar_ToSMT_Term.Type_sort, None))
in (

let t = (FStar_ToSMT_Term.mkApp (tsym, []))
in (

let t_kinding = (let _140_715 = (let _140_714 = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in (_140_714, None))
in FStar_ToSMT_Term.Assume (_140_715))
in (

let fsym = ("f", FStar_ToSMT_Term.Term_sort)
in (

let f = (FStar_ToSMT_Term.mkFreeV fsym)
in (

let f_has_t = (FStar_ToSMT_Term.mk_HasType f t)
in (

let t_interp = (let _140_722 = (let _140_721 = (let _140_720 = (let _140_719 = (let _140_718 = (let _140_717 = (let _140_716 = (FStar_ToSMT_Term.mk_PreType f)
in (FStar_ToSMT_Term.mk_tester "Typ_fun" _140_716))
in (f_has_t, _140_717))
in (FStar_ToSMT_Term.mkImp _140_718))
in (((f_has_t)::[])::[], (fsym)::[], _140_719))
in (mkForall_fuel _140_720))
in (_140_721, Some ("pre-typing")))
in FStar_ToSMT_Term.Assume (_140_722))
in (t, (tdecl)::(t_kinding)::(t_interp)::[])))))))))
end
end
| FStar_Absyn_Syntax.Typ_refine (_50_905) -> begin
(

let _50_924 = (match ((FStar_Tc_Normalize.normalize_refinement [] env.tcenv t0)) with
| {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_refine (x, f); FStar_Absyn_Syntax.tk = _50_914; FStar_Absyn_Syntax.pos = _50_912; FStar_Absyn_Syntax.fvs = _50_910; FStar_Absyn_Syntax.uvs = _50_908} -> begin
(x, f)
end
| _50_921 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_50_924) with
| (x, f) -> begin
(

let _50_927 = (encode_typ_term x.FStar_Absyn_Syntax.sort env)
in (match (_50_927) with
| (base_t, decls) -> begin
(

let _50_931 = (gen_term_var env x.FStar_Absyn_Syntax.v)
in (match (_50_931) with
| (x, xtm, env') -> begin
(

let _50_934 = (encode_formula f env')
in (match (_50_934) with
| (refinement, decls') -> begin
(

let _50_937 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_937) with
| (fsym, fterm) -> begin
(

let encoding = (let _140_724 = (let _140_723 = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (fterm)) xtm base_t)
in (_140_723, refinement))
in (FStar_ToSMT_Term.mkAnd _140_724))
in (

let cvars = (let _140_726 = (FStar_ToSMT_Term.free_variables encoding)
in (FStar_All.pipe_right _140_726 (FStar_List.filter (fun _50_942 -> (match (_50_942) with
| (y, _50_941) -> begin
((y <> x) && (y <> fsym))
end)))))
in (

let xfv = (x, FStar_ToSMT_Term.Term_sort)
in (

let ffv = (fsym, FStar_ToSMT_Term.Fuel_sort)
in (

let tkey = (FStar_ToSMT_Term.mkForall ([], (ffv)::(xfv)::cvars, encoding))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_949, _50_951) -> begin
(let _140_729 = (let _140_728 = (let _140_727 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in (t, _140_727))
in (FStar_ToSMT_Term.mkApp _140_728))
in (_140_729, []))
end
| None -> begin
(

let tsym = (varops.fresh "Typ_refine")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let tdecl = FStar_ToSMT_Term.DeclFun ((tsym, cvar_sorts, FStar_ToSMT_Term.Type_sort, None))
in (

let t = (let _140_731 = (let _140_730 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (tsym, _140_730))
in (FStar_ToSMT_Term.mkApp _140_731))
in (

let x_has_t = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (fterm)) xtm t)
in (

let t_has_kind = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in (

let t_kinding = (FStar_ToSMT_Term.mkForall (((t_has_kind)::[])::[], cvars, t_has_kind))
in (

let assumption = (let _140_733 = (let _140_732 = (FStar_ToSMT_Term.mkIff (x_has_t, encoding))
in (((x_has_t)::[])::[], (ffv)::(xfv)::cvars, _140_732))
in (FStar_ToSMT_Term.mkForall _140_733))
in (

let t_decls = (let _140_740 = (let _140_739 = (let _140_738 = (let _140_737 = (let _140_736 = (let _140_735 = (let _140_734 = (FStar_Absyn_Print.typ_to_string t0)
in Some (_140_734))
in (assumption, _140_735))
in FStar_ToSMT_Term.Assume (_140_736))
in (_140_737)::[])
in (FStar_ToSMT_Term.Assume ((t_kinding, None)))::_140_738)
in (tdecl)::_140_739)
in (FStar_List.append (FStar_List.append decls decls') _140_740))
in (

let _50_964 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash (tsym, cvar_sorts, t_decls))
in (t, t_decls)))))))))))
end))))))
end))
end))
end))
end))
end))
end
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(

let ttm = (let _140_741 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Typ_uvar _140_741))
in (

let _50_973 = (encode_knd k env ttm)
in (match (_50_973) with
| (t_has_k, decls) -> begin
(

let d = FStar_ToSMT_Term.Assume ((t_has_k, None))
in (ttm, (d)::decls))
end)))
end
| FStar_Absyn_Syntax.Typ_app (head, args) -> begin
(

let is_full_app = (fun _50_980 -> (match (()) with
| () -> begin
(

let kk = (FStar_Tc_Recheck.recompute_kind head)
in (

let _50_985 = (FStar_Absyn_Util.kind_formals kk)
in (match (_50_985) with
| (formals, _50_984) -> begin
((FStar_List.length formals) = (FStar_List.length args))
end)))
end))
in (

let head = (FStar_Absyn_Util.compress_typ head)
in (match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
(

let head = (lookup_typ_var env a)
in (

let _50_992 = (encode_args args env)
in (match (_50_992) with
| (args, decls) -> begin
(

let t = (mk_ApplyT_args head args)
in (t, decls))
end)))
end
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(

let _50_998 = (encode_args args env)
in (match (_50_998) with
| (args, decls) -> begin
if (is_full_app ()) then begin
(

let head = (lookup_free_tvar_name env fv)
in (

let t = (let _140_746 = (let _140_745 = (FStar_List.map (fun _50_11 -> (match (_50_11) with
| (FStar_Util.Inl (t)) | (FStar_Util.Inr (t)) -> begin
t
end)) args)
in (head, _140_745))
in (FStar_ToSMT_Term.mkApp _140_746))
in (t, decls)))
end else begin
(

let head = (lookup_free_tvar env fv)
in (

let t = (mk_ApplyT_args head args)
in (t, decls)))
end
end))
end
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(

let ttm = (let _140_747 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Typ_uvar _140_747))
in (

let _50_1014 = (encode_knd k env ttm)
in (match (_50_1014) with
| (t_has_k, decls) -> begin
(

let d = FStar_ToSMT_Term.Assume ((t_has_k, None))
in (ttm, (d)::decls))
end)))
end
| _50_1017 -> begin
(

let t = (norm_t env t)
in (encode_typ_term t env))
end)))
end
| FStar_Absyn_Syntax.Typ_lam (bs, body) -> begin
(

let _50_1029 = (encode_binders None bs env)
in (match (_50_1029) with
| (vars, guards, env, decls, _50_1028) -> begin
(

let _50_1032 = (encode_typ_term body env)
in (match (_50_1032) with
| (body, decls') -> begin
(

let key_body = (let _140_751 = (let _140_750 = (let _140_749 = (let _140_748 = (FStar_ToSMT_Term.mk_and_l guards)
in (_140_748, body))
in (FStar_ToSMT_Term.mkImp _140_749))
in ([], vars, _140_750))
in (FStar_ToSMT_Term.mkForall _140_751))
in (

let cvars = (FStar_ToSMT_Term.free_variables key_body)
in (

let tkey = (FStar_ToSMT_Term.mkForall ([], cvars, key_body))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_1038, _50_1040) -> begin
(let _140_754 = (let _140_753 = (let _140_752 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (t, _140_752))
in (FStar_ToSMT_Term.mkApp _140_753))
in (_140_754, []))
end
| None -> begin
(match ((is_eta env vars body)) with
| Some (head) -> begin
(head, [])
end
| None -> begin
(

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let tsym = (varops.fresh "Typ_lam")
in (

let tdecl = FStar_ToSMT_Term.DeclFun ((tsym, cvar_sorts, FStar_ToSMT_Term.Type_sort, None))
in (

let t = (let _140_756 = (let _140_755 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (tsym, _140_755))
in (FStar_ToSMT_Term.mkApp _140_756))
in (

let app = (mk_ApplyT t vars)
in (

let interp = (let _140_763 = (let _140_762 = (let _140_761 = (let _140_760 = (let _140_759 = (let _140_758 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _140_757 = (FStar_ToSMT_Term.mkEq (app, body))
in (_140_758, _140_757)))
in (FStar_ToSMT_Term.mkImp _140_759))
in (((app)::[])::[], (FStar_List.append vars cvars), _140_760))
in (FStar_ToSMT_Term.mkForall _140_761))
in (_140_762, Some ("Typ_lam interpretation")))
in FStar_ToSMT_Term.Assume (_140_763))
in (

let kinding = (

let _50_1055 = (let _140_764 = (FStar_Tc_Recheck.recompute_kind t0)
in (encode_knd _140_764 env t))
in (match (_50_1055) with
| (ktm, decls'') -> begin
(let _140_768 = (let _140_767 = (let _140_766 = (let _140_765 = (FStar_ToSMT_Term.mkForall (((t)::[])::[], cvars, ktm))
in (_140_765, Some ("Typ_lam kinding")))
in FStar_ToSMT_Term.Assume (_140_766))
in (_140_767)::[])
in (FStar_List.append decls'' _140_768))
end))
in (

let t_decls = (FStar_List.append (FStar_List.append decls decls') ((tdecl)::(interp)::kinding))
in (

let _50_1058 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash (tsym, cvar_sorts, t_decls))
in (t, t_decls))))))))))
end)
end))))
end))
end))
end
| FStar_Absyn_Syntax.Typ_ascribed (t, _50_1062) -> begin
(encode_typ_term t env)
end
| FStar_Absyn_Syntax.Typ_meta (_50_1066) -> begin
(let _140_769 = (FStar_Absyn_Util.unmeta_typ t0)
in (encode_typ_term _140_769 env))
end
| (FStar_Absyn_Syntax.Typ_delayed (_)) | (FStar_Absyn_Syntax.Typ_unknown) -> begin
(let _140_774 = (let _140_773 = (FStar_All.pipe_left FStar_Range.string_of_range t.FStar_Absyn_Syntax.pos)
in (let _140_772 = (FStar_Absyn_Print.tag_of_typ t0)
in (let _140_771 = (FStar_Absyn_Print.typ_to_string t0)
in (let _140_770 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format4 "(%s) Impossible: %s\n%s\n%s\n" _140_773 _140_772 _140_771 _140_770)))))
in (FStar_All.failwith _140_774))
end)))
and encode_exp : FStar_Absyn_Syntax.exp  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun e env -> (

let e = (FStar_Absyn_Visit.compress_exp_uvars e)
in (

let e0 = e
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_delayed (_50_1077) -> begin
(let _140_777 = (FStar_Absyn_Util.compress_exp e)
in (encode_exp _140_777 env))
end
| FStar_Absyn_Syntax.Exp_bvar (x) -> begin
(

let t = (lookup_term_var env x)
in (t, []))
end
| FStar_Absyn_Syntax.Exp_fvar (v, _50_1084) -> begin
(let _140_778 = (lookup_free_var env v)
in (_140_778, []))
end
| FStar_Absyn_Syntax.Exp_constant (c) -> begin
(let _140_779 = (encode_const c)
in (_140_779, []))
end
| FStar_Absyn_Syntax.Exp_ascribed (e, t, _50_1092) -> begin
(

let _50_1095 = (FStar_ST.op_Colon_Equals e.FStar_Absyn_Syntax.tk (Some (t)))
in (encode_exp e env))
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _50_1099)) -> begin
(encode_exp e env)
end
| FStar_Absyn_Syntax.Exp_uvar (uv, _50_1105) -> begin
(

let e = (let _140_780 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Exp_uvar _140_780))
in (e, []))
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(

let fallback = (fun _50_1114 -> (match (()) with
| () -> begin
(

let f = (varops.fresh "Exp_abs")
in (

let decl = FStar_ToSMT_Term.DeclFun ((f, [], FStar_ToSMT_Term.Term_sort, None))
in (let _140_783 = (FStar_ToSMT_Term.mkFreeV (f, FStar_ToSMT_Term.Term_sort))
in (_140_783, (decl)::[]))))
end))
in (match ((FStar_ST.read e.FStar_Absyn_Syntax.tk)) with
| None -> begin
(

let _50_1118 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "Losing precision when encoding a function literal")
in (fallback ()))
end
| Some (tfun) -> begin
if (let _140_784 = (FStar_Absyn_Util.is_pure_or_ghost_function tfun)
in (FStar_All.pipe_left Prims.op_Negation _140_784)) then begin
(fallback ())
end else begin
(

let tfun = (as_function_typ env tfun)
in (match (tfun.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (bs', c) -> begin
(

let nformals = (FStar_List.length bs')
in if ((nformals < (FStar_List.length bs)) && (FStar_Absyn_Util.is_total_comp c)) then begin
(

let _50_1130 = (FStar_Util.first_N nformals bs)
in (match (_50_1130) with
| (bs0, rest) -> begin
(

let res_t = (match ((FStar_Absyn_Util.mk_subst_binder bs0 bs')) with
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s (FStar_Absyn_Util.comp_result c))
end
| _50_1134 -> begin
(FStar_All.failwith "Impossible")
end)
in (

let e = (let _140_786 = (let _140_785 = (FStar_Absyn_Syntax.mk_Exp_abs (rest, body) (Some (res_t)) body.FStar_Absyn_Syntax.pos)
in (bs0, _140_785))
in (FStar_Absyn_Syntax.mk_Exp_abs _140_786 (Some (tfun)) e0.FStar_Absyn_Syntax.pos))
in (encode_exp e env)))
end))
end else begin
(

let _50_1143 = (encode_binders None bs env)
in (match (_50_1143) with
| (vars, guards, envbody, decls, _50_1142) -> begin
(

let _50_1146 = (encode_exp body envbody)
in (match (_50_1146) with
| (body, decls') -> begin
(

let key_body = (let _140_790 = (let _140_789 = (let _140_788 = (let _140_787 = (FStar_ToSMT_Term.mk_and_l guards)
in (_140_787, body))
in (FStar_ToSMT_Term.mkImp _140_788))
in ([], vars, _140_789))
in (FStar_ToSMT_Term.mkForall _140_790))
in (

let cvars = (FStar_ToSMT_Term.free_variables key_body)
in (

let tkey = (FStar_ToSMT_Term.mkForall ([], cvars, key_body))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_1152, _50_1154) -> begin
(let _140_793 = (let _140_792 = (let _140_791 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (t, _140_791))
in (FStar_ToSMT_Term.mkApp _140_792))
in (_140_793, []))
end
| None -> begin
(match ((is_eta env vars body)) with
| Some (t) -> begin
(t, [])
end
| None -> begin
(

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let fsym = (varops.fresh "Exp_abs")
in (

let fdecl = FStar_ToSMT_Term.DeclFun ((fsym, cvar_sorts, FStar_ToSMT_Term.Term_sort, None))
in (

let f = (let _140_795 = (let _140_794 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in (fsym, _140_794))
in (FStar_ToSMT_Term.mkApp _140_795))
in (

let app = (mk_ApplyE f vars)
in (

let _50_1168 = (encode_typ_pred None tfun env f)
in (match (_50_1168) with
| (f_has_t, decls'') -> begin
(

let typing_f = (let _140_797 = (let _140_796 = (FStar_ToSMT_Term.mkForall (((f)::[])::[], cvars, f_has_t))
in (_140_796, Some ((Prims.strcat fsym " typing"))))
in FStar_ToSMT_Term.Assume (_140_797))
in (

let interp_f = (let _140_804 = (let _140_803 = (let _140_802 = (let _140_801 = (let _140_800 = (let _140_799 = (FStar_ToSMT_Term.mk_IsTyped app)
in (let _140_798 = (FStar_ToSMT_Term.mkEq (app, body))
in (_140_799, _140_798)))
in (FStar_ToSMT_Term.mkImp _140_800))
in (((app)::[])::[], (FStar_List.append vars cvars), _140_801))
in (FStar_ToSMT_Term.mkForall _140_802))
in (_140_803, Some ((Prims.strcat fsym " interpretation"))))
in FStar_ToSMT_Term.Assume (_140_804))
in (

let f_decls = (FStar_List.append (FStar_List.append (FStar_List.append decls decls') ((fdecl)::decls'')) ((typing_f)::(interp_f)::[]))
in (

let _50_1172 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash (fsym, cvar_sorts, f_decls))
in (f, f_decls)))))
end)))))))
end)
end))))
end))
end))
end)
end
| _50_1175 -> begin
(FStar_All.failwith "Impossible")
end))
end
end))
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (l, _50_1186); FStar_Absyn_Syntax.tk = _50_1183; FStar_Absyn_Syntax.pos = _50_1181; FStar_Absyn_Syntax.fvs = _50_1179; FStar_Absyn_Syntax.uvs = _50_1177}, ((FStar_Util.Inl (_50_1201), _50_1204))::((FStar_Util.Inr (v1), _50_1198))::((FStar_Util.Inr (v2), _50_1193))::[]) when (FStar_Ident.lid_equals l.FStar_Absyn_Syntax.v FStar_Absyn_Const.lexcons_lid) -> begin
(

let _50_1211 = (encode_exp v1 env)
in (match (_50_1211) with
| (v1, decls1) -> begin
(

let _50_1214 = (encode_exp v2 env)
in (match (_50_1214) with
| (v2, decls2) -> begin
(let _140_805 = (FStar_ToSMT_Term.mk_LexCons v1 v2)
in (_140_805, (FStar_List.append decls1 decls2)))
end))
end))
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (_50_1224); FStar_Absyn_Syntax.tk = _50_1222; FStar_Absyn_Syntax.pos = _50_1220; FStar_Absyn_Syntax.fvs = _50_1218; FStar_Absyn_Syntax.uvs = _50_1216}, _50_1228) -> begin
(let _140_806 = (whnf_e env e)
in (encode_exp _140_806 env))
end
| FStar_Absyn_Syntax.Exp_app (head, args_e) -> begin
(

let _50_1237 = (encode_args args_e env)
in (match (_50_1237) with
| (args, decls) -> begin
(

let encode_partial_app = (fun ht_opt -> (

let _50_1242 = (encode_exp head env)
in (match (_50_1242) with
| (head, decls') -> begin
(

let app_tm = (mk_ApplyE_args head args)
in (match (ht_opt) with
| None -> begin
(app_tm, (FStar_List.append decls decls'))
end
| Some (formals, c) -> begin
(

let _50_1251 = (FStar_Util.first_N (FStar_List.length args_e) formals)
in (match (_50_1251) with
| (formals, rest) -> begin
(

let subst = (FStar_Absyn_Util.formals_for_actuals formals args_e)
in (

let ty = (let _140_809 = (FStar_Absyn_Syntax.mk_Typ_fun (rest, c) (Some (FStar_Absyn_Syntax.ktype)) e0.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _140_809 (FStar_Absyn_Util.subst_typ subst)))
in (

let _50_1256 = (encode_typ_pred None ty env app_tm)
in (match (_50_1256) with
| (has_type, decls'') -> begin
(

let cvars = (FStar_ToSMT_Term.free_variables has_type)
in (

let e_typing = (let _140_811 = (let _140_810 = (FStar_ToSMT_Term.mkForall (((has_type)::[])::[], cvars, has_type))
in (_140_810, None))
in FStar_ToSMT_Term.Assume (_140_811))
in (app_tm, (FStar_List.append (FStar_List.append (FStar_List.append decls decls') decls'') ((e_typing)::[])))))
end))))
end))
end))
end)))
in (

let encode_full_app = (fun fv -> (

let _50_1263 = (lookup_free_var_sym env fv)
in (match (_50_1263) with
| (fname, fuel_args) -> begin
(

let tm = (let _140_817 = (let _140_816 = (let _140_815 = (FStar_List.map (fun _50_12 -> (match (_50_12) with
| (FStar_Util.Inl (t)) | (FStar_Util.Inr (t)) -> begin
t
end)) args)
in (FStar_List.append fuel_args _140_815))
in (fname, _140_816))
in (FStar_ToSMT_Term.mkApp' _140_817))
in (tm, decls))
end)))
in (

let head = (FStar_Absyn_Util.compress_exp head)
in (

let _50_1270 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("186"))) then begin
(let _140_819 = (FStar_Absyn_Print.exp_to_string head)
in (let _140_818 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.print2 "Recomputing type for %s\nFull term is %s\n" _140_819 _140_818)))
end else begin
()
end
in (

let head_type = (let _140_822 = (let _140_821 = (let _140_820 = (FStar_Tc_Recheck.recompute_typ head)
in (FStar_Absyn_Util.unrefine _140_820))
in (whnf env _140_821))
in (FStar_All.pipe_left FStar_Absyn_Util.unrefine _140_822))
in (

let _50_1273 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _140_825 = (FStar_Absyn_Print.exp_to_string head)
in (let _140_824 = (FStar_Absyn_Print.tag_of_exp head)
in (let _140_823 = (FStar_Absyn_Print.typ_to_string head_type)
in (FStar_Util.print3 "Recomputed type of head %s (%s) to be %s\n" _140_825 _140_824 _140_823))))
end else begin
()
end
in (match ((FStar_Absyn_Util.function_formals head_type)) with
| None -> begin
(let _140_829 = (let _140_828 = (FStar_Range.string_of_range e0.FStar_Absyn_Syntax.pos)
in (let _140_827 = (FStar_Absyn_Print.exp_to_string e0)
in (let _140_826 = (FStar_Absyn_Print.typ_to_string head_type)
in (FStar_Util.format3 "(%s) term is %s; head type is %s\n" _140_828 _140_827 _140_826))))
in (FStar_All.failwith _140_829))
end
| Some (formals, c) -> begin
(match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_fvar (fv, _50_1282) when ((FStar_List.length formals) = (FStar_List.length args)) -> begin
(encode_full_app fv)
end
| _50_1286 -> begin
if ((FStar_List.length formals) > (FStar_List.length args)) then begin
(encode_partial_app (Some ((formals, c))))
end else begin
(encode_partial_app None)
end
end)
end)))))))
end))
end
| FStar_Absyn_Syntax.Exp_let ((false, ({FStar_Absyn_Syntax.lbname = FStar_Util.Inr (_50_1295); FStar_Absyn_Syntax.lbtyp = _50_1293; FStar_Absyn_Syntax.lbeff = _50_1291; FStar_Absyn_Syntax.lbdef = _50_1289})::[]), _50_1301) -> begin
(FStar_All.failwith "Impossible: already handled by encoding of Sig_let")
end
| FStar_Absyn_Syntax.Exp_let ((false, ({FStar_Absyn_Syntax.lbname = FStar_Util.Inl (x); FStar_Absyn_Syntax.lbtyp = t1; FStar_Absyn_Syntax.lbeff = _50_1307; FStar_Absyn_Syntax.lbdef = e1})::[]), e2) -> begin
(

let _50_1319 = (encode_exp e1 env)
in (match (_50_1319) with
| (ee1, decls1) -> begin
(

let env' = (push_term_var env x ee1)
in (

let _50_1323 = (encode_exp e2 env')
in (match (_50_1323) with
| (ee2, decls2) -> begin
(ee2, (FStar_List.append decls1 decls2))
end)))
end))
end
| FStar_Absyn_Syntax.Exp_let (_50_1325) -> begin
(

let _50_1327 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "Non-top-level recursive functions are not yet fully encoded to the SMT solver; you may not be able to prove some facts")
in (

let e = (varops.fresh "let-rec")
in (

let decl_e = FStar_ToSMT_Term.DeclFun ((e, [], FStar_ToSMT_Term.Term_sort, None))
in (let _140_830 = (FStar_ToSMT_Term.mkFreeV (e, FStar_ToSMT_Term.Term_sort))
in (_140_830, (decl_e)::[])))))
end
| FStar_Absyn_Syntax.Exp_match (e, pats) -> begin
(

let _50_1337 = (encode_exp e env)
in (match (_50_1337) with
| (scr, decls) -> begin
(

let _50_1377 = (FStar_List.fold_right (fun _50_1341 _50_1344 -> (match ((_50_1341, _50_1344)) with
| ((p, w, br), (else_case, decls)) -> begin
(

let patterns = (encode_pat env p)
in (FStar_List.fold_right (fun _50_1348 _50_1351 -> (match ((_50_1348, _50_1351)) with
| ((env0, pattern), (else_case, decls)) -> begin
(

let guard = (pattern.guard scr)
in (

let projections = (pattern.projections scr)
in (

let env = (FStar_All.pipe_right projections (FStar_List.fold_left (fun env _50_1357 -> (match (_50_1357) with
| (x, t) -> begin
(match (x) with
| FStar_Util.Inl (a) -> begin
(push_typ_var env a.FStar_Absyn_Syntax.v t)
end
| FStar_Util.Inr (x) -> begin
(push_term_var env x.FStar_Absyn_Syntax.v t)
end)
end)) env))
in (

let _50_1371 = (match (w) with
| None -> begin
(guard, [])
end
| Some (w) -> begin
(

let _50_1368 = (encode_exp w env)
in (match (_50_1368) with
| (w, decls2) -> begin
(let _140_841 = (let _140_840 = (let _140_839 = (let _140_838 = (let _140_837 = (FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkTrue)
in (w, _140_837))
in (FStar_ToSMT_Term.mkEq _140_838))
in (guard, _140_839))
in (FStar_ToSMT_Term.mkAnd _140_840))
in (_140_841, decls2))
end))
end)
in (match (_50_1371) with
| (guard, decls2) -> begin
(

let _50_1374 = (encode_exp br env)
in (match (_50_1374) with
| (br, decls3) -> begin
(let _140_842 = (FStar_ToSMT_Term.mkITE (guard, br, else_case))
in (_140_842, (FStar_List.append (FStar_List.append decls decls2) decls3)))
end))
end)))))
end)) patterns (else_case, decls)))
end)) pats (FStar_ToSMT_Term.mk_Term_unit, decls))
in (match (_50_1377) with
| (match_tm, decls) -> begin
(match_tm, decls)
end))
end))
end
| FStar_Absyn_Syntax.Exp_meta (_50_1379) -> begin
(let _140_845 = (let _140_844 = (FStar_Range.string_of_range e.FStar_Absyn_Syntax.pos)
in (let _140_843 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format2 "(%s): Impossible: encode_exp got %s" _140_844 _140_843)))
in (FStar_All.failwith _140_845))
end))))
and encode_pat : env_t  ->  FStar_Absyn_Syntax.pat  ->  (env_t * pattern) Prims.list = (fun env pat -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (ps) -> begin
(FStar_List.map (encode_one_pat env) ps)
end
| _50_1386 -> begin
(let _140_848 = (encode_one_pat env pat)
in (_140_848)::[])
end))
and encode_one_pat : env_t  ->  FStar_Absyn_Syntax.pat  ->  (env_t * pattern) = (fun env pat -> (

let _50_1389 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_851 = (FStar_Absyn_Print.pat_to_string pat)
in (FStar_Util.print1 "Encoding pattern %s\n" _140_851))
end else begin
()
end
in (

let _50_1393 = (FStar_Tc_Util.decorated_pattern_as_either pat)
in (match (_50_1393) with
| (vars, pat_exp_or_typ) -> begin
(

let _50_1414 = (FStar_All.pipe_right vars (FStar_List.fold_left (fun _50_1396 v -> (match (_50_1396) with
| (env, vars) -> begin
(match (v) with
| FStar_Util.Inl (a) -> begin
(

let _50_1404 = (gen_typ_var env a.FStar_Absyn_Syntax.v)
in (match (_50_1404) with
| (aa, _50_1402, env) -> begin
(env, ((v, (aa, FStar_ToSMT_Term.Type_sort)))::vars)
end))
end
| FStar_Util.Inr (x) -> begin
(

let _50_1411 = (gen_term_var env x.FStar_Absyn_Syntax.v)
in (match (_50_1411) with
| (xx, _50_1409, env) -> begin
(env, ((v, (xx, FStar_ToSMT_Term.Term_sort)))::vars)
end))
end)
end)) (env, [])))
in (match (_50_1414) with
| (env, vars) -> begin
(

let rec mk_guard = (fun pat scrutinee -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_50_1419) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Absyn_Syntax.Pat_var (_)) | (FStar_Absyn_Syntax.Pat_wild (_)) | (FStar_Absyn_Syntax.Pat_tvar (_)) | (FStar_Absyn_Syntax.Pat_twild (_)) | (FStar_Absyn_Syntax.Pat_dot_term (_)) | (FStar_Absyn_Syntax.Pat_dot_typ (_)) -> begin
FStar_ToSMT_Term.mkTrue
end
| FStar_Absyn_Syntax.Pat_constant (c) -> begin
(let _140_859 = (let _140_858 = (encode_const c)
in (scrutinee, _140_858))
in (FStar_ToSMT_Term.mkEq _140_859))
end
| FStar_Absyn_Syntax.Pat_cons (f, _50_1443, args) -> begin
(

let is_f = (mk_data_tester env f.FStar_Absyn_Syntax.v scrutinee)
in (

let sub_term_guards = (FStar_All.pipe_right args (FStar_List.mapi (fun i _50_1452 -> (match (_50_1452) with
| (arg, _50_1451) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Absyn_Syntax.v i)
in (let _140_862 = (FStar_ToSMT_Term.mkApp (proj, (scrutinee)::[]))
in (mk_guard arg _140_862)))
end))))
in (FStar_ToSMT_Term.mk_and_l ((is_f)::sub_term_guards))))
end))
in (

let rec mk_projections = (fun pat scrutinee -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_50_1459) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Absyn_Syntax.Pat_dot_term (x, _)) | (FStar_Absyn_Syntax.Pat_var (x)) | (FStar_Absyn_Syntax.Pat_wild (x)) -> begin
((FStar_Util.Inr (x), scrutinee))::[]
end
| (FStar_Absyn_Syntax.Pat_dot_typ (a, _)) | (FStar_Absyn_Syntax.Pat_tvar (a)) | (FStar_Absyn_Syntax.Pat_twild (a)) -> begin
((FStar_Util.Inl (a), scrutinee))::[]
end
| FStar_Absyn_Syntax.Pat_constant (_50_1476) -> begin
[]
end
| FStar_Absyn_Syntax.Pat_cons (f, _50_1480, args) -> begin
(let _140_870 = (FStar_All.pipe_right args (FStar_List.mapi (fun i _50_1488 -> (match (_50_1488) with
| (arg, _50_1487) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Absyn_Syntax.v i)
in (let _140_869 = (FStar_ToSMT_Term.mkApp (proj, (scrutinee)::[]))
in (mk_projections arg _140_869)))
end))))
in (FStar_All.pipe_right _140_870 FStar_List.flatten))
end))
in (

let pat_term = (fun _50_1491 -> (match (()) with
| () -> begin
(match (pat_exp_or_typ) with
| FStar_Util.Inl (t) -> begin
(encode_typ_term t env)
end
| FStar_Util.Inr (e) -> begin
(encode_exp e env)
end)
end))
in (

let pattern = {pat_vars = vars; pat_term = pat_term; guard = (mk_guard pat); projections = (mk_projections pat)}
in (env, pattern)))))
end))
end))))
and encode_args : FStar_Absyn_Syntax.args  ->  env_t  ->  ((FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list * FStar_ToSMT_Term.decls_t) = (fun l env -> (

let _50_1521 = (FStar_All.pipe_right l (FStar_List.fold_left (fun _50_1501 x -> (match (_50_1501) with
| (tms, decls) -> begin
(match (x) with
| (FStar_Util.Inl (t), _50_1506) -> begin
(

let _50_1510 = (encode_typ_term t env)
in (match (_50_1510) with
| (t, decls') -> begin
((FStar_Util.Inl (t))::tms, (FStar_List.append decls decls'))
end))
end
| (FStar_Util.Inr (e), _50_1514) -> begin
(

let _50_1518 = (encode_exp e env)
in (match (_50_1518) with
| (t, decls') -> begin
((FStar_Util.Inr (t))::tms, (FStar_List.append decls decls'))
end))
end)
end)) ([], [])))
in (match (_50_1521) with
| (l, decls) -> begin
((FStar_List.rev l), decls)
end)))
and encode_formula : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun phi env -> (

let _50_1527 = (encode_formula_with_labels phi env)
in (match (_50_1527) with
| (t, vars, decls) -> begin
(match (vars) with
| [] -> begin
(t, decls)
end
| _50_1530 -> begin
(FStar_All.failwith "Unexpected labels in formula")
end)
end)))
and encode_function_type_as_formula : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.exp Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun induction_on new_pats t env -> (

let rec list_elements = (fun e -> (match ((let _140_885 = (FStar_Absyn_Util.unmeta_exp e)
in _140_885.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1547); FStar_Absyn_Syntax.tk = _50_1544; FStar_Absyn_Syntax.pos = _50_1542; FStar_Absyn_Syntax.fvs = _50_1540; FStar_Absyn_Syntax.uvs = _50_1538}, _50_1552) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.nil_lid) -> begin
[]
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1565); FStar_Absyn_Syntax.tk = _50_1562; FStar_Absyn_Syntax.pos = _50_1560; FStar_Absyn_Syntax.fvs = _50_1558; FStar_Absyn_Syntax.uvs = _50_1556}, (_50_1580)::((FStar_Util.Inr (hd), _50_1577))::((FStar_Util.Inr (tl), _50_1572))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.cons_lid) -> begin
(let _140_886 = (list_elements tl)
in (hd)::_140_886)
end
| _50_1585 -> begin
(

let _50_1586 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "SMT pattern is not a list literal; ignoring the pattern")
in [])
end))
in (

let v_or_t_pat = (fun p -> (match ((let _140_889 = (FStar_Absyn_Util.unmeta_exp p)
in _140_889.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1600); FStar_Absyn_Syntax.tk = _50_1597; FStar_Absyn_Syntax.pos = _50_1595; FStar_Absyn_Syntax.fvs = _50_1593; FStar_Absyn_Syntax.uvs = _50_1591}, ((FStar_Util.Inl (_50_1610), _50_1613))::((FStar_Util.Inr (e), _50_1607))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpat_lid) -> begin
(FStar_Absyn_Syntax.varg e)
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1628); FStar_Absyn_Syntax.tk = _50_1625; FStar_Absyn_Syntax.pos = _50_1623; FStar_Absyn_Syntax.fvs = _50_1621; FStar_Absyn_Syntax.uvs = _50_1619}, ((FStar_Util.Inl (t), _50_1635))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpatT_lid) -> begin
(FStar_Absyn_Syntax.targ t)
end
| _50_1641 -> begin
(FStar_All.failwith "Unexpected pattern term")
end))
in (

let lemma_pats = (fun p -> (

let elts = (list_elements p)
in (match (elts) with
| ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1663); FStar_Absyn_Syntax.tk = _50_1660; FStar_Absyn_Syntax.pos = _50_1658; FStar_Absyn_Syntax.fvs = _50_1656; FStar_Absyn_Syntax.uvs = _50_1654}, ((FStar_Util.Inr (e), _50_1670))::[]); FStar_Absyn_Syntax.tk = _50_1652; FStar_Absyn_Syntax.pos = _50_1650; FStar_Absyn_Syntax.fvs = _50_1648; FStar_Absyn_Syntax.uvs = _50_1646})::[] when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpatOr_lid) -> begin
(let _140_894 = (list_elements e)
in (FStar_All.pipe_right _140_894 (FStar_List.map (fun branch -> (let _140_893 = (list_elements branch)
in (FStar_All.pipe_right _140_893 (FStar_List.map v_or_t_pat)))))))
end
| _50_1679 -> begin
(let _140_895 = (FStar_All.pipe_right elts (FStar_List.map v_or_t_pat))
in (_140_895)::[])
end)))
in (

let _50_1722 = (match ((let _140_896 = (FStar_Absyn_Util.compress_typ t)
in _140_896.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_fun (binders, {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Comp (ct); FStar_Absyn_Syntax.tk = _50_1688; FStar_Absyn_Syntax.pos = _50_1686; FStar_Absyn_Syntax.fvs = _50_1684; FStar_Absyn_Syntax.uvs = _50_1682}) -> begin
(match (ct.FStar_Absyn_Syntax.effect_args) with
| ((FStar_Util.Inl (pre), _50_1707))::((FStar_Util.Inl (post), _50_1702))::((FStar_Util.Inr (pats), _50_1697))::[] -> begin
(

let pats' = (match (new_pats) with
| Some (new_pats') -> begin
new_pats'
end
| None -> begin
pats
end)
in (let _140_897 = (lemma_pats pats')
in (binders, pre, post, _140_897)))
end
| _50_1715 -> begin
(FStar_All.failwith "impos")
end)
end
| _50_1717 -> begin
(FStar_All.failwith "Impos")
end)
in (match (_50_1722) with
| (binders, pre, post, patterns) -> begin
(

let _50_1729 = (encode_binders None binders env)
in (match (_50_1729) with
| (vars, guards, env, decls, _50_1728) -> begin
(

let _50_1749 = (let _140_901 = (FStar_All.pipe_right patterns (FStar_List.map (fun branch -> (

let _50_1746 = (let _140_900 = (FStar_All.pipe_right branch (FStar_List.map (fun _50_13 -> (match (_50_13) with
| (FStar_Util.Inl (t), _50_1735) -> begin
(encode_formula t env)
end
| (FStar_Util.Inr (e), _50_1740) -> begin
(encode_exp e (

let _50_1742 = env
in {bindings = _50_1742.bindings; depth = _50_1742.depth; tcenv = _50_1742.tcenv; warn = _50_1742.warn; cache = _50_1742.cache; nolabels = _50_1742.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _50_1742.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _140_900 FStar_List.unzip))
in (match (_50_1746) with
| (pats, decls) -> begin
(pats, decls)
end)))))
in (FStar_All.pipe_right _140_901 FStar_List.unzip))
in (match (_50_1749) with
| (pats, decls') -> begin
(

let decls' = (FStar_List.flatten decls')
in (

let pats = (match (induction_on) with
| None -> begin
pats
end
| Some (e) -> begin
(match (vars) with
| [] -> begin
pats
end
| (l)::[] -> begin
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _140_904 = (let _140_903 = (FStar_ToSMT_Term.mkFreeV l)
in (FStar_ToSMT_Term.mk_Precedes _140_903 e))
in (_140_904)::p))))
end
| _50_1759 -> begin
(

let rec aux = (fun tl vars -> (match (vars) with
| [] -> begin
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _140_910 = (FStar_ToSMT_Term.mk_Precedes tl e)
in (_140_910)::p))))
end
| ((x, FStar_ToSMT_Term.Term_sort))::vars -> begin
(let _140_912 = (let _140_911 = (FStar_ToSMT_Term.mkFreeV (x, FStar_ToSMT_Term.Term_sort))
in (FStar_ToSMT_Term.mk_LexCons _140_911 tl))
in (aux _140_912 vars))
end
| _50_1771 -> begin
pats
end))
in (let _140_913 = (FStar_ToSMT_Term.mkFreeV ("Prims.LexTop", FStar_ToSMT_Term.Term_sort))
in (aux _140_913 vars)))
end)
end)
in (

let env = (

let _50_1773 = env
in {bindings = _50_1773.bindings; depth = _50_1773.depth; tcenv = _50_1773.tcenv; warn = _50_1773.warn; cache = _50_1773.cache; nolabels = true; use_zfuel_name = _50_1773.use_zfuel_name; encode_non_total_function_typ = _50_1773.encode_non_total_function_typ})
in (

let _50_1778 = (let _140_914 = (FStar_Absyn_Util.unmeta_typ pre)
in (encode_formula _140_914 env))
in (match (_50_1778) with
| (pre, decls'') -> begin
(

let _50_1781 = (let _140_915 = (FStar_Absyn_Util.unmeta_typ post)
in (encode_formula _140_915 env))
in (match (_50_1781) with
| (post, decls''') -> begin
(

let decls = (FStar_List.append (FStar_List.append (FStar_List.append decls (FStar_List.flatten decls')) decls'') decls''')
in (let _140_920 = (let _140_919 = (let _140_918 = (let _140_917 = (let _140_916 = (FStar_ToSMT_Term.mk_and_l ((pre)::guards))
in (_140_916, post))
in (FStar_ToSMT_Term.mkImp _140_917))
in (pats, vars, _140_918))
in (FStar_ToSMT_Term.mkForall _140_919))
in (_140_920, decls)))
end))
end)))))
end))
end))
end))))))
and encode_formula_with_labels : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * labels * FStar_ToSMT_Term.decls_t) = (fun phi env -> (

let enc = (fun f l -> (

let _50_1802 = (FStar_Util.fold_map (fun decls x -> (match ((Prims.fst x)) with
| FStar_Util.Inl (t) -> begin
(

let _50_1794 = (encode_typ_term t env)
in (match (_50_1794) with
| (t, decls') -> begin
((FStar_List.append decls decls'), t)
end))
end
| FStar_Util.Inr (e) -> begin
(

let _50_1799 = (encode_exp e env)
in (match (_50_1799) with
| (e, decls') -> begin
((FStar_List.append decls decls'), e)
end))
end)) [] l)
in (match (_50_1802) with
| (decls, args) -> begin
(let _140_938 = (f args)
in (_140_938, [], decls))
end)))
in (

let enc_prop_c = (fun f l -> (

let _50_1822 = (FStar_List.fold_right (fun t _50_1810 -> (match (_50_1810) with
| (phis, labs, decls) -> begin
(match ((Prims.fst t)) with
| FStar_Util.Inl (t) -> begin
(

let _50_1816 = (encode_formula_with_labels t env)
in (match (_50_1816) with
| (phi, labs', decls') -> begin
((phi)::phis, (FStar_List.append labs' labs), (FStar_List.append decls' decls))
end))
end
| _50_1818 -> begin
(FStar_All.failwith "Expected a formula")
end)
end)) l ([], [], []))
in (match (_50_1822) with
| (phis, labs, decls) -> begin
(let _140_954 = (f phis)
in (_140_954, labs, decls))
end)))
in (

let const_op = (fun f _50_1825 -> (f, [], []))
in (

let un_op = (fun f l -> (let _140_968 = (FStar_List.hd l)
in (FStar_All.pipe_left f _140_968)))
in (

let bin_op = (fun f _50_14 -> (match (_50_14) with
| (t1)::(t2)::[] -> begin
(f (t1, t2))
end
| _50_1836 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let eq_op = (fun _50_15 -> (match (_50_15) with
| (_50_1844)::(_50_1842)::(e1)::(e2)::[] -> begin
(enc (bin_op FStar_ToSMT_Term.mkEq) ((e1)::(e2)::[]))
end
| l -> begin
(enc (bin_op FStar_ToSMT_Term.mkEq) l)
end))
in (

let mk_imp = (fun _50_16 -> (match (_50_16) with
| ((FStar_Util.Inl (lhs), _50_1857))::((FStar_Util.Inl (rhs), _50_1852))::[] -> begin
(

let _50_1863 = (encode_formula_with_labels rhs env)
in (match (_50_1863) with
| (l1, labs1, decls1) -> begin
(match (l1.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.True, _50_1866) -> begin
(l1, labs1, decls1)
end
| _50_1870 -> begin
(

let _50_1874 = (encode_formula_with_labels lhs env)
in (match (_50_1874) with
| (l2, labs2, decls2) -> begin
(let _140_982 = (FStar_ToSMT_Term.mkImp (l2, l1))
in (_140_982, (FStar_List.append labs1 labs2), (FStar_List.append decls1 decls2)))
end))
end)
end))
end
| _50_1876 -> begin
(FStar_All.failwith "impossible")
end))
in (

let mk_ite = (fun _50_17 -> (match (_50_17) with
| ((FStar_Util.Inl (guard), _50_1892))::((FStar_Util.Inl (_then), _50_1887))::((FStar_Util.Inl (_else), _50_1882))::[] -> begin
(

let _50_1898 = (encode_formula_with_labels guard env)
in (match (_50_1898) with
| (g, labs1, decls1) -> begin
(

let _50_1902 = (encode_formula_with_labels _then env)
in (match (_50_1902) with
| (t, labs2, decls2) -> begin
(

let _50_1906 = (encode_formula_with_labels _else env)
in (match (_50_1906) with
| (e, labs3, decls3) -> begin
(

let res = (FStar_ToSMT_Term.mkITE (g, t, e))
in (res, (FStar_List.append (FStar_List.append labs1 labs2) labs3), (FStar_List.append (FStar_List.append decls1 decls2) decls3)))
end))
end))
end))
end
| _50_1909 -> begin
(FStar_All.failwith "impossible")
end))
in (

let unboxInt_l = (fun f l -> (let _140_994 = (FStar_List.map FStar_ToSMT_Term.unboxInt l)
in (f _140_994)))
in (

let connectives = (let _140_1055 = (let _140_1003 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkAnd))
in (FStar_Absyn_Const.and_lid, _140_1003))
in (let _140_1054 = (let _140_1053 = (let _140_1009 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkOr))
in (FStar_Absyn_Const.or_lid, _140_1009))
in (let _140_1052 = (let _140_1051 = (let _140_1050 = (let _140_1018 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkIff))
in (FStar_Absyn_Const.iff_lid, _140_1018))
in (let _140_1049 = (let _140_1048 = (let _140_1047 = (let _140_1027 = (FStar_All.pipe_left enc_prop_c (un_op FStar_ToSMT_Term.mkNot))
in (FStar_Absyn_Const.not_lid, _140_1027))
in (let _140_1046 = (let _140_1045 = (let _140_1033 = (FStar_All.pipe_left enc (bin_op FStar_ToSMT_Term.mkEq))
in (FStar_Absyn_Const.eqT_lid, _140_1033))
in (_140_1045)::((FStar_Absyn_Const.eq2_lid, eq_op))::((FStar_Absyn_Const.true_lid, (const_op FStar_ToSMT_Term.mkTrue)))::((FStar_Absyn_Const.false_lid, (const_op FStar_ToSMT_Term.mkFalse)))::[])
in (_140_1047)::_140_1046))
in ((FStar_Absyn_Const.ite_lid, mk_ite))::_140_1048)
in (_140_1050)::_140_1049))
in ((FStar_Absyn_Const.imp_lid, mk_imp))::_140_1051)
in (_140_1053)::_140_1052))
in (_140_1055)::_140_1054))
in (

let fallback = (fun phi -> (match (phi.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_labeled (phi', msg, r, b)) -> begin
(

let _50_1927 = (encode_formula_with_labels phi' env)
in (match (_50_1927) with
| (phi, labs, decls) -> begin
if env.nolabels then begin
(phi, [], decls)
end else begin
(

let lvar = (let _140_1058 = (varops.fresh "label")
in (_140_1058, FStar_ToSMT_Term.Bool_sort))
in (

let lterm = (FStar_ToSMT_Term.mkFreeV lvar)
in (

let lphi = (FStar_ToSMT_Term.mkOr (lterm, phi))
in (lphi, ((lvar, msg, r))::labs, decls))))
end
end))
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (ih); FStar_Absyn_Syntax.tk = _50_1938; FStar_Absyn_Syntax.pos = _50_1936; FStar_Absyn_Syntax.fvs = _50_1934; FStar_Absyn_Syntax.uvs = _50_1932}, (_50_1953)::((FStar_Util.Inr (l), _50_1950))::((FStar_Util.Inl (phi), _50_1945))::[]) when (FStar_Ident.lid_equals ih.FStar_Absyn_Syntax.v FStar_Absyn_Const.using_IH) -> begin
if (FStar_Absyn_Util.is_lemma phi) then begin
(

let _50_1959 = (encode_exp l env)
in (match (_50_1959) with
| (e, decls) -> begin
(

let _50_1962 = (encode_function_type_as_formula (Some (e)) None phi env)
in (match (_50_1962) with
| (f, decls') -> begin
(f, [], (FStar_List.append decls decls'))
end))
end))
end else begin
(FStar_ToSMT_Term.mkTrue, [], [])
end
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (ih); FStar_Absyn_Syntax.tk = _50_1970; FStar_Absyn_Syntax.pos = _50_1968; FStar_Absyn_Syntax.fvs = _50_1966; FStar_Absyn_Syntax.uvs = _50_1964}, (_50_1982)::((FStar_Util.Inl (phi), _50_1978))::tl) when (FStar_Ident.lid_equals ih.FStar_Absyn_Syntax.v FStar_Absyn_Const.using_lem) -> begin
if (FStar_Absyn_Util.is_lemma phi) then begin
(

let pat = (match (tl) with
| [] -> begin
None
end
| ((FStar_Util.Inr (pat), _50_1990))::[] -> begin
Some (pat)
end)
in (

let _50_1996 = (encode_function_type_as_formula None pat phi env)
in (match (_50_1996) with
| (f, decls) -> begin
(f, [], decls)
end)))
end else begin
(FStar_ToSMT_Term.mkTrue, [], [])
end
end
| _50_1998 -> begin
(

let _50_2001 = (encode_typ_term phi env)
in (match (_50_2001) with
| (tt, decls) -> begin
(let _140_1059 = (FStar_ToSMT_Term.mk_Valid tt)
in (_140_1059, [], decls))
end))
end))
in (

let encode_q_body = (fun env bs ps body -> (

let _50_2013 = (encode_binders None bs env)
in (match (_50_2013) with
| (vars, guards, env, decls, _50_2012) -> begin
(

let _50_2033 = (let _140_1071 = (FStar_All.pipe_right ps (FStar_List.map (fun p -> (

let _50_2030 = (let _140_1070 = (FStar_All.pipe_right p (FStar_List.map (fun _50_18 -> (match (_50_18) with
| (FStar_Util.Inl (t), _50_2019) -> begin
(encode_typ_term t env)
end
| (FStar_Util.Inr (e), _50_2024) -> begin
(encode_exp e (

let _50_2026 = env
in {bindings = _50_2026.bindings; depth = _50_2026.depth; tcenv = _50_2026.tcenv; warn = _50_2026.warn; cache = _50_2026.cache; nolabels = _50_2026.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _50_2026.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _140_1070 FStar_List.unzip))
in (match (_50_2030) with
| (p, decls) -> begin
(p, (FStar_List.flatten decls))
end)))))
in (FStar_All.pipe_right _140_1071 FStar_List.unzip))
in (match (_50_2033) with
| (pats, decls') -> begin
(

let _50_2037 = (encode_formula_with_labels body env)
in (match (_50_2037) with
| (body, labs, decls'') -> begin
(let _140_1072 = (FStar_ToSMT_Term.mk_and_l guards)
in (vars, pats, _140_1072, body, labs, (FStar_List.append (FStar_List.append decls (FStar_List.flatten decls')) decls'')))
end))
end))
end)))
in (

let _50_2038 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_1073 = (FStar_Absyn_Print.formula_to_string phi)
in (FStar_Util.print1 ">>>> Destructing as formula ... %s\n" _140_1073))
end else begin
()
end
in (

let phi = (FStar_Absyn_Util.compress_typ phi)
in (match ((FStar_Absyn_Util.destruct_typ_as_formula phi)) with
| None -> begin
(fallback phi)
end
| Some (FStar_Absyn_Util.BaseConn (op, arms)) -> begin
(match ((FStar_All.pipe_right connectives (FStar_List.tryFind (fun _50_2050 -> (match (_50_2050) with
| (l, _50_2049) -> begin
(FStar_Ident.lid_equals op l)
end))))) with
| None -> begin
(fallback phi)
end
| Some (_50_2053, f) -> begin
(f arms)
end)
end
| Some (FStar_Absyn_Util.QAll (vars, pats, body)) -> begin
(

let _50_2063 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_1090 = (FStar_All.pipe_right vars (FStar_Absyn_Print.binders_to_string "; "))
in (FStar_Util.print1 ">>>> Got QALL [%s]\n" _140_1090))
end else begin
()
end
in (

let _50_2071 = (encode_q_body env vars pats body)
in (match (_50_2071) with
| (vars, pats, guard, body, labs, decls) -> begin
(let _140_1093 = (let _140_1092 = (let _140_1091 = (FStar_ToSMT_Term.mkImp (guard, body))
in (pats, vars, _140_1091))
in (FStar_ToSMT_Term.mkForall _140_1092))
in (_140_1093, labs, decls))
end)))
end
| Some (FStar_Absyn_Util.QEx (vars, pats, body)) -> begin
(

let _50_2084 = (encode_q_body env vars pats body)
in (match (_50_2084) with
| (vars, pats, guard, body, labs, decls) -> begin
(let _140_1096 = (let _140_1095 = (let _140_1094 = (FStar_ToSMT_Term.mkAnd (guard, body))
in (pats, vars, _140_1094))
in (FStar_ToSMT_Term.mkExists _140_1095))
in (_140_1096, labs, decls))
end))
end))))))))))))))))


type prims_t =
{mk : FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.decl Prims.list; is : FStar_Ident.lident  ->  Prims.bool}


let is_Mkprims_t : prims_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkprims_t"))))


let prims : prims_t = (

let _50_2090 = (fresh_fvar "a" FStar_ToSMT_Term.Type_sort)
in (match (_50_2090) with
| (asym, a) -> begin
(

let _50_2093 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2093) with
| (xsym, x) -> begin
(

let _50_2096 = (fresh_fvar "y" FStar_ToSMT_Term.Term_sort)
in (match (_50_2096) with
| (ysym, y) -> begin
(

let deffun = (fun vars body x -> (let _140_1131 = (let _140_1130 = (let _140_1129 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in (let _140_1128 = (FStar_ToSMT_Term.abstr vars body)
in (x, _140_1129, FStar_ToSMT_Term.Term_sort, _140_1128, None)))
in FStar_ToSMT_Term.DefineFun (_140_1130))
in (_140_1131)::[]))
in (

let quant = (fun vars body x -> (

let t1 = (let _140_1143 = (let _140_1142 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (x, _140_1142))
in (FStar_ToSMT_Term.mkApp _140_1143))
in (

let vname_decl = (let _140_1145 = (let _140_1144 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in (x, _140_1144, FStar_ToSMT_Term.Term_sort, None))
in FStar_ToSMT_Term.DeclFun (_140_1145))
in (let _140_1151 = (let _140_1150 = (let _140_1149 = (let _140_1148 = (let _140_1147 = (let _140_1146 = (FStar_ToSMT_Term.mkEq (t1, body))
in (((t1)::[])::[], vars, _140_1146))
in (FStar_ToSMT_Term.mkForall _140_1147))
in (_140_1148, None))
in FStar_ToSMT_Term.Assume (_140_1149))
in (_140_1150)::[])
in (vname_decl)::_140_1151))))
in (

let def_or_quant = (fun vars body x -> if (FStar_Options.inline_arith ()) then begin
(deffun vars body x)
end else begin
(quant vars body x)
end)
in (

let axy = ((asym, FStar_ToSMT_Term.Type_sort))::((xsym, FStar_ToSMT_Term.Term_sort))::((ysym, FStar_ToSMT_Term.Term_sort))::[]
in (

let xy = ((xsym, FStar_ToSMT_Term.Term_sort))::((ysym, FStar_ToSMT_Term.Term_sort))::[]
in (

let qx = ((xsym, FStar_ToSMT_Term.Term_sort))::[]
in (

let prims = (let _140_1317 = (let _140_1166 = (let _140_1165 = (let _140_1164 = (FStar_ToSMT_Term.mkEq (x, y))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1164))
in (def_or_quant axy _140_1165))
in (FStar_Absyn_Const.op_Eq, _140_1166))
in (let _140_1316 = (let _140_1315 = (let _140_1173 = (let _140_1172 = (let _140_1171 = (let _140_1170 = (FStar_ToSMT_Term.mkEq (x, y))
in (FStar_ToSMT_Term.mkNot _140_1170))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1171))
in (def_or_quant axy _140_1172))
in (FStar_Absyn_Const.op_notEq, _140_1173))
in (let _140_1314 = (let _140_1313 = (let _140_1182 = (let _140_1181 = (let _140_1180 = (let _140_1179 = (let _140_1178 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1177 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1178, _140_1177)))
in (FStar_ToSMT_Term.mkLT _140_1179))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1180))
in (def_or_quant xy _140_1181))
in (FStar_Absyn_Const.op_LT, _140_1182))
in (let _140_1312 = (let _140_1311 = (let _140_1191 = (let _140_1190 = (let _140_1189 = (let _140_1188 = (let _140_1187 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1186 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1187, _140_1186)))
in (FStar_ToSMT_Term.mkLTE _140_1188))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1189))
in (def_or_quant xy _140_1190))
in (FStar_Absyn_Const.op_LTE, _140_1191))
in (let _140_1310 = (let _140_1309 = (let _140_1200 = (let _140_1199 = (let _140_1198 = (let _140_1197 = (let _140_1196 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1195 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1196, _140_1195)))
in (FStar_ToSMT_Term.mkGT _140_1197))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1198))
in (def_or_quant xy _140_1199))
in (FStar_Absyn_Const.op_GT, _140_1200))
in (let _140_1308 = (let _140_1307 = (let _140_1209 = (let _140_1208 = (let _140_1207 = (let _140_1206 = (let _140_1205 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1204 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1205, _140_1204)))
in (FStar_ToSMT_Term.mkGTE _140_1206))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1207))
in (def_or_quant xy _140_1208))
in (FStar_Absyn_Const.op_GTE, _140_1209))
in (let _140_1306 = (let _140_1305 = (let _140_1218 = (let _140_1217 = (let _140_1216 = (let _140_1215 = (let _140_1214 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1213 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1214, _140_1213)))
in (FStar_ToSMT_Term.mkSub _140_1215))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1216))
in (def_or_quant xy _140_1217))
in (FStar_Absyn_Const.op_Subtraction, _140_1218))
in (let _140_1304 = (let _140_1303 = (let _140_1225 = (let _140_1224 = (let _140_1223 = (let _140_1222 = (FStar_ToSMT_Term.unboxInt x)
in (FStar_ToSMT_Term.mkMinus _140_1222))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1223))
in (def_or_quant qx _140_1224))
in (FStar_Absyn_Const.op_Minus, _140_1225))
in (let _140_1302 = (let _140_1301 = (let _140_1234 = (let _140_1233 = (let _140_1232 = (let _140_1231 = (let _140_1230 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1229 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1230, _140_1229)))
in (FStar_ToSMT_Term.mkAdd _140_1231))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1232))
in (def_or_quant xy _140_1233))
in (FStar_Absyn_Const.op_Addition, _140_1234))
in (let _140_1300 = (let _140_1299 = (let _140_1243 = (let _140_1242 = (let _140_1241 = (let _140_1240 = (let _140_1239 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1238 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1239, _140_1238)))
in (FStar_ToSMT_Term.mkMul _140_1240))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1241))
in (def_or_quant xy _140_1242))
in (FStar_Absyn_Const.op_Multiply, _140_1243))
in (let _140_1298 = (let _140_1297 = (let _140_1252 = (let _140_1251 = (let _140_1250 = (let _140_1249 = (let _140_1248 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1247 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1248, _140_1247)))
in (FStar_ToSMT_Term.mkDiv _140_1249))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1250))
in (def_or_quant xy _140_1251))
in (FStar_Absyn_Const.op_Division, _140_1252))
in (let _140_1296 = (let _140_1295 = (let _140_1261 = (let _140_1260 = (let _140_1259 = (let _140_1258 = (let _140_1257 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1256 = (FStar_ToSMT_Term.unboxInt y)
in (_140_1257, _140_1256)))
in (FStar_ToSMT_Term.mkMod _140_1258))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _140_1259))
in (def_or_quant xy _140_1260))
in (FStar_Absyn_Const.op_Modulus, _140_1261))
in (let _140_1294 = (let _140_1293 = (let _140_1270 = (let _140_1269 = (let _140_1268 = (let _140_1267 = (let _140_1266 = (FStar_ToSMT_Term.unboxBool x)
in (let _140_1265 = (FStar_ToSMT_Term.unboxBool y)
in (_140_1266, _140_1265)))
in (FStar_ToSMT_Term.mkAnd _140_1267))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1268))
in (def_or_quant xy _140_1269))
in (FStar_Absyn_Const.op_And, _140_1270))
in (let _140_1292 = (let _140_1291 = (let _140_1279 = (let _140_1278 = (let _140_1277 = (let _140_1276 = (let _140_1275 = (FStar_ToSMT_Term.unboxBool x)
in (let _140_1274 = (FStar_ToSMT_Term.unboxBool y)
in (_140_1275, _140_1274)))
in (FStar_ToSMT_Term.mkOr _140_1276))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1277))
in (def_or_quant xy _140_1278))
in (FStar_Absyn_Const.op_Or, _140_1279))
in (let _140_1290 = (let _140_1289 = (let _140_1286 = (let _140_1285 = (let _140_1284 = (let _140_1283 = (FStar_ToSMT_Term.unboxBool x)
in (FStar_ToSMT_Term.mkNot _140_1283))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_1284))
in (def_or_quant qx _140_1285))
in (FStar_Absyn_Const.op_Negation, _140_1286))
in (_140_1289)::[])
in (_140_1291)::_140_1290))
in (_140_1293)::_140_1292))
in (_140_1295)::_140_1294))
in (_140_1297)::_140_1296))
in (_140_1299)::_140_1298))
in (_140_1301)::_140_1300))
in (_140_1303)::_140_1302))
in (_140_1305)::_140_1304))
in (_140_1307)::_140_1306))
in (_140_1309)::_140_1308))
in (_140_1311)::_140_1310))
in (_140_1313)::_140_1312))
in (_140_1315)::_140_1314))
in (_140_1317)::_140_1316))
in (

let mk = (fun l v -> (let _140_1349 = (FStar_All.pipe_right prims (FStar_List.filter (fun _50_2120 -> (match (_50_2120) with
| (l', _50_2119) -> begin
(FStar_Ident.lid_equals l l')
end))))
in (FStar_All.pipe_right _140_1349 (FStar_List.collect (fun _50_2124 -> (match (_50_2124) with
| (_50_2122, b) -> begin
(b v)
end))))))
in (

let is = (fun l -> (FStar_All.pipe_right prims (FStar_Util.for_some (fun _50_2130 -> (match (_50_2130) with
| (l', _50_2129) -> begin
(FStar_Ident.lid_equals l l')
end)))))
in {mk = mk; is = is})))))))))
end))
end))
end))


let primitive_type_axioms : FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.decl Prims.list = (

let xx = ("x", FStar_ToSMT_Term.Term_sort)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let yy = ("y", FStar_ToSMT_Term.Term_sort)
in (

let y = (FStar_ToSMT_Term.mkFreeV yy)
in (

let mk_unit = (fun _50_2136 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (let _140_1381 = (let _140_1372 = (let _140_1371 = (FStar_ToSMT_Term.mk_HasType FStar_ToSMT_Term.mk_Term_unit tt)
in (_140_1371, Some ("unit typing")))
in FStar_ToSMT_Term.Assume (_140_1372))
in (let _140_1380 = (let _140_1379 = (let _140_1378 = (let _140_1377 = (let _140_1376 = (let _140_1375 = (let _140_1374 = (let _140_1373 = (FStar_ToSMT_Term.mkEq (x, FStar_ToSMT_Term.mk_Term_unit))
in (typing_pred, _140_1373))
in (FStar_ToSMT_Term.mkImp _140_1374))
in (((typing_pred)::[])::[], (xx)::[], _140_1375))
in (mkForall_fuel _140_1376))
in (_140_1377, Some ("unit inversion")))
in FStar_ToSMT_Term.Assume (_140_1378))
in (_140_1379)::[])
in (_140_1381)::_140_1380))))
in (

let mk_bool = (fun _50_2141 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let bb = ("b", FStar_ToSMT_Term.Bool_sort)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (let _140_1402 = (let _140_1391 = (let _140_1390 = (let _140_1389 = (let _140_1388 = (let _140_1387 = (let _140_1386 = (FStar_ToSMT_Term.mk_tester "BoxBool" x)
in (typing_pred, _140_1386))
in (FStar_ToSMT_Term.mkImp _140_1387))
in (((typing_pred)::[])::[], (xx)::[], _140_1388))
in (mkForall_fuel _140_1389))
in (_140_1390, Some ("bool inversion")))
in FStar_ToSMT_Term.Assume (_140_1391))
in (let _140_1401 = (let _140_1400 = (let _140_1399 = (let _140_1398 = (let _140_1397 = (let _140_1396 = (let _140_1393 = (let _140_1392 = (FStar_ToSMT_Term.boxBool b)
in (_140_1392)::[])
in (_140_1393)::[])
in (let _140_1395 = (let _140_1394 = (FStar_ToSMT_Term.boxBool b)
in (FStar_ToSMT_Term.mk_HasType _140_1394 tt))
in (_140_1396, (bb)::[], _140_1395)))
in (FStar_ToSMT_Term.mkForall _140_1397))
in (_140_1398, Some ("bool typing")))
in FStar_ToSMT_Term.Assume (_140_1399))
in (_140_1400)::[])
in (_140_1402)::_140_1401))))))
in (

let mk_int = (fun _50_2148 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let typing_pred_y = (FStar_ToSMT_Term.mk_HasType y tt)
in (

let aa = ("a", FStar_ToSMT_Term.Int_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let bb = ("b", FStar_ToSMT_Term.Int_sort)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let precedes = (let _140_1414 = (let _140_1413 = (let _140_1412 = (let _140_1411 = (let _140_1410 = (let _140_1409 = (FStar_ToSMT_Term.boxInt a)
in (let _140_1408 = (let _140_1407 = (FStar_ToSMT_Term.boxInt b)
in (_140_1407)::[])
in (_140_1409)::_140_1408))
in (tt)::_140_1410)
in (tt)::_140_1411)
in ("Prims.Precedes", _140_1412))
in (FStar_ToSMT_Term.mkApp _140_1413))
in (FStar_All.pipe_left FStar_ToSMT_Term.mk_Valid _140_1414))
in (

let precedes_y_x = (let _140_1415 = (FStar_ToSMT_Term.mkApp ("Precedes", (y)::(x)::[]))
in (FStar_All.pipe_left FStar_ToSMT_Term.mk_Valid _140_1415))
in (let _140_1457 = (let _140_1421 = (let _140_1420 = (let _140_1419 = (let _140_1418 = (let _140_1417 = (let _140_1416 = (FStar_ToSMT_Term.mk_tester "BoxInt" x)
in (typing_pred, _140_1416))
in (FStar_ToSMT_Term.mkImp _140_1417))
in (((typing_pred)::[])::[], (xx)::[], _140_1418))
in (mkForall_fuel _140_1419))
in (_140_1420, Some ("int inversion")))
in FStar_ToSMT_Term.Assume (_140_1421))
in (let _140_1456 = (let _140_1455 = (let _140_1429 = (let _140_1428 = (let _140_1427 = (let _140_1426 = (let _140_1423 = (let _140_1422 = (FStar_ToSMT_Term.boxInt b)
in (_140_1422)::[])
in (_140_1423)::[])
in (let _140_1425 = (let _140_1424 = (FStar_ToSMT_Term.boxInt b)
in (FStar_ToSMT_Term.mk_HasType _140_1424 tt))
in (_140_1426, (bb)::[], _140_1425)))
in (FStar_ToSMT_Term.mkForall _140_1427))
in (_140_1428, Some ("int typing")))
in FStar_ToSMT_Term.Assume (_140_1429))
in (let _140_1454 = (let _140_1453 = (let _140_1452 = (let _140_1451 = (let _140_1450 = (let _140_1449 = (let _140_1448 = (let _140_1447 = (let _140_1446 = (let _140_1445 = (let _140_1444 = (let _140_1443 = (let _140_1432 = (let _140_1431 = (FStar_ToSMT_Term.unboxInt x)
in (let _140_1430 = (FStar_ToSMT_Term.mkInteger' 0)
in (_140_1431, _140_1430)))
in (FStar_ToSMT_Term.mkGT _140_1432))
in (let _140_1442 = (let _140_1441 = (let _140_1435 = (let _140_1434 = (FStar_ToSMT_Term.unboxInt y)
in (let _140_1433 = (FStar_ToSMT_Term.mkInteger' 0)
in (_140_1434, _140_1433)))
in (FStar_ToSMT_Term.mkGTE _140_1435))
in (let _140_1440 = (let _140_1439 = (let _140_1438 = (let _140_1437 = (FStar_ToSMT_Term.unboxInt y)
in (let _140_1436 = (FStar_ToSMT_Term.unboxInt x)
in (_140_1437, _140_1436)))
in (FStar_ToSMT_Term.mkLT _140_1438))
in (_140_1439)::[])
in (_140_1441)::_140_1440))
in (_140_1443)::_140_1442))
in (typing_pred_y)::_140_1444)
in (typing_pred)::_140_1445)
in (FStar_ToSMT_Term.mk_and_l _140_1446))
in (_140_1447, precedes_y_x))
in (FStar_ToSMT_Term.mkImp _140_1448))
in (((typing_pred)::(typing_pred_y)::(precedes_y_x)::[])::[], (xx)::(yy)::[], _140_1449))
in (mkForall_fuel _140_1450))
in (_140_1451, Some ("well-founded ordering on nat (alt)")))
in FStar_ToSMT_Term.Assume (_140_1452))
in (_140_1453)::[])
in (_140_1455)::_140_1454))
in (_140_1457)::_140_1456)))))))))))
in (

let mk_int_alias = (fun _50_2160 tt -> (let _140_1466 = (let _140_1465 = (let _140_1464 = (let _140_1463 = (let _140_1462 = (FStar_ToSMT_Term.mkApp (FStar_Absyn_Const.int_lid.FStar_Ident.str, []))
in (tt, _140_1462))
in (FStar_ToSMT_Term.mkEq _140_1463))
in (_140_1464, Some ("mapping to int; for now")))
in FStar_ToSMT_Term.Assume (_140_1465))
in (_140_1466)::[]))
in (

let mk_str = (fun _50_2164 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let bb = ("b", FStar_ToSMT_Term.String_sort)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (let _140_1487 = (let _140_1476 = (let _140_1475 = (let _140_1474 = (let _140_1473 = (let _140_1472 = (let _140_1471 = (FStar_ToSMT_Term.mk_tester "BoxString" x)
in (typing_pred, _140_1471))
in (FStar_ToSMT_Term.mkImp _140_1472))
in (((typing_pred)::[])::[], (xx)::[], _140_1473))
in (mkForall_fuel _140_1474))
in (_140_1475, Some ("string inversion")))
in FStar_ToSMT_Term.Assume (_140_1476))
in (let _140_1486 = (let _140_1485 = (let _140_1484 = (let _140_1483 = (let _140_1482 = (let _140_1481 = (let _140_1478 = (let _140_1477 = (FStar_ToSMT_Term.boxString b)
in (_140_1477)::[])
in (_140_1478)::[])
in (let _140_1480 = (let _140_1479 = (FStar_ToSMT_Term.boxString b)
in (FStar_ToSMT_Term.mk_HasType _140_1479 tt))
in (_140_1481, (bb)::[], _140_1480)))
in (FStar_ToSMT_Term.mkForall _140_1482))
in (_140_1483, Some ("string typing")))
in FStar_ToSMT_Term.Assume (_140_1484))
in (_140_1485)::[])
in (_140_1487)::_140_1486))))))
in (

let mk_ref = (fun reft_name _50_2172 -> (

let r = ("r", FStar_ToSMT_Term.Ref_sort)
in (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let refa = (let _140_1494 = (let _140_1493 = (let _140_1492 = (FStar_ToSMT_Term.mkFreeV aa)
in (_140_1492)::[])
in (reft_name, _140_1493))
in (FStar_ToSMT_Term.mkApp _140_1494))
in (

let refb = (let _140_1497 = (let _140_1496 = (let _140_1495 = (FStar_ToSMT_Term.mkFreeV bb)
in (_140_1495)::[])
in (reft_name, _140_1496))
in (FStar_ToSMT_Term.mkApp _140_1497))
in (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x refa)
in (

let typing_pred_b = (FStar_ToSMT_Term.mk_HasType x refb)
in (let _140_1516 = (let _140_1503 = (let _140_1502 = (let _140_1501 = (let _140_1500 = (let _140_1499 = (let _140_1498 = (FStar_ToSMT_Term.mk_tester "BoxRef" x)
in (typing_pred, _140_1498))
in (FStar_ToSMT_Term.mkImp _140_1499))
in (((typing_pred)::[])::[], (xx)::(aa)::[], _140_1500))
in (mkForall_fuel _140_1501))
in (_140_1502, Some ("ref inversion")))
in FStar_ToSMT_Term.Assume (_140_1503))
in (let _140_1515 = (let _140_1514 = (let _140_1513 = (let _140_1512 = (let _140_1511 = (let _140_1510 = (let _140_1509 = (let _140_1508 = (FStar_ToSMT_Term.mkAnd (typing_pred, typing_pred_b))
in (let _140_1507 = (let _140_1506 = (let _140_1505 = (FStar_ToSMT_Term.mkFreeV aa)
in (let _140_1504 = (FStar_ToSMT_Term.mkFreeV bb)
in (_140_1505, _140_1504)))
in (FStar_ToSMT_Term.mkEq _140_1506))
in (_140_1508, _140_1507)))
in (FStar_ToSMT_Term.mkImp _140_1509))
in (((typing_pred)::(typing_pred_b)::[])::[], (xx)::(aa)::(bb)::[], _140_1510))
in (mkForall_fuel' 2 _140_1511))
in (_140_1512, Some ("ref typing is injective")))
in FStar_ToSMT_Term.Assume (_140_1513))
in (_140_1514)::[])
in (_140_1516)::_140_1515))))))))))
in (

let mk_false_interp = (fun _50_2182 false_tm -> (

let valid = (FStar_ToSMT_Term.mkApp ("Valid", (false_tm)::[]))
in (let _140_1523 = (let _140_1522 = (let _140_1521 = (FStar_ToSMT_Term.mkIff (FStar_ToSMT_Term.mkFalse, valid))
in (_140_1521, Some ("False interpretation")))
in FStar_ToSMT_Term.Assume (_140_1522))
in (_140_1523)::[])))
in (

let mk_and_interp = (fun conj _50_2188 -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1530 = (let _140_1529 = (let _140_1528 = (FStar_ToSMT_Term.mkApp (conj, (a)::(b)::[]))
in (_140_1528)::[])
in ("Valid", _140_1529))
in (FStar_ToSMT_Term.mkApp _140_1530))
in (

let valid_a = (FStar_ToSMT_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_ToSMT_Term.mkApp ("Valid", (b)::[]))
in (let _140_1537 = (let _140_1536 = (let _140_1535 = (let _140_1534 = (let _140_1533 = (let _140_1532 = (let _140_1531 = (FStar_ToSMT_Term.mkAnd (valid_a, valid_b))
in (_140_1531, valid))
in (FStar_ToSMT_Term.mkIff _140_1532))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1533))
in (FStar_ToSMT_Term.mkForall _140_1534))
in (_140_1535, Some ("/\\ interpretation")))
in FStar_ToSMT_Term.Assume (_140_1536))
in (_140_1537)::[])))))))))
in (

let mk_or_interp = (fun disj _50_2199 -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1544 = (let _140_1543 = (let _140_1542 = (FStar_ToSMT_Term.mkApp (disj, (a)::(b)::[]))
in (_140_1542)::[])
in ("Valid", _140_1543))
in (FStar_ToSMT_Term.mkApp _140_1544))
in (

let valid_a = (FStar_ToSMT_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_ToSMT_Term.mkApp ("Valid", (b)::[]))
in (let _140_1551 = (let _140_1550 = (let _140_1549 = (let _140_1548 = (let _140_1547 = (let _140_1546 = (let _140_1545 = (FStar_ToSMT_Term.mkOr (valid_a, valid_b))
in (_140_1545, valid))
in (FStar_ToSMT_Term.mkIff _140_1546))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1547))
in (FStar_ToSMT_Term.mkForall _140_1548))
in (_140_1549, Some ("\\/ interpretation")))
in FStar_ToSMT_Term.Assume (_140_1550))
in (_140_1551)::[])))))))))
in (

let mk_eq2_interp = (fun eq2 tt -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let xx = ("x", FStar_ToSMT_Term.Term_sort)
in (

let yy = ("y", FStar_ToSMT_Term.Term_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let y = (FStar_ToSMT_Term.mkFreeV yy)
in (

let valid = (let _140_1558 = (let _140_1557 = (let _140_1556 = (FStar_ToSMT_Term.mkApp (eq2, (a)::(b)::(x)::(y)::[]))
in (_140_1556)::[])
in ("Valid", _140_1557))
in (FStar_ToSMT_Term.mkApp _140_1558))
in (let _140_1565 = (let _140_1564 = (let _140_1563 = (let _140_1562 = (let _140_1561 = (let _140_1560 = (let _140_1559 = (FStar_ToSMT_Term.mkEq (x, y))
in (_140_1559, valid))
in (FStar_ToSMT_Term.mkIff _140_1560))
in (((valid)::[])::[], (aa)::(bb)::(xx)::(yy)::[], _140_1561))
in (FStar_ToSMT_Term.mkForall _140_1562))
in (_140_1563, Some ("Eq2 interpretation")))
in FStar_ToSMT_Term.Assume (_140_1564))
in (_140_1565)::[])))))))))))
in (

let mk_imp_interp = (fun imp tt -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1572 = (let _140_1571 = (let _140_1570 = (FStar_ToSMT_Term.mkApp (imp, (a)::(b)::[]))
in (_140_1570)::[])
in ("Valid", _140_1571))
in (FStar_ToSMT_Term.mkApp _140_1572))
in (

let valid_a = (FStar_ToSMT_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_ToSMT_Term.mkApp ("Valid", (b)::[]))
in (let _140_1579 = (let _140_1578 = (let _140_1577 = (let _140_1576 = (let _140_1575 = (let _140_1574 = (let _140_1573 = (FStar_ToSMT_Term.mkImp (valid_a, valid_b))
in (_140_1573, valid))
in (FStar_ToSMT_Term.mkIff _140_1574))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1575))
in (FStar_ToSMT_Term.mkForall _140_1576))
in (_140_1577, Some ("==> interpretation")))
in FStar_ToSMT_Term.Assume (_140_1578))
in (_140_1579)::[])))))))))
in (

let mk_iff_interp = (fun iff tt -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1586 = (let _140_1585 = (let _140_1584 = (FStar_ToSMT_Term.mkApp (iff, (a)::(b)::[]))
in (_140_1584)::[])
in ("Valid", _140_1585))
in (FStar_ToSMT_Term.mkApp _140_1586))
in (

let valid_a = (FStar_ToSMT_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_ToSMT_Term.mkApp ("Valid", (b)::[]))
in (let _140_1593 = (let _140_1592 = (let _140_1591 = (let _140_1590 = (let _140_1589 = (let _140_1588 = (let _140_1587 = (FStar_ToSMT_Term.mkIff (valid_a, valid_b))
in (_140_1587, valid))
in (FStar_ToSMT_Term.mkIff _140_1588))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1589))
in (FStar_ToSMT_Term.mkForall _140_1590))
in (_140_1591, Some ("<==> interpretation")))
in FStar_ToSMT_Term.Assume (_140_1592))
in (_140_1593)::[])))))))))
in (

let mk_forall_interp = (fun for_all tt -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let xx = ("x", FStar_ToSMT_Term.Term_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid = (let _140_1600 = (let _140_1599 = (let _140_1598 = (FStar_ToSMT_Term.mkApp (for_all, (a)::(b)::[]))
in (_140_1598)::[])
in ("Valid", _140_1599))
in (FStar_ToSMT_Term.mkApp _140_1600))
in (

let valid_b_x = (let _140_1603 = (let _140_1602 = (let _140_1601 = (FStar_ToSMT_Term.mk_ApplyTE b x)
in (_140_1601)::[])
in ("Valid", _140_1602))
in (FStar_ToSMT_Term.mkApp _140_1603))
in (let _140_1617 = (let _140_1616 = (let _140_1615 = (let _140_1614 = (let _140_1613 = (let _140_1612 = (let _140_1611 = (let _140_1610 = (let _140_1609 = (let _140_1605 = (let _140_1604 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_140_1604)::[])
in (_140_1605)::[])
in (let _140_1608 = (let _140_1607 = (let _140_1606 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_140_1606, valid_b_x))
in (FStar_ToSMT_Term.mkImp _140_1607))
in (_140_1609, (xx)::[], _140_1608)))
in (FStar_ToSMT_Term.mkForall _140_1610))
in (_140_1611, valid))
in (FStar_ToSMT_Term.mkIff _140_1612))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1613))
in (FStar_ToSMT_Term.mkForall _140_1614))
in (_140_1615, Some ("forall interpretation")))
in FStar_ToSMT_Term.Assume (_140_1616))
in (_140_1617)::[]))))))))))
in (

let mk_exists_interp = (fun for_all tt -> (

let aa = ("a", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("b", FStar_ToSMT_Term.Type_sort)
in (

let xx = ("x", FStar_ToSMT_Term.Term_sort)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid = (let _140_1624 = (let _140_1623 = (let _140_1622 = (FStar_ToSMT_Term.mkApp (for_all, (a)::(b)::[]))
in (_140_1622)::[])
in ("Valid", _140_1623))
in (FStar_ToSMT_Term.mkApp _140_1624))
in (

let valid_b_x = (let _140_1627 = (let _140_1626 = (let _140_1625 = (FStar_ToSMT_Term.mk_ApplyTE b x)
in (_140_1625)::[])
in ("Valid", _140_1626))
in (FStar_ToSMT_Term.mkApp _140_1627))
in (let _140_1641 = (let _140_1640 = (let _140_1639 = (let _140_1638 = (let _140_1637 = (let _140_1636 = (let _140_1635 = (let _140_1634 = (let _140_1633 = (let _140_1629 = (let _140_1628 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_140_1628)::[])
in (_140_1629)::[])
in (let _140_1632 = (let _140_1631 = (let _140_1630 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_140_1630, valid_b_x))
in (FStar_ToSMT_Term.mkImp _140_1631))
in (_140_1633, (xx)::[], _140_1632)))
in (FStar_ToSMT_Term.mkExists _140_1634))
in (_140_1635, valid))
in (FStar_ToSMT_Term.mkIff _140_1636))
in (((valid)::[])::[], (aa)::(bb)::[], _140_1637))
in (FStar_ToSMT_Term.mkForall _140_1638))
in (_140_1639, Some ("exists interpretation")))
in FStar_ToSMT_Term.Assume (_140_1640))
in (_140_1641)::[]))))))))))
in (

let mk_foralltyp_interp = (fun for_all tt -> (

let kk = ("k", FStar_ToSMT_Term.Kind_sort)
in (

let aa = ("aa", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("bb", FStar_ToSMT_Term.Term_sort)
in (

let k = (FStar_ToSMT_Term.mkFreeV kk)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1648 = (let _140_1647 = (let _140_1646 = (FStar_ToSMT_Term.mkApp (for_all, (k)::(a)::[]))
in (_140_1646)::[])
in ("Valid", _140_1647))
in (FStar_ToSMT_Term.mkApp _140_1648))
in (

let valid_a_b = (let _140_1651 = (let _140_1650 = (let _140_1649 = (FStar_ToSMT_Term.mk_ApplyTE a b)
in (_140_1649)::[])
in ("Valid", _140_1650))
in (FStar_ToSMT_Term.mkApp _140_1651))
in (let _140_1665 = (let _140_1664 = (let _140_1663 = (let _140_1662 = (let _140_1661 = (let _140_1660 = (let _140_1659 = (let _140_1658 = (let _140_1657 = (let _140_1653 = (let _140_1652 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_140_1652)::[])
in (_140_1653)::[])
in (let _140_1656 = (let _140_1655 = (let _140_1654 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_140_1654, valid_a_b))
in (FStar_ToSMT_Term.mkImp _140_1655))
in (_140_1657, (bb)::[], _140_1656)))
in (FStar_ToSMT_Term.mkForall _140_1658))
in (_140_1659, valid))
in (FStar_ToSMT_Term.mkIff _140_1660))
in (((valid)::[])::[], (kk)::(aa)::[], _140_1661))
in (FStar_ToSMT_Term.mkForall _140_1662))
in (_140_1663, Some ("ForallTyp interpretation")))
in FStar_ToSMT_Term.Assume (_140_1664))
in (_140_1665)::[]))))))))))
in (

let mk_existstyp_interp = (fun for_some tt -> (

let kk = ("k", FStar_ToSMT_Term.Kind_sort)
in (

let aa = ("aa", FStar_ToSMT_Term.Type_sort)
in (

let bb = ("bb", FStar_ToSMT_Term.Term_sort)
in (

let k = (FStar_ToSMT_Term.mkFreeV kk)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _140_1672 = (let _140_1671 = (let _140_1670 = (FStar_ToSMT_Term.mkApp (for_some, (k)::(a)::[]))
in (_140_1670)::[])
in ("Valid", _140_1671))
in (FStar_ToSMT_Term.mkApp _140_1672))
in (

let valid_a_b = (let _140_1675 = (let _140_1674 = (let _140_1673 = (FStar_ToSMT_Term.mk_ApplyTE a b)
in (_140_1673)::[])
in ("Valid", _140_1674))
in (FStar_ToSMT_Term.mkApp _140_1675))
in (let _140_1689 = (let _140_1688 = (let _140_1687 = (let _140_1686 = (let _140_1685 = (let _140_1684 = (let _140_1683 = (let _140_1682 = (let _140_1681 = (let _140_1677 = (let _140_1676 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_140_1676)::[])
in (_140_1677)::[])
in (let _140_1680 = (let _140_1679 = (let _140_1678 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_140_1678, valid_a_b))
in (FStar_ToSMT_Term.mkImp _140_1679))
in (_140_1681, (bb)::[], _140_1680)))
in (FStar_ToSMT_Term.mkExists _140_1682))
in (_140_1683, valid))
in (FStar_ToSMT_Term.mkIff _140_1684))
in (((valid)::[])::[], (kk)::(aa)::[], _140_1685))
in (FStar_ToSMT_Term.mkForall _140_1686))
in (_140_1687, Some ("ExistsTyp interpretation")))
in FStar_ToSMT_Term.Assume (_140_1688))
in (_140_1689)::[]))))))))))
in (

let prims = ((FStar_Absyn_Const.unit_lid, mk_unit))::((FStar_Absyn_Const.bool_lid, mk_bool))::((FStar_Absyn_Const.int_lid, mk_int))::((FStar_Absyn_Const.string_lid, mk_str))::((FStar_Absyn_Const.ref_lid, mk_ref))::((FStar_Absyn_Const.false_lid, mk_false_interp))::((FStar_Absyn_Const.and_lid, mk_and_interp))::((FStar_Absyn_Const.or_lid, mk_or_interp))::((FStar_Absyn_Const.eq2_lid, mk_eq2_interp))::((FStar_Absyn_Const.imp_lid, mk_imp_interp))::((FStar_Absyn_Const.iff_lid, mk_iff_interp))::((FStar_Absyn_Const.forall_lid, mk_forall_interp))::((FStar_Absyn_Const.exists_lid, mk_exists_interp))::[]
in (fun t s tt -> (match ((FStar_Util.find_opt (fun _50_2292 -> (match (_50_2292) with
| (l, _50_2291) -> begin
(FStar_Ident.lid_equals l t)
end)) prims)) with
| None -> begin
[]
end
| Some (_50_2295, f) -> begin
(f s tt)
end)))))))))))))))))))))))


let rec encode_sigelt : env_t  ->  FStar_Absyn_Syntax.sigelt  ->  (FStar_ToSMT_Term.decls_t * env_t) = (fun env se -> (

let _50_2301 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _140_1820 = (FStar_Absyn_Print.sigelt_to_string se)
in (FStar_All.pipe_left (FStar_Util.print1 ">>>>Encoding [%s]\n") _140_1820))
end else begin
()
end
in (

let nm = (match ((FStar_Absyn_Util.lid_of_sigelt se)) with
| None -> begin
""
end
| Some (l) -> begin
l.FStar_Ident.str
end)
in (

let _50_2309 = (encode_sigelt' env se)
in (match (_50_2309) with
| (g, e) -> begin
(match (g) with
| [] -> begin
(let _140_1823 = (let _140_1822 = (let _140_1821 = (FStar_Util.format1 "<Skipped %s/>" nm)
in FStar_ToSMT_Term.Caption (_140_1821))
in (_140_1822)::[])
in (_140_1823, e))
end
| _50_2312 -> begin
(let _140_1830 = (let _140_1829 = (let _140_1825 = (let _140_1824 = (FStar_Util.format1 "<Start encoding %s>" nm)
in FStar_ToSMT_Term.Caption (_140_1824))
in (_140_1825)::g)
in (let _140_1828 = (let _140_1827 = (let _140_1826 = (FStar_Util.format1 "</end encoding %s>" nm)
in FStar_ToSMT_Term.Caption (_140_1826))
in (_140_1827)::[])
in (FStar_List.append _140_1829 _140_1828)))
in (_140_1830, e))
end)
end)))))
and encode_sigelt' : env_t  ->  FStar_Absyn_Syntax.sigelt  ->  (FStar_ToSMT_Term.decls_t * env_t) = (fun env se -> (

let should_skip = (fun l -> ((((FStar_Util.starts_with l.FStar_Ident.str "Prims.pure_") || (FStar_Util.starts_with l.FStar_Ident.str "Prims.ex_")) || (FStar_Util.starts_with l.FStar_Ident.str "Prims.st_")) || (FStar_Util.starts_with l.FStar_Ident.str "Prims.all_")))
in (

let encode_top_level_val = (fun env lid t quals -> (

let tt = (whnf env t)
in (

let _50_2325 = (encode_free_var env lid t tt quals)
in (match (_50_2325) with
| (decls, env) -> begin
if (FStar_Absyn_Util.is_smt_lemma t) then begin
(let _140_1844 = (let _140_1843 = (encode_smt_lemma env lid t)
in (FStar_List.append decls _140_1843))
in (_140_1844, env))
end else begin
(decls, env)
end
end))))
in (

let encode_top_level_vals = (fun env bindings quals -> (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _50_2332 lb -> (match (_50_2332) with
| (decls, env) -> begin
(

let _50_2336 = (let _140_1853 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in (encode_top_level_val env _140_1853 lb.FStar_Absyn_Syntax.lbtyp quals))
in (match (_50_2336) with
| (decls', env) -> begin
((FStar_List.append decls decls'), env)
end))
end)) ([], env))))
in (match (se) with
| FStar_Absyn_Syntax.Sig_typ_abbrev (_50_2338, _50_2340, _50_2342, _50_2344, (FStar_Absyn_Syntax.Effect)::[], _50_2348) -> begin
([], env)
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, _50_2353, _50_2355, _50_2357, _50_2359, _50_2361) when (should_skip lid) -> begin
([], env)
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, _50_2366, _50_2368, _50_2370, _50_2372, _50_2374) when (FStar_Ident.lid_equals lid FStar_Absyn_Const.b2t_lid) -> begin
(

let _50_2380 = (new_typ_constant_and_tok_from_lid env lid)
in (match (_50_2380) with
| (tname, ttok, env) -> begin
(

let xx = ("x", FStar_ToSMT_Term.Term_sort)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid_b2t_x = (let _140_1856 = (let _140_1855 = (let _140_1854 = (FStar_ToSMT_Term.mkApp ("Prims.b2t", (x)::[]))
in (_140_1854)::[])
in ("Valid", _140_1855))
in (FStar_ToSMT_Term.mkApp _140_1856))
in (

let decls = (let _140_1864 = (let _140_1863 = (let _140_1862 = (let _140_1861 = (let _140_1860 = (let _140_1859 = (let _140_1858 = (let _140_1857 = (FStar_ToSMT_Term.mkApp ("BoxBool_proj_0", (x)::[]))
in (valid_b2t_x, _140_1857))
in (FStar_ToSMT_Term.mkEq _140_1858))
in (((valid_b2t_x)::[])::[], (xx)::[], _140_1859))
in (FStar_ToSMT_Term.mkForall _140_1860))
in (_140_1861, Some ("b2t def")))
in FStar_ToSMT_Term.Assume (_140_1862))
in (_140_1863)::[])
in (FStar_ToSMT_Term.DeclFun ((tname, (FStar_ToSMT_Term.Term_sort)::[], FStar_ToSMT_Term.Type_sort, None)))::_140_1864)
in (decls, env)))))
end))
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, tps, _50_2388, t, tags, _50_2392) -> begin
(

let _50_2398 = (new_typ_constant_and_tok_from_lid env lid)
in (match (_50_2398) with
| (tname, ttok, env) -> begin
(

let _50_2407 = (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_lam (tps', body) -> begin
((FStar_List.append tps tps'), body)
end
| _50_2404 -> begin
(tps, t)
end)
in (match (_50_2407) with
| (tps, t) -> begin
(

let _50_2414 = (encode_binders None tps env)
in (match (_50_2414) with
| (vars, guards, env', binder_decls, _50_2413) -> begin
(

let tok_app = (let _140_1865 = (FStar_ToSMT_Term.mkApp (ttok, []))
in (mk_ApplyT _140_1865 vars))
in (

let tok_decl = FStar_ToSMT_Term.DeclFun ((ttok, [], FStar_ToSMT_Term.Type_sort, None))
in (

let app = (let _140_1867 = (let _140_1866 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (tname, _140_1866))
in (FStar_ToSMT_Term.mkApp _140_1867))
in (

let fresh_tok = (match (vars) with
| [] -> begin
[]
end
| _50_2420 -> begin
(let _140_1869 = (let _140_1868 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token (ttok, FStar_ToSMT_Term.Type_sort) _140_1868))
in (_140_1869)::[])
end)
in (

let decls = (let _140_1880 = (let _140_1873 = (let _140_1872 = (let _140_1871 = (let _140_1870 = (FStar_List.map Prims.snd vars)
in (tname, _140_1870, FStar_ToSMT_Term.Type_sort, None))
in FStar_ToSMT_Term.DeclFun (_140_1871))
in (_140_1872)::(tok_decl)::[])
in (FStar_List.append _140_1873 fresh_tok))
in (let _140_1879 = (let _140_1878 = (let _140_1877 = (let _140_1876 = (let _140_1875 = (let _140_1874 = (FStar_ToSMT_Term.mkEq (tok_app, app))
in (((tok_app)::[])::[], vars, _140_1874))
in (FStar_ToSMT_Term.mkForall _140_1875))
in (_140_1876, Some ("name-token correspondence")))
in FStar_ToSMT_Term.Assume (_140_1877))
in (_140_1878)::[])
in (FStar_List.append _140_1880 _140_1879)))
in (

let t = if (FStar_All.pipe_right tags (FStar_List.contains FStar_Absyn_Syntax.Opaque)) then begin
(FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t)
end else begin
(whnf env t)
end
in (

let _50_2432 = if (FStar_All.pipe_right tags (FStar_Util.for_some (fun _50_19 -> (match (_50_19) with
| FStar_Absyn_Syntax.Logic -> begin
true
end
| _50_2427 -> begin
false
end)))) then begin
(let _140_1883 = (FStar_ToSMT_Term.mk_Valid app)
in (let _140_1882 = (encode_formula t env')
in (_140_1883, _140_1882)))
end else begin
(let _140_1884 = (encode_typ_term t env')
in (app, _140_1884))
end
in (match (_50_2432) with
| (def, (body, decls1)) -> begin
(

let abbrev_def = (let _140_1891 = (let _140_1890 = (let _140_1889 = (let _140_1888 = (let _140_1887 = (let _140_1886 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _140_1885 = (FStar_ToSMT_Term.mkEq (def, body))
in (_140_1886, _140_1885)))
in (FStar_ToSMT_Term.mkImp _140_1887))
in (((def)::[])::[], vars, _140_1888))
in (FStar_ToSMT_Term.mkForall _140_1889))
in (_140_1890, Some ("abbrev. elimination")))
in FStar_ToSMT_Term.Assume (_140_1891))
in (

let kindingAx = (

let _50_2436 = (let _140_1892 = (FStar_Tc_Recheck.recompute_kind t)
in (encode_knd _140_1892 env' app))
in (match (_50_2436) with
| (k, decls) -> begin
(let _140_1900 = (let _140_1899 = (let _140_1898 = (let _140_1897 = (let _140_1896 = (let _140_1895 = (let _140_1894 = (let _140_1893 = (FStar_ToSMT_Term.mk_and_l guards)
in (_140_1893, k))
in (FStar_ToSMT_Term.mkImp _140_1894))
in (((app)::[])::[], vars, _140_1895))
in (FStar_ToSMT_Term.mkForall _140_1896))
in (_140_1897, Some ("abbrev. kinding")))
in FStar_ToSMT_Term.Assume (_140_1898))
in (_140_1899)::[])
in (FStar_List.append decls _140_1900))
end))
in (

let g = (let _140_1901 = (primitive_type_axioms lid tname app)
in (FStar_List.append (FStar_List.append (FStar_List.append (FStar_List.append binder_decls decls) decls1) ((abbrev_def)::kindingAx)) _140_1901))
in (g, env))))
end))))))))
end))
end))
end))
end
| FStar_Absyn_Syntax.Sig_val_decl (lid, t, quals, _50_2443) -> begin
if ((FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.Assumption)) || env.tcenv.FStar_Tc_Env.is_iface) then begin
(encode_top_level_val env lid t quals)
end else begin
([], env)
end
end
| FStar_Absyn_Syntax.Sig_assume (l, f, _50_2449, _50_2451) -> begin
(

let _50_2456 = (encode_formula f env)
in (match (_50_2456) with
| (f, decls) -> begin
(

let g = (let _140_1906 = (let _140_1905 = (let _140_1904 = (let _140_1903 = (let _140_1902 = (FStar_Absyn_Print.sli l)
in (FStar_Util.format1 "Assumption: %s" _140_1902))
in Some (_140_1903))
in (f, _140_1904))
in FStar_ToSMT_Term.Assume (_140_1905))
in (_140_1906)::[])
in ((FStar_List.append decls g), env))
end))
end
| FStar_Absyn_Syntax.Sig_tycon (t, tps, k, _50_2462, datas, quals, _50_2466) when (FStar_Ident.lid_equals t FStar_Absyn_Const.precedes_lid) -> begin
(

let _50_2472 = (new_typ_constant_and_tok_from_lid env t)
in (match (_50_2472) with
| (tname, ttok, env) -> begin
([], env)
end))
end
| FStar_Absyn_Syntax.Sig_tycon (t, _50_2475, _50_2477, _50_2479, _50_2481, _50_2483, _50_2485) when ((FStar_Ident.lid_equals t FStar_Absyn_Const.char_lid) || (FStar_Ident.lid_equals t FStar_Absyn_Const.uint8_lid)) -> begin
(

let tname = t.FStar_Ident.str
in (

let tsym = (FStar_ToSMT_Term.mkFreeV (tname, FStar_ToSMT_Term.Type_sort))
in (

let decl = FStar_ToSMT_Term.DeclFun ((tname, [], FStar_ToSMT_Term.Type_sort, None))
in (let _140_1908 = (let _140_1907 = (primitive_type_axioms t tname tsym)
in (decl)::_140_1907)
in (_140_1908, (push_free_tvar env t tname (Some (tsym))))))))
end
| FStar_Absyn_Syntax.Sig_tycon (t, tps, k, _50_2495, datas, quals, _50_2499) -> begin
(

let is_logical = (FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_20 -> (match (_50_20) with
| (FStar_Absyn_Syntax.Logic) | (FStar_Absyn_Syntax.Assumption) -> begin
true
end
| _50_2506 -> begin
false
end))))
in (

let constructor_or_logic_type_decl = (fun c -> if is_logical then begin
(

let _50_2516 = c
in (match (_50_2516) with
| (name, args, _50_2513, _50_2515) -> begin
(let _140_1914 = (let _140_1913 = (let _140_1912 = (FStar_All.pipe_right args (FStar_List.map Prims.snd))
in (name, _140_1912, FStar_ToSMT_Term.Type_sort, None))
in FStar_ToSMT_Term.DeclFun (_140_1913))
in (_140_1914)::[])
end))
end else begin
(FStar_ToSMT_Term.constructor_to_decl c)
end)
in (

let inversion_axioms = (fun tapp vars -> if (((FStar_List.length datas) = 0) || (FStar_All.pipe_right datas (FStar_Util.for_some (fun l -> (let _140_1920 = (FStar_Tc_Env.lookup_qname env.tcenv l)
in (FStar_All.pipe_right _140_1920 FStar_Option.isNone)))))) then begin
[]
end else begin
(

let _50_2523 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2523) with
| (xxsym, xx) -> begin
(

let _50_2566 = (FStar_All.pipe_right datas (FStar_List.fold_left (fun _50_2526 l -> (match (_50_2526) with
| (out, decls) -> begin
(

let data_t = (FStar_Tc_Env.lookup_datacon env.tcenv l)
in (

let _50_2536 = (match ((FStar_Absyn_Util.function_formals data_t)) with
| Some (formals, res) -> begin
(formals, (FStar_Absyn_Util.comp_result res))
end
| None -> begin
([], data_t)
end)
in (match (_50_2536) with
| (args, res) -> begin
(

let indices = (match ((let _140_1923 = (FStar_Absyn_Util.compress_typ res)
in _140_1923.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_app (_50_2538, indices) -> begin
indices
end
| _50_2543 -> begin
[]
end)
in (

let env = (FStar_All.pipe_right args (FStar_List.fold_left (fun env a -> (match ((Prims.fst a)) with
| FStar_Util.Inl (a) -> begin
(let _140_1928 = (let _140_1927 = (let _140_1926 = (mk_typ_projector_name l a.FStar_Absyn_Syntax.v)
in (_140_1926, (xx)::[]))
in (FStar_ToSMT_Term.mkApp _140_1927))
in (push_typ_var env a.FStar_Absyn_Syntax.v _140_1928))
end
| FStar_Util.Inr (x) -> begin
(let _140_1931 = (let _140_1930 = (let _140_1929 = (mk_term_projector_name l x.FStar_Absyn_Syntax.v)
in (_140_1929, (xx)::[]))
in (FStar_ToSMT_Term.mkApp _140_1930))
in (push_term_var env x.FStar_Absyn_Syntax.v _140_1931))
end)) env))
in (

let _50_2554 = (encode_args indices env)
in (match (_50_2554) with
| (indices, decls') -> begin
(

let _50_2555 = if ((FStar_List.length indices) <> (FStar_List.length vars)) then begin
(FStar_All.failwith "Impossible")
end else begin
()
end
in (

let eqs = (let _140_1938 = (FStar_List.map2 (fun v a -> (match (a) with
| FStar_Util.Inl (a) -> begin
(let _140_1935 = (let _140_1934 = (FStar_ToSMT_Term.mkFreeV v)
in (_140_1934, a))
in (FStar_ToSMT_Term.mkEq _140_1935))
end
| FStar_Util.Inr (a) -> begin
(let _140_1937 = (let _140_1936 = (FStar_ToSMT_Term.mkFreeV v)
in (_140_1936, a))
in (FStar_ToSMT_Term.mkEq _140_1937))
end)) vars indices)
in (FStar_All.pipe_right _140_1938 FStar_ToSMT_Term.mk_and_l))
in (let _140_1943 = (let _140_1942 = (let _140_1941 = (let _140_1940 = (let _140_1939 = (mk_data_tester env l xx)
in (_140_1939, eqs))
in (FStar_ToSMT_Term.mkAnd _140_1940))
in (out, _140_1941))
in (FStar_ToSMT_Term.mkOr _140_1942))
in (_140_1943, (FStar_List.append decls decls')))))
end))))
end)))
end)) (FStar_ToSMT_Term.mkFalse, [])))
in (match (_50_2566) with
| (data_ax, decls) -> begin
(

let _50_2569 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2569) with
| (ffsym, ff) -> begin
(

let xx_has_type = (let _140_1944 = (FStar_ToSMT_Term.mkApp ("SFuel", (ff)::[]))
in (FStar_ToSMT_Term.mk_HasTypeFuel _140_1944 xx tapp))
in (let _140_1951 = (let _140_1950 = (let _140_1949 = (let _140_1948 = (let _140_1947 = (let _140_1946 = (add_fuel (ffsym, FStar_ToSMT_Term.Fuel_sort) (((xxsym, FStar_ToSMT_Term.Term_sort))::vars))
in (let _140_1945 = (FStar_ToSMT_Term.mkImp (xx_has_type, data_ax))
in (((xx_has_type)::[])::[], _140_1946, _140_1945)))
in (FStar_ToSMT_Term.mkForall _140_1947))
in (_140_1948, Some ("inversion axiom")))
in FStar_ToSMT_Term.Assume (_140_1949))
in (_140_1950)::[])
in (FStar_List.append decls _140_1951)))
end))
end))
end))
end)
in (

let k = (FStar_Absyn_Util.close_kind tps k)
in (

let _50_2581 = (match ((let _140_1952 = (FStar_Absyn_Util.compress_kind k)
in _140_1952.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Kind_arrow (bs, res) -> begin
(true, bs, res)
end
| _50_2577 -> begin
(false, [], k)
end)
in (match (_50_2581) with
| (is_kind_arrow, formals, res) -> begin
(

let _50_2588 = (encode_binders None formals env)
in (match (_50_2588) with
| (vars, guards, env', binder_decls, _50_2587) -> begin
(

let projection_axioms = (fun tapp vars -> (match ((FStar_All.pipe_right quals (FStar_Util.find_opt (fun _50_21 -> (match (_50_21) with
| FStar_Absyn_Syntax.Projector (_50_2594) -> begin
true
end
| _50_2597 -> begin
false
end))))) with
| Some (FStar_Absyn_Syntax.Projector (d, FStar_Util.Inl (a))) -> begin
(

let rec projectee = (fun i _50_22 -> (match (_50_22) with
| [] -> begin
i
end
| (f)::tl -> begin
(match ((Prims.fst f)) with
| FStar_Util.Inl (_50_2612) -> begin
(projectee (i + 1) tl)
end
| FStar_Util.Inr (x) -> begin
if (x.FStar_Absyn_Syntax.v.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = "projectee") then begin
i
end else begin
(projectee (i + 1) tl)
end
end)
end))
in (

let projectee_pos = (projectee 0 formals)
in (

let _50_2627 = (match ((FStar_Util.first_N projectee_pos vars)) with
| (_50_2618, (xx)::suffix) -> begin
(xx, suffix)
end
| _50_2624 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_50_2627) with
| (xx, suffix) -> begin
(

let dproj_app = (let _140_1966 = (let _140_1965 = (let _140_1964 = (mk_typ_projector_name d a)
in (let _140_1963 = (let _140_1962 = (FStar_ToSMT_Term.mkFreeV xx)
in (_140_1962)::[])
in (_140_1964, _140_1963)))
in (FStar_ToSMT_Term.mkApp _140_1965))
in (mk_ApplyT _140_1966 suffix))
in (let _140_1971 = (let _140_1970 = (let _140_1969 = (let _140_1968 = (let _140_1967 = (FStar_ToSMT_Term.mkEq (tapp, dproj_app))
in (((tapp)::[])::[], vars, _140_1967))
in (FStar_ToSMT_Term.mkForall _140_1968))
in (_140_1969, Some ("projector axiom")))
in FStar_ToSMT_Term.Assume (_140_1970))
in (_140_1971)::[]))
end))))
end
| _50_2630 -> begin
[]
end))
in (

let pretype_axioms = (fun tapp vars -> (

let _50_2636 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2636) with
| (xxsym, xx) -> begin
(

let _50_2639 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2639) with
| (ffsym, ff) -> begin
(

let xx_has_type = (FStar_ToSMT_Term.mk_HasTypeFuel ff xx tapp)
in (let _140_1984 = (let _140_1983 = (let _140_1982 = (let _140_1981 = (let _140_1980 = (let _140_1979 = (let _140_1978 = (let _140_1977 = (let _140_1976 = (FStar_ToSMT_Term.mkApp ("PreType", (xx)::[]))
in (tapp, _140_1976))
in (FStar_ToSMT_Term.mkEq _140_1977))
in (xx_has_type, _140_1978))
in (FStar_ToSMT_Term.mkImp _140_1979))
in (((xx_has_type)::[])::[], ((xxsym, FStar_ToSMT_Term.Term_sort))::((ffsym, FStar_ToSMT_Term.Fuel_sort))::vars, _140_1980))
in (FStar_ToSMT_Term.mkForall _140_1981))
in (_140_1982, Some ("pretyping")))
in FStar_ToSMT_Term.Assume (_140_1983))
in (_140_1984)::[]))
end))
end)))
in (

let _50_2644 = (new_typ_constant_and_tok_from_lid env t)
in (match (_50_2644) with
| (tname, ttok, env) -> begin
(

let ttok_tm = (FStar_ToSMT_Term.mkApp (ttok, []))
in (

let guard = (FStar_ToSMT_Term.mk_and_l guards)
in (

let tapp = (let _140_1986 = (let _140_1985 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (tname, _140_1985))
in (FStar_ToSMT_Term.mkApp _140_1986))
in (

let _50_2665 = (

let tname_decl = (let _140_1990 = (let _140_1989 = (FStar_All.pipe_right vars (FStar_List.map (fun _50_2650 -> (match (_50_2650) with
| (n, s) -> begin
((Prims.strcat tname n), s)
end))))
in (let _140_1988 = (varops.next_id ())
in (tname, _140_1989, FStar_ToSMT_Term.Type_sort, _140_1988)))
in (constructor_or_logic_type_decl _140_1990))
in (

let _50_2662 = (match (vars) with
| [] -> begin
(let _140_1994 = (let _140_1993 = (let _140_1992 = (FStar_ToSMT_Term.mkApp (tname, []))
in (FStar_All.pipe_left (fun _140_1991 -> Some (_140_1991)) _140_1992))
in (push_free_tvar env t tname _140_1993))
in ([], _140_1994))
end
| _50_2654 -> begin
(

let ttok_decl = FStar_ToSMT_Term.DeclFun ((ttok, [], FStar_ToSMT_Term.Type_sort, Some ("token")))
in (

let ttok_fresh = (let _140_1995 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token (ttok, FStar_ToSMT_Term.Type_sort) _140_1995))
in (

let ttok_app = (mk_ApplyT ttok_tm vars)
in (

let pats = ((ttok_app)::[])::((tapp)::[])::[]
in (

let name_tok_corr = (let _140_1999 = (let _140_1998 = (let _140_1997 = (let _140_1996 = (FStar_ToSMT_Term.mkEq (ttok_app, tapp))
in (pats, None, vars, _140_1996))
in (FStar_ToSMT_Term.mkForall' _140_1997))
in (_140_1998, Some ("name-token correspondence")))
in FStar_ToSMT_Term.Assume (_140_1999))
in ((ttok_decl)::(ttok_fresh)::(name_tok_corr)::[], env))))))
end)
in (match (_50_2662) with
| (tok_decls, env) -> begin
((FStar_List.append tname_decl tok_decls), env)
end)))
in (match (_50_2665) with
| (decls, env) -> begin
(

let kindingAx = (

let _50_2668 = (encode_knd res env' tapp)
in (match (_50_2668) with
| (k, decls) -> begin
(

let karr = if is_kind_arrow then begin
(let _140_2003 = (let _140_2002 = (let _140_2001 = (let _140_2000 = (FStar_ToSMT_Term.mk_PreKind ttok_tm)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _140_2000))
in (_140_2001, Some ("kinding")))
in FStar_ToSMT_Term.Assume (_140_2002))
in (_140_2003)::[])
end else begin
[]
end
in (let _140_2009 = (let _140_2008 = (let _140_2007 = (let _140_2006 = (let _140_2005 = (let _140_2004 = (FStar_ToSMT_Term.mkImp (guard, k))
in (((tapp)::[])::[], vars, _140_2004))
in (FStar_ToSMT_Term.mkForall _140_2005))
in (_140_2006, Some ("kinding")))
in FStar_ToSMT_Term.Assume (_140_2007))
in (_140_2008)::[])
in (FStar_List.append (FStar_List.append decls karr) _140_2009)))
end))
in (

let aux = if is_logical then begin
(let _140_2010 = (projection_axioms tapp vars)
in (FStar_List.append kindingAx _140_2010))
end else begin
(let _140_2017 = (let _140_2015 = (let _140_2013 = (let _140_2011 = (primitive_type_axioms t tname tapp)
in (FStar_List.append kindingAx _140_2011))
in (let _140_2012 = (inversion_axioms tapp vars)
in (FStar_List.append _140_2013 _140_2012)))
in (let _140_2014 = (projection_axioms tapp vars)
in (FStar_List.append _140_2015 _140_2014)))
in (let _140_2016 = (pretype_axioms tapp vars)
in (FStar_List.append _140_2017 _140_2016)))
end
in (

let g = (FStar_List.append (FStar_List.append decls binder_decls) aux)
in (g, env))))
end)))))
end))))
end))
end))))))
end
| FStar_Absyn_Syntax.Sig_datacon (d, _50_2675, _50_2677, _50_2679, _50_2681, _50_2683) when (FStar_Ident.lid_equals d FStar_Absyn_Const.lexcons_lid) -> begin
([], env)
end
| FStar_Absyn_Syntax.Sig_datacon (d, t, (_50_2689, tps, _50_2692), quals, _50_2696, drange) -> begin
(

let t = (let _140_2019 = (FStar_List.map (fun _50_2703 -> (match (_50_2703) with
| (x, _50_2702) -> begin
(x, Some (FStar_Absyn_Syntax.Implicit (true)))
end)) tps)
in (FStar_Absyn_Util.close_typ _140_2019 t))
in (

let _50_2708 = (new_term_constant_and_tok_from_lid env d)
in (match (_50_2708) with
| (ddconstrsym, ddtok, env) -> begin
(

let ddtok_tm = (FStar_ToSMT_Term.mkApp (ddtok, []))
in (

let _50_2717 = (match ((FStar_Absyn_Util.function_formals t)) with
| Some (f, c) -> begin
(f, (FStar_Absyn_Util.comp_result c))
end
| None -> begin
([], t)
end)
in (match (_50_2717) with
| (formals, t_res) -> begin
(

let _50_2720 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2720) with
| (fuel_var, fuel_tm) -> begin
(

let s_fuel_tm = (FStar_ToSMT_Term.mkApp ("SFuel", (fuel_tm)::[]))
in (

let _50_2727 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_50_2727) with
| (vars, guards, env', binder_decls, names) -> begin
(

let projectors = (FStar_All.pipe_right names (FStar_List.map (fun _50_23 -> (match (_50_23) with
| FStar_Util.Inl (a) -> begin
(let _140_2021 = (mk_typ_projector_name d a)
in (_140_2021, FStar_ToSMT_Term.Type_sort))
end
| FStar_Util.Inr (x) -> begin
(let _140_2022 = (mk_term_projector_name d x)
in (_140_2022, FStar_ToSMT_Term.Term_sort))
end))))
in (

let datacons = (let _140_2024 = (let _140_2023 = (varops.next_id ())
in (ddconstrsym, projectors, FStar_ToSMT_Term.Term_sort, _140_2023))
in (FStar_All.pipe_right _140_2024 FStar_ToSMT_Term.constructor_to_decl))
in (

let app = (mk_ApplyE ddtok_tm vars)
in (

let guard = (FStar_ToSMT_Term.mk_and_l guards)
in (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let dapp = (FStar_ToSMT_Term.mkApp (ddconstrsym, xvars))
in (

let _50_2741 = (encode_typ_pred None t env ddtok_tm)
in (match (_50_2741) with
| (tok_typing, decls3) -> begin
(

let _50_2748 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_50_2748) with
| (vars', guards', env'', decls_formals, _50_2747) -> begin
(

let _50_2753 = (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars')
in (

let dapp = (FStar_ToSMT_Term.mkApp (ddconstrsym, xvars))
in (encode_typ_pred (Some (fuel_tm)) t_res env'' dapp)))
in (match (_50_2753) with
| (ty_pred', decls_pred) -> begin
(

let guard' = (FStar_ToSMT_Term.mk_and_l guards')
in (

let proxy_fresh = (match (formals) with
| [] -> begin
[]
end
| _50_2757 -> begin
(let _140_2026 = (let _140_2025 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token (ddtok, FStar_ToSMT_Term.Term_sort) _140_2025))
in (_140_2026)::[])
end)
in (

let encode_elim = (fun _50_2760 -> (match (()) with
| () -> begin
(

let _50_2763 = (FStar_Absyn_Util.head_and_args t_res)
in (match (_50_2763) with
| (head, args) -> begin
(match ((let _140_2029 = (FStar_Absyn_Util.compress_typ head)
in _140_2029.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(

let encoded_head = (lookup_free_tvar_name env' fv)
in (

let _50_2769 = (encode_args args env')
in (match (_50_2769) with
| (encoded_args, arg_decls) -> begin
(

let _50_2793 = (FStar_List.fold_left (fun _50_2773 arg -> (match (_50_2773) with
| (env, arg_vars, eqns) -> begin
(match (arg) with
| FStar_Util.Inl (targ) -> begin
(

let _50_2781 = (let _140_2032 = (FStar_Absyn_Util.new_bvd None)
in (gen_typ_var env _140_2032))
in (match (_50_2781) with
| (_50_2778, tv, env) -> begin
(let _140_2034 = (let _140_2033 = (FStar_ToSMT_Term.mkEq (targ, tv))
in (_140_2033)::eqns)
in (env, (tv)::arg_vars, _140_2034))
end))
end
| FStar_Util.Inr (varg) -> begin
(

let _50_2788 = (let _140_2035 = (FStar_Absyn_Util.new_bvd None)
in (gen_term_var env _140_2035))
in (match (_50_2788) with
| (_50_2785, xv, env) -> begin
(let _140_2037 = (let _140_2036 = (FStar_ToSMT_Term.mkEq (varg, xv))
in (_140_2036)::eqns)
in (env, (xv)::arg_vars, _140_2037))
end))
end)
end)) (env', [], []) encoded_args)
in (match (_50_2793) with
| (_50_2790, arg_vars, eqns) -> begin
(

let arg_vars = (FStar_List.rev arg_vars)
in (

let ty = (FStar_ToSMT_Term.mkApp (encoded_head, arg_vars))
in (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let dapp = (FStar_ToSMT_Term.mkApp (ddconstrsym, xvars))
in (

let ty_pred = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (s_fuel_tm)) dapp ty)
in (

let arg_binders = (FStar_List.map FStar_ToSMT_Term.fv_of_term arg_vars)
in (

let typing_inversion = (let _140_2044 = (let _140_2043 = (let _140_2042 = (let _140_2041 = (add_fuel (fuel_var, FStar_ToSMT_Term.Fuel_sort) (FStar_List.append vars arg_binders))
in (let _140_2040 = (let _140_2039 = (let _140_2038 = (FStar_ToSMT_Term.mk_and_l (FStar_List.append eqns guards))
in (ty_pred, _140_2038))
in (FStar_ToSMT_Term.mkImp _140_2039))
in (((ty_pred)::[])::[], _140_2041, _140_2040)))
in (FStar_ToSMT_Term.mkForall _140_2042))
in (_140_2043, Some ("data constructor typing elim")))
in FStar_ToSMT_Term.Assume (_140_2044))
in (

let subterm_ordering = if (FStar_Ident.lid_equals d FStar_Absyn_Const.lextop_lid) then begin
(

let x = (let _140_2045 = (varops.fresh "x")
in (_140_2045, FStar_ToSMT_Term.Term_sort))
in (

let xtm = (FStar_ToSMT_Term.mkFreeV x)
in (let _140_2055 = (let _140_2054 = (let _140_2053 = (let _140_2052 = (let _140_2047 = (let _140_2046 = (FStar_ToSMT_Term.mk_Precedes xtm dapp)
in (_140_2046)::[])
in (_140_2047)::[])
in (let _140_2051 = (let _140_2050 = (let _140_2049 = (FStar_ToSMT_Term.mk_tester "LexCons" xtm)
in (let _140_2048 = (FStar_ToSMT_Term.mk_Precedes xtm dapp)
in (_140_2049, _140_2048)))
in (FStar_ToSMT_Term.mkImp _140_2050))
in (_140_2052, (x)::[], _140_2051)))
in (FStar_ToSMT_Term.mkForall _140_2053))
in (_140_2054, Some ("lextop is top")))
in FStar_ToSMT_Term.Assume (_140_2055))))
end else begin
(

let prec = (FStar_All.pipe_right vars (FStar_List.collect (fun v -> (match ((Prims.snd v)) with
| (FStar_ToSMT_Term.Type_sort) | (FStar_ToSMT_Term.Fuel_sort) -> begin
[]
end
| FStar_ToSMT_Term.Term_sort -> begin
(let _140_2058 = (let _140_2057 = (FStar_ToSMT_Term.mkFreeV v)
in (FStar_ToSMT_Term.mk_Precedes _140_2057 dapp))
in (_140_2058)::[])
end
| _50_2808 -> begin
(FStar_All.failwith "unexpected sort")
end))))
in (let _140_2065 = (let _140_2064 = (let _140_2063 = (let _140_2062 = (add_fuel (fuel_var, FStar_ToSMT_Term.Fuel_sort) (FStar_List.append vars arg_binders))
in (let _140_2061 = (let _140_2060 = (let _140_2059 = (FStar_ToSMT_Term.mk_and_l prec)
in (ty_pred, _140_2059))
in (FStar_ToSMT_Term.mkImp _140_2060))
in (((ty_pred)::[])::[], _140_2062, _140_2061)))
in (FStar_ToSMT_Term.mkForall _140_2063))
in (_140_2064, Some ("subterm ordering")))
in FStar_ToSMT_Term.Assume (_140_2065)))
end
in (arg_decls, (typing_inversion)::(subterm_ordering)::[])))))))))
end))
end)))
end
| _50_2812 -> begin
(

let _50_2813 = (let _140_2068 = (let _140_2067 = (FStar_Absyn_Print.sli d)
in (let _140_2066 = (FStar_Absyn_Print.typ_to_string head)
in (FStar_Util.format2 "Constructor %s builds an unexpected type %s\n" _140_2067 _140_2066)))
in (FStar_Tc_Errors.warn drange _140_2068))
in ([], []))
end)
end))
end))
in (

let _50_2817 = (encode_elim ())
in (match (_50_2817) with
| (decls2, elim) -> begin
(

let g = (let _140_2093 = (let _140_2092 = (let _140_2077 = (let _140_2076 = (let _140_2075 = (let _140_2074 = (let _140_2073 = (let _140_2072 = (let _140_2071 = (let _140_2070 = (let _140_2069 = (FStar_Absyn_Print.sli d)
in (FStar_Util.format1 "data constructor proxy: %s" _140_2069))
in Some (_140_2070))
in (ddtok, [], FStar_ToSMT_Term.Term_sort, _140_2071))
in FStar_ToSMT_Term.DeclFun (_140_2072))
in (_140_2073)::[])
in (FStar_List.append (FStar_List.append (FStar_List.append binder_decls decls2) decls3) _140_2074))
in (FStar_List.append _140_2075 proxy_fresh))
in (FStar_List.append _140_2076 decls_formals))
in (FStar_List.append _140_2077 decls_pred))
in (let _140_2091 = (let _140_2090 = (let _140_2089 = (let _140_2081 = (let _140_2080 = (let _140_2079 = (let _140_2078 = (FStar_ToSMT_Term.mkEq (app, dapp))
in (((app)::[])::[], vars, _140_2078))
in (FStar_ToSMT_Term.mkForall _140_2079))
in (_140_2080, Some ("equality for proxy")))
in FStar_ToSMT_Term.Assume (_140_2081))
in (let _140_2088 = (let _140_2087 = (let _140_2086 = (let _140_2085 = (let _140_2084 = (let _140_2083 = (add_fuel (fuel_var, FStar_ToSMT_Term.Fuel_sort) vars')
in (let _140_2082 = (FStar_ToSMT_Term.mkImp (guard', ty_pred'))
in (((ty_pred')::[])::[], _140_2083, _140_2082)))
in (FStar_ToSMT_Term.mkForall _140_2084))
in (_140_2085, Some ("data constructor typing intro")))
in FStar_ToSMT_Term.Assume (_140_2086))
in (_140_2087)::[])
in (_140_2089)::_140_2088))
in (FStar_ToSMT_Term.Assume ((tok_typing, Some ("typing for data constructor proxy"))))::_140_2090)
in (FStar_List.append _140_2092 _140_2091)))
in (FStar_List.append _140_2093 elim))
in ((FStar_List.append datacons g), env))
end)))))
end))
end))
end))))))))
end)))
end))
end)))
end)))
end
| FStar_Absyn_Syntax.Sig_bundle (ses, _50_2821, _50_2823, _50_2825) -> begin
(

let _50_2830 = (encode_signature env ses)
in (match (_50_2830) with
| (g, env) -> begin
(

let _50_2842 = (FStar_All.pipe_right g (FStar_List.partition (fun _50_24 -> (match (_50_24) with
| FStar_ToSMT_Term.Assume (_50_2833, Some ("inversion axiom")) -> begin
false
end
| _50_2839 -> begin
true
end))))
in (match (_50_2842) with
| (g', inversions) -> begin
(

let _50_2851 = (FStar_All.pipe_right g' (FStar_List.partition (fun _50_25 -> (match (_50_25) with
| FStar_ToSMT_Term.DeclFun (_50_2845) -> begin
true
end
| _50_2848 -> begin
false
end))))
in (match (_50_2851) with
| (decls, rest) -> begin
((FStar_List.append (FStar_List.append decls rest) inversions), env)
end))
end))
end))
end
| FStar_Absyn_Syntax.Sig_let (_50_2853, _50_2855, _50_2857, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_26 -> (match (_50_26) with
| (FStar_Absyn_Syntax.Projector (_)) | (FStar_Absyn_Syntax.Discriminator (_)) -> begin
true
end
| _50_2869 -> begin
false
end)))) -> begin
([], env)
end
| FStar_Absyn_Syntax.Sig_let ((is_rec, bindings), _50_2874, _50_2876, quals) -> begin
(

let eta_expand = (fun binders formals body t -> (

let nbinders = (FStar_List.length binders)
in (

let _50_2888 = (FStar_Util.first_N nbinders formals)
in (match (_50_2888) with
| (formals, extra_formals) -> begin
(

let subst = (FStar_List.map2 (fun formal binder -> (match (((Prims.fst formal), (Prims.fst binder))) with
| (FStar_Util.Inl (a), FStar_Util.Inl (b)) -> begin
(let _140_2108 = (let _140_2107 = (FStar_Absyn_Util.btvar_to_typ b)
in (a.FStar_Absyn_Syntax.v, _140_2107))
in FStar_Util.Inl (_140_2108))
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(let _140_2110 = (let _140_2109 = (FStar_Absyn_Util.bvar_to_exp y)
in (x.FStar_Absyn_Syntax.v, _140_2109))
in FStar_Util.Inr (_140_2110))
end
| _50_2902 -> begin
(FStar_All.failwith "Impossible")
end)) formals binders)
in (

let extra_formals = (let _140_2111 = (FStar_Absyn_Util.subst_binders subst extra_formals)
in (FStar_All.pipe_right _140_2111 FStar_Absyn_Util.name_binders))
in (

let body = (let _140_2117 = (let _140_2113 = (let _140_2112 = (FStar_Absyn_Util.args_of_binders extra_formals)
in (FStar_All.pipe_left Prims.snd _140_2112))
in (body, _140_2113))
in (let _140_2116 = (let _140_2115 = (FStar_Absyn_Util.subst_typ subst t)
in (FStar_All.pipe_left (fun _140_2114 -> Some (_140_2114)) _140_2115))
in (FStar_Absyn_Syntax.mk_Exp_app_flat _140_2117 _140_2116 body.FStar_Absyn_Syntax.pos)))
in ((FStar_List.append binders extra_formals), body))))
end))))
in (

let destruct_bound_function = (fun flid t_norm e -> (match (e.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Exp_ascribed ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (binders, body); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _, _)) | (FStar_Absyn_Syntax.Exp_abs (binders, body)) -> begin
(match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (formals, c) -> begin
(

let nformals = (FStar_List.length formals)
in (

let nbinders = (FStar_List.length binders)
in (

let tres = (FStar_Absyn_Util.comp_result c)
in if ((nformals < nbinders) && (FStar_Absyn_Util.is_total_comp c)) then begin
(

let _50_2940 = (FStar_Util.first_N nformals binders)
in (match (_50_2940) with
| (bs0, rest) -> begin
(

let tres = (match ((FStar_Absyn_Util.mk_subst_binder bs0 formals)) with
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s tres)
end
| _50_2944 -> begin
(FStar_All.failwith "impossible")
end)
in (

let body = (FStar_Absyn_Syntax.mk_Exp_abs (rest, body) (Some (tres)) body.FStar_Absyn_Syntax.pos)
in (bs0, body, bs0, tres)))
end))
end else begin
if (nformals > nbinders) then begin
(

let _50_2949 = (eta_expand binders formals body tres)
in (match (_50_2949) with
| (binders, body) -> begin
(binders, body, formals, tres)
end))
end else begin
(binders, body, formals, tres)
end
end)))
end
| _50_2951 -> begin
(let _140_2126 = (let _140_2125 = (FStar_Absyn_Print.exp_to_string e)
in (let _140_2124 = (FStar_Absyn_Print.typ_to_string t_norm)
in (FStar_Util.format3 "Impossible! let-bound lambda %s = %s has a type that\'s not a function: %s\n" flid.FStar_Ident.str _140_2125 _140_2124)))
in (FStar_All.failwith _140_2126))
end)
end
| _50_2953 -> begin
(match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (formals, c) -> begin
(

let tres = (FStar_Absyn_Util.comp_result c)
in (

let _50_2961 = (eta_expand [] formals e tres)
in (match (_50_2961) with
| (binders, body) -> begin
(binders, body, formals, tres)
end)))
end
| _50_2963 -> begin
([], e, [], t_norm)
end)
end))
in try
(match (()) with
| () -> begin
if ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_27 -> (match (_50_27) with
| FStar_Absyn_Syntax.Opaque -> begin
true
end
| _50_2976 -> begin
false
end)))) || (FStar_All.pipe_right bindings (FStar_Util.for_all (fun lb -> (FStar_Absyn_Util.is_smt_lemma lb.FStar_Absyn_Syntax.lbtyp))))) then begin
(encode_top_level_vals env bindings quals)
end else begin
(

let _50_2995 = (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _50_2982 lb -> (match (_50_2982) with
| (toks, typs, decls, env) -> begin
(

let _50_2984 = if (FStar_Absyn_Util.is_smt_lemma lb.FStar_Absyn_Syntax.lbtyp) then begin
(Prims.raise Let_rec_unencodeable)
end else begin
()
end
in (

let t_norm = (let _140_2132 = (whnf env lb.FStar_Absyn_Syntax.lbtyp)
in (FStar_All.pipe_right _140_2132 FStar_Absyn_Util.compress_typ))
in (

let _50_2990 = (let _140_2133 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in (declare_top_level_let env _140_2133 lb.FStar_Absyn_Syntax.lbtyp t_norm))
in (match (_50_2990) with
| (tok, decl, env) -> begin
(let _140_2136 = (let _140_2135 = (let _140_2134 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in (_140_2134, tok))
in (_140_2135)::toks)
in (_140_2136, (t_norm)::typs, (decl)::decls, env))
end))))
end)) ([], [], [], env)))
in (match (_50_2995) with
| (toks, typs, decls, env) -> begin
(

let toks = (FStar_List.rev toks)
in (

let decls = (FStar_All.pipe_right (FStar_List.rev decls) FStar_List.flatten)
in (

let typs = (FStar_List.rev typs)
in if ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_28 -> (match (_50_28) with
| FStar_Absyn_Syntax.HasMaskedEffect -> begin
true
end
| _50_3002 -> begin
false
end)))) || (FStar_All.pipe_right typs (FStar_Util.for_some (fun t -> ((FStar_Absyn_Util.is_lemma t) || (let _140_2139 = (FStar_Absyn_Util.is_pure_or_ghost_function t)
in (FStar_All.pipe_left Prims.op_Negation _140_2139))))))) then begin
(decls, env)
end else begin
if (not (is_rec)) then begin
(match ((bindings, typs, toks)) with
| (({FStar_Absyn_Syntax.lbname = _50_3010; FStar_Absyn_Syntax.lbtyp = _50_3008; FStar_Absyn_Syntax.lbeff = _50_3006; FStar_Absyn_Syntax.lbdef = e})::[], (t_norm)::[], ((flid, (f, ftok)))::[]) -> begin
(

let _50_3026 = (destruct_bound_function flid t_norm e)
in (match (_50_3026) with
| (binders, body, formals, tres) -> begin
(

let _50_3033 = (encode_binders None binders env)
in (match (_50_3033) with
| (vars, guards, env', binder_decls, _50_3032) -> begin
(

let app = (match (vars) with
| [] -> begin
(FStar_ToSMT_Term.mkFreeV (f, FStar_ToSMT_Term.Term_sort))
end
| _50_3036 -> begin
(let _140_2141 = (let _140_2140 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (f, _140_2140))
in (FStar_ToSMT_Term.mkApp _140_2141))
end)
in (

let _50_3040 = (encode_exp body env')
in (match (_50_3040) with
| (body, decls2) -> begin
(

let eqn = (let _140_2150 = (let _140_2149 = (let _140_2146 = (let _140_2145 = (let _140_2144 = (let _140_2143 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _140_2142 = (FStar_ToSMT_Term.mkEq (app, body))
in (_140_2143, _140_2142)))
in (FStar_ToSMT_Term.mkImp _140_2144))
in (((app)::[])::[], vars, _140_2145))
in (FStar_ToSMT_Term.mkForall _140_2146))
in (let _140_2148 = (let _140_2147 = (FStar_Util.format1 "Equation for %s" flid.FStar_Ident.str)
in Some (_140_2147))
in (_140_2149, _140_2148)))
in FStar_ToSMT_Term.Assume (_140_2150))
in ((FStar_List.append (FStar_List.append (FStar_List.append decls binder_decls) decls2) ((eqn)::[])), env))
end)))
end))
end))
end
| _50_3043 -> begin
(FStar_All.failwith "Impossible")
end)
end else begin
(

let fuel = (let _140_2151 = (varops.fresh "fuel")
in (_140_2151, FStar_ToSMT_Term.Fuel_sort))
in (

let fuel_tm = (FStar_ToSMT_Term.mkFreeV fuel)
in (

let env0 = env
in (

let _50_3060 = (FStar_All.pipe_right toks (FStar_List.fold_left (fun _50_3049 _50_3054 -> (match ((_50_3049, _50_3054)) with
| ((gtoks, env), (flid, (f, ftok))) -> begin
(

let g = (varops.new_fvar flid)
in (

let gtok = (varops.new_fvar flid)
in (

let env = (let _140_2156 = (let _140_2155 = (FStar_ToSMT_Term.mkApp (g, (fuel_tm)::[]))
in (FStar_All.pipe_left (fun _140_2154 -> Some (_140_2154)) _140_2155))
in (push_free_var env flid gtok _140_2156))
in (((flid, f, ftok, g, gtok))::gtoks, env))))
end)) ([], env)))
in (match (_50_3060) with
| (gtoks, env) -> begin
(

let gtoks = (FStar_List.rev gtoks)
in (

let encode_one_binding = (fun env0 _50_3069 t_norm _50_3078 -> (match ((_50_3069, _50_3078)) with
| ((flid, f, ftok, g, gtok), {FStar_Absyn_Syntax.lbname = _50_3077; FStar_Absyn_Syntax.lbtyp = _50_3075; FStar_Absyn_Syntax.lbeff = _50_3073; FStar_Absyn_Syntax.lbdef = e}) -> begin
(

let _50_3083 = (destruct_bound_function flid t_norm e)
in (match (_50_3083) with
| (binders, body, formals, tres) -> begin
(

let _50_3090 = (encode_binders None binders env)
in (match (_50_3090) with
| (vars, guards, env', binder_decls, _50_3089) -> begin
(

let decl_g = (let _140_2167 = (let _140_2166 = (let _140_2165 = (FStar_List.map Prims.snd vars)
in (FStar_ToSMT_Term.Fuel_sort)::_140_2165)
in (g, _140_2166, FStar_ToSMT_Term.Term_sort, Some ("Fuel-instrumented function name")))
in FStar_ToSMT_Term.DeclFun (_140_2167))
in (

let env0 = (push_zfuel_name env0 flid g)
in (

let decl_g_tok = FStar_ToSMT_Term.DeclFun ((gtok, [], FStar_ToSMT_Term.Term_sort, Some ("Token for fuel-instrumented partial applications")))
in (

let vars_tm = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let app = (FStar_ToSMT_Term.mkApp (f, vars_tm))
in (

let gsapp = (let _140_2170 = (let _140_2169 = (let _140_2168 = (FStar_ToSMT_Term.mkApp ("SFuel", (fuel_tm)::[]))
in (_140_2168)::vars_tm)
in (g, _140_2169))
in (FStar_ToSMT_Term.mkApp _140_2170))
in (

let gmax = (let _140_2173 = (let _140_2172 = (let _140_2171 = (FStar_ToSMT_Term.mkApp ("MaxFuel", []))
in (_140_2171)::vars_tm)
in (g, _140_2172))
in (FStar_ToSMT_Term.mkApp _140_2173))
in (

let _50_3100 = (encode_exp body env')
in (match (_50_3100) with
| (body_tm, decls2) -> begin
(

let eqn_g = (let _140_2182 = (let _140_2181 = (let _140_2178 = (let _140_2177 = (let _140_2176 = (let _140_2175 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _140_2174 = (FStar_ToSMT_Term.mkEq (gsapp, body_tm))
in (_140_2175, _140_2174)))
in (FStar_ToSMT_Term.mkImp _140_2176))
in (((gsapp)::[])::[], (fuel)::vars, _140_2177))
in (FStar_ToSMT_Term.mkForall _140_2178))
in (let _140_2180 = (let _140_2179 = (FStar_Util.format1 "Equation for fuel-instrumented recursive function: %s" flid.FStar_Ident.str)
in Some (_140_2179))
in (_140_2181, _140_2180)))
in FStar_ToSMT_Term.Assume (_140_2182))
in (

let eqn_f = (let _140_2186 = (let _140_2185 = (let _140_2184 = (let _140_2183 = (FStar_ToSMT_Term.mkEq (app, gmax))
in (((app)::[])::[], vars, _140_2183))
in (FStar_ToSMT_Term.mkForall _140_2184))
in (_140_2185, Some ("Correspondence of recursive function to instrumented version")))
in FStar_ToSMT_Term.Assume (_140_2186))
in (

let eqn_g' = (let _140_2195 = (let _140_2194 = (let _140_2193 = (let _140_2192 = (let _140_2191 = (let _140_2190 = (let _140_2189 = (let _140_2188 = (let _140_2187 = (FStar_ToSMT_Term.n_fuel 0)
in (_140_2187)::vars_tm)
in (g, _140_2188))
in (FStar_ToSMT_Term.mkApp _140_2189))
in (gsapp, _140_2190))
in (FStar_ToSMT_Term.mkEq _140_2191))
in (((gsapp)::[])::[], (fuel)::vars, _140_2192))
in (FStar_ToSMT_Term.mkForall _140_2193))
in (_140_2194, Some ("Fuel irrelevance")))
in FStar_ToSMT_Term.Assume (_140_2195))
in (

let _50_3123 = (

let _50_3110 = (encode_binders None formals env0)
in (match (_50_3110) with
| (vars, v_guards, env, binder_decls, _50_3109) -> begin
(

let vars_tm = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let gapp = (FStar_ToSMT_Term.mkApp (g, (fuel_tm)::vars_tm))
in (

let tok_corr = (

let tok_app = (let _140_2196 = (FStar_ToSMT_Term.mkFreeV (gtok, FStar_ToSMT_Term.Term_sort))
in (mk_ApplyE _140_2196 ((fuel)::vars)))
in (let _140_2200 = (let _140_2199 = (let _140_2198 = (let _140_2197 = (FStar_ToSMT_Term.mkEq (tok_app, gapp))
in (((tok_app)::[])::[], (fuel)::vars, _140_2197))
in (FStar_ToSMT_Term.mkForall _140_2198))
in (_140_2199, Some ("Fuel token correspondence")))
in FStar_ToSMT_Term.Assume (_140_2200)))
in (

let _50_3120 = (

let _50_3117 = (encode_typ_pred None tres env gapp)
in (match (_50_3117) with
| (g_typing, d3) -> begin
(let _140_2208 = (let _140_2207 = (let _140_2206 = (let _140_2205 = (let _140_2204 = (let _140_2203 = (let _140_2202 = (let _140_2201 = (FStar_ToSMT_Term.mk_and_l v_guards)
in (_140_2201, g_typing))
in (FStar_ToSMT_Term.mkImp _140_2202))
in (((gapp)::[])::[], (fuel)::vars, _140_2203))
in (FStar_ToSMT_Term.mkForall _140_2204))
in (_140_2205, None))
in FStar_ToSMT_Term.Assume (_140_2206))
in (_140_2207)::[])
in (d3, _140_2208))
end))
in (match (_50_3120) with
| (aux_decls, typing_corr) -> begin
((FStar_List.append binder_decls aux_decls), (FStar_List.append typing_corr ((tok_corr)::[])))
end)))))
end))
in (match (_50_3123) with
| (aux_decls, g_typing) -> begin
((FStar_List.append (FStar_List.append (FStar_List.append binder_decls decls2) aux_decls) ((decl_g)::(decl_g_tok)::[])), (FStar_List.append ((eqn_g)::(eqn_g')::(eqn_f)::[]) g_typing), env0)
end)))))
end)))))))))
end))
end))
end))
in (

let _50_3139 = (let _140_2211 = (FStar_List.zip3 gtoks typs bindings)
in (FStar_List.fold_left (fun _50_3127 _50_3131 -> (match ((_50_3127, _50_3131)) with
| ((decls, eqns, env0), (gtok, ty, bs)) -> begin
(

let _50_3135 = (encode_one_binding env0 gtok ty bs)
in (match (_50_3135) with
| (decls', eqns', env0) -> begin
((decls')::decls, (FStar_List.append eqns' eqns), env0)
end))
end)) ((decls)::[], [], env0) _140_2211))
in (match (_50_3139) with
| (decls, eqns, env0) -> begin
(

let _50_3148 = (let _140_2213 = (FStar_All.pipe_right decls FStar_List.flatten)
in (FStar_All.pipe_right _140_2213 (FStar_List.partition (fun _50_29 -> (match (_50_29) with
| FStar_ToSMT_Term.DeclFun (_50_3142) -> begin
true
end
| _50_3145 -> begin
false
end)))))
in (match (_50_3148) with
| (prefix_decls, rest) -> begin
(

let eqns = (FStar_List.rev eqns)
in ((FStar_List.append (FStar_List.append prefix_decls rest) eqns), env0))
end))
end))))
end)))))
end
end)))
end))
end
end)
with
| Let_rec_unencodeable -> begin
(

let msg = (let _140_2216 = (FStar_All.pipe_right bindings (FStar_List.map (fun lb -> (FStar_Absyn_Print.lbname_to_string lb.FStar_Absyn_Syntax.lbname))))
in (FStar_All.pipe_right _140_2216 (FStar_String.concat " and ")))
in (

let decl = FStar_ToSMT_Term.Caption ((Prims.strcat "let rec unencodeable: Skipping: " msg))
in ((decl)::[], env)))
end))
end
| (FStar_Absyn_Syntax.Sig_pragma (_)) | (FStar_Absyn_Syntax.Sig_main (_)) | (FStar_Absyn_Syntax.Sig_new_effect (_)) | (FStar_Absyn_Syntax.Sig_effect_abbrev (_)) | (FStar_Absyn_Syntax.Sig_kind_abbrev (_)) | (FStar_Absyn_Syntax.Sig_sub_effect (_)) -> begin
([], env)
end)))))
and declare_top_level_let : env_t  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  ((Prims.string * FStar_ToSMT_Term.term Prims.option) * FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env x t t_norm -> (match ((try_lookup_lid env x)) with
| None -> begin
(

let _50_3175 = (encode_free_var env x t t_norm [])
in (match (_50_3175) with
| (decls, env) -> begin
(

let _50_3180 = (lookup_lid env x)
in (match (_50_3180) with
| (n, x', _50_3179) -> begin
((n, x'), decls, env)
end))
end))
end
| Some (n, x, _50_3184) -> begin
((n, x), [], env)
end))
and encode_smt_lemma : env_t  ->  FStar_Ident.lident  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_ToSMT_Term.decl Prims.list = (fun env lid t -> (

let _50_3192 = (encode_function_type_as_formula None None t env)
in (match (_50_3192) with
| (form, decls) -> begin
(FStar_List.append decls ((FStar_ToSMT_Term.Assume ((form, Some ((Prims.strcat "Lemma: " lid.FStar_Ident.str)))))::[]))
end)))
and encode_free_var : env_t  ->  FStar_Ident.lident  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_Absyn_Syntax.qualifier Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env lid tt t_norm quals -> if ((let _140_2229 = (FStar_Absyn_Util.is_pure_or_ghost_function t_norm)
in (FStar_All.pipe_left Prims.op_Negation _140_2229)) || (FStar_Absyn_Util.is_lemma t_norm)) then begin
(

let _50_3201 = (new_term_constant_and_tok_from_lid env lid)
in (match (_50_3201) with
| (vname, vtok, env) -> begin
(

let arg_sorts = (match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (binders, _50_3204) -> begin
(FStar_All.pipe_right binders (FStar_List.map (fun _50_30 -> (match (_50_30) with
| (FStar_Util.Inl (_50_3209), _50_3212) -> begin
FStar_ToSMT_Term.Type_sort
end
| _50_3215 -> begin
FStar_ToSMT_Term.Term_sort
end))))
end
| _50_3217 -> begin
[]
end)
in (

let d = FStar_ToSMT_Term.DeclFun ((vname, arg_sorts, FStar_ToSMT_Term.Term_sort, Some ("Uninterpreted function symbol for impure function")))
in (

let dd = FStar_ToSMT_Term.DeclFun ((vtok, [], FStar_ToSMT_Term.Term_sort, Some ("Uninterpreted name for impure function")))
in ((d)::(dd)::[], env))))
end))
end else begin
if (prims.is lid) then begin
(

let vname = (varops.new_fvar lid)
in (

let definition = (prims.mk lid vname)
in (

let env = (push_free_var env lid vname None)
in (definition, env))))
end else begin
(

let encode_non_total_function_typ = (lid.FStar_Ident.nsstr <> "Prims")
in (

let _50_3234 = (match ((FStar_Absyn_Util.function_formals t_norm)) with
| Some (args, comp) -> begin
if encode_non_total_function_typ then begin
(let _140_2231 = (FStar_Tc_Util.pure_or_ghost_pre_and_post env.tcenv comp)
in (args, _140_2231))
end else begin
(args, (None, (FStar_Absyn_Util.comp_result comp)))
end
end
| None -> begin
([], (None, t_norm))
end)
in (match (_50_3234) with
| (formals, (pre_opt, res_t)) -> begin
(

let _50_3238 = (new_term_constant_and_tok_from_lid env lid)
in (match (_50_3238) with
| (vname, vtok, env) -> begin
(

let vtok_tm = (match (formals) with
| [] -> begin
(FStar_ToSMT_Term.mkFreeV (vname, FStar_ToSMT_Term.Term_sort))
end
| _50_3241 -> begin
(FStar_ToSMT_Term.mkApp (vtok, []))
end)
in (

let mk_disc_proj_axioms = (fun guard encoded_res_t vapp vars -> (FStar_All.pipe_right quals (FStar_List.collect (fun _50_31 -> (match (_50_31) with
| FStar_Absyn_Syntax.Discriminator (d) -> begin
(

let _50_3257 = (FStar_Util.prefix vars)
in (match (_50_3257) with
| (_50_3252, (xxsym, _50_3255)) -> begin
(

let xx = (FStar_ToSMT_Term.mkFreeV (xxsym, FStar_ToSMT_Term.Term_sort))
in (let _140_2248 = (let _140_2247 = (let _140_2246 = (let _140_2245 = (let _140_2244 = (let _140_2243 = (let _140_2242 = (let _140_2241 = (FStar_ToSMT_Term.mk_tester (escape d.FStar_Ident.str) xx)
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _140_2241))
in (vapp, _140_2242))
in (FStar_ToSMT_Term.mkEq _140_2243))
in (((vapp)::[])::[], vars, _140_2244))
in (FStar_ToSMT_Term.mkForall _140_2245))
in (_140_2246, Some ("Discriminator equation")))
in FStar_ToSMT_Term.Assume (_140_2247))
in (_140_2248)::[]))
end))
end
| FStar_Absyn_Syntax.Projector (d, FStar_Util.Inr (f)) -> begin
(

let _50_3270 = (FStar_Util.prefix vars)
in (match (_50_3270) with
| (_50_3265, (xxsym, _50_3268)) -> begin
(

let xx = (FStar_ToSMT_Term.mkFreeV (xxsym, FStar_ToSMT_Term.Term_sort))
in (

let prim_app = (let _140_2250 = (let _140_2249 = (mk_term_projector_name d f)
in (_140_2249, (xx)::[]))
in (FStar_ToSMT_Term.mkApp _140_2250))
in (let _140_2255 = (let _140_2254 = (let _140_2253 = (let _140_2252 = (let _140_2251 = (FStar_ToSMT_Term.mkEq (vapp, prim_app))
in (((vapp)::[])::[], vars, _140_2251))
in (FStar_ToSMT_Term.mkForall _140_2252))
in (_140_2253, Some ("Projector equation")))
in FStar_ToSMT_Term.Assume (_140_2254))
in (_140_2255)::[])))
end))
end
| _50_3274 -> begin
[]
end)))))
in (

let _50_3281 = (encode_binders None formals env)
in (match (_50_3281) with
| (vars, guards, env', decls1, _50_3280) -> begin
(

let _50_3290 = (match (pre_opt) with
| None -> begin
(let _140_2256 = (FStar_ToSMT_Term.mk_and_l guards)
in (_140_2256, decls1))
end
| Some (p) -> begin
(

let _50_3287 = (encode_formula p env')
in (match (_50_3287) with
| (g, ds) -> begin
(let _140_2257 = (FStar_ToSMT_Term.mk_and_l ((g)::guards))
in (_140_2257, (FStar_List.append decls1 ds)))
end))
end)
in (match (_50_3290) with
| (guard, decls1) -> begin
(

let vtok_app = (mk_ApplyE vtok_tm vars)
in (

let vapp = (let _140_2259 = (let _140_2258 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (vname, _140_2258))
in (FStar_ToSMT_Term.mkApp _140_2259))
in (

let _50_3321 = (

let vname_decl = (let _140_2262 = (let _140_2261 = (FStar_All.pipe_right formals (FStar_List.map (fun _50_32 -> (match (_50_32) with
| (FStar_Util.Inl (_50_3295), _50_3298) -> begin
FStar_ToSMT_Term.Type_sort
end
| _50_3301 -> begin
FStar_ToSMT_Term.Term_sort
end))))
in (vname, _140_2261, FStar_ToSMT_Term.Term_sort, None))
in FStar_ToSMT_Term.DeclFun (_140_2262))
in (

let _50_3308 = (

let env = (

let _50_3303 = env
in {bindings = _50_3303.bindings; depth = _50_3303.depth; tcenv = _50_3303.tcenv; warn = _50_3303.warn; cache = _50_3303.cache; nolabels = _50_3303.nolabels; use_zfuel_name = _50_3303.use_zfuel_name; encode_non_total_function_typ = encode_non_total_function_typ})
in if (not ((head_normal env tt))) then begin
(encode_typ_pred None tt env vtok_tm)
end else begin
(encode_typ_pred None t_norm env vtok_tm)
end)
in (match (_50_3308) with
| (tok_typing, decls2) -> begin
(

let tok_typing = FStar_ToSMT_Term.Assume ((tok_typing, Some ("function token typing")))
in (

let _50_3318 = (match (formals) with
| [] -> begin
(let _140_2266 = (let _140_2265 = (let _140_2264 = (FStar_ToSMT_Term.mkFreeV (vname, FStar_ToSMT_Term.Term_sort))
in (FStar_All.pipe_left (fun _140_2263 -> Some (_140_2263)) _140_2264))
in (push_free_var env lid vname _140_2265))
in ((FStar_List.append decls2 ((tok_typing)::[])), _140_2266))
end
| _50_3312 -> begin
(

let vtok_decl = FStar_ToSMT_Term.DeclFun ((vtok, [], FStar_ToSMT_Term.Term_sort, None))
in (

let vtok_fresh = (let _140_2267 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token (vtok, FStar_ToSMT_Term.Term_sort) _140_2267))
in (

let name_tok_corr = (let _140_2271 = (let _140_2270 = (let _140_2269 = (let _140_2268 = (FStar_ToSMT_Term.mkEq (vtok_app, vapp))
in (((vtok_app)::[])::[], vars, _140_2268))
in (FStar_ToSMT_Term.mkForall _140_2269))
in (_140_2270, None))
in FStar_ToSMT_Term.Assume (_140_2271))
in ((FStar_List.append decls2 ((vtok_decl)::(vtok_fresh)::(name_tok_corr)::(tok_typing)::[])), env))))
end)
in (match (_50_3318) with
| (tok_decl, env) -> begin
((vname_decl)::tok_decl, env)
end)))
end)))
in (match (_50_3321) with
| (decls2, env) -> begin
(

let _50_3329 = (

let res_t = (FStar_Absyn_Util.compress_typ res_t)
in (

let _50_3325 = (encode_typ_term res_t env')
in (match (_50_3325) with
| (encoded_res_t, decls) -> begin
(let _140_2272 = (FStar_ToSMT_Term.mk_HasType vapp encoded_res_t)
in (encoded_res_t, _140_2272, decls))
end)))
in (match (_50_3329) with
| (encoded_res_t, ty_pred, decls3) -> begin
(

let typingAx = (let _140_2276 = (let _140_2275 = (let _140_2274 = (let _140_2273 = (FStar_ToSMT_Term.mkImp (guard, ty_pred))
in (((vapp)::[])::[], vars, _140_2273))
in (FStar_ToSMT_Term.mkForall _140_2274))
in (_140_2275, Some ("free var typing")))
in FStar_ToSMT_Term.Assume (_140_2276))
in (

let g = (let _140_2278 = (let _140_2277 = (mk_disc_proj_axioms guard encoded_res_t vapp vars)
in (typingAx)::_140_2277)
in (FStar_List.append (FStar_List.append (FStar_List.append decls1 decls2) decls3) _140_2278))
in (g, env)))
end))
end))))
end))
end))))
end))
end)))
end
end)
and encode_signature : env_t  ->  FStar_Absyn_Syntax.sigelt Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.fold_left (fun _50_3336 se -> (match (_50_3336) with
| (g, env) -> begin
(

let _50_3340 = (encode_sigelt env se)
in (match (_50_3340) with
| (g', env) -> begin
((FStar_List.append g g'), env)
end))
end)) ([], env))))


let encode_env_bindings : env_t  ->  FStar_Tc_Env.binding Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env bindings -> (

let encode_binding = (fun b _50_3347 -> (match (_50_3347) with
| (decls, env) -> begin
(match (b) with
| FStar_Tc_Env.Binding_var (x, t0) -> begin
(

let _50_3355 = (new_term_constant env x)
in (match (_50_3355) with
| (xxsym, xx, env') -> begin
(

let t1 = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.EtaArgs)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t0)
in (

let _50_3357 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _140_2293 = (FStar_Absyn_Print.strBvd x)
in (let _140_2292 = (FStar_Absyn_Print.typ_to_string t0)
in (let _140_2291 = (FStar_Absyn_Print.typ_to_string t1)
in (FStar_Util.print3 "Normalized %s : %s to %s\n" _140_2293 _140_2292 _140_2291))))
end else begin
()
end
in (

let _50_3361 = (encode_typ_pred None t1 env xx)
in (match (_50_3361) with
| (t, decls') -> begin
(

let caption = if (FStar_Options.log_queries ()) then begin
(let _140_2297 = (let _140_2296 = (FStar_Absyn_Print.strBvd x)
in (let _140_2295 = (FStar_Absyn_Print.typ_to_string t0)
in (let _140_2294 = (FStar_Absyn_Print.typ_to_string t1)
in (FStar_Util.format3 "%s : %s (%s)" _140_2296 _140_2295 _140_2294))))
in Some (_140_2297))
end else begin
None
end
in (

let g = (FStar_List.append (FStar_List.append ((FStar_ToSMT_Term.DeclFun ((xxsym, [], FStar_ToSMT_Term.Term_sort, caption)))::[]) decls') ((FStar_ToSMT_Term.Assume ((t, None)))::[]))
in ((FStar_List.append decls g), env')))
end))))
end))
end
| FStar_Tc_Env.Binding_typ (a, k) -> begin
(

let _50_3371 = (new_typ_constant env a)
in (match (_50_3371) with
| (aasym, aa, env') -> begin
(

let _50_3374 = (encode_knd k env aa)
in (match (_50_3374) with
| (k, decls') -> begin
(

let g = (let _140_2303 = (let _140_2302 = (let _140_2301 = (let _140_2300 = (let _140_2299 = (let _140_2298 = (FStar_Absyn_Print.strBvd a)
in Some (_140_2298))
in (aasym, [], FStar_ToSMT_Term.Type_sort, _140_2299))
in FStar_ToSMT_Term.DeclFun (_140_2300))
in (_140_2301)::[])
in (FStar_List.append _140_2302 decls'))
in (FStar_List.append _140_2303 ((FStar_ToSMT_Term.Assume ((k, None)))::[])))
in ((FStar_List.append decls g), env'))
end))
end))
end
| FStar_Tc_Env.Binding_lid (x, t) -> begin
(

let t_norm = (whnf env t)
in (

let _50_3383 = (encode_free_var env x t t_norm [])
in (match (_50_3383) with
| (g, env') -> begin
((FStar_List.append decls g), env')
end)))
end
| FStar_Tc_Env.Binding_sig (se) -> begin
(

let _50_3388 = (encode_sigelt env se)
in (match (_50_3388) with
| (g, env') -> begin
((FStar_List.append decls g), env')
end))
end)
end))
in (FStar_List.fold_right encode_binding bindings ([], env))))


let encode_labels = (fun labs -> (

let prefix = (FStar_All.pipe_right labs (FStar_List.map (fun _50_3395 -> (match (_50_3395) with
| (l, _50_3392, _50_3394) -> begin
FStar_ToSMT_Term.DeclFun (((Prims.fst l), [], FStar_ToSMT_Term.Bool_sort, None))
end))))
in (

let suffix = (FStar_All.pipe_right labs (FStar_List.collect (fun _50_3402 -> (match (_50_3402) with
| (l, _50_3399, _50_3401) -> begin
(let _140_2311 = (FStar_All.pipe_left (fun _140_2307 -> FStar_ToSMT_Term.Echo (_140_2307)) (Prims.fst l))
in (let _140_2310 = (let _140_2309 = (let _140_2308 = (FStar_ToSMT_Term.mkFreeV l)
in FStar_ToSMT_Term.Eval (_140_2308))
in (_140_2309)::[])
in (_140_2311)::_140_2310))
end))))
in (prefix, suffix))))


let last_env : env_t Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let init_env : FStar_Tc_Env.env  ->  Prims.unit = (fun tcenv -> (let _140_2316 = (let _140_2315 = (let _140_2314 = (FStar_Util.smap_create 100)
in {bindings = []; depth = 0; tcenv = tcenv; warn = true; cache = _140_2314; nolabels = false; use_zfuel_name = false; encode_non_total_function_typ = true})
in (_140_2315)::[])
in (FStar_ST.op_Colon_Equals last_env _140_2316)))


let get_env : FStar_Tc_Env.env  ->  env_t = (fun tcenv -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "No env; call init first!")
end
| (e)::_50_3408 -> begin
(

let _50_3411 = e
in {bindings = _50_3411.bindings; depth = _50_3411.depth; tcenv = tcenv; warn = _50_3411.warn; cache = _50_3411.cache; nolabels = _50_3411.nolabels; use_zfuel_name = _50_3411.use_zfuel_name; encode_non_total_function_typ = _50_3411.encode_non_total_function_typ})
end))


let set_env : env_t  ->  Prims.unit = (fun env -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Empty env stack")
end
| (_50_3417)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((env)::tl))
end))


let push_env : Prims.unit  ->  Prims.unit = (fun _50_3419 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Empty env stack")
end
| (hd)::tl -> begin
(

let refs = (FStar_Util.smap_copy hd.cache)
in (

let top = (

let _50_3425 = hd
in {bindings = _50_3425.bindings; depth = _50_3425.depth; tcenv = _50_3425.tcenv; warn = _50_3425.warn; cache = refs; nolabels = _50_3425.nolabels; use_zfuel_name = _50_3425.use_zfuel_name; encode_non_total_function_typ = _50_3425.encode_non_total_function_typ})
in (FStar_ST.op_Colon_Equals last_env ((top)::(hd)::tl))))
end)
end))


let pop_env : Prims.unit  ->  Prims.unit = (fun _50_3428 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Popping an empty stack")
end
| (_50_3432)::tl -> begin
(FStar_ST.op_Colon_Equals last_env tl)
end)
end))


let mark_env : Prims.unit  ->  Prims.unit = (fun _50_3434 -> (match (()) with
| () -> begin
(push_env ())
end))


let reset_mark_env : Prims.unit  ->  Prims.unit = (fun _50_3435 -> (match (()) with
| () -> begin
(pop_env ())
end))


let commit_mark_env : Prims.unit  ->  Prims.unit = (fun _50_3436 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| (hd)::(_50_3439)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((hd)::tl))
end
| _50_3444 -> begin
(FStar_All.failwith "Impossible")
end)
end))


let init : FStar_Tc_Env.env  ->  Prims.unit = (fun tcenv -> (

let _50_3446 = (init_env tcenv)
in (

let _50_3448 = (FStar_ToSMT_Z3.init ())
in (FStar_ToSMT_Z3.giveZ3 ((FStar_ToSMT_Term.DefPrelude)::[])))))


let push : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3451 = (push_env ())
in (

let _50_3453 = (varops.push ())
in (FStar_ToSMT_Z3.push msg))))


let pop : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3456 = (let _140_2337 = (pop_env ())
in (FStar_All.pipe_left Prims.ignore _140_2337))
in (

let _50_3458 = (varops.pop ())
in (FStar_ToSMT_Z3.pop msg))))


let mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3461 = (mark_env ())
in (

let _50_3463 = (varops.mark ())
in (FStar_ToSMT_Z3.mark msg))))


let reset_mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3466 = (reset_mark_env ())
in (

let _50_3468 = (varops.reset_mark ())
in (FStar_ToSMT_Z3.reset_mark msg))))


let commit_mark = (fun msg -> (

let _50_3471 = (commit_mark_env ())
in (

let _50_3473 = (varops.commit_mark ())
in (FStar_ToSMT_Z3.commit_mark msg))))


let encode_sig : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.sigelt  ->  Prims.unit = (fun tcenv se -> (

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(let _140_2351 = (let _140_2350 = (let _140_2349 = (FStar_Absyn_Print.sigelt_to_string_short se)
in (Prims.strcat "encoding sigelt " _140_2349))
in FStar_ToSMT_Term.Caption (_140_2350))
in (_140_2351)::decls)
end else begin
decls
end)
in (

let env = (get_env tcenv)
in (

let _50_3482 = (encode_sigelt env se)
in (match (_50_3482) with
| (decls, env) -> begin
(

let _50_3483 = (set_env env)
in (let _140_2352 = (caption decls)
in (FStar_ToSMT_Z3.giveZ3 _140_2352)))
end)))))


let encode_modul : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.modul  ->  Prims.unit = (fun tcenv modul -> (

let name = (FStar_Util.format2 "%s %s" (if modul.FStar_Absyn_Syntax.is_interface then begin
"interface"
end else begin
"module"
end) modul.FStar_Absyn_Syntax.name.FStar_Ident.str)
in (

let _50_3488 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(let _140_2357 = (FStar_All.pipe_right (FStar_List.length modul.FStar_Absyn_Syntax.exports) FStar_Util.string_of_int)
in (FStar_Util.print2 "Encoding externals for %s ... %s exports\n" name _140_2357))
end else begin
()
end
in (

let env = (get_env tcenv)
in (

let _50_3495 = (encode_signature (

let _50_3491 = env
in {bindings = _50_3491.bindings; depth = _50_3491.depth; tcenv = _50_3491.tcenv; warn = false; cache = _50_3491.cache; nolabels = _50_3491.nolabels; use_zfuel_name = _50_3491.use_zfuel_name; encode_non_total_function_typ = _50_3491.encode_non_total_function_typ}) modul.FStar_Absyn_Syntax.exports)
in (match (_50_3495) with
| (decls, env) -> begin
(

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(

let msg = (Prims.strcat "Externals for " name)
in (FStar_List.append ((FStar_ToSMT_Term.Caption (msg))::decls) ((FStar_ToSMT_Term.Caption ((Prims.strcat "End " msg)))::[])))
end else begin
decls
end)
in (

let _50_3501 = (set_env (

let _50_3499 = env
in {bindings = _50_3499.bindings; depth = _50_3499.depth; tcenv = _50_3499.tcenv; warn = true; cache = _50_3499.cache; nolabels = _50_3499.nolabels; use_zfuel_name = _50_3499.use_zfuel_name; encode_non_total_function_typ = _50_3499.encode_non_total_function_typ}))
in (

let _50_3503 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(FStar_Util.print1 "Done encoding externals for %s\n" name)
end else begin
()
end
in (

let decls = (caption decls)
in (FStar_ToSMT_Z3.giveZ3 decls)))))
end))))))


let solve : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  Prims.unit = (fun tcenv q -> (

let _50_3508 = (let _140_2366 = (let _140_2365 = (let _140_2364 = (FStar_Tc_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _140_2364))
in (FStar_Util.format1 "Starting query at %s" _140_2365))
in (push _140_2366))
in (

let pop = (fun _50_3511 -> (match (()) with
| () -> begin
(let _140_2371 = (let _140_2370 = (let _140_2369 = (FStar_Tc_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _140_2369))
in (FStar_Util.format1 "Ending query at %s" _140_2370))
in (pop _140_2371))
end))
in (

let _50_3570 = (

let env = (get_env tcenv)
in (

let bindings = (FStar_Tc_Env.fold_env tcenv (fun bs b -> (b)::bs) [])
in (

let _50_3544 = (

let rec aux = (fun bindings -> (match (bindings) with
| (FStar_Tc_Env.Binding_var (x, t))::rest -> begin
(

let _50_3526 = (aux rest)
in (match (_50_3526) with
| (out, rest) -> begin
(

let t = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.EtaArgs)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t)
in (let _140_2377 = (let _140_2376 = (FStar_Absyn_Syntax.v_binder (FStar_Absyn_Util.bvd_to_bvar_s x t))
in (_140_2376)::out)
in (_140_2377, rest)))
end))
end
| (FStar_Tc_Env.Binding_typ (a, k))::rest -> begin
(

let _50_3536 = (aux rest)
in (match (_50_3536) with
| (out, rest) -> begin
(let _140_2379 = (let _140_2378 = (FStar_Absyn_Syntax.t_binder (FStar_Absyn_Util.bvd_to_bvar_s a k))
in (_140_2378)::out)
in (_140_2379, rest))
end))
end
| _50_3538 -> begin
([], bindings)
end))
in (

let _50_3541 = (aux bindings)
in (match (_50_3541) with
| (closing, bindings) -> begin
(let _140_2380 = (FStar_Absyn_Util.close_forall (FStar_List.rev closing) q)
in (_140_2380, bindings))
end)))
in (match (_50_3544) with
| (q, bindings) -> begin
(

let _50_3553 = (let _140_2382 = (FStar_List.filter (fun _50_33 -> (match (_50_33) with
| FStar_Tc_Env.Binding_sig (_50_3547) -> begin
false
end
| _50_3550 -> begin
true
end)) bindings)
in (encode_env_bindings env _140_2382))
in (match (_50_3553) with
| (env_decls, env) -> begin
(

let _50_3554 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(let _140_2383 = (FStar_Absyn_Print.formula_to_string q)
in (FStar_Util.print1 "Encoding query formula: %s\n" _140_2383))
end else begin
()
end
in (

let _50_3559 = (encode_formula_with_labels q env)
in (match (_50_3559) with
| (phi, labels, qdecls) -> begin
(

let _50_3562 = (encode_labels labels)
in (match (_50_3562) with
| (label_prefix, label_suffix) -> begin
(

let query_prelude = (FStar_List.append (FStar_List.append env_decls label_prefix) qdecls)
in (

let qry = (let _140_2385 = (let _140_2384 = (FStar_ToSMT_Term.mkNot phi)
in (_140_2384, Some ("query")))
in FStar_ToSMT_Term.Assume (_140_2385))
in (

let suffix = (FStar_List.append label_suffix ((FStar_ToSMT_Term.Echo ("Done!"))::[]))
in (query_prelude, labels, qry, suffix))))
end))
end)))
end))
end))))
in (match (_50_3570) with
| (prefix, labels, qry, suffix) -> begin
(match (qry) with
| FStar_ToSMT_Term.Assume ({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.App (FStar_ToSMT_Term.False, _50_3577); FStar_ToSMT_Term.hash = _50_3574; FStar_ToSMT_Term.freevars = _50_3572}, _50_3582) -> begin
(

let _50_3585 = (pop ())
in ())
end
| _50_3588 when tcenv.FStar_Tc_Env.admit -> begin
(

let _50_3589 = (pop ())
in ())
end
| FStar_ToSMT_Term.Assume (q, _50_3593) -> begin
(

let fresh = ((FStar_String.length q.FStar_ToSMT_Term.hash) >= 2048)
in (

let _50_3597 = (FStar_ToSMT_Z3.giveZ3 prefix)
in (

let with_fuel = (fun p _50_3603 -> (match (_50_3603) with
| (n, i) -> begin
(let _140_2408 = (let _140_2407 = (let _140_2392 = (let _140_2391 = (FStar_Util.string_of_int n)
in (let _140_2390 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "<fuel=\'%s\' ifuel=\'%s\'>" _140_2391 _140_2390)))
in FStar_ToSMT_Term.Caption (_140_2392))
in (let _140_2406 = (let _140_2405 = (let _140_2397 = (let _140_2396 = (let _140_2395 = (let _140_2394 = (FStar_ToSMT_Term.mkApp ("MaxFuel", []))
in (let _140_2393 = (FStar_ToSMT_Term.n_fuel n)
in (_140_2394, _140_2393)))
in (FStar_ToSMT_Term.mkEq _140_2395))
in (_140_2396, None))
in FStar_ToSMT_Term.Assume (_140_2397))
in (let _140_2404 = (let _140_2403 = (let _140_2402 = (let _140_2401 = (let _140_2400 = (let _140_2399 = (FStar_ToSMT_Term.mkApp ("MaxIFuel", []))
in (let _140_2398 = (FStar_ToSMT_Term.n_fuel i)
in (_140_2399, _140_2398)))
in (FStar_ToSMT_Term.mkEq _140_2400))
in (_140_2401, None))
in FStar_ToSMT_Term.Assume (_140_2402))
in (_140_2403)::(p)::(FStar_ToSMT_Term.CheckSat)::[])
in (_140_2405)::_140_2404))
in (_140_2407)::_140_2406))
in (FStar_List.append _140_2408 suffix))
end))
in (

let check = (fun p -> (

let initial_config = (let _140_2412 = (FStar_Options.initial_fuel ())
in (let _140_2411 = (FStar_Options.initial_ifuel ())
in (_140_2412, _140_2411)))
in (

let alt_configs = (let _140_2431 = (let _140_2430 = if ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ())) then begin
(let _140_2415 = (let _140_2414 = (FStar_Options.initial_fuel ())
in (let _140_2413 = (FStar_Options.max_ifuel ())
in (_140_2414, _140_2413)))
in (_140_2415)::[])
end else begin
[]
end
in (let _140_2429 = (let _140_2428 = if (((FStar_Options.max_fuel ()) / 2) > (FStar_Options.initial_fuel ())) then begin
(let _140_2418 = (let _140_2417 = ((FStar_Options.max_fuel ()) / 2)
in (let _140_2416 = (FStar_Options.max_ifuel ())
in (_140_2417, _140_2416)))
in (_140_2418)::[])
end else begin
[]
end
in (let _140_2427 = (let _140_2426 = if (((FStar_Options.max_fuel ()) > (FStar_Options.initial_fuel ())) && ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ()))) then begin
(let _140_2421 = (let _140_2420 = (FStar_Options.max_fuel ())
in (let _140_2419 = (FStar_Options.max_ifuel ())
in (_140_2420, _140_2419)))
in (_140_2421)::[])
end else begin
[]
end
in (let _140_2425 = (let _140_2424 = if ((FStar_Options.min_fuel ()) < (FStar_Options.initial_fuel ())) then begin
(let _140_2423 = (let _140_2422 = (FStar_Options.min_fuel ())
in (_140_2422, 1))
in (_140_2423)::[])
end else begin
[]
end
in (_140_2424)::[])
in (_140_2426)::_140_2425))
in (_140_2428)::_140_2427))
in (_140_2430)::_140_2429))
in (FStar_List.flatten _140_2431))
in (

let report = (fun errs -> (

let errs = (match (errs) with
| [] -> begin
(("Unknown assertion failed", FStar_Absyn_Syntax.dummyRange))::[]
end
| _50_3612 -> begin
errs
end)
in (

let _50_3614 = if ((FStar_Options.print_fuels ()) || (FStar_Options.hint_info ())) then begin
(let _140_2439 = (let _140_2434 = (FStar_Tc_Env.get_range tcenv)
in (FStar_Range.string_of_range _140_2434))
in (let _140_2438 = (let _140_2435 = (FStar_Options.max_fuel ())
in (FStar_All.pipe_right _140_2435 FStar_Util.string_of_int))
in (let _140_2437 = (let _140_2436 = (FStar_Options.max_ifuel ())
in (FStar_All.pipe_right _140_2436 FStar_Util.string_of_int))
in (FStar_Util.print3 "(%s) Query failed with maximum fuel %s and ifuel %s\n" _140_2439 _140_2438 _140_2437))))
end else begin
()
end
in (FStar_Tc_Errors.add_errors tcenv errs))))
in (

let rec try_alt_configs = (fun p errs _50_34 -> (match (_50_34) with
| [] -> begin
(report errs)
end
| (mi)::[] -> begin
(match (errs) with
| [] -> begin
(let _140_2450 = (with_fuel p mi)
in (FStar_ToSMT_Z3.ask fresh labels _140_2450 (cb mi p [])))
end
| _50_3626 -> begin
(report errs)
end)
end
| (mi)::tl -> begin
(let _140_2452 = (with_fuel p mi)
in (FStar_ToSMT_Z3.ask fresh labels _140_2452 (fun _50_3632 -> (match (_50_3632) with
| (ok, errs') -> begin
(match (errs) with
| [] -> begin
(cb mi p tl (ok, errs'))
end
| _50_3635 -> begin
(cb mi p tl (ok, errs))
end)
end))))
end))
and cb = (fun _50_3638 p alt _50_3643 -> (match ((_50_3638, _50_3643)) with
| ((prev_fuel, prev_ifuel), (ok, errs)) -> begin
if ok then begin
if ((FStar_Options.print_fuels ()) || (FStar_Options.hint_info ())) then begin
(let _140_2460 = (let _140_2457 = (FStar_Tc_Env.get_range tcenv)
in (FStar_Range.string_of_range _140_2457))
in (let _140_2459 = (FStar_Util.string_of_int prev_fuel)
in (let _140_2458 = (FStar_Util.string_of_int prev_ifuel)
in (FStar_Util.print3 "(%s) Query succeeded with fuel %s and ifuel %s\n" _140_2460 _140_2459 _140_2458))))
end else begin
()
end
end else begin
(try_alt_configs p errs alt)
end
end))
in (let _140_2461 = (with_fuel p initial_config)
in (FStar_ToSMT_Z3.ask fresh labels _140_2461 (cb initial_config p alt_configs))))))))
in (

let process_query = (fun q -> if ((FStar_Options.split_cases ()) > 0) then begin
(

let _50_3648 = (let _140_2467 = (FStar_Options.split_cases ())
in (FStar_ToSMT_SplitQueryCases.can_handle_query _140_2467 q))
in (match (_50_3648) with
| (b, cb) -> begin
if b then begin
(FStar_ToSMT_SplitQueryCases.handle_query cb check)
end else begin
(check q)
end
end))
end else begin
(check q)
end)
in (

let _50_3649 = if (FStar_Options.admit_smt_queries ()) then begin
()
end else begin
(process_query qry)
end
in (pop ())))))))
end)
end)))))


let is_trivial : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  Prims.bool = (fun tcenv q -> (

let env = (get_env tcenv)
in (

let _50_3654 = (push "query")
in (

let _50_3661 = (encode_formula_with_labels q env)
in (match (_50_3661) with
| (f, _50_3658, _50_3660) -> begin
(

let _50_3662 = (pop "query")
in (match (f.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.True, _50_3666) -> begin
true
end
| _50_3670 -> begin
false
end))
end)))))


let solver : FStar_Tc_Env.solver_t = {FStar_Tc_Env.init = init; FStar_Tc_Env.push = push; FStar_Tc_Env.pop = pop; FStar_Tc_Env.mark = mark; FStar_Tc_Env.reset_mark = reset_mark; FStar_Tc_Env.commit_mark = commit_mark; FStar_Tc_Env.encode_modul = encode_modul; FStar_Tc_Env.encode_sig = encode_sig; FStar_Tc_Env.solve = solve; FStar_Tc_Env.is_trivial = is_trivial; FStar_Tc_Env.finish = FStar_ToSMT_Z3.finish; FStar_Tc_Env.refresh = FStar_ToSMT_Z3.refresh}


let dummy : FStar_Tc_Env.solver_t = {FStar_Tc_Env.init = (fun _50_3671 -> ()); FStar_Tc_Env.push = (fun _50_3673 -> ()); FStar_Tc_Env.pop = (fun _50_3675 -> ()); FStar_Tc_Env.mark = (fun _50_3677 -> ()); FStar_Tc_Env.reset_mark = (fun _50_3679 -> ()); FStar_Tc_Env.commit_mark = (fun _50_3681 -> ()); FStar_Tc_Env.encode_modul = (fun _50_3683 _50_3685 -> ()); FStar_Tc_Env.encode_sig = (fun _50_3687 _50_3689 -> ()); FStar_Tc_Env.solve = (fun _50_3691 _50_3693 -> ()); FStar_Tc_Env.is_trivial = (fun _50_3695 _50_3697 -> false); FStar_Tc_Env.finish = (fun _50_3699 -> ()); FStar_Tc_Env.refresh = (fun _50_3700 -> ())}




