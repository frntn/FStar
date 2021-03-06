
open Prims

let add_fuel = (fun x tl -> if (FStar_Options.unthrottle_inductives ()) then begin
tl
end else begin
(x)::tl
end)


let withenv = (fun c _83_28 -> (match (_83_28) with
| (a, b) -> begin
(a, b, c)
end))


let vargs = (fun args -> (FStar_List.filter (fun _83_1 -> (match (_83_1) with
| (FStar_Util.Inl (_83_32), _83_35) -> begin
false
end
| _83_38 -> begin
true
end)) args))


let subst_lcomp_opt = (fun s l -> (match (l) with
| Some (FStar_Util.Inl (l)) -> begin
(let _173_12 = (let _173_11 = (let _173_10 = (let _173_9 = (l.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Subst.subst_comp s _173_9))
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _173_10))
in FStar_Util.Inl (_173_11))
in Some (_173_12))
end
| _83_45 -> begin
l
end))


let escape : Prims.string  ->  Prims.string = (fun s -> (FStar_Util.replace_char s '\'' '_'))


let mk_term_projector_name : FStar_Ident.lident  ->  FStar_Syntax_Syntax.bv  ->  Prims.string = (fun lid a -> (

let a = (

let _83_49 = a
in (let _173_19 = (FStar_Syntax_Util.unmangle_field_name a.FStar_Syntax_Syntax.ppname)
in {FStar_Syntax_Syntax.ppname = _173_19; FStar_Syntax_Syntax.index = _83_49.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _83_49.FStar_Syntax_Syntax.sort}))
in (let _173_20 = (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str a.FStar_Syntax_Syntax.ppname.FStar_Ident.idText)
in (FStar_All.pipe_left escape _173_20))))


let primitive_projector_by_pos : FStar_TypeChecker_Env.env  ->  FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun env lid i -> (

let fail = (fun _83_56 -> (match (()) with
| () -> begin
(let _173_30 = (let _173_29 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "Projector %s on data constructor %s not found" _173_29 lid.FStar_Ident.str))
in (FStar_All.failwith _173_30))
end))
in (

let _83_60 = (FStar_TypeChecker_Env.lookup_datacon env lid)
in (match (_83_60) with
| (_83_58, t) -> begin
(match ((let _173_31 = (FStar_Syntax_Subst.compress t)
in _173_31.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let _83_68 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_83_68) with
| (binders, _83_67) -> begin
if ((i < 0) || (i >= (FStar_List.length binders))) then begin
(fail ())
end else begin
(

let b = (FStar_List.nth binders i)
in (mk_term_projector_name lid (Prims.fst b)))
end
end))
end
| _83_71 -> begin
(fail ())
end)
end))))


let mk_term_projector_name_by_pos : FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun lid i -> (let _173_37 = (let _173_36 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str _173_36))
in (FStar_All.pipe_left escape _173_37)))


let mk_term_projector : FStar_Ident.lident  ->  FStar_Syntax_Syntax.bv  ->  FStar_SMTEncoding_Term.term = (fun lid a -> (let _173_43 = (let _173_42 = (mk_term_projector_name lid a)
in (_173_42, FStar_SMTEncoding_Term.Arrow ((FStar_SMTEncoding_Term.Term_sort, FStar_SMTEncoding_Term.Term_sort))))
in (FStar_SMTEncoding_Term.mkFreeV _173_43)))


let mk_term_projector_by_pos : FStar_Ident.lident  ->  Prims.int  ->  FStar_SMTEncoding_Term.term = (fun lid i -> (let _173_49 = (let _173_48 = (mk_term_projector_name_by_pos lid i)
in (_173_48, FStar_SMTEncoding_Term.Arrow ((FStar_SMTEncoding_Term.Term_sort, FStar_SMTEncoding_Term.Term_sort))))
in (FStar_SMTEncoding_Term.mkFreeV _173_49)))


let mk_data_tester = (fun env l x -> (FStar_SMTEncoding_Term.mk_tester (escape l.FStar_Ident.str) x))


type varops_t =
{push : Prims.unit  ->  Prims.unit; pop : Prims.unit  ->  Prims.unit; mark : Prims.unit  ->  Prims.unit; reset_mark : Prims.unit  ->  Prims.unit; commit_mark : Prims.unit  ->  Prims.unit; new_var : FStar_Ident.ident  ->  Prims.int  ->  Prims.string; new_fvar : FStar_Ident.lident  ->  Prims.string; fresh : Prims.string  ->  Prims.string; string_const : Prims.string  ->  FStar_SMTEncoding_Term.term; next_id : Prims.unit  ->  Prims.int}


let is_Mkvarops_t : varops_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkvarops_t"))))


let varops : varops_t = (

let initial_ctr = 100
in (

let ctr = (FStar_Util.mk_ref initial_ctr)
in (

let new_scope = (fun _83_95 -> (match (()) with
| () -> begin
(let _173_153 = (FStar_Util.smap_create 100)
in (let _173_152 = (FStar_Util.smap_create 100)
in (_173_153, _173_152)))
end))
in (

let scopes = (let _173_155 = (let _173_154 = (new_scope ())
in (_173_154)::[])
in (FStar_Util.mk_ref _173_155))
in (

let mk_unique = (fun y -> (

let y = (escape y)
in (

let y = (match ((let _173_159 = (FStar_ST.read scopes)
in (FStar_Util.find_map _173_159 (fun _83_103 -> (match (_83_103) with
| (names, _83_102) -> begin
(FStar_Util.smap_try_find names y)
end))))) with
| None -> begin
y
end
| Some (_83_106) -> begin
(

let _83_108 = (FStar_Util.incr ctr)
in (let _173_161 = (let _173_160 = (FStar_ST.read ctr)
in (FStar_Util.string_of_int _173_160))
in (Prims.strcat (Prims.strcat y "__") _173_161)))
end)
in (

let top_scope = (let _173_163 = (let _173_162 = (FStar_ST.read scopes)
in (FStar_List.hd _173_162))
in (FStar_All.pipe_left Prims.fst _173_163))
in (

let _83_112 = (FStar_Util.smap_add top_scope y true)
in y)))))
in (

let new_var = (fun pp rn -> (let _173_170 = (let _173_168 = (FStar_All.pipe_left mk_unique pp.FStar_Ident.idText)
in (Prims.strcat _173_168 "__"))
in (let _173_169 = (FStar_Util.string_of_int rn)
in (Prims.strcat _173_170 _173_169))))
in (

let new_fvar = (fun lid -> (mk_unique lid.FStar_Ident.str))
in (

let next_id = (fun _83_120 -> (match (()) with
| () -> begin
(

let _83_121 = (FStar_Util.incr ctr)
in (FStar_ST.read ctr))
end))
in (

let fresh = (fun pfx -> (let _173_178 = (let _173_177 = (next_id ())
in (FStar_All.pipe_left FStar_Util.string_of_int _173_177))
in (FStar_Util.format2 "%s_%s" pfx _173_178)))
in (

let string_const = (fun s -> (match ((let _173_182 = (FStar_ST.read scopes)
in (FStar_Util.find_map _173_182 (fun _83_130 -> (match (_83_130) with
| (_83_128, strings) -> begin
(FStar_Util.smap_try_find strings s)
end))))) with
| Some (f) -> begin
f
end
| None -> begin
(

let id = (next_id ())
in (

let f = (let _173_183 = (FStar_SMTEncoding_Term.mk_String_const id)
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxString _173_183))
in (

let top_scope = (let _173_185 = (let _173_184 = (FStar_ST.read scopes)
in (FStar_List.hd _173_184))
in (FStar_All.pipe_left Prims.snd _173_185))
in (

let _83_137 = (FStar_Util.smap_add top_scope s f)
in f))))
end))
in (

let push = (fun _83_140 -> (match (()) with
| () -> begin
(let _173_190 = (let _173_189 = (new_scope ())
in (let _173_188 = (FStar_ST.read scopes)
in (_173_189)::_173_188))
in (FStar_ST.op_Colon_Equals scopes _173_190))
end))
in (

let pop = (fun _83_142 -> (match (()) with
| () -> begin
(let _173_194 = (let _173_193 = (FStar_ST.read scopes)
in (FStar_List.tl _173_193))
in (FStar_ST.op_Colon_Equals scopes _173_194))
end))
in (

let mark = (fun _83_144 -> (match (()) with
| () -> begin
(push ())
end))
in (

let reset_mark = (fun _83_146 -> (match (()) with
| () -> begin
(pop ())
end))
in (

let commit_mark = (fun _83_148 -> (match (()) with
| () -> begin
(match ((FStar_ST.read scopes)) with
| ((hd1, hd2))::((next1, next2))::tl -> begin
(

let _83_161 = (FStar_Util.smap_fold hd1 (fun key value v -> (FStar_Util.smap_add next1 key value)) ())
in (

let _83_166 = (FStar_Util.smap_fold hd2 (fun key value v -> (FStar_Util.smap_add next2 key value)) ())
in (FStar_ST.op_Colon_Equals scopes (((next1, next2))::tl))))
end
| _83_169 -> begin
(FStar_All.failwith "Impossible")
end)
end))
in {push = push; pop = pop; mark = mark; reset_mark = reset_mark; commit_mark = commit_mark; new_var = new_var; new_fvar = new_fvar; fresh = fresh; string_const = string_const; next_id = next_id})))))))))))))))


let unmangle : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.bv = (fun x -> (

let _83_171 = x
in (let _173_209 = (FStar_Syntax_Util.unmangle_field_name x.FStar_Syntax_Syntax.ppname)
in {FStar_Syntax_Syntax.ppname = _173_209; FStar_Syntax_Syntax.index = _83_171.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _83_171.FStar_Syntax_Syntax.sort})))


type binding =
| Binding_var of (FStar_Syntax_Syntax.bv * FStar_SMTEncoding_Term.term)
| Binding_fvar of (FStar_Ident.lident * Prims.string * FStar_SMTEncoding_Term.term Prims.option * FStar_SMTEncoding_Term.term Prims.option)


let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
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


let ___Binding_var____0 = (fun projectee -> (match (projectee) with
| Binding_var (_83_175) -> begin
_83_175
end))


let ___Binding_fvar____0 = (fun projectee -> (match (projectee) with
| Binding_fvar (_83_178) -> begin
_83_178
end))


let binder_of_eithervar = (fun v -> (v, None))


type env_t =
{bindings : binding Prims.list; depth : Prims.int; tcenv : FStar_TypeChecker_Env.env; warn : Prims.bool; cache : (Prims.string * FStar_SMTEncoding_Term.sort Prims.list * FStar_SMTEncoding_Term.decl Prims.list) FStar_Util.smap; nolabels : Prims.bool; use_zfuel_name : Prims.bool; encode_non_total_function_typ : Prims.bool}


let is_Mkenv_t : env_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv_t"))))


let print_env : env_t  ->  Prims.string = (fun e -> (let _173_267 = (FStar_All.pipe_right e.bindings (FStar_List.map (fun _83_2 -> (match (_83_2) with
| Binding_var (x, _83_193) -> begin
(FStar_Syntax_Print.bv_to_string x)
end
| Binding_fvar (l, _83_198, _83_200, _83_202) -> begin
(FStar_Syntax_Print.lid_to_string l)
end))))
in (FStar_All.pipe_right _173_267 (FStar_String.concat ", "))))


let lookup_binding = (fun env f -> (FStar_Util.find_map env.bindings f))


let caption_t : env_t  ->  FStar_Syntax_Syntax.term  ->  Prims.string Prims.option = (fun env t -> if (FStar_TypeChecker_Env.debug env.tcenv FStar_Options.Low) then begin
(let _173_277 = (FStar_Syntax_Print.term_to_string t)
in Some (_173_277))
end else begin
None
end)


let fresh_fvar : Prims.string  ->  FStar_SMTEncoding_Term.sort  ->  (Prims.string * FStar_SMTEncoding_Term.term) = (fun x s -> (

let xsym = (varops.fresh x)
in (let _173_282 = (FStar_SMTEncoding_Term.mkFreeV (xsym, s))
in (xsym, _173_282))))


let gen_term_var : env_t  ->  FStar_Syntax_Syntax.bv  ->  (Prims.string * FStar_SMTEncoding_Term.term * env_t) = (fun env x -> (

let ysym = (let _173_287 = (FStar_Util.string_of_int env.depth)
in (Prims.strcat "@x" _173_287))
in (

let y = (FStar_SMTEncoding_Term.mkFreeV (ysym, FStar_SMTEncoding_Term.Term_sort))
in (ysym, y, (

let _83_216 = env
in {bindings = (Binding_var ((x, y)))::env.bindings; depth = (env.depth + 1); tcenv = _83_216.tcenv; warn = _83_216.warn; cache = _83_216.cache; nolabels = _83_216.nolabels; use_zfuel_name = _83_216.use_zfuel_name; encode_non_total_function_typ = _83_216.encode_non_total_function_typ})))))


let new_term_constant : env_t  ->  FStar_Syntax_Syntax.bv  ->  (Prims.string * FStar_SMTEncoding_Term.term * env_t) = (fun env x -> (

let ysym = (varops.new_var x.FStar_Syntax_Syntax.ppname x.FStar_Syntax_Syntax.index)
in (

let y = (FStar_SMTEncoding_Term.mkApp (ysym, []))
in (ysym, y, (

let _83_222 = env
in {bindings = (Binding_var ((x, y)))::env.bindings; depth = _83_222.depth; tcenv = _83_222.tcenv; warn = _83_222.warn; cache = _83_222.cache; nolabels = _83_222.nolabels; use_zfuel_name = _83_222.use_zfuel_name; encode_non_total_function_typ = _83_222.encode_non_total_function_typ})))))


let push_term_var : env_t  ->  FStar_Syntax_Syntax.bv  ->  FStar_SMTEncoding_Term.term  ->  env_t = (fun env x t -> (

let _83_227 = env
in {bindings = (Binding_var ((x, t)))::env.bindings; depth = _83_227.depth; tcenv = _83_227.tcenv; warn = _83_227.warn; cache = _83_227.cache; nolabels = _83_227.nolabels; use_zfuel_name = _83_227.use_zfuel_name; encode_non_total_function_typ = _83_227.encode_non_total_function_typ}))


let lookup_term_var : env_t  ->  FStar_Syntax_Syntax.bv  ->  FStar_SMTEncoding_Term.term = (fun env a -> (match ((lookup_binding env (fun _83_3 -> (match (_83_3) with
| Binding_var (b, t) when (FStar_Syntax_Syntax.bv_eq b a) -> begin
Some ((b, t))
end
| _83_237 -> begin
None
end)))) with
| None -> begin
(let _173_304 = (let _173_303 = (FStar_Syntax_Print.bv_to_string a)
in (FStar_Util.format1 "Bound term variable not found: %s" _173_303))
in (FStar_All.failwith _173_304))
end
| Some (b, t) -> begin
t
end))


let new_term_constant_and_tok_from_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * Prims.string * env_t) = (fun env x -> (

let fname = (varops.new_fvar x)
in (

let ftok = (Prims.strcat fname "@tok")
in (let _173_315 = (

let _83_247 = env
in (let _173_314 = (let _173_313 = (let _173_312 = (let _173_311 = (let _173_310 = (FStar_SMTEncoding_Term.mkApp (ftok, []))
in (FStar_All.pipe_left (fun _173_309 -> Some (_173_309)) _173_310))
in (x, fname, _173_311, None))
in Binding_fvar (_173_312))
in (_173_313)::env.bindings)
in {bindings = _173_314; depth = _83_247.depth; tcenv = _83_247.tcenv; warn = _83_247.warn; cache = _83_247.cache; nolabels = _83_247.nolabels; use_zfuel_name = _83_247.use_zfuel_name; encode_non_total_function_typ = _83_247.encode_non_total_function_typ}))
in (fname, ftok, _173_315)))))


let try_lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_SMTEncoding_Term.term Prims.option * FStar_SMTEncoding_Term.term Prims.option) Prims.option = (fun env a -> (lookup_binding env (fun _83_4 -> (match (_83_4) with
| Binding_fvar (b, t1, t2, t3) when (FStar_Ident.lid_equals b a) -> begin
Some ((t1, t2, t3))
end
| _83_259 -> begin
None
end))))


let contains_name : env_t  ->  Prims.string  ->  Prims.bool = (fun env s -> (let _173_326 = (lookup_binding env (fun _83_5 -> (match (_83_5) with
| Binding_fvar (b, t1, t2, t3) when (b.FStar_Ident.str = s) -> begin
Some (())
end
| _83_270 -> begin
None
end)))
in (FStar_All.pipe_right _173_326 FStar_Option.isSome)))


let lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_SMTEncoding_Term.term Prims.option * FStar_SMTEncoding_Term.term Prims.option) = (fun env a -> (match ((try_lookup_lid env a)) with
| None -> begin
(let _173_332 = (let _173_331 = (FStar_Syntax_Print.lid_to_string a)
in (FStar_Util.format1 "Name not found: %s" _173_331))
in (FStar_All.failwith _173_332))
end
| Some (s) -> begin
s
end))


let push_free_var : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_SMTEncoding_Term.term Prims.option  ->  env_t = (fun env x fname ftok -> (

let _83_280 = env
in {bindings = (Binding_fvar ((x, fname, ftok, None)))::env.bindings; depth = _83_280.depth; tcenv = _83_280.tcenv; warn = _83_280.warn; cache = _83_280.cache; nolabels = _83_280.nolabels; use_zfuel_name = _83_280.use_zfuel_name; encode_non_total_function_typ = _83_280.encode_non_total_function_typ}))


let push_zfuel_name : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  env_t = (fun env x f -> (

let _83_289 = (lookup_lid env x)
in (match (_83_289) with
| (t1, t2, _83_288) -> begin
(

let t3 = (let _173_349 = (let _173_348 = (let _173_347 = (FStar_SMTEncoding_Term.mkApp ("ZFuel", []))
in (_173_347)::[])
in (f, _173_348))
in (FStar_SMTEncoding_Term.mkApp _173_349))
in (

let _83_291 = env
in {bindings = (Binding_fvar ((x, t1, t2, Some (t3))))::env.bindings; depth = _83_291.depth; tcenv = _83_291.tcenv; warn = _83_291.warn; cache = _83_291.cache; nolabels = _83_291.nolabels; use_zfuel_name = _83_291.use_zfuel_name; encode_non_total_function_typ = _83_291.encode_non_total_function_typ}))
end)))


let try_lookup_free_var : env_t  ->  FStar_Ident.lident  ->  FStar_SMTEncoding_Term.term Prims.option = (fun env l -> (match ((try_lookup_lid env l)) with
| None -> begin
None
end
| Some (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some (f) when env.use_zfuel_name -> begin
Some (f)
end
| _83_304 -> begin
(match (sym) with
| Some (t) -> begin
(match (t.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (_83_308, (fuel)::[]) -> begin
if (let _173_355 = (let _173_354 = (FStar_SMTEncoding_Term.fv_of_term fuel)
in (FStar_All.pipe_right _173_354 Prims.fst))
in (FStar_Util.starts_with _173_355 "fuel")) then begin
(let _173_358 = (let _173_357 = (FStar_SMTEncoding_Term.mkFreeV (name, FStar_SMTEncoding_Term.Term_sort))
in (FStar_SMTEncoding_Term.mk_ApplyTF _173_357 fuel))
in (FStar_All.pipe_left (fun _173_356 -> Some (_173_356)) _173_358))
end else begin
Some (t)
end
end
| _83_314 -> begin
Some (t)
end)
end
| _83_316 -> begin
None
end)
end)
end))


let lookup_free_var = (fun env a -> (match ((try_lookup_free_var env a.FStar_Syntax_Syntax.v)) with
| Some (t) -> begin
t
end
| None -> begin
(let _173_362 = (let _173_361 = (FStar_Syntax_Print.lid_to_string a.FStar_Syntax_Syntax.v)
in (FStar_Util.format1 "Name not found: %s" _173_361))
in (FStar_All.failwith _173_362))
end))


let lookup_free_var_name = (fun env a -> (

let _83_329 = (lookup_lid env a.FStar_Syntax_Syntax.v)
in (match (_83_329) with
| (x, _83_326, _83_328) -> begin
x
end)))


let lookup_free_var_sym = (fun env a -> (

let _83_335 = (lookup_lid env a.FStar_Syntax_Syntax.v)
in (match (_83_335) with
| (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some ({FStar_SMTEncoding_Term.tm = FStar_SMTEncoding_Term.App (g, zf); FStar_SMTEncoding_Term.hash = _83_339; FStar_SMTEncoding_Term.freevars = _83_337}) when env.use_zfuel_name -> begin
(g, zf)
end
| _83_347 -> begin
(match (sym) with
| None -> begin
(FStar_SMTEncoding_Term.Var (name), [])
end
| Some (sym) -> begin
(match (sym.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (g, (fuel)::[]) -> begin
(g, (fuel)::[])
end
| _83_357 -> begin
(FStar_SMTEncoding_Term.Var (name), [])
end)
end)
end)
end)))


let tok_of_name : env_t  ->  Prims.string  ->  FStar_SMTEncoding_Term.term Prims.option = (fun env nm -> (FStar_Util.find_map env.bindings (fun _83_6 -> (match (_83_6) with
| Binding_fvar (_83_362, nm', tok, _83_366) when (nm = nm') -> begin
tok
end
| _83_370 -> begin
None
end))))


let mkForall_fuel' = (fun n _83_375 -> (match (_83_375) with
| (pats, vars, body) -> begin
(

let fallback = (fun _83_377 -> (match (()) with
| () -> begin
(FStar_SMTEncoding_Term.mkForall (pats, vars, body))
end))
in if (FStar_Options.unthrottle_inductives ()) then begin
(fallback ())
end else begin
(

let _83_380 = (fresh_fvar "f" FStar_SMTEncoding_Term.Fuel_sort)
in (match (_83_380) with
| (fsym, fterm) -> begin
(

let add_fuel = (fun tms -> (FStar_All.pipe_right tms (FStar_List.map (fun p -> (match (p.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.Var ("HasType"), args) -> begin
(FStar_SMTEncoding_Term.mkApp ("HasTypeFuel", (fterm)::args))
end
| _83_390 -> begin
p
end)))))
in (

let pats = (FStar_List.map add_fuel pats)
in (

let body = (match (body.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.Imp, (guard)::(body')::[]) -> begin
(

let guard = (match (guard.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.And, guards) -> begin
(let _173_379 = (add_fuel guards)
in (FStar_SMTEncoding_Term.mk_and_l _173_379))
end
| _83_403 -> begin
(let _173_380 = (add_fuel ((guard)::[]))
in (FStar_All.pipe_right _173_380 FStar_List.hd))
end)
in (FStar_SMTEncoding_Term.mkImp (guard, body')))
end
| _83_406 -> begin
body
end)
in (

let vars = ((fsym, FStar_SMTEncoding_Term.Fuel_sort))::vars
in (FStar_SMTEncoding_Term.mkForall (pats, vars, body))))))
end))
end)
end))


let mkForall_fuel : (FStar_SMTEncoding_Term.pat Prims.list Prims.list * FStar_SMTEncoding_Term.fvs * FStar_SMTEncoding_Term.term)  ->  FStar_SMTEncoding_Term.term = (mkForall_fuel' 1)


let head_normal : env_t  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (fun env t -> (

let t = (FStar_Syntax_Util.unmeta t)
in (match (t.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_refine (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) -> begin
true
end
| (FStar_Syntax_Syntax.Tm_fvar (fv)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) -> begin
(let _173_386 = (FStar_TypeChecker_Env.lookup_definition FStar_TypeChecker_Env.OnlyInline env.tcenv fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (FStar_All.pipe_right _173_386 FStar_Option.isNone))
end
| _83_445 -> begin
false
end)))


let head_redex : env_t  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (fun env t -> (match ((let _173_391 = (FStar_Syntax_Util.un_uinst t)
in _173_391.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_abs (_83_449) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(let _173_392 = (FStar_TypeChecker_Env.lookup_definition FStar_TypeChecker_Env.OnlyInline env.tcenv fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (FStar_All.pipe_right _173_392 FStar_Option.isSome))
end
| _83_454 -> begin
false
end))


let whnf : env_t  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> if (head_normal env t) then begin
t
end else begin
(FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv t)
end)


let norm : env_t  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv t))


let trivial_post : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun t -> (let _173_405 = (let _173_403 = (FStar_Syntax_Syntax.null_binder t)
in (_173_403)::[])
in (let _173_404 = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.true_lid FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Util.abs _173_405 _173_404 None))))


let mk_Apply : FStar_SMTEncoding_Term.term  ->  (Prims.string * FStar_SMTEncoding_Term.sort) Prims.list  ->  FStar_SMTEncoding_Term.term = (fun e vars -> (FStar_All.pipe_right vars (FStar_List.fold_left (fun out var -> (match ((Prims.snd var)) with
| FStar_SMTEncoding_Term.Fuel_sort -> begin
(let _173_412 = (FStar_SMTEncoding_Term.mkFreeV var)
in (FStar_SMTEncoding_Term.mk_ApplyTF out _173_412))
end
| s -> begin
(

let _83_466 = ()
in (let _173_413 = (FStar_SMTEncoding_Term.mkFreeV var)
in (FStar_SMTEncoding_Term.mk_ApplyTT out _173_413)))
end)) e)))


let mk_Apply_args : FStar_SMTEncoding_Term.term  ->  FStar_SMTEncoding_Term.term Prims.list  ->  FStar_SMTEncoding_Term.term = (fun e args -> (FStar_All.pipe_right args (FStar_List.fold_left FStar_SMTEncoding_Term.mk_ApplyTT e)))


let is_app : FStar_SMTEncoding_Term.op  ->  Prims.bool = (fun _83_7 -> (match (_83_7) with
| (FStar_SMTEncoding_Term.Var ("ApplyTT")) | (FStar_SMTEncoding_Term.Var ("ApplyTF")) -> begin
true
end
| _83_476 -> begin
false
end))


let is_eta : env_t  ->  FStar_SMTEncoding_Term.fv Prims.list  ->  FStar_SMTEncoding_Term.term  ->  FStar_SMTEncoding_Term.term Prims.option = (fun env vars t -> (

let rec aux = (fun t xs -> (match ((t.FStar_SMTEncoding_Term.tm, xs)) with
| (FStar_SMTEncoding_Term.App (app, (f)::({FStar_SMTEncoding_Term.tm = FStar_SMTEncoding_Term.FreeV (y); FStar_SMTEncoding_Term.hash = _83_487; FStar_SMTEncoding_Term.freevars = _83_485})::[]), (x)::xs) when ((is_app app) && (FStar_SMTEncoding_Term.fv_eq x y)) -> begin
(aux f xs)
end
| (FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.Var (f), args), _83_505) -> begin
if (((FStar_List.length args) = (FStar_List.length vars)) && (FStar_List.forall2 (fun a v -> (match (a.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.FreeV (fv) -> begin
(FStar_SMTEncoding_Term.fv_eq fv v)
end
| _83_512 -> begin
false
end)) args vars)) then begin
(tok_of_name env f)
end else begin
None
end
end
| (_83_514, []) -> begin
(

let fvs = (FStar_SMTEncoding_Term.free_variables t)
in if (FStar_All.pipe_right fvs (FStar_List.for_all (fun fv -> (not ((FStar_Util.for_some (FStar_SMTEncoding_Term.fv_eq fv) vars)))))) then begin
Some (t)
end else begin
None
end)
end
| _83_520 -> begin
None
end))
in (aux t (FStar_List.rev vars))))


type label =
(FStar_SMTEncoding_Term.fv * Prims.string * FStar_Range.range)


type labels =
label Prims.list


type pattern =
{pat_vars : (FStar_Syntax_Syntax.bv * FStar_SMTEncoding_Term.fv) Prims.list; pat_term : Prims.unit  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t); guard : FStar_SMTEncoding_Term.term  ->  FStar_SMTEncoding_Term.term; projections : FStar_SMTEncoding_Term.term  ->  (FStar_Syntax_Syntax.bv * FStar_SMTEncoding_Term.term) Prims.list}


let is_Mkpattern : pattern  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkpattern"))))


exception Let_rec_unencodeable


let is_Let_rec_unencodeable = (fun _discr_ -> (match (_discr_) with
| Let_rec_unencodeable (_) -> begin
true
end
| _ -> begin
false
end))


let encode_const : FStar_Const.sconst  ->  FStar_SMTEncoding_Term.term = (fun _83_8 -> (match (_83_8) with
| FStar_Const.Const_unit -> begin
FStar_SMTEncoding_Term.mk_Term_unit
end
| FStar_Const.Const_bool (true) -> begin
(FStar_SMTEncoding_Term.boxBool FStar_SMTEncoding_Term.mkTrue)
end
| FStar_Const.Const_bool (false) -> begin
(FStar_SMTEncoding_Term.boxBool FStar_SMTEncoding_Term.mkFalse)
end
| FStar_Const.Const_char (c) -> begin
(let _173_470 = (let _173_469 = (let _173_468 = (let _173_467 = (FStar_SMTEncoding_Term.mkInteger' (FStar_Util.int_of_char c))
in (FStar_SMTEncoding_Term.boxInt _173_467))
in (_173_468)::[])
in ("FStar.Char.Char", _173_469))
in (FStar_SMTEncoding_Term.mkApp _173_470))
end
| FStar_Const.Const_int (i, None) -> begin
(let _173_471 = (FStar_SMTEncoding_Term.mkInteger i)
in (FStar_SMTEncoding_Term.boxInt _173_471))
end
| FStar_Const.Const_int (i, Some (_83_540)) -> begin
(FStar_All.failwith "Machine integers should be desugared")
end
| FStar_Const.Const_string (bytes, _83_546) -> begin
(let _173_472 = (FStar_All.pipe_left FStar_Util.string_of_bytes bytes)
in (varops.string_const _173_472))
end
| FStar_Const.Const_range (r) -> begin
FStar_SMTEncoding_Term.mk_Range_const
end
| FStar_Const.Const_effect -> begin
FStar_SMTEncoding_Term.mk_Term_type
end
| c -> begin
(let _173_474 = (let _173_473 = (FStar_Syntax_Print.const_to_string c)
in (FStar_Util.format1 "Unhandled constant: %s" _173_473))
in (FStar_All.failwith _173_474))
end))


let as_function_typ : env_t  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.term = (fun env t0 -> (

let rec aux = (fun norm t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (_83_560) -> begin
t
end
| FStar_Syntax_Syntax.Tm_refine (_83_563) -> begin
(let _173_483 = (FStar_Syntax_Util.unrefine t)
in (aux true _173_483))
end
| _83_566 -> begin
if norm then begin
(let _173_484 = (whnf env t)
in (aux false _173_484))
end else begin
(let _173_487 = (let _173_486 = (FStar_Range.string_of_range t0.FStar_Syntax_Syntax.pos)
in (let _173_485 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format2 "(%s) Expected a function typ; got %s" _173_486 _173_485)))
in (FStar_All.failwith _173_487))
end
end)))
in (aux true t0)))


let curried_arrow_formals_comp : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) = (fun k -> (

let k = (FStar_Syntax_Subst.compress k)
in (match (k.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(FStar_Syntax_Subst.open_comp bs c)
end
| _83_574 -> begin
(let _173_490 = (FStar_Syntax_Syntax.mk_Total k)
in ([], _173_490))
end)))


let rec encode_binders : FStar_SMTEncoding_Term.term Prims.option  ->  FStar_Syntax_Syntax.binders  ->  env_t  ->  (FStar_SMTEncoding_Term.fv Prims.list * FStar_SMTEncoding_Term.term Prims.list * env_t * FStar_SMTEncoding_Term.decls_t * FStar_Syntax_Syntax.bv Prims.list) = (fun fuel_opt bs env -> (

let _83_578 = if (FStar_TypeChecker_Env.debug env.tcenv FStar_Options.Low) then begin
(let _173_538 = (FStar_Syntax_Print.binders_to_string ", " bs)
in (FStar_Util.print1 "Encoding binders %s\n" _173_538))
end else begin
()
end
in (

let _83_606 = (FStar_All.pipe_right bs (FStar_List.fold_left (fun _83_585 b -> (match (_83_585) with
| (vars, guards, env, decls, names) -> begin
(

let _83_600 = (

let x = (unmangle (Prims.fst b))
in (

let _83_591 = (gen_term_var env x)
in (match (_83_591) with
| (xxsym, xx, env') -> begin
(

let _83_594 = (let _173_541 = (norm env x.FStar_Syntax_Syntax.sort)
in (encode_term_pred fuel_opt _173_541 env xx))
in (match (_83_594) with
| (guard_x_t, decls') -> begin
((xxsym, FStar_SMTEncoding_Term.Term_sort), guard_x_t, env', decls', x)
end))
end)))
in (match (_83_600) with
| (v, g, env, decls', n) -> begin
((v)::vars, (g)::guards, env, (FStar_List.append decls decls'), (n)::names)
end))
end)) ([], [], env, [], [])))
in (match (_83_606) with
| (vars, guards, env, decls, names) -> begin
((FStar_List.rev vars), (FStar_List.rev guards), env, decls, (FStar_List.rev names))
end))))
and encode_term_pred : FStar_SMTEncoding_Term.term Prims.option  ->  FStar_Syntax_Syntax.typ  ->  env_t  ->  FStar_SMTEncoding_Term.term  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun fuel_opt t env e -> (

let _83_613 = (encode_term t env)
in (match (_83_613) with
| (t, decls) -> begin
(let _173_546 = (FStar_SMTEncoding_Term.mk_HasTypeWithFuel fuel_opt e t)
in (_173_546, decls))
end)))
and encode_term_pred' : FStar_SMTEncoding_Term.term Prims.option  ->  FStar_Syntax_Syntax.typ  ->  env_t  ->  FStar_SMTEncoding_Term.term  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun fuel_opt t env e -> (

let _83_620 = (encode_term t env)
in (match (_83_620) with
| (t, decls) -> begin
(match (fuel_opt) with
| None -> begin
(let _173_551 = (FStar_SMTEncoding_Term.mk_HasTypeZ e t)
in (_173_551, decls))
end
| Some (f) -> begin
(let _173_552 = (FStar_SMTEncoding_Term.mk_HasTypeFuel f e t)
in (_173_552, decls))
end)
end)))
and encode_term : FStar_Syntax_Syntax.typ  ->  env_t  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun t env -> (

let t0 = (FStar_Syntax_Subst.compress t)
in (

let _83_627 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env.tcenv) (FStar_Options.Other ("SMTEncoding"))) then begin
(let _173_557 = (FStar_Syntax_Print.tag_of_term t)
in (let _173_556 = (FStar_Syntax_Print.tag_of_term t0)
in (let _173_555 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.print3 "(%s) (%s)   %s\n" _173_557 _173_556 _173_555))))
end else begin
()
end
in (match (t0.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_delayed (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
(let _173_562 = (let _173_561 = (FStar_All.pipe_left FStar_Range.string_of_range t.FStar_Syntax_Syntax.pos)
in (let _173_560 = (FStar_Syntax_Print.tag_of_term t0)
in (let _173_559 = (FStar_Syntax_Print.term_to_string t0)
in (let _173_558 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format4 "(%s) Impossible: %s\n%s\n%s\n" _173_561 _173_560 _173_559 _173_558)))))
in (FStar_All.failwith _173_562))
end
| FStar_Syntax_Syntax.Tm_bvar (x) -> begin
(let _173_564 = (let _173_563 = (FStar_Syntax_Print.bv_to_string x)
in (FStar_Util.format1 "Impossible: locally nameless; got %s" _173_563))
in (FStar_All.failwith _173_564))
end
| FStar_Syntax_Syntax.Tm_ascribed (t, k, _83_638) -> begin
(encode_term t env)
end
| FStar_Syntax_Syntax.Tm_meta (t, _83_643) -> begin
(encode_term t env)
end
| FStar_Syntax_Syntax.Tm_name (x) -> begin
(

let t = (lookup_term_var env x)
in (t, []))
end
| FStar_Syntax_Syntax.Tm_fvar (v) -> begin
(let _173_565 = (lookup_free_var env v.FStar_Syntax_Syntax.fv_name)
in (_173_565, []))
end
| FStar_Syntax_Syntax.Tm_type (_83_652) -> begin
(FStar_SMTEncoding_Term.mk_Term_type, [])
end
| FStar_Syntax_Syntax.Tm_uinst (t, _83_656) -> begin
(encode_term t env)
end
| FStar_Syntax_Syntax.Tm_constant (c) -> begin
(let _173_566 = (encode_const c)
in (_173_566, []))
end
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
(

let _83_667 = (FStar_Syntax_Subst.open_comp binders c)
in (match (_83_667) with
| (binders, res) -> begin
if ((env.encode_non_total_function_typ && (FStar_Syntax_Util.is_pure_or_ghost_comp res)) || (FStar_Syntax_Util.is_tot_or_gtot_comp res)) then begin
(

let _83_674 = (encode_binders None binders env)
in (match (_83_674) with
| (vars, guards, env', decls, _83_673) -> begin
(

let fsym = (let _173_567 = (varops.fresh "f")
in (_173_567, FStar_SMTEncoding_Term.Term_sort))
in (

let f = (FStar_SMTEncoding_Term.mkFreeV fsym)
in (

let app = (mk_Apply f vars)
in (

let _83_680 = (FStar_TypeChecker_Util.pure_or_ghost_pre_and_post env.tcenv res)
in (match (_83_680) with
| (pre_opt, res_t) -> begin
(

let _83_683 = (encode_term_pred None res_t env' app)
in (match (_83_683) with
| (res_pred, decls') -> begin
(

let _83_692 = (match (pre_opt) with
| None -> begin
(let _173_568 = (FStar_SMTEncoding_Term.mk_and_l guards)
in (_173_568, []))
end
| Some (pre) -> begin
(

let _83_689 = (encode_formula pre env')
in (match (_83_689) with
| (guard, decls0) -> begin
(let _173_569 = (FStar_SMTEncoding_Term.mk_and_l ((guard)::guards))
in (_173_569, decls0))
end))
end)
in (match (_83_692) with
| (guards, guard_decls) -> begin
(

let t_interp = (let _173_571 = (let _173_570 = (FStar_SMTEncoding_Term.mkImp (guards, res_pred))
in (((app)::[])::[], vars, _173_570))
in (FStar_SMTEncoding_Term.mkForall _173_571))
in (

let cvars = (let _173_573 = (FStar_SMTEncoding_Term.free_variables t_interp)
in (FStar_All.pipe_right _173_573 (FStar_List.filter (fun _83_697 -> (match (_83_697) with
| (x, _83_696) -> begin
(x <> (Prims.fst fsym))
end)))))
in (

let tkey = (FStar_SMTEncoding_Term.mkForall ([], (fsym)::cvars, t_interp))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_SMTEncoding_Term.hash)) with
| Some (t', sorts, _83_703) -> begin
(let _173_576 = (let _173_575 = (let _173_574 = (FStar_All.pipe_right cvars (FStar_List.map FStar_SMTEncoding_Term.mkFreeV))
in (t', _173_574))
in (FStar_SMTEncoding_Term.mkApp _173_575))
in (_173_576, []))
end
| None -> begin
(

let tsym = (varops.fresh "Tm_arrow")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let caption = if (FStar_Options.log_queries ()) then begin
(let _173_577 = (FStar_TypeChecker_Normalize.term_to_string env.tcenv t0)
in Some (_173_577))
end else begin
None
end
in (

let tdecl = FStar_SMTEncoding_Term.DeclFun ((tsym, cvar_sorts, FStar_SMTEncoding_Term.Term_sort, caption))
in (

let t = (let _173_579 = (let _173_578 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV cvars)
in (tsym, _173_578))
in (FStar_SMTEncoding_Term.mkApp _173_579))
in (

let t_has_kind = (FStar_SMTEncoding_Term.mk_HasType t FStar_SMTEncoding_Term.mk_Term_type)
in (

let k_assumption = (

let a_name = Some ((Prims.strcat "kinding_" tsym))
in (let _173_581 = (let _173_580 = (FStar_SMTEncoding_Term.mkForall (((t_has_kind)::[])::[], cvars, t_has_kind))
in (_173_580, a_name, a_name))
in FStar_SMTEncoding_Term.Assume (_173_581)))
in (

let f_has_t = (FStar_SMTEncoding_Term.mk_HasType f t)
in (

let f_has_t_z = (FStar_SMTEncoding_Term.mk_HasTypeZ f t)
in (

let pre_typing = (

let a_name = Some ((Prims.strcat "pre_typing_" tsym))
in (let _173_588 = (let _173_587 = (let _173_586 = (let _173_585 = (let _173_584 = (let _173_583 = (let _173_582 = (FStar_SMTEncoding_Term.mk_PreType f)
in (FStar_SMTEncoding_Term.mk_tester "Tm_arrow" _173_582))
in (f_has_t, _173_583))
in (FStar_SMTEncoding_Term.mkImp _173_584))
in (((f_has_t)::[])::[], (fsym)::cvars, _173_585))
in (mkForall_fuel _173_586))
in (_173_587, Some ("pre-typing for functions"), a_name))
in FStar_SMTEncoding_Term.Assume (_173_588)))
in (

let t_interp = (

let a_name = Some ((Prims.strcat "interpretation_" tsym))
in (let _173_592 = (let _173_591 = (let _173_590 = (let _173_589 = (FStar_SMTEncoding_Term.mkIff (f_has_t_z, t_interp))
in (((f_has_t_z)::[])::[], (fsym)::cvars, _173_589))
in (FStar_SMTEncoding_Term.mkForall _173_590))
in (_173_591, a_name, a_name))
in FStar_SMTEncoding_Term.Assume (_173_592)))
in (

let t_decls = (FStar_List.append (FStar_List.append (FStar_List.append ((tdecl)::decls) decls') guard_decls) ((k_assumption)::(pre_typing)::(t_interp)::[]))
in (

let _83_722 = (FStar_Util.smap_add env.cache tkey.FStar_SMTEncoding_Term.hash (tsym, cvar_sorts, t_decls))
in (t, t_decls))))))))))))))
end))))
end))
end))
end)))))
end))
end else begin
(

let tsym = (varops.fresh "Non_total_Tm_arrow")
in (

let tdecl = FStar_SMTEncoding_Term.DeclFun ((tsym, [], FStar_SMTEncoding_Term.Term_sort, None))
in (

let t = (FStar_SMTEncoding_Term.mkApp (tsym, []))
in (

let t_kinding = (

let a_name = Some ((Prims.strcat "non_total_function_typing_" tsym))
in (let _173_594 = (let _173_593 = (FStar_SMTEncoding_Term.mk_HasType t FStar_SMTEncoding_Term.mk_Term_type)
in (_173_593, Some ("Typing for non-total arrows"), a_name))
in FStar_SMTEncoding_Term.Assume (_173_594)))
in (

let fsym = ("f", FStar_SMTEncoding_Term.Term_sort)
in (

let f = (FStar_SMTEncoding_Term.mkFreeV fsym)
in (

let f_has_t = (FStar_SMTEncoding_Term.mk_HasType f t)
in (

let t_interp = (

let a_name = Some ((Prims.strcat "pre_typing_" tsym))
in (let _173_601 = (let _173_600 = (let _173_599 = (let _173_598 = (let _173_597 = (let _173_596 = (let _173_595 = (FStar_SMTEncoding_Term.mk_PreType f)
in (FStar_SMTEncoding_Term.mk_tester "Tm_arrow" _173_595))
in (f_has_t, _173_596))
in (FStar_SMTEncoding_Term.mkImp _173_597))
in (((f_has_t)::[])::[], (fsym)::[], _173_598))
in (mkForall_fuel _173_599))
in (_173_600, a_name, a_name))
in FStar_SMTEncoding_Term.Assume (_173_601)))
in (t, (tdecl)::(t_kinding)::(t_interp)::[])))))))))
end
end))
end
| FStar_Syntax_Syntax.Tm_refine (_83_735) -> begin
(

let _83_755 = (match ((FStar_TypeChecker_Normalize.normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv t0)) with
| {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_refine (x, f); FStar_Syntax_Syntax.tk = _83_742; FStar_Syntax_Syntax.pos = _83_740; FStar_Syntax_Syntax.vars = _83_738} -> begin
(

let _83_750 = (FStar_Syntax_Subst.open_term (((x, None))::[]) f)
in (match (_83_750) with
| (b, f) -> begin
(let _173_603 = (let _173_602 = (FStar_List.hd b)
in (Prims.fst _173_602))
in (_173_603, f))
end))
end
| _83_752 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_83_755) with
| (x, f) -> begin
(

let _83_758 = (encode_term x.FStar_Syntax_Syntax.sort env)
in (match (_83_758) with
| (base_t, decls) -> begin
(

let _83_762 = (gen_term_var env x)
in (match (_83_762) with
| (x, xtm, env') -> begin
(

let _83_765 = (encode_formula f env')
in (match (_83_765) with
| (refinement, decls') -> begin
(

let _83_768 = (fresh_fvar "f" FStar_SMTEncoding_Term.Fuel_sort)
in (match (_83_768) with
| (fsym, fterm) -> begin
(

let encoding = (let _173_605 = (let _173_604 = (FStar_SMTEncoding_Term.mk_HasTypeWithFuel (Some (fterm)) xtm base_t)
in (_173_604, refinement))
in (FStar_SMTEncoding_Term.mkAnd _173_605))
in (

let cvars = (let _173_607 = (FStar_SMTEncoding_Term.free_variables encoding)
in (FStar_All.pipe_right _173_607 (FStar_List.filter (fun _83_773 -> (match (_83_773) with
| (y, _83_772) -> begin
((y <> x) && (y <> fsym))
end)))))
in (

let xfv = (x, FStar_SMTEncoding_Term.Term_sort)
in (

let ffv = (fsym, FStar_SMTEncoding_Term.Fuel_sort)
in (

let tkey = (FStar_SMTEncoding_Term.mkForall ([], (ffv)::(xfv)::cvars, encoding))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_SMTEncoding_Term.hash)) with
| Some (t, _83_780, _83_782) -> begin
(let _173_610 = (let _173_609 = (let _173_608 = (FStar_All.pipe_right cvars (FStar_List.map FStar_SMTEncoding_Term.mkFreeV))
in (t, _173_608))
in (FStar_SMTEncoding_Term.mkApp _173_609))
in (_173_610, []))
end
| None -> begin
(

let tsym = (varops.fresh "Tm_refine")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let tdecl = FStar_SMTEncoding_Term.DeclFun ((tsym, cvar_sorts, FStar_SMTEncoding_Term.Term_sort, None))
in (

let t = (let _173_612 = (let _173_611 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV cvars)
in (tsym, _173_611))
in (FStar_SMTEncoding_Term.mkApp _173_612))
in (

let x_has_t = (FStar_SMTEncoding_Term.mk_HasTypeWithFuel (Some (fterm)) xtm t)
in (

let t_has_kind = (FStar_SMTEncoding_Term.mk_HasType t FStar_SMTEncoding_Term.mk_Term_type)
in (

let t_kinding = (let _173_614 = (let _173_613 = (FStar_SMTEncoding_Term.mkForall (((t_has_kind)::[])::[], cvars, t_has_kind))
in (_173_613, Some ("refinement kinding"), Some ((Prims.strcat "refinement_kinding_" tsym))))
in FStar_SMTEncoding_Term.Assume (_173_614))
in (

let t_interp = (let _173_620 = (let _173_619 = (let _173_616 = (let _173_615 = (FStar_SMTEncoding_Term.mkIff (x_has_t, encoding))
in (((x_has_t)::[])::[], (ffv)::(xfv)::cvars, _173_615))
in (FStar_SMTEncoding_Term.mkForall _173_616))
in (let _173_618 = (let _173_617 = (FStar_Syntax_Print.term_to_string t0)
in Some (_173_617))
in (_173_619, _173_618, Some ((Prims.strcat "refinement_interpretation_" tsym)))))
in FStar_SMTEncoding_Term.Assume (_173_620))
in (

let t_decls = (FStar_List.append (FStar_List.append decls decls') ((tdecl)::(t_kinding)::(t_interp)::[]))
in (

let _83_795 = (FStar_Util.smap_add env.cache tkey.FStar_SMTEncoding_Term.hash (tsym, cvar_sorts, t_decls))
in (t, t_decls)))))))))))
end))))))
end))
end))
end))
end))
end))
end
| FStar_Syntax_Syntax.Tm_uvar (uv, k) -> begin
(

let ttm = (let _173_621 = (FStar_Unionfind.uvar_id uv)
in (FStar_SMTEncoding_Term.mk_Term_uvar _173_621))
in (

let _83_804 = (encode_term_pred None k env ttm)
in (match (_83_804) with
| (t_has_k, decls) -> begin
(

let d = (let _173_627 = (let _173_626 = (let _173_625 = (let _173_624 = (let _173_623 = (let _173_622 = (FStar_Unionfind.uvar_id uv)
in (FStar_All.pipe_left FStar_Util.string_of_int _173_622))
in (FStar_Util.format1 "@uvar_typing_%s" _173_623))
in (varops.fresh _173_624))
in Some (_173_625))
in (t_has_k, Some ("Uvar typing"), _173_626))
in FStar_SMTEncoding_Term.Assume (_173_627))
in (ttm, (FStar_List.append decls ((d)::[]))))
end)))
end
| FStar_Syntax_Syntax.Tm_app (_83_807) -> begin
(

let _83_811 = (FStar_Syntax_Util.head_and_args t0)
in (match (_83_811) with
| (head, args_e) -> begin
(match ((let _173_629 = (let _173_628 = (FStar_Syntax_Subst.compress head)
in _173_628.FStar_Syntax_Syntax.n)
in (_173_629, args_e))) with
| (_83_813, _83_815) when (head_redex env head) -> begin
(let _173_630 = (whnf env t)
in (encode_term _173_630 env))
end
| ((FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), (_)::((v1, _))::((v2, _))::[])) | ((FStar_Syntax_Syntax.Tm_fvar (fv), (_)::((v1, _))::((v2, _))::[])) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.lexcons_lid) -> begin
(

let _83_855 = (encode_term v1 env)
in (match (_83_855) with
| (v1, decls1) -> begin
(

let _83_858 = (encode_term v2 env)
in (match (_83_858) with
| (v2, decls2) -> begin
(let _173_631 = (FStar_SMTEncoding_Term.mk_LexCons v1 v2)
in (_173_631, (FStar_List.append decls1 decls2)))
end))
end))
end
| _83_860 -> begin
(

let _83_863 = (encode_args args_e env)
in (match (_83_863) with
| (args, decls) -> begin
(

let encode_partial_app = (fun ht_opt -> (

let _83_868 = (encode_term head env)
in (match (_83_868) with
| (head, decls') -> begin
(

let app_tm = (mk_Apply_args head args)
in (match (ht_opt) with
| None -> begin
(app_tm, (FStar_List.append decls decls'))
end
| Some (formals, c) -> begin
(

let _83_877 = (FStar_Util.first_N (FStar_List.length args_e) formals)
in (match (_83_877) with
| (formals, rest) -> begin
(

let subst = (FStar_List.map2 (fun _83_881 _83_885 -> (match ((_83_881, _83_885)) with
| ((bv, _83_880), (a, _83_884)) -> begin
FStar_Syntax_Syntax.NT ((bv, a))
end)) formals args_e)
in (

let ty = (let _173_636 = (FStar_Syntax_Util.arrow rest c)
in (FStar_All.pipe_right _173_636 (FStar_Syntax_Subst.subst subst)))
in (

let _83_890 = (encode_term_pred None ty env app_tm)
in (match (_83_890) with
| (has_type, decls'') -> begin
(

let cvars = (FStar_SMTEncoding_Term.free_variables has_type)
in (

let e_typing = (let _173_640 = (let _173_639 = (FStar_SMTEncoding_Term.mkForall (((has_type)::[])::[], cvars, has_type))
in (let _173_638 = (let _173_637 = (varops.fresh "@partial_app_typing_")
in Some (_173_637))
in (_173_639, Some ("Partial app typing"), _173_638)))
in FStar_SMTEncoding_Term.Assume (_173_640))
in (app_tm, (FStar_List.append (FStar_List.append (FStar_List.append decls decls') decls'') ((e_typing)::[])))))
end))))
end))
end))
end)))
in (

let encode_full_app = (fun fv -> (

let _83_897 = (lookup_free_var_sym env fv)
in (match (_83_897) with
| (fname, fuel_args) -> begin
(

let tm = (FStar_SMTEncoding_Term.mkApp' (fname, (FStar_List.append fuel_args args)))
in (tm, decls))
end)))
in (

let head = (FStar_Syntax_Subst.compress head)
in (

let head_type = (match (head.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_name (x); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_name (x)) -> begin
Some (x.FStar_Syntax_Syntax.sort)
end
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_fvar (fv)) -> begin
(let _173_644 = (let _173_643 = (FStar_TypeChecker_Env.lookup_lid env.tcenv fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (FStar_All.pipe_right _173_643 Prims.snd))
in Some (_173_644))
end
| FStar_Syntax_Syntax.Tm_ascribed (_83_929, FStar_Util.Inl (t), _83_933) -> begin
Some (t)
end
| FStar_Syntax_Syntax.Tm_ascribed (_83_937, FStar_Util.Inr (c), _83_941) -> begin
Some ((FStar_Syntax_Util.comp_result c))
end
| _83_945 -> begin
None
end)
in (match (head_type) with
| None -> begin
(encode_partial_app None)
end
| Some (head_type) -> begin
(

let head_type = (let _173_645 = (FStar_TypeChecker_Normalize.normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv head_type)
in (FStar_All.pipe_left FStar_Syntax_Util.unrefine _173_645))
in (

let _83_953 = (curried_arrow_formals_comp head_type)
in (match (_83_953) with
| (formals, c) -> begin
(match (head.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_fvar (fv)) when ((FStar_List.length formals) = (FStar_List.length args)) -> begin
(encode_full_app fv.FStar_Syntax_Syntax.fv_name)
end
| _83_969 -> begin
if ((FStar_List.length formals) > (FStar_List.length args)) then begin
(encode_partial_app (Some ((formals, c))))
end else begin
(encode_partial_app None)
end
end)
end)))
end)))))
end))
end)
end))
end
| FStar_Syntax_Syntax.Tm_abs (bs, body, lopt) -> begin
(

let _83_978 = (FStar_Syntax_Subst.open_term' bs body)
in (match (_83_978) with
| (bs, body, opening) -> begin
(

let fallback = (fun _83_980 -> (match (()) with
| () -> begin
(

let f = (varops.fresh "Tm_abs")
in (

let decl = FStar_SMTEncoding_Term.DeclFun ((f, [], FStar_SMTEncoding_Term.Term_sort, Some ("Imprecise function encoding")))
in (let _173_648 = (FStar_SMTEncoding_Term.mkFreeV (f, FStar_SMTEncoding_Term.Term_sort))
in (_173_648, (decl)::[]))))
end))
in (

let is_pure_or_ghost = (fun lc_eff -> (match (lc_eff) with
| FStar_Util.Inl (lc) -> begin
(FStar_Syntax_Util.is_pure_or_ghost_lcomp lc)
end
| FStar_Util.Inr (eff) -> begin
((FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_Tot_lid) || (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_GTot_lid))
end))
in (

let codomain_eff = (fun lc -> (match (lc) with
| FStar_Util.Inl (lc) -> begin
(let _173_653 = (lc.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Subst.subst_comp opening _173_653))
end
| FStar_Util.Inr (ef) -> begin
(let _173_655 = (let _173_654 = (FStar_TypeChecker_Rel.new_uvar FStar_Range.dummyRange [] FStar_Syntax_Util.ktype0)
in (FStar_All.pipe_right _173_654 Prims.fst))
in (FStar_Syntax_Syntax.mk_Total _173_655))
end))
in (match (lopt) with
| None -> begin
(

let _83_996 = (let _173_657 = (let _173_656 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Losing precision when encoding a function literal: %s" _173_656))
in (FStar_TypeChecker_Errors.warn t0.FStar_Syntax_Syntax.pos _173_657))
in (fallback ()))
end
| Some (lc) -> begin
if (let _173_658 = (is_pure_or_ghost lc)
in (FStar_All.pipe_left Prims.op_Negation _173_658)) then begin
(fallback ())
end else begin
(

let c = (codomain_eff lc)
in (

let _83_1007 = (encode_binders None bs env)
in (match (_83_1007) with
| (vars, guards, envbody, decls, _83_1006) -> begin
(

let _83_1010 = (encode_term body envbody)
in (match (_83_1010) with
| (body, decls') -> begin
(

let key_body = (let _173_662 = (let _173_661 = (let _173_660 = (let _173_659 = (FStar_SMTEncoding_Term.mk_and_l guards)
in (_173_659, body))
in (FStar_SMTEncoding_Term.mkImp _173_660))
in ([], vars, _173_661))
in (FStar_SMTEncoding_Term.mkForall _173_662))
in (

let cvars = (FStar_SMTEncoding_Term.free_variables key_body)
in (

let tkey = (FStar_SMTEncoding_Term.mkForall ([], cvars, key_body))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_SMTEncoding_Term.hash)) with
| Some (t, _83_1016, _83_1018) -> begin
(let _173_665 = (let _173_664 = (let _173_663 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV cvars)
in (t, _173_663))
in (FStar_SMTEncoding_Term.mkApp _173_664))
in (_173_665, []))
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

let fdecl = FStar_SMTEncoding_Term.DeclFun ((fsym, cvar_sorts, FStar_SMTEncoding_Term.Term_sort, None))
in (

let f = (let _173_667 = (let _173_666 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV cvars)
in (fsym, _173_666))
in (FStar_SMTEncoding_Term.mkApp _173_667))
in (

let app = (mk_Apply f vars)
in (

let tfun = (FStar_Syntax_Util.arrow bs c)
in (

let _83_1033 = (encode_term_pred None tfun env f)
in (match (_83_1033) with
| (f_has_t, decls'') -> begin
(

let typing_f = (

let a_name = Some ((Prims.strcat "typing_" fsym))
in (let _173_669 = (let _173_668 = (FStar_SMTEncoding_Term.mkForall (((f)::[])::[], cvars, f_has_t))
in (_173_668, a_name, a_name))
in FStar_SMTEncoding_Term.Assume (_173_669)))
in (

let interp_f = (

let a_name = Some ((Prims.strcat "interpretation_" fsym))
in (let _173_676 = (let _173_675 = (let _173_674 = (let _173_673 = (let _173_672 = (let _173_671 = (FStar_SMTEncoding_Term.mk_IsTyped app)
in (let _173_670 = (FStar_SMTEncoding_Term.mkEq (app, body))
in (_173_671, _173_670)))
in (FStar_SMTEncoding_Term.mkImp _173_672))
in (((app)::[])::[], (FStar_List.append vars cvars), _173_673))
in (FStar_SMTEncoding_Term.mkForall _173_674))
in (_173_675, a_name, a_name))
in FStar_SMTEncoding_Term.Assume (_173_676)))
in (

let f_decls = (FStar_List.append (FStar_List.append (FStar_List.append decls decls') ((fdecl)::decls'')) ((typing_f)::(interp_f)::[]))
in (

let _83_1039 = (FStar_Util.smap_add env.cache tkey.FStar_SMTEncoding_Term.hash (fsym, cvar_sorts, f_decls))
in (f, f_decls)))))
end))))))))
end)
end))))
end))
end)))
end
end))))
end))
end
| FStar_Syntax_Syntax.Tm_let ((_83_1042, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inr (_83_1054); FStar_Syntax_Syntax.lbunivs = _83_1052; FStar_Syntax_Syntax.lbtyp = _83_1050; FStar_Syntax_Syntax.lbeff = _83_1048; FStar_Syntax_Syntax.lbdef = _83_1046})::_83_1044), _83_1060) -> begin
(FStar_All.failwith "Impossible: already handled by encoding of Sig_let")
end
| FStar_Syntax_Syntax.Tm_let ((false, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inl (x); FStar_Syntax_Syntax.lbunivs = _83_1069; FStar_Syntax_Syntax.lbtyp = t1; FStar_Syntax_Syntax.lbeff = _83_1066; FStar_Syntax_Syntax.lbdef = e1})::[]), e2) -> begin
(encode_let x t1 e1 e2 env encode_term)
end
| FStar_Syntax_Syntax.Tm_let (_83_1079) -> begin
(

let _83_1081 = (FStar_TypeChecker_Errors.warn t0.FStar_Syntax_Syntax.pos "Non-top-level recursive functions are not yet fully encoded to the SMT solver; you may not be able to prove some facts")
in (

let e = (varops.fresh "let-rec")
in (

let decl_e = FStar_SMTEncoding_Term.DeclFun ((e, [], FStar_SMTEncoding_Term.Term_sort, None))
in (let _173_677 = (FStar_SMTEncoding_Term.mkFreeV (e, FStar_SMTEncoding_Term.Term_sort))
in (_173_677, (decl_e)::[])))))
end
| FStar_Syntax_Syntax.Tm_match (e, pats) -> begin
(encode_match e pats FStar_SMTEncoding_Term.mk_Term_unit env encode_term)
end))))
and encode_let : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  env_t  ->  (FStar_Syntax_Syntax.term  ->  env_t  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t))  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun x t1 e1 e2 env encode_body -> (

let _83_1097 = (encode_term e1 env)
in (match (_83_1097) with
| (ee1, decls1) -> begin
(

let _83_1100 = (FStar_Syntax_Subst.open_term (((x, None))::[]) e2)
in (match (_83_1100) with
| (xs, e2) -> begin
(

let _83_1104 = (FStar_List.hd xs)
in (match (_83_1104) with
| (x, _83_1103) -> begin
(

let env' = (push_term_var env x ee1)
in (

let _83_1108 = (encode_body e2 env')
in (match (_83_1108) with
| (ee2, decls2) -> begin
(ee2, (FStar_List.append decls1 decls2))
end)))
end))
end))
end)))
and encode_match : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.branch Prims.list  ->  FStar_SMTEncoding_Term.term  ->  env_t  ->  (FStar_Syntax_Syntax.term  ->  env_t  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t))  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun e pats default_case env encode_br -> (

let _83_1116 = (encode_term e env)
in (match (_83_1116) with
| (scr, decls) -> begin
(

let _83_1153 = (FStar_List.fold_right (fun b _83_1120 -> (match (_83_1120) with
| (else_case, decls) -> begin
(

let _83_1124 = (FStar_Syntax_Subst.open_branch b)
in (match (_83_1124) with
| (p, w, br) -> begin
(

let patterns = (encode_pat env p)
in (FStar_List.fold_right (fun _83_1128 _83_1131 -> (match ((_83_1128, _83_1131)) with
| ((env0, pattern), (else_case, decls)) -> begin
(

let guard = (pattern.guard scr)
in (

let projections = (pattern.projections scr)
in (

let env = (FStar_All.pipe_right projections (FStar_List.fold_left (fun env _83_1137 -> (match (_83_1137) with
| (x, t) -> begin
(push_term_var env x t)
end)) env))
in (

let _83_1147 = (match (w) with
| None -> begin
(guard, [])
end
| Some (w) -> begin
(

let _83_1144 = (encode_term w env)
in (match (_83_1144) with
| (w, decls2) -> begin
(let _173_711 = (let _173_710 = (let _173_709 = (let _173_708 = (let _173_707 = (FStar_SMTEncoding_Term.boxBool FStar_SMTEncoding_Term.mkTrue)
in (w, _173_707))
in (FStar_SMTEncoding_Term.mkEq _173_708))
in (guard, _173_709))
in (FStar_SMTEncoding_Term.mkAnd _173_710))
in (_173_711, decls2))
end))
end)
in (match (_83_1147) with
| (guard, decls2) -> begin
(

let _83_1150 = (encode_br br env)
in (match (_83_1150) with
| (br, decls3) -> begin
(let _173_712 = (FStar_SMTEncoding_Term.mkITE (guard, br, else_case))
in (_173_712, (FStar_List.append (FStar_List.append decls decls2) decls3)))
end))
end)))))
end)) patterns (else_case, decls)))
end))
end)) pats (default_case, decls))
in (match (_83_1153) with
| (match_tm, decls) -> begin
(match_tm, decls)
end))
end)))
and encode_pat : env_t  ->  FStar_Syntax_Syntax.pat  ->  (env_t * pattern) Prims.list = (fun env pat -> (match (pat.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj (ps) -> begin
(FStar_List.map (encode_one_pat env) ps)
end
| _83_1159 -> begin
(let _173_715 = (encode_one_pat env pat)
in (_173_715)::[])
end))
and encode_one_pat : env_t  ->  FStar_Syntax_Syntax.pat  ->  (env_t * pattern) = (fun env pat -> (

let _83_1162 = if (FStar_TypeChecker_Env.debug env.tcenv FStar_Options.Low) then begin
(let _173_718 = (FStar_Syntax_Print.pat_to_string pat)
in (FStar_Util.print1 "Encoding pattern %s\n" _173_718))
end else begin
()
end
in (

let _83_1166 = (FStar_TypeChecker_Util.decorated_pattern_as_term pat)
in (match (_83_1166) with
| (vars, pat_term) -> begin
(

let _83_1178 = (FStar_All.pipe_right vars (FStar_List.fold_left (fun _83_1169 v -> (match (_83_1169) with
| (env, vars) -> begin
(

let _83_1175 = (gen_term_var env v)
in (match (_83_1175) with
| (xx, _83_1173, env) -> begin
(env, ((v, (xx, FStar_SMTEncoding_Term.Term_sort)))::vars)
end))
end)) (env, [])))
in (match (_83_1178) with
| (env, vars) -> begin
(

let rec mk_guard = (fun pat scrutinee -> (match (pat.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj (_83_1183) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Syntax_Syntax.Pat_var (_)) | (FStar_Syntax_Syntax.Pat_wild (_)) | (FStar_Syntax_Syntax.Pat_dot_term (_)) -> begin
FStar_SMTEncoding_Term.mkTrue
end
| FStar_Syntax_Syntax.Pat_constant (c) -> begin
(let _173_726 = (let _173_725 = (encode_const c)
in (scrutinee, _173_725))
in (FStar_SMTEncoding_Term.mkEq _173_726))
end
| FStar_Syntax_Syntax.Pat_cons (f, args) -> begin
(

let is_f = (mk_data_tester env f.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v scrutinee)
in (

let sub_term_guards = (FStar_All.pipe_right args (FStar_List.mapi (fun i _83_1205 -> (match (_83_1205) with
| (arg, _83_1204) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v i)
in (let _173_729 = (FStar_SMTEncoding_Term.mkApp (proj, (scrutinee)::[]))
in (mk_guard arg _173_729)))
end))))
in (FStar_SMTEncoding_Term.mk_and_l ((is_f)::sub_term_guards))))
end))
in (

let rec mk_projections = (fun pat scrutinee -> (match (pat.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_disj (_83_1212) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Syntax_Syntax.Pat_dot_term (x, _)) | (FStar_Syntax_Syntax.Pat_var (x)) | (FStar_Syntax_Syntax.Pat_wild (x)) -> begin
((x, scrutinee))::[]
end
| FStar_Syntax_Syntax.Pat_constant (_83_1222) -> begin
[]
end
| FStar_Syntax_Syntax.Pat_cons (f, args) -> begin
(let _173_737 = (FStar_All.pipe_right args (FStar_List.mapi (fun i _83_1232 -> (match (_83_1232) with
| (arg, _83_1231) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v i)
in (let _173_736 = (FStar_SMTEncoding_Term.mkApp (proj, (scrutinee)::[]))
in (mk_projections arg _173_736)))
end))))
in (FStar_All.pipe_right _173_737 FStar_List.flatten))
end))
in (

let pat_term = (fun _83_1235 -> (match (()) with
| () -> begin
(encode_term pat_term env)
end))
in (

let pattern = {pat_vars = vars; pat_term = pat_term; guard = (mk_guard pat); projections = (mk_projections pat)}
in (env, pattern)))))
end))
end))))
and encode_args : FStar_Syntax_Syntax.args  ->  env_t  ->  (FStar_SMTEncoding_Term.term Prims.list * FStar_SMTEncoding_Term.decls_t) = (fun l env -> (

let _83_1251 = (FStar_All.pipe_right l (FStar_List.fold_left (fun _83_1241 _83_1245 -> (match ((_83_1241, _83_1245)) with
| ((tms, decls), (t, _83_1244)) -> begin
(

let _83_1248 = (encode_term t env)
in (match (_83_1248) with
| (t, decls') -> begin
((t)::tms, (FStar_List.append decls decls'))
end))
end)) ([], [])))
in (match (_83_1251) with
| (l, decls) -> begin
((FStar_List.rev l), decls)
end)))
and encode_function_type_as_formula : FStar_SMTEncoding_Term.term Prims.option  ->  FStar_Syntax_Syntax.term Prims.option  ->  FStar_Syntax_Syntax.typ  ->  env_t  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun induction_on new_pats t env -> (

let rec list_elements = (fun e -> (

let _83_1260 = (let _173_750 = (FStar_Syntax_Util.unmeta e)
in (FStar_Syntax_Util.head_and_args _173_750))
in (match (_83_1260) with
| (head, args) -> begin
(match ((let _173_752 = (let _173_751 = (FStar_Syntax_Util.un_uinst head)
in _173_751.FStar_Syntax_Syntax.n)
in (_173_752, args))) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), _83_1264) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.nil_lid) -> begin
[]
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), (_83_1277)::((hd, _83_1274))::((tl, _83_1270))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.cons_lid) -> begin
(let _173_753 = (list_elements tl)
in (hd)::_173_753)
end
| _83_1281 -> begin
(

let _83_1282 = (FStar_TypeChecker_Errors.warn e.FStar_Syntax_Syntax.pos "SMT pattern is not a list literal; ignoring the pattern")
in [])
end)
end)))
in (

let one_pat = (fun p -> (

let _83_1288 = (let _173_756 = (FStar_Syntax_Util.unmeta p)
in (FStar_All.pipe_right _173_756 FStar_Syntax_Util.head_and_args))
in (match (_83_1288) with
| (head, args) -> begin
(match ((let _173_758 = (let _173_757 = (FStar_Syntax_Util.un_uinst head)
in _173_757.FStar_Syntax_Syntax.n)
in (_173_758, args))) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), ((_83_1296, _83_1298))::((e, _83_1293))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.smtpat_lid) -> begin
(e, None)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), ((e, _83_1306))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.smtpatT_lid) -> begin
(e, None)
end
| _83_1311 -> begin
(FStar_All.failwith "Unexpected pattern term")
end)
end)))
in (

let lemma_pats = (fun p -> (

let elts = (list_elements p)
in (

let smt_pat_or = (fun t -> (

let _83_1319 = (let _173_763 = (FStar_Syntax_Util.unmeta t)
in (FStar_All.pipe_right _173_763 FStar_Syntax_Util.head_and_args))
in (match (_83_1319) with
| (head, args) -> begin
(match ((let _173_765 = (let _173_764 = (FStar_Syntax_Util.un_uinst head)
in _173_764.FStar_Syntax_Syntax.n)
in (_173_765, args))) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), ((e, _83_1324))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.smtpatOr_lid) -> begin
Some (e)
end
| _83_1329 -> begin
None
end)
end)))
in (match (elts) with
| (t)::[] -> begin
(match ((smt_pat_or t)) with
| Some (e) -> begin
(let _173_768 = (list_elements e)
in (FStar_All.pipe_right _173_768 (FStar_List.map (fun branch -> (let _173_767 = (list_elements branch)
in (FStar_All.pipe_right _173_767 (FStar_List.map one_pat)))))))
end
| _83_1336 -> begin
(let _173_769 = (FStar_All.pipe_right elts (FStar_List.map one_pat))
in (_173_769)::[])
end)
end
| _83_1338 -> begin
(let _173_770 = (FStar_All.pipe_right elts (FStar_List.map one_pat))
in (_173_770)::[])
end))))
in (

let _83_1372 = (match ((let _173_771 = (FStar_Syntax_Subst.compress t)
in _173_771.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
(

let _83_1345 = (FStar_Syntax_Subst.open_comp binders c)
in (match (_83_1345) with
| (binders, c) -> begin
(

let ct = (FStar_Syntax_Util.comp_to_comp_typ c)
in (match (ct.FStar_Syntax_Syntax.effect_args) with
| ((pre, _83_1357))::((post, _83_1353))::((pats, _83_1349))::[] -> begin
(

let pats' = (match (new_pats) with
| Some (new_pats') -> begin
new_pats'
end
| None -> begin
pats
end)
in (let _173_772 = (lemma_pats pats')
in (binders, pre, post, _173_772)))
end
| _83_1365 -> begin
(FStar_All.failwith "impos")
end))
end))
end
| _83_1367 -> begin
(FStar_All.failwith "Impos")
end)
in (match (_83_1372) with
| (binders, pre, post, patterns) -> begin
(

let _83_1379 = (encode_binders None binders env)
in (match (_83_1379) with
| (vars, guards, env, decls, _83_1378) -> begin
(

let _83_1392 = (let _173_776 = (FStar_All.pipe_right patterns (FStar_List.map (fun branch -> (

let _83_1389 = (let _173_775 = (FStar_All.pipe_right branch (FStar_List.map (fun _83_1384 -> (match (_83_1384) with
| (t, _83_1383) -> begin
(encode_term t (

let _83_1385 = env
in {bindings = _83_1385.bindings; depth = _83_1385.depth; tcenv = _83_1385.tcenv; warn = _83_1385.warn; cache = _83_1385.cache; nolabels = _83_1385.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _83_1385.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _173_775 FStar_List.unzip))
in (match (_83_1389) with
| (pats, decls) -> begin
(pats, decls)
end)))))
in (FStar_All.pipe_right _173_776 FStar_List.unzip))
in (match (_83_1392) with
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
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _173_779 = (let _173_778 = (FStar_SMTEncoding_Term.mkFreeV l)
in (FStar_SMTEncoding_Term.mk_Precedes _173_778 e))
in (_173_779)::p))))
end
| _83_1402 -> begin
(

let rec aux = (fun tl vars -> (match (vars) with
| [] -> begin
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _173_785 = (FStar_SMTEncoding_Term.mk_Precedes tl e)
in (_173_785)::p))))
end
| ((x, FStar_SMTEncoding_Term.Term_sort))::vars -> begin
(let _173_787 = (let _173_786 = (FStar_SMTEncoding_Term.mkFreeV (x, FStar_SMTEncoding_Term.Term_sort))
in (FStar_SMTEncoding_Term.mk_LexCons _173_786 tl))
in (aux _173_787 vars))
end
| _83_1414 -> begin
pats
end))
in (let _173_788 = (FStar_SMTEncoding_Term.mkFreeV ("Prims.LexTop", FStar_SMTEncoding_Term.Term_sort))
in (aux _173_788 vars)))
end)
end)
in (

let env = (

let _83_1416 = env
in {bindings = _83_1416.bindings; depth = _83_1416.depth; tcenv = _83_1416.tcenv; warn = _83_1416.warn; cache = _83_1416.cache; nolabels = true; use_zfuel_name = _83_1416.use_zfuel_name; encode_non_total_function_typ = _83_1416.encode_non_total_function_typ})
in (

let _83_1421 = (let _173_789 = (FStar_Syntax_Util.unmeta pre)
in (encode_formula _173_789 env))
in (match (_83_1421) with
| (pre, decls'') -> begin
(

let _83_1424 = (let _173_790 = (FStar_Syntax_Util.unmeta post)
in (encode_formula _173_790 env))
in (match (_83_1424) with
| (post, decls''') -> begin
(

let decls = (FStar_List.append (FStar_List.append (FStar_List.append decls (FStar_List.flatten decls')) decls'') decls''')
in (let _173_795 = (let _173_794 = (let _173_793 = (let _173_792 = (let _173_791 = (FStar_SMTEncoding_Term.mk_and_l ((pre)::guards))
in (_173_791, post))
in (FStar_SMTEncoding_Term.mkImp _173_792))
in (pats, vars, _173_793))
in (FStar_SMTEncoding_Term.mkForall _173_794))
in (_173_795, decls)))
end))
end)))))
end))
end))
end))))))
and encode_formula : FStar_Syntax_Syntax.typ  ->  env_t  ->  (FStar_SMTEncoding_Term.term * FStar_SMTEncoding_Term.decls_t) = (fun phi env -> (

let debug = (fun phi -> if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env.tcenv) (FStar_Options.Other ("SMTEncoding"))) then begin
(let _173_801 = (FStar_Syntax_Print.tag_of_term phi)
in (let _173_800 = (FStar_Syntax_Print.term_to_string phi)
in (FStar_Util.print2 "Formula (%s)  %s\n" _173_801 _173_800)))
end else begin
()
end)
in (

let enc = (fun f l -> (

let _83_1440 = (FStar_Util.fold_map (fun decls x -> (

let _83_1437 = (encode_term (Prims.fst x) env)
in (match (_83_1437) with
| (t, decls') -> begin
((FStar_List.append decls decls'), t)
end))) [] l)
in (match (_83_1440) with
| (decls, args) -> begin
(let _173_817 = (f args)
in (_173_817, decls))
end)))
in (

let const_op = (fun f _83_1443 -> (f, []))
in (

let un_op = (fun f l -> (let _173_831 = (FStar_List.hd l)
in (FStar_All.pipe_left f _173_831)))
in (

let bin_op = (fun f _83_9 -> (match (_83_9) with
| (t1)::(t2)::[] -> begin
(f (t1, t2))
end
| _83_1454 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let enc_prop_c = (fun f l -> (

let _83_1469 = (FStar_Util.fold_map (fun decls _83_1463 -> (match (_83_1463) with
| (t, _83_1462) -> begin
(

let _83_1466 = (encode_formula t env)
in (match (_83_1466) with
| (phi, decls') -> begin
((FStar_List.append decls decls'), phi)
end))
end)) [] l)
in (match (_83_1469) with
| (decls, phis) -> begin
(let _173_856 = (f phis)
in (_173_856, decls))
end)))
in (

let eq_op = (fun _83_10 -> (match (_83_10) with
| (_83_1476)::(_83_1474)::(e1)::(e2)::[] -> begin
(enc (bin_op FStar_SMTEncoding_Term.mkEq) ((e1)::(e2)::[]))
end
| l -> begin
(enc (bin_op FStar_SMTEncoding_Term.mkEq) l)
end))
in (

let mk_imp = (fun _83_11 -> (match (_83_11) with
| ((lhs, _83_1487))::((rhs, _83_1483))::[] -> begin
(

let _83_1492 = (encode_formula rhs env)
in (match (_83_1492) with
| (l1, decls1) -> begin
(match (l1.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.True, _83_1495) -> begin
(l1, decls1)
end
| _83_1499 -> begin
(

let _83_1502 = (encode_formula lhs env)
in (match (_83_1502) with
| (l2, decls2) -> begin
(let _173_861 = (FStar_SMTEncoding_Term.mkImp (l2, l1))
in (_173_861, (FStar_List.append decls1 decls2)))
end))
end)
end))
end
| _83_1504 -> begin
(FStar_All.failwith "impossible")
end))
in (

let mk_ite = (fun _83_12 -> (match (_83_12) with
| ((guard, _83_1517))::((_then, _83_1513))::((_else, _83_1509))::[] -> begin
(

let _83_1522 = (encode_formula guard env)
in (match (_83_1522) with
| (g, decls1) -> begin
(

let _83_1525 = (encode_formula _then env)
in (match (_83_1525) with
| (t, decls2) -> begin
(

let _83_1528 = (encode_formula _else env)
in (match (_83_1528) with
| (e, decls3) -> begin
(

let res = (FStar_SMTEncoding_Term.mkITE (g, t, e))
in (res, (FStar_List.append (FStar_List.append decls1 decls2) decls3)))
end))
end))
end))
end
| _83_1531 -> begin
(FStar_All.failwith "impossible")
end))
in (

let unboxInt_l = (fun f l -> (let _173_873 = (FStar_List.map FStar_SMTEncoding_Term.unboxInt l)
in (f _173_873)))
in (

let connectives = (let _173_926 = (let _173_882 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_SMTEncoding_Term.mkAnd))
in (FStar_Syntax_Const.and_lid, _173_882))
in (let _173_925 = (let _173_924 = (let _173_888 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_SMTEncoding_Term.mkOr))
in (FStar_Syntax_Const.or_lid, _173_888))
in (let _173_923 = (let _173_922 = (let _173_921 = (let _173_897 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_SMTEncoding_Term.mkIff))
in (FStar_Syntax_Const.iff_lid, _173_897))
in (let _173_920 = (let _173_919 = (let _173_918 = (let _173_906 = (FStar_All.pipe_left enc_prop_c (un_op FStar_SMTEncoding_Term.mkNot))
in (FStar_Syntax_Const.not_lid, _173_906))
in (_173_918)::((FStar_Syntax_Const.eq2_lid, eq_op))::((FStar_Syntax_Const.true_lid, (const_op FStar_SMTEncoding_Term.mkTrue)))::((FStar_Syntax_Const.false_lid, (const_op FStar_SMTEncoding_Term.mkFalse)))::[])
in ((FStar_Syntax_Const.ite_lid, mk_ite))::_173_919)
in (_173_921)::_173_920))
in ((FStar_Syntax_Const.imp_lid, mk_imp))::_173_922)
in (_173_924)::_173_923))
in (_173_926)::_173_925))
in (

let rec fallback = (fun phi -> (match (phi.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_meta (phi', FStar_Syntax_Syntax.Meta_labeled (msg, r, b)) -> begin
(

let _83_1549 = (encode_formula phi' env)
in (match (_83_1549) with
| (phi, decls) -> begin
(let _173_929 = (FStar_SMTEncoding_Term.mk (FStar_SMTEncoding_Term.Labeled ((phi, msg, r))))
in (_173_929, decls))
end))
end
| FStar_Syntax_Syntax.Tm_match (e, pats) -> begin
(

let _83_1556 = (encode_match e pats FStar_SMTEncoding_Term.mkFalse env encode_formula)
in (match (_83_1556) with
| (t, decls) -> begin
(t, decls)
end))
end
| FStar_Syntax_Syntax.Tm_let ((false, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inl (x); FStar_Syntax_Syntax.lbunivs = _83_1563; FStar_Syntax_Syntax.lbtyp = t1; FStar_Syntax_Syntax.lbeff = _83_1560; FStar_Syntax_Syntax.lbdef = e1})::[]), e2) -> begin
(

let _83_1574 = (encode_let x t1 e1 e2 env encode_formula)
in (match (_83_1574) with
| (t, decls) -> begin
(t, decls)
end))
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let head = (FStar_Syntax_Util.un_uinst head)
in (match ((head.FStar_Syntax_Syntax.n, args)) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), (_83_1591)::((x, _83_1588))::((t, _83_1584))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.has_type_lid) -> begin
(

let _83_1596 = (encode_term x env)
in (match (_83_1596) with
| (x, decls) -> begin
(

let _83_1599 = (encode_term t env)
in (match (_83_1599) with
| (t, decls') -> begin
(let _173_930 = (FStar_SMTEncoding_Term.mk_HasType x t)
in (_173_930, (FStar_List.append decls decls')))
end))
end))
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), ((r, _83_1612))::((msg, _83_1608))::((phi, _83_1604))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.labeled_lid) -> begin
(match ((let _173_934 = (let _173_931 = (FStar_Syntax_Subst.compress r)
in _173_931.FStar_Syntax_Syntax.n)
in (let _173_933 = (let _173_932 = (FStar_Syntax_Subst.compress msg)
in _173_932.FStar_Syntax_Syntax.n)
in (_173_934, _173_933)))) with
| (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range (r)), FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_string (s, _83_1621))) -> begin
(

let phi = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((phi, FStar_Syntax_Syntax.Meta_labeled (((FStar_Util.string_of_unicode s), r, false))))) None r)
in (fallback phi))
end
| _83_1628 -> begin
(fallback phi)
end)
end
| _83_1630 when (head_redex env head) -> begin
(let _173_935 = (whnf env phi)
in (encode_formula _173_935 env))
end
| _83_1632 -> begin
(

let _83_1635 = (encode_term phi env)
in (match (_83_1635) with
| (tt, decls) -> begin
(let _173_936 = (FStar_SMTEncoding_Term.mk_Valid tt)
in (_173_936, decls))
end))
end))
end
| _83_1637 -> begin
(

let _83_1640 = (encode_term phi env)
in (match (_83_1640) with
| (tt, decls) -> begin
(let _173_937 = (FStar_SMTEncoding_Term.mk_Valid tt)
in (_173_937, decls))
end))
end))
in (

let encode_q_body = (fun env bs ps body -> (

let _83_1652 = (encode_binders None bs env)
in (match (_83_1652) with
| (vars, guards, env, decls, _83_1651) -> begin
(

let _83_1665 = (let _173_949 = (FStar_All.pipe_right ps (FStar_List.map (fun p -> (

let _83_1662 = (let _173_948 = (FStar_All.pipe_right p (FStar_List.map (fun _83_1657 -> (match (_83_1657) with
| (t, _83_1656) -> begin
(encode_term t (

let _83_1658 = env
in {bindings = _83_1658.bindings; depth = _83_1658.depth; tcenv = _83_1658.tcenv; warn = _83_1658.warn; cache = _83_1658.cache; nolabels = _83_1658.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _83_1658.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _173_948 FStar_List.unzip))
in (match (_83_1662) with
| (p, decls) -> begin
(p, (FStar_List.flatten decls))
end)))))
in (FStar_All.pipe_right _173_949 FStar_List.unzip))
in (match (_83_1665) with
| (pats, decls') -> begin
(

let _83_1668 = (encode_formula body env)
in (match (_83_1668) with
| (body, decls'') -> begin
(

let guards = (match (pats) with
| (({FStar_SMTEncoding_Term.tm = FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.Var ("Prims.guard_free"), (p)::[]); FStar_SMTEncoding_Term.hash = _83_1672; FStar_SMTEncoding_Term.freevars = _83_1670})::[])::[] -> begin
[]
end
| _83_1683 -> begin
guards
end)
in (let _173_950 = (FStar_SMTEncoding_Term.mk_and_l guards)
in (vars, pats, _173_950, body, (FStar_List.append (FStar_List.append decls (FStar_List.flatten decls')) decls''))))
end))
end))
end)))
in (

let _83_1685 = (debug phi)
in (

let phi = (FStar_Syntax_Util.unascribe phi)
in (match ((FStar_Syntax_Util.destruct_typ_as_formula phi)) with
| None -> begin
(fallback phi)
end
| Some (FStar_Syntax_Util.BaseConn (op, arms)) -> begin
(match ((FStar_All.pipe_right connectives (FStar_List.tryFind (fun _83_1697 -> (match (_83_1697) with
| (l, _83_1696) -> begin
(FStar_Ident.lid_equals op l)
end))))) with
| None -> begin
(fallback phi)
end
| Some (_83_1700, f) -> begin
(f arms)
end)
end
| Some (FStar_Syntax_Util.QAll (vars, pats, body)) -> begin
(

let _83_1710 = if (FStar_TypeChecker_Env.debug env.tcenv FStar_Options.Low) then begin
(let _173_967 = (FStar_All.pipe_right vars (FStar_Syntax_Print.binders_to_string "; "))
in (FStar_Util.print1 ">>>> Got QALL [%s]\n" _173_967))
end else begin
()
end
in (

let _83_1717 = (encode_q_body env vars pats body)
in (match (_83_1717) with
| (vars, pats, guard, body, decls) -> begin
(

let tm = (let _173_969 = (let _173_968 = (FStar_SMTEncoding_Term.mkImp (guard, body))
in (pats, vars, _173_968))
in (FStar_SMTEncoding_Term.mkForall _173_969))
in (

let _83_1719 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _173_970 = (FStar_SMTEncoding_Term.termToSmt tm)
in (FStar_Util.print1 ">>>> Encoded QALL to %s\n" _173_970))
end else begin
()
end
in (tm, decls)))
end)))
end
| Some (FStar_Syntax_Util.QEx (vars, pats, body)) -> begin
(

let _83_1732 = (encode_q_body env vars pats body)
in (match (_83_1732) with
| (vars, pats, guard, body, decls) -> begin
(let _173_973 = (let _173_972 = (let _173_971 = (FStar_SMTEncoding_Term.mkAnd (guard, body))
in (pats, vars, _173_971))
in (FStar_SMTEncoding_Term.mkExists _173_972))
in (_173_973, decls))
end))
end)))))))))))))))))


type prims_t =
{mk : FStar_Ident.lident  ->  Prims.string  ->  FStar_SMTEncoding_Term.decl Prims.list; is : FStar_Ident.lident  ->  Prims.bool}


let is_Mkprims_t : prims_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkprims_t"))))


let prims : prims_t = (

let _83_1738 = (fresh_fvar "a" FStar_SMTEncoding_Term.Term_sort)
in (match (_83_1738) with
| (asym, a) -> begin
(

let _83_1741 = (fresh_fvar "x" FStar_SMTEncoding_Term.Term_sort)
in (match (_83_1741) with
| (xsym, x) -> begin
(

let _83_1744 = (fresh_fvar "y" FStar_SMTEncoding_Term.Term_sort)
in (match (_83_1744) with
| (ysym, y) -> begin
(

let deffun = (fun vars body x -> (FStar_SMTEncoding_Term.DefineFun ((x, vars, FStar_SMTEncoding_Term.Term_sort, body, None)))::[])
in (

let quant = (fun vars body x -> (

let t1 = (let _173_1016 = (let _173_1015 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (x, _173_1015))
in (FStar_SMTEncoding_Term.mkApp _173_1016))
in (

let vname_decl = (let _173_1018 = (let _173_1017 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in (x, _173_1017, FStar_SMTEncoding_Term.Term_sort, None))
in FStar_SMTEncoding_Term.DeclFun (_173_1018))
in (let _173_1024 = (let _173_1023 = (let _173_1022 = (let _173_1021 = (let _173_1020 = (let _173_1019 = (FStar_SMTEncoding_Term.mkEq (t1, body))
in (((t1)::[])::[], vars, _173_1019))
in (FStar_SMTEncoding_Term.mkForall _173_1020))
in (_173_1021, None, Some ((Prims.strcat "primitive_" x))))
in FStar_SMTEncoding_Term.Assume (_173_1022))
in (_173_1023)::[])
in (vname_decl)::_173_1024))))
in (

let axy = ((asym, FStar_SMTEncoding_Term.Term_sort))::((xsym, FStar_SMTEncoding_Term.Term_sort))::((ysym, FStar_SMTEncoding_Term.Term_sort))::[]
in (

let xy = ((xsym, FStar_SMTEncoding_Term.Term_sort))::((ysym, FStar_SMTEncoding_Term.Term_sort))::[]
in (

let qx = ((xsym, FStar_SMTEncoding_Term.Term_sort))::[]
in (

let prims = (let _173_1184 = (let _173_1033 = (let _173_1032 = (let _173_1031 = (FStar_SMTEncoding_Term.mkEq (x, y))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1031))
in (quant axy _173_1032))
in (FStar_Syntax_Const.op_Eq, _173_1033))
in (let _173_1183 = (let _173_1182 = (let _173_1040 = (let _173_1039 = (let _173_1038 = (let _173_1037 = (FStar_SMTEncoding_Term.mkEq (x, y))
in (FStar_SMTEncoding_Term.mkNot _173_1037))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1038))
in (quant axy _173_1039))
in (FStar_Syntax_Const.op_notEq, _173_1040))
in (let _173_1181 = (let _173_1180 = (let _173_1049 = (let _173_1048 = (let _173_1047 = (let _173_1046 = (let _173_1045 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1044 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1045, _173_1044)))
in (FStar_SMTEncoding_Term.mkLT _173_1046))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1047))
in (quant xy _173_1048))
in (FStar_Syntax_Const.op_LT, _173_1049))
in (let _173_1179 = (let _173_1178 = (let _173_1058 = (let _173_1057 = (let _173_1056 = (let _173_1055 = (let _173_1054 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1053 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1054, _173_1053)))
in (FStar_SMTEncoding_Term.mkLTE _173_1055))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1056))
in (quant xy _173_1057))
in (FStar_Syntax_Const.op_LTE, _173_1058))
in (let _173_1177 = (let _173_1176 = (let _173_1067 = (let _173_1066 = (let _173_1065 = (let _173_1064 = (let _173_1063 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1062 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1063, _173_1062)))
in (FStar_SMTEncoding_Term.mkGT _173_1064))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1065))
in (quant xy _173_1066))
in (FStar_Syntax_Const.op_GT, _173_1067))
in (let _173_1175 = (let _173_1174 = (let _173_1076 = (let _173_1075 = (let _173_1074 = (let _173_1073 = (let _173_1072 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1071 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1072, _173_1071)))
in (FStar_SMTEncoding_Term.mkGTE _173_1073))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1074))
in (quant xy _173_1075))
in (FStar_Syntax_Const.op_GTE, _173_1076))
in (let _173_1173 = (let _173_1172 = (let _173_1085 = (let _173_1084 = (let _173_1083 = (let _173_1082 = (let _173_1081 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1080 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1081, _173_1080)))
in (FStar_SMTEncoding_Term.mkSub _173_1082))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1083))
in (quant xy _173_1084))
in (FStar_Syntax_Const.op_Subtraction, _173_1085))
in (let _173_1171 = (let _173_1170 = (let _173_1092 = (let _173_1091 = (let _173_1090 = (let _173_1089 = (FStar_SMTEncoding_Term.unboxInt x)
in (FStar_SMTEncoding_Term.mkMinus _173_1089))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1090))
in (quant qx _173_1091))
in (FStar_Syntax_Const.op_Minus, _173_1092))
in (let _173_1169 = (let _173_1168 = (let _173_1101 = (let _173_1100 = (let _173_1099 = (let _173_1098 = (let _173_1097 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1096 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1097, _173_1096)))
in (FStar_SMTEncoding_Term.mkAdd _173_1098))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1099))
in (quant xy _173_1100))
in (FStar_Syntax_Const.op_Addition, _173_1101))
in (let _173_1167 = (let _173_1166 = (let _173_1110 = (let _173_1109 = (let _173_1108 = (let _173_1107 = (let _173_1106 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1105 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1106, _173_1105)))
in (FStar_SMTEncoding_Term.mkMul _173_1107))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1108))
in (quant xy _173_1109))
in (FStar_Syntax_Const.op_Multiply, _173_1110))
in (let _173_1165 = (let _173_1164 = (let _173_1119 = (let _173_1118 = (let _173_1117 = (let _173_1116 = (let _173_1115 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1114 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1115, _173_1114)))
in (FStar_SMTEncoding_Term.mkDiv _173_1116))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1117))
in (quant xy _173_1118))
in (FStar_Syntax_Const.op_Division, _173_1119))
in (let _173_1163 = (let _173_1162 = (let _173_1128 = (let _173_1127 = (let _173_1126 = (let _173_1125 = (let _173_1124 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1123 = (FStar_SMTEncoding_Term.unboxInt y)
in (_173_1124, _173_1123)))
in (FStar_SMTEncoding_Term.mkMod _173_1125))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxInt _173_1126))
in (quant xy _173_1127))
in (FStar_Syntax_Const.op_Modulus, _173_1128))
in (let _173_1161 = (let _173_1160 = (let _173_1137 = (let _173_1136 = (let _173_1135 = (let _173_1134 = (let _173_1133 = (FStar_SMTEncoding_Term.unboxBool x)
in (let _173_1132 = (FStar_SMTEncoding_Term.unboxBool y)
in (_173_1133, _173_1132)))
in (FStar_SMTEncoding_Term.mkAnd _173_1134))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1135))
in (quant xy _173_1136))
in (FStar_Syntax_Const.op_And, _173_1137))
in (let _173_1159 = (let _173_1158 = (let _173_1146 = (let _173_1145 = (let _173_1144 = (let _173_1143 = (let _173_1142 = (FStar_SMTEncoding_Term.unboxBool x)
in (let _173_1141 = (FStar_SMTEncoding_Term.unboxBool y)
in (_173_1142, _173_1141)))
in (FStar_SMTEncoding_Term.mkOr _173_1143))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1144))
in (quant xy _173_1145))
in (FStar_Syntax_Const.op_Or, _173_1146))
in (let _173_1157 = (let _173_1156 = (let _173_1153 = (let _173_1152 = (let _173_1151 = (let _173_1150 = (FStar_SMTEncoding_Term.unboxBool x)
in (FStar_SMTEncoding_Term.mkNot _173_1150))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_1151))
in (quant qx _173_1152))
in (FStar_Syntax_Const.op_Negation, _173_1153))
in (_173_1156)::[])
in (_173_1158)::_173_1157))
in (_173_1160)::_173_1159))
in (_173_1162)::_173_1161))
in (_173_1164)::_173_1163))
in (_173_1166)::_173_1165))
in (_173_1168)::_173_1167))
in (_173_1170)::_173_1169))
in (_173_1172)::_173_1171))
in (_173_1174)::_173_1173))
in (_173_1176)::_173_1175))
in (_173_1178)::_173_1177))
in (_173_1180)::_173_1179))
in (_173_1182)::_173_1181))
in (_173_1184)::_173_1183))
in (

let mk = (fun l v -> (let _173_1216 = (FStar_All.pipe_right prims (FStar_List.filter (fun _83_1764 -> (match (_83_1764) with
| (l', _83_1763) -> begin
(FStar_Ident.lid_equals l l')
end))))
in (FStar_All.pipe_right _173_1216 (FStar_List.collect (fun _83_1768 -> (match (_83_1768) with
| (_83_1766, b) -> begin
(b v)
end))))))
in (

let is = (fun l -> (FStar_All.pipe_right prims (FStar_Util.for_some (fun _83_1774 -> (match (_83_1774) with
| (l', _83_1773) -> begin
(FStar_Ident.lid_equals l l')
end)))))
in {mk = mk; is = is}))))))))
end))
end))
end))


let pretype_axiom : FStar_SMTEncoding_Term.term  ->  (Prims.string * FStar_SMTEncoding_Term.sort) Prims.list  ->  FStar_SMTEncoding_Term.decl = (fun tapp vars -> (

let _83_1780 = (fresh_fvar "x" FStar_SMTEncoding_Term.Term_sort)
in (match (_83_1780) with
| (xxsym, xx) -> begin
(

let _83_1783 = (fresh_fvar "f" FStar_SMTEncoding_Term.Fuel_sort)
in (match (_83_1783) with
| (ffsym, ff) -> begin
(

let xx_has_type = (FStar_SMTEncoding_Term.mk_HasTypeFuel ff xx tapp)
in (let _173_1244 = (let _173_1243 = (let _173_1240 = (let _173_1239 = (let _173_1238 = (let _173_1237 = (let _173_1236 = (let _173_1235 = (FStar_SMTEncoding_Term.mkApp ("PreType", (xx)::[]))
in (tapp, _173_1235))
in (FStar_SMTEncoding_Term.mkEq _173_1236))
in (xx_has_type, _173_1237))
in (FStar_SMTEncoding_Term.mkImp _173_1238))
in (((xx_has_type)::[])::[], ((xxsym, FStar_SMTEncoding_Term.Term_sort))::((ffsym, FStar_SMTEncoding_Term.Fuel_sort))::vars, _173_1239))
in (FStar_SMTEncoding_Term.mkForall _173_1240))
in (let _173_1242 = (let _173_1241 = (varops.fresh "@pretyping_")
in Some (_173_1241))
in (_173_1243, Some ("pretyping"), _173_1242)))
in FStar_SMTEncoding_Term.Assume (_173_1244)))
end))
end)))


let primitive_type_axioms : FStar_TypeChecker_Env.env  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_SMTEncoding_Term.term  ->  FStar_SMTEncoding_Term.decl Prims.list = (

let xx = ("x", FStar_SMTEncoding_Term.Term_sort)
in (

let x = (FStar_SMTEncoding_Term.mkFreeV xx)
in (

let yy = ("y", FStar_SMTEncoding_Term.Term_sort)
in (

let y = (FStar_SMTEncoding_Term.mkFreeV yy)
in (

let mk_unit = (fun env nm tt -> (

let typing_pred = (FStar_SMTEncoding_Term.mk_HasType x tt)
in (let _173_1265 = (let _173_1256 = (let _173_1255 = (FStar_SMTEncoding_Term.mk_HasType FStar_SMTEncoding_Term.mk_Term_unit tt)
in (_173_1255, Some ("unit typing"), Some ("unit_typing")))
in FStar_SMTEncoding_Term.Assume (_173_1256))
in (let _173_1264 = (let _173_1263 = (let _173_1262 = (let _173_1261 = (let _173_1260 = (let _173_1259 = (let _173_1258 = (let _173_1257 = (FStar_SMTEncoding_Term.mkEq (x, FStar_SMTEncoding_Term.mk_Term_unit))
in (typing_pred, _173_1257))
in (FStar_SMTEncoding_Term.mkImp _173_1258))
in (((typing_pred)::[])::[], (xx)::[], _173_1259))
in (mkForall_fuel _173_1260))
in (_173_1261, Some ("unit inversion"), Some ("unit_inversion")))
in FStar_SMTEncoding_Term.Assume (_173_1262))
in (_173_1263)::[])
in (_173_1265)::_173_1264))))
in (

let mk_bool = (fun env nm tt -> (

let typing_pred = (FStar_SMTEncoding_Term.mk_HasType x tt)
in (

let bb = ("b", FStar_SMTEncoding_Term.Bool_sort)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (let _173_1288 = (let _173_1279 = (let _173_1278 = (let _173_1277 = (let _173_1276 = (let _173_1273 = (let _173_1272 = (FStar_SMTEncoding_Term.boxBool b)
in (_173_1272)::[])
in (_173_1273)::[])
in (let _173_1275 = (let _173_1274 = (FStar_SMTEncoding_Term.boxBool b)
in (FStar_SMTEncoding_Term.mk_HasType _173_1274 tt))
in (_173_1276, (bb)::[], _173_1275)))
in (FStar_SMTEncoding_Term.mkForall _173_1277))
in (_173_1278, Some ("bool typing"), Some ("bool_typing")))
in FStar_SMTEncoding_Term.Assume (_173_1279))
in (let _173_1287 = (let _173_1286 = (let _173_1285 = (let _173_1284 = (let _173_1283 = (let _173_1282 = (let _173_1281 = (let _173_1280 = (FStar_SMTEncoding_Term.mk_tester "BoxBool" x)
in (typing_pred, _173_1280))
in (FStar_SMTEncoding_Term.mkImp _173_1281))
in (((typing_pred)::[])::[], (xx)::[], _173_1282))
in (mkForall_fuel _173_1283))
in (_173_1284, Some ("bool inversion"), Some ("bool_inversion")))
in FStar_SMTEncoding_Term.Assume (_173_1285))
in (_173_1286)::[])
in (_173_1288)::_173_1287))))))
in (

let mk_int = (fun env nm tt -> (

let typing_pred = (FStar_SMTEncoding_Term.mk_HasType x tt)
in (

let typing_pred_y = (FStar_SMTEncoding_Term.mk_HasType y tt)
in (

let aa = ("a", FStar_SMTEncoding_Term.Int_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let bb = ("b", FStar_SMTEncoding_Term.Int_sort)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let precedes = (let _173_1302 = (let _173_1301 = (let _173_1300 = (let _173_1299 = (let _173_1298 = (let _173_1297 = (FStar_SMTEncoding_Term.boxInt a)
in (let _173_1296 = (let _173_1295 = (FStar_SMTEncoding_Term.boxInt b)
in (_173_1295)::[])
in (_173_1297)::_173_1296))
in (tt)::_173_1298)
in (tt)::_173_1299)
in ("Prims.Precedes", _173_1300))
in (FStar_SMTEncoding_Term.mkApp _173_1301))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.mk_Valid _173_1302))
in (

let precedes_y_x = (let _173_1303 = (FStar_SMTEncoding_Term.mkApp ("Precedes", (y)::(x)::[]))
in (FStar_All.pipe_left FStar_SMTEncoding_Term.mk_Valid _173_1303))
in (let _173_1345 = (let _173_1311 = (let _173_1310 = (let _173_1309 = (let _173_1308 = (let _173_1305 = (let _173_1304 = (FStar_SMTEncoding_Term.boxInt b)
in (_173_1304)::[])
in (_173_1305)::[])
in (let _173_1307 = (let _173_1306 = (FStar_SMTEncoding_Term.boxInt b)
in (FStar_SMTEncoding_Term.mk_HasType _173_1306 tt))
in (_173_1308, (bb)::[], _173_1307)))
in (FStar_SMTEncoding_Term.mkForall _173_1309))
in (_173_1310, Some ("int typing"), Some ("int_typing")))
in FStar_SMTEncoding_Term.Assume (_173_1311))
in (let _173_1344 = (let _173_1343 = (let _173_1317 = (let _173_1316 = (let _173_1315 = (let _173_1314 = (let _173_1313 = (let _173_1312 = (FStar_SMTEncoding_Term.mk_tester "BoxInt" x)
in (typing_pred, _173_1312))
in (FStar_SMTEncoding_Term.mkImp _173_1313))
in (((typing_pred)::[])::[], (xx)::[], _173_1314))
in (mkForall_fuel _173_1315))
in (_173_1316, Some ("int inversion"), Some ("int_inversion")))
in FStar_SMTEncoding_Term.Assume (_173_1317))
in (let _173_1342 = (let _173_1341 = (let _173_1340 = (let _173_1339 = (let _173_1338 = (let _173_1337 = (let _173_1336 = (let _173_1335 = (let _173_1334 = (let _173_1333 = (let _173_1332 = (let _173_1331 = (let _173_1320 = (let _173_1319 = (FStar_SMTEncoding_Term.unboxInt x)
in (let _173_1318 = (FStar_SMTEncoding_Term.mkInteger' 0)
in (_173_1319, _173_1318)))
in (FStar_SMTEncoding_Term.mkGT _173_1320))
in (let _173_1330 = (let _173_1329 = (let _173_1323 = (let _173_1322 = (FStar_SMTEncoding_Term.unboxInt y)
in (let _173_1321 = (FStar_SMTEncoding_Term.mkInteger' 0)
in (_173_1322, _173_1321)))
in (FStar_SMTEncoding_Term.mkGTE _173_1323))
in (let _173_1328 = (let _173_1327 = (let _173_1326 = (let _173_1325 = (FStar_SMTEncoding_Term.unboxInt y)
in (let _173_1324 = (FStar_SMTEncoding_Term.unboxInt x)
in (_173_1325, _173_1324)))
in (FStar_SMTEncoding_Term.mkLT _173_1326))
in (_173_1327)::[])
in (_173_1329)::_173_1328))
in (_173_1331)::_173_1330))
in (typing_pred_y)::_173_1332)
in (typing_pred)::_173_1333)
in (FStar_SMTEncoding_Term.mk_and_l _173_1334))
in (_173_1335, precedes_y_x))
in (FStar_SMTEncoding_Term.mkImp _173_1336))
in (((typing_pred)::(typing_pred_y)::(precedes_y_x)::[])::[], (xx)::(yy)::[], _173_1337))
in (mkForall_fuel _173_1338))
in (_173_1339, Some ("well-founded ordering on nat (alt)"), Some ("well-founded-ordering-on-nat")))
in FStar_SMTEncoding_Term.Assume (_173_1340))
in (_173_1341)::[])
in (_173_1343)::_173_1342))
in (_173_1345)::_173_1344)))))))))))
in (

let mk_str = (fun env nm tt -> (

let typing_pred = (FStar_SMTEncoding_Term.mk_HasType x tt)
in (

let bb = ("b", FStar_SMTEncoding_Term.String_sort)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (let _173_1368 = (let _173_1359 = (let _173_1358 = (let _173_1357 = (let _173_1356 = (let _173_1353 = (let _173_1352 = (FStar_SMTEncoding_Term.boxString b)
in (_173_1352)::[])
in (_173_1353)::[])
in (let _173_1355 = (let _173_1354 = (FStar_SMTEncoding_Term.boxString b)
in (FStar_SMTEncoding_Term.mk_HasType _173_1354 tt))
in (_173_1356, (bb)::[], _173_1355)))
in (FStar_SMTEncoding_Term.mkForall _173_1357))
in (_173_1358, Some ("string typing"), Some ("string_typing")))
in FStar_SMTEncoding_Term.Assume (_173_1359))
in (let _173_1367 = (let _173_1366 = (let _173_1365 = (let _173_1364 = (let _173_1363 = (let _173_1362 = (let _173_1361 = (let _173_1360 = (FStar_SMTEncoding_Term.mk_tester "BoxString" x)
in (typing_pred, _173_1360))
in (FStar_SMTEncoding_Term.mkImp _173_1361))
in (((typing_pred)::[])::[], (xx)::[], _173_1362))
in (mkForall_fuel _173_1363))
in (_173_1364, Some ("string inversion"), Some ("string_inversion")))
in FStar_SMTEncoding_Term.Assume (_173_1365))
in (_173_1366)::[])
in (_173_1368)::_173_1367))))))
in (

let mk_ref = (fun env reft_name _83_1822 -> (

let r = ("r", FStar_SMTEncoding_Term.Ref_sort)
in (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let refa = (let _173_1377 = (let _173_1376 = (let _173_1375 = (FStar_SMTEncoding_Term.mkFreeV aa)
in (_173_1375)::[])
in (reft_name, _173_1376))
in (FStar_SMTEncoding_Term.mkApp _173_1377))
in (

let refb = (let _173_1380 = (let _173_1379 = (let _173_1378 = (FStar_SMTEncoding_Term.mkFreeV bb)
in (_173_1378)::[])
in (reft_name, _173_1379))
in (FStar_SMTEncoding_Term.mkApp _173_1380))
in (

let typing_pred = (FStar_SMTEncoding_Term.mk_HasType x refa)
in (

let typing_pred_b = (FStar_SMTEncoding_Term.mk_HasType x refb)
in (let _173_1399 = (let _173_1386 = (let _173_1385 = (let _173_1384 = (let _173_1383 = (let _173_1382 = (let _173_1381 = (FStar_SMTEncoding_Term.mk_tester "BoxRef" x)
in (typing_pred, _173_1381))
in (FStar_SMTEncoding_Term.mkImp _173_1382))
in (((typing_pred)::[])::[], (xx)::(aa)::[], _173_1383))
in (mkForall_fuel _173_1384))
in (_173_1385, Some ("ref inversion"), Some ("ref_inversion")))
in FStar_SMTEncoding_Term.Assume (_173_1386))
in (let _173_1398 = (let _173_1397 = (let _173_1396 = (let _173_1395 = (let _173_1394 = (let _173_1393 = (let _173_1392 = (let _173_1391 = (FStar_SMTEncoding_Term.mkAnd (typing_pred, typing_pred_b))
in (let _173_1390 = (let _173_1389 = (let _173_1388 = (FStar_SMTEncoding_Term.mkFreeV aa)
in (let _173_1387 = (FStar_SMTEncoding_Term.mkFreeV bb)
in (_173_1388, _173_1387)))
in (FStar_SMTEncoding_Term.mkEq _173_1389))
in (_173_1391, _173_1390)))
in (FStar_SMTEncoding_Term.mkImp _173_1392))
in (((typing_pred)::(typing_pred_b)::[])::[], (xx)::(aa)::(bb)::[], _173_1393))
in (mkForall_fuel' 2 _173_1394))
in (_173_1395, Some ("ref typing is injective"), Some ("ref_injectivity")))
in FStar_SMTEncoding_Term.Assume (_173_1396))
in (_173_1397)::[])
in (_173_1399)::_173_1398))))))))))
in (

let mk_false_interp = (fun env nm false_tm -> (

let valid = (FStar_SMTEncoding_Term.mkApp ("Valid", (false_tm)::[]))
in (let _173_1408 = (let _173_1407 = (let _173_1406 = (FStar_SMTEncoding_Term.mkIff (FStar_SMTEncoding_Term.mkFalse, valid))
in (_173_1406, Some ("False interpretation"), Some ("false_interp")))
in FStar_SMTEncoding_Term.Assume (_173_1407))
in (_173_1408)::[])))
in (

let mk_and_interp = (fun env conj _83_1839 -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let valid = (let _173_1417 = (let _173_1416 = (let _173_1415 = (FStar_SMTEncoding_Term.mkApp (conj, (a)::(b)::[]))
in (_173_1415)::[])
in ("Valid", _173_1416))
in (FStar_SMTEncoding_Term.mkApp _173_1417))
in (

let valid_a = (FStar_SMTEncoding_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_SMTEncoding_Term.mkApp ("Valid", (b)::[]))
in (let _173_1424 = (let _173_1423 = (let _173_1422 = (let _173_1421 = (let _173_1420 = (let _173_1419 = (let _173_1418 = (FStar_SMTEncoding_Term.mkAnd (valid_a, valid_b))
in (_173_1418, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1419))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1420))
in (FStar_SMTEncoding_Term.mkForall _173_1421))
in (_173_1422, Some ("/\\ interpretation"), Some ("l_and-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1423))
in (_173_1424)::[])))))))))
in (

let mk_or_interp = (fun env disj _83_1851 -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let valid = (let _173_1433 = (let _173_1432 = (let _173_1431 = (FStar_SMTEncoding_Term.mkApp (disj, (a)::(b)::[]))
in (_173_1431)::[])
in ("Valid", _173_1432))
in (FStar_SMTEncoding_Term.mkApp _173_1433))
in (

let valid_a = (FStar_SMTEncoding_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_SMTEncoding_Term.mkApp ("Valid", (b)::[]))
in (let _173_1440 = (let _173_1439 = (let _173_1438 = (let _173_1437 = (let _173_1436 = (let _173_1435 = (let _173_1434 = (FStar_SMTEncoding_Term.mkOr (valid_a, valid_b))
in (_173_1434, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1435))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1436))
in (FStar_SMTEncoding_Term.mkForall _173_1437))
in (_173_1438, Some ("\\/ interpretation"), Some ("l_or-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1439))
in (_173_1440)::[])))))))))
in (

let mk_eq2_interp = (fun env eq2 tt -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let xx = ("x", FStar_SMTEncoding_Term.Term_sort)
in (

let yy = ("y", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let x = (FStar_SMTEncoding_Term.mkFreeV xx)
in (

let y = (FStar_SMTEncoding_Term.mkFreeV yy)
in (

let valid = (let _173_1449 = (let _173_1448 = (let _173_1447 = (FStar_SMTEncoding_Term.mkApp (eq2, (a)::(b)::(x)::(y)::[]))
in (_173_1447)::[])
in ("Valid", _173_1448))
in (FStar_SMTEncoding_Term.mkApp _173_1449))
in (let _173_1456 = (let _173_1455 = (let _173_1454 = (let _173_1453 = (let _173_1452 = (let _173_1451 = (let _173_1450 = (FStar_SMTEncoding_Term.mkEq (x, y))
in (_173_1450, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1451))
in (((valid)::[])::[], (aa)::(bb)::(xx)::(yy)::[], _173_1452))
in (FStar_SMTEncoding_Term.mkForall _173_1453))
in (_173_1454, Some ("Eq2 interpretation"), Some ("eq2-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1455))
in (_173_1456)::[])))))))))))
in (

let mk_imp_interp = (fun env imp tt -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let valid = (let _173_1465 = (let _173_1464 = (let _173_1463 = (FStar_SMTEncoding_Term.mkApp (imp, (a)::(b)::[]))
in (_173_1463)::[])
in ("Valid", _173_1464))
in (FStar_SMTEncoding_Term.mkApp _173_1465))
in (

let valid_a = (FStar_SMTEncoding_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_SMTEncoding_Term.mkApp ("Valid", (b)::[]))
in (let _173_1472 = (let _173_1471 = (let _173_1470 = (let _173_1469 = (let _173_1468 = (let _173_1467 = (let _173_1466 = (FStar_SMTEncoding_Term.mkImp (valid_a, valid_b))
in (_173_1466, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1467))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1468))
in (FStar_SMTEncoding_Term.mkForall _173_1469))
in (_173_1470, Some ("==> interpretation"), Some ("l_imp-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1471))
in (_173_1472)::[])))))))))
in (

let mk_iff_interp = (fun env iff tt -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let valid = (let _173_1481 = (let _173_1480 = (let _173_1479 = (FStar_SMTEncoding_Term.mkApp (iff, (a)::(b)::[]))
in (_173_1479)::[])
in ("Valid", _173_1480))
in (FStar_SMTEncoding_Term.mkApp _173_1481))
in (

let valid_a = (FStar_SMTEncoding_Term.mkApp ("Valid", (a)::[]))
in (

let valid_b = (FStar_SMTEncoding_Term.mkApp ("Valid", (b)::[]))
in (let _173_1488 = (let _173_1487 = (let _173_1486 = (let _173_1485 = (let _173_1484 = (let _173_1483 = (let _173_1482 = (FStar_SMTEncoding_Term.mkIff (valid_a, valid_b))
in (_173_1482, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1483))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1484))
in (FStar_SMTEncoding_Term.mkForall _173_1485))
in (_173_1486, Some ("<==> interpretation"), Some ("l_iff-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1487))
in (_173_1488)::[])))))))))
in (

let mk_forall_interp = (fun env for_all tt -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let xx = ("x", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let x = (FStar_SMTEncoding_Term.mkFreeV xx)
in (

let valid = (let _173_1497 = (let _173_1496 = (let _173_1495 = (FStar_SMTEncoding_Term.mkApp (for_all, (a)::(b)::[]))
in (_173_1495)::[])
in ("Valid", _173_1496))
in (FStar_SMTEncoding_Term.mkApp _173_1497))
in (

let valid_b_x = (let _173_1500 = (let _173_1499 = (let _173_1498 = (FStar_SMTEncoding_Term.mk_ApplyTT b x)
in (_173_1498)::[])
in ("Valid", _173_1499))
in (FStar_SMTEncoding_Term.mkApp _173_1500))
in (let _173_1514 = (let _173_1513 = (let _173_1512 = (let _173_1511 = (let _173_1510 = (let _173_1509 = (let _173_1508 = (let _173_1507 = (let _173_1506 = (let _173_1502 = (let _173_1501 = (FStar_SMTEncoding_Term.mk_HasTypeZ x a)
in (_173_1501)::[])
in (_173_1502)::[])
in (let _173_1505 = (let _173_1504 = (let _173_1503 = (FStar_SMTEncoding_Term.mk_HasTypeZ x a)
in (_173_1503, valid_b_x))
in (FStar_SMTEncoding_Term.mkImp _173_1504))
in (_173_1506, (xx)::[], _173_1505)))
in (FStar_SMTEncoding_Term.mkForall _173_1507))
in (_173_1508, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1509))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1510))
in (FStar_SMTEncoding_Term.mkForall _173_1511))
in (_173_1512, Some ("forall interpretation"), Some ("forall-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1513))
in (_173_1514)::[]))))))))))
in (

let mk_exists_interp = (fun env for_some tt -> (

let aa = ("a", FStar_SMTEncoding_Term.Term_sort)
in (

let bb = ("b", FStar_SMTEncoding_Term.Term_sort)
in (

let xx = ("x", FStar_SMTEncoding_Term.Term_sort)
in (

let a = (FStar_SMTEncoding_Term.mkFreeV aa)
in (

let b = (FStar_SMTEncoding_Term.mkFreeV bb)
in (

let x = (FStar_SMTEncoding_Term.mkFreeV xx)
in (

let valid = (let _173_1523 = (let _173_1522 = (let _173_1521 = (FStar_SMTEncoding_Term.mkApp (for_some, (a)::(b)::[]))
in (_173_1521)::[])
in ("Valid", _173_1522))
in (FStar_SMTEncoding_Term.mkApp _173_1523))
in (

let valid_b_x = (let _173_1526 = (let _173_1525 = (let _173_1524 = (FStar_SMTEncoding_Term.mk_ApplyTT b x)
in (_173_1524)::[])
in ("Valid", _173_1525))
in (FStar_SMTEncoding_Term.mkApp _173_1526))
in (let _173_1540 = (let _173_1539 = (let _173_1538 = (let _173_1537 = (let _173_1536 = (let _173_1535 = (let _173_1534 = (let _173_1533 = (let _173_1532 = (let _173_1528 = (let _173_1527 = (FStar_SMTEncoding_Term.mk_HasTypeZ x a)
in (_173_1527)::[])
in (_173_1528)::[])
in (let _173_1531 = (let _173_1530 = (let _173_1529 = (FStar_SMTEncoding_Term.mk_HasTypeZ x a)
in (_173_1529, valid_b_x))
in (FStar_SMTEncoding_Term.mkImp _173_1530))
in (_173_1532, (xx)::[], _173_1531)))
in (FStar_SMTEncoding_Term.mkExists _173_1533))
in (_173_1534, valid))
in (FStar_SMTEncoding_Term.mkIff _173_1535))
in (((valid)::[])::[], (aa)::(bb)::[], _173_1536))
in (FStar_SMTEncoding_Term.mkForall _173_1537))
in (_173_1538, Some ("exists interpretation"), Some ("exists-interp")))
in FStar_SMTEncoding_Term.Assume (_173_1539))
in (_173_1540)::[]))))))))))
in (

let mk_range_interp = (fun env range tt -> (

let range_ty = (FStar_SMTEncoding_Term.mkApp (range, []))
in (let _173_1551 = (let _173_1550 = (let _173_1549 = (FStar_SMTEncoding_Term.mk_HasTypeZ FStar_SMTEncoding_Term.mk_Range_const range_ty)
in (let _173_1548 = (let _173_1547 = (varops.fresh "typing_range_const")
in Some (_173_1547))
in (_173_1549, Some ("Range_const typing"), _173_1548)))
in FStar_SMTEncoding_Term.Assume (_173_1550))
in (_173_1551)::[])))
in (

let prims = ((FStar_Syntax_Const.unit_lid, mk_unit))::((FStar_Syntax_Const.bool_lid, mk_bool))::((FStar_Syntax_Const.int_lid, mk_int))::((FStar_Syntax_Const.string_lid, mk_str))::((FStar_Syntax_Const.ref_lid, mk_ref))::((FStar_Syntax_Const.false_lid, mk_false_interp))::((FStar_Syntax_Const.and_lid, mk_and_interp))::((FStar_Syntax_Const.or_lid, mk_or_interp))::((FStar_Syntax_Const.eq2_lid, mk_eq2_interp))::((FStar_Syntax_Const.imp_lid, mk_imp_interp))::((FStar_Syntax_Const.iff_lid, mk_iff_interp))::((FStar_Syntax_Const.forall_lid, mk_forall_interp))::((FStar_Syntax_Const.exists_lid, mk_exists_interp))::((FStar_Syntax_Const.range_lid, mk_range_interp))::[]
in (fun env t s tt -> (match ((FStar_Util.find_opt (fun _83_1933 -> (match (_83_1933) with
| (l, _83_1932) -> begin
(FStar_Ident.lid_equals l t)
end)) prims)) with
| None -> begin
[]
end
| Some (_83_1936, f) -> begin
(f env s tt)
end)))))))))))))))))))))


let rec encode_sigelt : env_t  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_SMTEncoding_Term.decls_t * env_t) = (fun env se -> (

let _83_1942 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env.tcenv) (FStar_Options.Other ("SMTEncoding"))) then begin
(let _173_1745 = (FStar_Syntax_Print.sigelt_to_string se)
in (FStar_All.pipe_left (FStar_Util.print1 ">>>>Encoding [%s]\n") _173_1745))
end else begin
()
end
in (

let nm = (match ((FStar_Syntax_Util.lid_of_sigelt se)) with
| None -> begin
""
end
| Some (l) -> begin
l.FStar_Ident.str
end)
in (

let _83_1950 = (encode_sigelt' env se)
in (match (_83_1950) with
| (g, e) -> begin
(match (g) with
| [] -> begin
(let _173_1748 = (let _173_1747 = (let _173_1746 = (FStar_Util.format1 "<Skipped %s/>" nm)
in FStar_SMTEncoding_Term.Caption (_173_1746))
in (_173_1747)::[])
in (_173_1748, e))
end
| _83_1953 -> begin
(let _173_1755 = (let _173_1754 = (let _173_1750 = (let _173_1749 = (FStar_Util.format1 "<Start encoding %s>" nm)
in FStar_SMTEncoding_Term.Caption (_173_1749))
in (_173_1750)::g)
in (let _173_1753 = (let _173_1752 = (let _173_1751 = (FStar_Util.format1 "</end encoding %s>" nm)
in FStar_SMTEncoding_Term.Caption (_173_1751))
in (_173_1752)::[])
in (FStar_List.append _173_1754 _173_1753)))
in (_173_1755, e))
end)
end)))))
and encode_sigelt' : env_t  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_SMTEncoding_Term.decls_t * env_t) = (fun env se -> (

let should_skip = (fun l -> false)
in (

let encode_top_level_val = (fun env lid t quals -> (

let tt = (norm env t)
in (

let _83_1966 = (encode_free_var env lid t tt quals)
in (match (_83_1966) with
| (decls, env) -> begin
if (FStar_Syntax_Util.is_smt_lemma t) then begin
(let _173_1769 = (let _173_1768 = (encode_smt_lemma env lid tt)
in (FStar_List.append decls _173_1768))
in (_173_1769, env))
end else begin
(decls, env)
end
end))))
in (

let encode_top_level_vals = (fun env bindings quals -> (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _83_1973 lb -> (match (_83_1973) with
| (decls, env) -> begin
(

let _83_1977 = (let _173_1778 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (encode_top_level_val env _173_1778 lb.FStar_Syntax_Syntax.lbtyp quals))
in (match (_83_1977) with
| (decls', env) -> begin
((FStar_List.append decls decls'), env)
end))
end)) ([], env))))
in (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect_for_free (_83_1979) -> begin
(FStar_All.failwith "impossible -- removed by tc.fs")
end
| (FStar_Syntax_Syntax.Sig_pragma (_)) | (FStar_Syntax_Syntax.Sig_main (_)) | (FStar_Syntax_Syntax.Sig_new_effect (_)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (_)) | (FStar_Syntax_Syntax.Sig_sub_effect (_)) -> begin
([], env)
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, _83_1998, _83_2000, _83_2002, _83_2004) when (FStar_Ident.lid_equals lid FStar_Syntax_Const.precedes_lid) -> begin
(

let _83_2010 = (new_term_constant_and_tok_from_lid env lid)
in (match (_83_2010) with
| (tname, ttok, env) -> begin
([], env)
end))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, _83_2013, t, quals, _83_2017) -> begin
(

let will_encode_definition = (not ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _83_13 -> (match (_83_13) with
| (FStar_Syntax_Syntax.Assumption) | (FStar_Syntax_Syntax.Projector (_)) | (FStar_Syntax_Syntax.Discriminator (_)) | (FStar_Syntax_Syntax.Irreducible) -> begin
true
end
| _83_2030 -> begin
false
end))))))
in if will_encode_definition then begin
([], env)
end else begin
(

let fv = (FStar_Syntax_Syntax.lid_as_fv lid FStar_Syntax_Syntax.Delta_constant None)
in (

let _83_2035 = (encode_top_level_val env fv t quals)
in (match (_83_2035) with
| (decls, env) -> begin
(

let tname = lid.FStar_Ident.str
in (

let tsym = (FStar_SMTEncoding_Term.mkFreeV (tname, FStar_SMTEncoding_Term.Term_sort))
in (let _173_1781 = (let _173_1780 = (primitive_type_axioms env.tcenv lid tname tsym)
in (FStar_List.append decls _173_1780))
in (_173_1781, env))))
end)))
end)
end
| FStar_Syntax_Syntax.Sig_assume (l, f, _83_2041, _83_2043) -> begin
(

let _83_2048 = (encode_formula f env)
in (match (_83_2048) with
| (f, decls) -> begin
(

let g = (let _173_1788 = (let _173_1787 = (let _173_1786 = (let _173_1783 = (let _173_1782 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format1 "Assumption: %s" _173_1782))
in Some (_173_1783))
in (let _173_1785 = (let _173_1784 = (varops.fresh (Prims.strcat "assumption_" l.FStar_Ident.str))
in Some (_173_1784))
in (f, _173_1786, _173_1785)))
in FStar_SMTEncoding_Term.Assume (_173_1787))
in (_173_1788)::[])
in ((FStar_List.append decls g), env))
end))
end
| FStar_Syntax_Syntax.Sig_let (lbs, r, _83_2053, quals) when (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Irreducible)) -> begin
(

let _83_2066 = (FStar_Util.fold_map (fun env lb -> (

let lid = (let _173_1792 = (let _173_1791 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in _173_1791.FStar_Syntax_Syntax.fv_name)
in _173_1792.FStar_Syntax_Syntax.v)
in if (let _173_1793 = (FStar_TypeChecker_Env.try_lookup_val_decl env.tcenv lid)
in (FStar_All.pipe_left FStar_Option.isNone _173_1793)) then begin
(

let val_decl = FStar_Syntax_Syntax.Sig_declare_typ ((lid, lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp, quals, r))
in (

let _83_2063 = (encode_sigelt' env val_decl)
in (match (_83_2063) with
| (decls, env) -> begin
(env, decls)
end)))
end else begin
(env, [])
end)) env (Prims.snd lbs))
in (match (_83_2066) with
| (env, decls) -> begin
((FStar_List.flatten decls), env)
end))
end
| FStar_Syntax_Syntax.Sig_let ((_83_2068, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inr (b2t); FStar_Syntax_Syntax.lbunivs = _83_2076; FStar_Syntax_Syntax.lbtyp = _83_2074; FStar_Syntax_Syntax.lbeff = _83_2072; FStar_Syntax_Syntax.lbdef = _83_2070})::[]), _83_2083, _83_2085, _83_2087) when (FStar_Syntax_Syntax.fv_eq_lid b2t FStar_Syntax_Const.b2t_lid) -> begin
(

let _83_2093 = (new_term_constant_and_tok_from_lid env b2t.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (match (_83_2093) with
| (tname, ttok, env) -> begin
(

let xx = ("x", FStar_SMTEncoding_Term.Term_sort)
in (

let x = (FStar_SMTEncoding_Term.mkFreeV xx)
in (

let valid_b2t_x = (let _173_1796 = (let _173_1795 = (let _173_1794 = (FStar_SMTEncoding_Term.mkApp ("Prims.b2t", (x)::[]))
in (_173_1794)::[])
in ("Valid", _173_1795))
in (FStar_SMTEncoding_Term.mkApp _173_1796))
in (

let decls = (let _173_1804 = (let _173_1803 = (let _173_1802 = (let _173_1801 = (let _173_1800 = (let _173_1799 = (let _173_1798 = (let _173_1797 = (FStar_SMTEncoding_Term.mkApp ("BoxBool_proj_0", (x)::[]))
in (valid_b2t_x, _173_1797))
in (FStar_SMTEncoding_Term.mkEq _173_1798))
in (((valid_b2t_x)::[])::[], (xx)::[], _173_1799))
in (FStar_SMTEncoding_Term.mkForall _173_1800))
in (_173_1801, Some ("b2t def"), Some ("b2t_def")))
in FStar_SMTEncoding_Term.Assume (_173_1802))
in (_173_1803)::[])
in (FStar_SMTEncoding_Term.DeclFun ((tname, (FStar_SMTEncoding_Term.Term_sort)::[], FStar_SMTEncoding_Term.Term_sort, None)))::_173_1804)
in (decls, env)))))
end))
end
| FStar_Syntax_Syntax.Sig_let (_83_2099, _83_2101, _83_2103, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some (fun _83_14 -> (match (_83_14) with
| (FStar_Syntax_Syntax.Discriminator (_)) | (FStar_Syntax_Syntax.Inline) -> begin
true
end
| _83_2113 -> begin
false
end)))) -> begin
([], env)
end
| FStar_Syntax_Syntax.Sig_let ((false, (lb)::[]), _83_2119, _83_2121, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some (fun _83_15 -> (match (_83_15) with
| FStar_Syntax_Syntax.Projector (_83_2127) -> begin
true
end
| _83_2130 -> begin
false
end)))) -> begin
(

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let l = fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in (match ((try_lookup_free_var env l)) with
| Some (_83_2134) -> begin
([], env)
end
| None -> begin
(

let se = FStar_Syntax_Syntax.Sig_declare_typ ((l, lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp, quals, (FStar_Ident.range_of_lid l)))
in (encode_sigelt env se))
end)))
end
| FStar_Syntax_Syntax.Sig_let ((is_rec, bindings), _83_2142, _83_2144, quals) -> begin
(

let eta_expand = (fun binders formals body t -> (

let nbinders = (FStar_List.length binders)
in (

let _83_2156 = (FStar_Util.first_N nbinders formals)
in (match (_83_2156) with
| (formals, extra_formals) -> begin
(

let subst = (FStar_List.map2 (fun _83_2160 _83_2164 -> (match ((_83_2160, _83_2164)) with
| ((formal, _83_2159), (binder, _83_2163)) -> begin
(let _173_1818 = (let _173_1817 = (FStar_Syntax_Syntax.bv_to_name binder)
in (formal, _173_1817))
in FStar_Syntax_Syntax.NT (_173_1818))
end)) formals binders)
in (

let extra_formals = (let _173_1822 = (FStar_All.pipe_right extra_formals (FStar_List.map (fun _83_2168 -> (match (_83_2168) with
| (x, i) -> begin
(let _173_1821 = (

let _83_2169 = x
in (let _173_1820 = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _83_2169.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _83_2169.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _173_1820}))
in (_173_1821, i))
end))))
in (FStar_All.pipe_right _173_1822 FStar_Syntax_Util.name_binders))
in (

let body = (let _173_1829 = (FStar_Syntax_Subst.compress body)
in (let _173_1828 = (let _173_1823 = (FStar_Syntax_Util.args_of_binders extra_formals)
in (FStar_All.pipe_left Prims.snd _173_1823))
in (let _173_1827 = (let _173_1826 = (let _173_1825 = (FStar_Syntax_Subst.subst subst t)
in _173_1825.FStar_Syntax_Syntax.n)
in (FStar_All.pipe_left (fun _173_1824 -> Some (_173_1824)) _173_1826))
in (FStar_Syntax_Syntax.extend_app_n _173_1829 _173_1828 _173_1827 body.FStar_Syntax_Syntax.pos))))
in ((FStar_List.append binders extra_formals), body))))
end))))
in (

let destruct_bound_function = (fun flid t_norm e -> (

let rec aux = (fun norm t_norm -> (match ((let _173_1840 = (FStar_Syntax_Util.unascribe e)
in _173_1840.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_abs (binders, body, lopt) -> begin
(

let _83_2188 = (FStar_Syntax_Subst.open_term' binders body)
in (match (_83_2188) with
| (binders, body, opening) -> begin
(match ((let _173_1841 = (FStar_Syntax_Subst.compress t_norm)
in _173_1841.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (formals, c) -> begin
(

let _83_2195 = (FStar_Syntax_Subst.open_comp formals c)
in (match (_83_2195) with
| (formals, c) -> begin
(

let nformals = (FStar_List.length formals)
in (

let nbinders = (FStar_List.length binders)
in (

let tres = (FStar_Syntax_Util.comp_result c)
in if ((nformals < nbinders) && (FStar_Syntax_Util.is_total_comp c)) then begin
(

let lopt = (subst_lcomp_opt opening lopt)
in (

let _83_2202 = (FStar_Util.first_N nformals binders)
in (match (_83_2202) with
| (bs0, rest) -> begin
(

let c = (

let subst = (FStar_List.map2 (fun _83_2206 _83_2210 -> (match ((_83_2206, _83_2210)) with
| ((b, _83_2205), (x, _83_2209)) -> begin
(let _173_1845 = (let _173_1844 = (FStar_Syntax_Syntax.bv_to_name x)
in (b, _173_1844))
in FStar_Syntax_Syntax.NT (_173_1845))
end)) bs0 formals)
in (FStar_Syntax_Subst.subst_comp subst c))
in (

let body = (FStar_Syntax_Util.abs rest body lopt)
in (bs0, body, bs0, (FStar_Syntax_Util.comp_result c))))
end)))
end else begin
if (nformals > nbinders) then begin
(

let _83_2216 = (eta_expand binders formals body tres)
in (match (_83_2216) with
| (binders, body) -> begin
(binders, body, formals, tres)
end))
end else begin
(binders, body, formals, tres)
end
end)))
end))
end
| FStar_Syntax_Syntax.Tm_refine (x, _83_2219) -> begin
(aux true x.FStar_Syntax_Syntax.sort)
end
| _83_2223 when (not (norm)) -> begin
(

let t_norm = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.AllowUnboundUniverses)::(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv t_norm)
in (aux true t_norm))
end
| _83_2226 -> begin
(let _173_1848 = (let _173_1847 = (FStar_Syntax_Print.term_to_string e)
in (let _173_1846 = (FStar_Syntax_Print.term_to_string t_norm)
in (FStar_Util.format3 "Impossible! let-bound lambda %s = %s has a type that\'s not a function: %s\n" flid.FStar_Ident.str _173_1847 _173_1846)))
in (FStar_All.failwith _173_1848))
end)
end))
end
| _83_2228 -> begin
(match ((let _173_1849 = (FStar_Syntax_Subst.compress t_norm)
in _173_1849.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (formals, c) -> begin
(

let _83_2235 = (FStar_Syntax_Subst.open_comp formals c)
in (match (_83_2235) with
| (formals, c) -> begin
(

let tres = (FStar_Syntax_Util.comp_result c)
in (

let _83_2239 = (eta_expand [] formals e tres)
in (match (_83_2239) with
| (binders, body) -> begin
(binders, body, formals, tres)
end)))
end))
end
| _83_2241 -> begin
([], e, [], t_norm)
end)
end))
in (aux false t_norm)))
in try
(match (()) with
| () -> begin
if (FStar_All.pipe_right bindings (FStar_Util.for_all (fun lb -> (FStar_Syntax_Util.is_lemma lb.FStar_Syntax_Syntax.lbtyp)))) then begin
(encode_top_level_vals env bindings quals)
end else begin
(

let _83_2269 = (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _83_2256 lb -> (match (_83_2256) with
| (toks, typs, decls, env) -> begin
(

let _83_2258 = if (FStar_Syntax_Util.is_lemma lb.FStar_Syntax_Syntax.lbtyp) then begin
(Prims.raise Let_rec_unencodeable)
end else begin
()
end
in (

let t_norm = (whnf env lb.FStar_Syntax_Syntax.lbtyp)
in (

let _83_2264 = (let _173_1854 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (declare_top_level_let env _173_1854 lb.FStar_Syntax_Syntax.lbtyp t_norm))
in (match (_83_2264) with
| (tok, decl, env) -> begin
(let _173_1857 = (let _173_1856 = (let _173_1855 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (_173_1855, tok))
in (_173_1856)::toks)
in (_173_1857, (t_norm)::typs, (decl)::decls, env))
end))))
end)) ([], [], [], env)))
in (match (_83_2269) with
| (toks, typs, decls, env) -> begin
(

let toks = (FStar_List.rev toks)
in (

let decls = (FStar_All.pipe_right (FStar_List.rev decls) FStar_List.flatten)
in (

let typs = (FStar_List.rev typs)
in if ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _83_16 -> (match (_83_16) with
| FStar_Syntax_Syntax.HasMaskedEffect -> begin
true
end
| _83_2276 -> begin
false
end)))) || (FStar_All.pipe_right typs (FStar_Util.for_some (fun t -> (let _173_1860 = (FStar_Syntax_Util.is_pure_or_ghost_function t)
in (FStar_All.pipe_left Prims.op_Negation _173_1860)))))) then begin
(decls, env)
end else begin
if (not (is_rec)) then begin
(match ((bindings, typs, toks)) with
| (({FStar_Syntax_Syntax.lbname = _83_2286; FStar_Syntax_Syntax.lbunivs = _83_2284; FStar_Syntax_Syntax.lbtyp = _83_2282; FStar_Syntax_Syntax.lbeff = _83_2280; FStar_Syntax_Syntax.lbdef = e})::[], (t_norm)::[], ((flid_fv, (f, ftok)))::[]) -> begin
(

let e = (FStar_Syntax_Subst.compress e)
in (

let flid = flid_fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in (

let _83_2306 = (destruct_bound_function flid t_norm e)
in (match (_83_2306) with
| (binders, body, _83_2303, _83_2305) -> begin
(

let _83_2313 = (encode_binders None binders env)
in (match (_83_2313) with
| (vars, guards, env', binder_decls, _83_2312) -> begin
(

let app = (match (vars) with
| [] -> begin
(FStar_SMTEncoding_Term.mkFreeV (f, FStar_SMTEncoding_Term.Term_sort))
end
| _83_2316 -> begin
(let _173_1862 = (let _173_1861 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (f, _173_1861))
in (FStar_SMTEncoding_Term.mkApp _173_1862))
end)
in (

let _83_2322 = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Logic)) then begin
(let _173_1864 = (FStar_SMTEncoding_Term.mk_Valid app)
in (let _173_1863 = (encode_formula body env')
in (_173_1864, _173_1863)))
end else begin
(let _173_1865 = (encode_term body env')
in (app, _173_1865))
end
in (match (_83_2322) with
| (app, (body, decls2)) -> begin
(

let eqn = (let _173_1871 = (let _173_1870 = (let _173_1867 = (let _173_1866 = (FStar_SMTEncoding_Term.mkEq (app, body))
in (((app)::[])::[], vars, _173_1866))
in (FStar_SMTEncoding_Term.mkForall _173_1867))
in (let _173_1869 = (let _173_1868 = (FStar_Util.format1 "Equation for %s" flid.FStar_Ident.str)
in Some (_173_1868))
in (_173_1870, _173_1869, Some ((Prims.strcat "equation_" f)))))
in FStar_SMTEncoding_Term.Assume (_173_1871))
in (let _173_1873 = (let _173_1872 = (primitive_type_axioms env.tcenv flid f app)
in (FStar_List.append (FStar_List.append (FStar_List.append (FStar_List.append decls binder_decls) decls2) ((eqn)::[])) _173_1872))
in (_173_1873, env)))
end)))
end))
end))))
end
| _83_2325 -> begin
(FStar_All.failwith "Impossible")
end)
end else begin
(

let fuel = (let _173_1874 = (varops.fresh "fuel")
in (_173_1874, FStar_SMTEncoding_Term.Fuel_sort))
in (

let fuel_tm = (FStar_SMTEncoding_Term.mkFreeV fuel)
in (

let env0 = env
in (

let _83_2343 = (FStar_All.pipe_right toks (FStar_List.fold_left (fun _83_2331 _83_2336 -> (match ((_83_2331, _83_2336)) with
| ((gtoks, env), (flid_fv, (f, ftok))) -> begin
(

let flid = flid_fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in (

let g = (varops.new_fvar flid)
in (

let gtok = (varops.new_fvar flid)
in (

let env = (let _173_1879 = (let _173_1878 = (FStar_SMTEncoding_Term.mkApp (g, (fuel_tm)::[]))
in (FStar_All.pipe_left (fun _173_1877 -> Some (_173_1877)) _173_1878))
in (push_free_var env flid gtok _173_1879))
in (((flid, f, ftok, g, gtok))::gtoks, env)))))
end)) ([], env)))
in (match (_83_2343) with
| (gtoks, env) -> begin
(

let gtoks = (FStar_List.rev gtoks)
in (

let encode_one_binding = (fun env0 _83_2352 t_norm _83_2363 -> (match ((_83_2352, _83_2363)) with
| ((flid, f, ftok, g, gtok), {FStar_Syntax_Syntax.lbname = _83_2362; FStar_Syntax_Syntax.lbunivs = _83_2360; FStar_Syntax_Syntax.lbtyp = _83_2358; FStar_Syntax_Syntax.lbeff = _83_2356; FStar_Syntax_Syntax.lbdef = e}) -> begin
(

let _83_2368 = (destruct_bound_function flid t_norm e)
in (match (_83_2368) with
| (binders, body, formals, tres) -> begin
(

let _83_2375 = (encode_binders None binders env)
in (match (_83_2375) with
| (vars, guards, env', binder_decls, _83_2374) -> begin
(

let decl_g = (let _173_1890 = (let _173_1889 = (let _173_1888 = (FStar_List.map Prims.snd vars)
in (FStar_SMTEncoding_Term.Fuel_sort)::_173_1888)
in (g, _173_1889, FStar_SMTEncoding_Term.Term_sort, Some ("Fuel-instrumented function name")))
in FStar_SMTEncoding_Term.DeclFun (_173_1890))
in (

let env0 = (push_zfuel_name env0 flid g)
in (

let decl_g_tok = FStar_SMTEncoding_Term.DeclFun ((gtok, [], FStar_SMTEncoding_Term.Term_sort, Some ("Token for fuel-instrumented partial applications")))
in (

let vars_tm = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (

let app = (FStar_SMTEncoding_Term.mkApp (f, vars_tm))
in (

let gsapp = (let _173_1893 = (let _173_1892 = (let _173_1891 = (FStar_SMTEncoding_Term.mkApp ("SFuel", (fuel_tm)::[]))
in (_173_1891)::vars_tm)
in (g, _173_1892))
in (FStar_SMTEncoding_Term.mkApp _173_1893))
in (

let gmax = (let _173_1896 = (let _173_1895 = (let _173_1894 = (FStar_SMTEncoding_Term.mkApp ("MaxFuel", []))
in (_173_1894)::vars_tm)
in (g, _173_1895))
in (FStar_SMTEncoding_Term.mkApp _173_1896))
in (

let _83_2385 = (encode_term body env')
in (match (_83_2385) with
| (body_tm, decls2) -> begin
(

let eqn_g = (let _173_1902 = (let _173_1901 = (let _173_1898 = (let _173_1897 = (FStar_SMTEncoding_Term.mkEq (gsapp, body_tm))
in (((gsapp)::[])::[], (fuel)::vars, _173_1897))
in (FStar_SMTEncoding_Term.mkForall _173_1898))
in (let _173_1900 = (let _173_1899 = (FStar_Util.format1 "Equation for fuel-instrumented recursive function: %s" flid.FStar_Ident.str)
in Some (_173_1899))
in (_173_1901, _173_1900, Some ((Prims.strcat "equation_with_fuel_" g)))))
in FStar_SMTEncoding_Term.Assume (_173_1902))
in (

let eqn_f = (let _173_1906 = (let _173_1905 = (let _173_1904 = (let _173_1903 = (FStar_SMTEncoding_Term.mkEq (app, gmax))
in (((app)::[])::[], vars, _173_1903))
in (FStar_SMTEncoding_Term.mkForall _173_1904))
in (_173_1905, Some ("Correspondence of recursive function to instrumented version"), Some ((Prims.strcat "fuel_correspondence_" g))))
in FStar_SMTEncoding_Term.Assume (_173_1906))
in (

let eqn_g' = (let _173_1915 = (let _173_1914 = (let _173_1913 = (let _173_1912 = (let _173_1911 = (let _173_1910 = (let _173_1909 = (let _173_1908 = (let _173_1907 = (FStar_SMTEncoding_Term.n_fuel 0)
in (_173_1907)::vars_tm)
in (g, _173_1908))
in (FStar_SMTEncoding_Term.mkApp _173_1909))
in (gsapp, _173_1910))
in (FStar_SMTEncoding_Term.mkEq _173_1911))
in (((gsapp)::[])::[], (fuel)::vars, _173_1912))
in (FStar_SMTEncoding_Term.mkForall _173_1913))
in (_173_1914, Some ("Fuel irrelevance"), Some ((Prims.strcat "fuel_irrelevance_" g))))
in FStar_SMTEncoding_Term.Assume (_173_1915))
in (

let _83_2408 = (

let _83_2395 = (encode_binders None formals env0)
in (match (_83_2395) with
| (vars, v_guards, env, binder_decls, _83_2394) -> begin
(

let vars_tm = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (

let gapp = (FStar_SMTEncoding_Term.mkApp (g, (fuel_tm)::vars_tm))
in (

let tok_corr = (

let tok_app = (let _173_1916 = (FStar_SMTEncoding_Term.mkFreeV (gtok, FStar_SMTEncoding_Term.Term_sort))
in (mk_Apply _173_1916 ((fuel)::vars)))
in (let _173_1920 = (let _173_1919 = (let _173_1918 = (let _173_1917 = (FStar_SMTEncoding_Term.mkEq (tok_app, gapp))
in (((tok_app)::[])::[], (fuel)::vars, _173_1917))
in (FStar_SMTEncoding_Term.mkForall _173_1918))
in (_173_1919, Some ("Fuel token correspondence"), Some ((Prims.strcat "fuel_tokem_correspondence_" gtok))))
in FStar_SMTEncoding_Term.Assume (_173_1920)))
in (

let _83_2405 = (

let _83_2402 = (encode_term_pred None tres env gapp)
in (match (_83_2402) with
| (g_typing, d3) -> begin
(let _173_1928 = (let _173_1927 = (let _173_1926 = (let _173_1925 = (let _173_1924 = (let _173_1923 = (let _173_1922 = (let _173_1921 = (FStar_SMTEncoding_Term.mk_and_l v_guards)
in (_173_1921, g_typing))
in (FStar_SMTEncoding_Term.mkImp _173_1922))
in (((gapp)::[])::[], (fuel)::vars, _173_1923))
in (FStar_SMTEncoding_Term.mkForall _173_1924))
in (_173_1925, Some ("Typing correspondence of token to term"), Some ((Prims.strcat "token_correspondence_" g))))
in FStar_SMTEncoding_Term.Assume (_173_1926))
in (_173_1927)::[])
in (d3, _173_1928))
end))
in (match (_83_2405) with
| (aux_decls, typing_corr) -> begin
((FStar_List.append binder_decls aux_decls), (FStar_List.append typing_corr ((tok_corr)::[])))
end)))))
end))
in (match (_83_2408) with
| (aux_decls, g_typing) -> begin
((FStar_List.append (FStar_List.append (FStar_List.append binder_decls decls2) aux_decls) ((decl_g)::(decl_g_tok)::[])), (FStar_List.append ((eqn_g)::(eqn_g')::(eqn_f)::[]) g_typing), env0)
end)))))
end)))))))))
end))
end))
end))
in (

let _83_2424 = (let _173_1931 = (FStar_List.zip3 gtoks typs bindings)
in (FStar_List.fold_left (fun _83_2412 _83_2416 -> (match ((_83_2412, _83_2416)) with
| ((decls, eqns, env0), (gtok, ty, bs)) -> begin
(

let _83_2420 = (encode_one_binding env0 gtok ty bs)
in (match (_83_2420) with
| (decls', eqns', env0) -> begin
((decls')::decls, (FStar_List.append eqns' eqns), env0)
end))
end)) ((decls)::[], [], env0) _173_1931))
in (match (_83_2424) with
| (decls, eqns, env0) -> begin
(

let _83_2433 = (let _173_1933 = (FStar_All.pipe_right decls FStar_List.flatten)
in (FStar_All.pipe_right _173_1933 (FStar_List.partition (fun _83_17 -> (match (_83_17) with
| FStar_SMTEncoding_Term.DeclFun (_83_2427) -> begin
true
end
| _83_2430 -> begin
false
end)))))
in (match (_83_2433) with
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

let msg = (let _173_1936 = (FStar_All.pipe_right bindings (FStar_List.map (fun lb -> (FStar_Syntax_Print.lbname_to_string lb.FStar_Syntax_Syntax.lbname))))
in (FStar_All.pipe_right _173_1936 (FStar_String.concat " and ")))
in (

let decl = FStar_SMTEncoding_Term.Caption ((Prims.strcat "let rec unencodeable: Skipping: " msg))
in ((decl)::[], env)))
end))
end
| FStar_Syntax_Syntax.Sig_bundle (ses, _83_2437, _83_2439, _83_2441) -> begin
(

let _83_2446 = (encode_signature env ses)
in (match (_83_2446) with
| (g, env) -> begin
(

let _83_2460 = (FStar_All.pipe_right g (FStar_List.partition (fun _83_18 -> (match (_83_18) with
| FStar_SMTEncoding_Term.Assume (_83_2449, Some ("inversion axiom"), _83_2453) -> begin
false
end
| _83_2457 -> begin
true
end))))
in (match (_83_2460) with
| (g', inversions) -> begin
(

let _83_2469 = (FStar_All.pipe_right g' (FStar_List.partition (fun _83_19 -> (match (_83_19) with
| FStar_SMTEncoding_Term.DeclFun (_83_2463) -> begin
true
end
| _83_2466 -> begin
false
end))))
in (match (_83_2469) with
| (decls, rest) -> begin
((FStar_List.append (FStar_List.append decls rest) inversions), env)
end))
end))
end))
end
| FStar_Syntax_Syntax.Sig_inductive_typ (t, _83_2472, tps, k, _83_2476, datas, quals, _83_2480) -> begin
(

let is_logical = (FStar_All.pipe_right quals (FStar_Util.for_some (fun _83_20 -> (match (_83_20) with
| (FStar_Syntax_Syntax.Logic) | (FStar_Syntax_Syntax.Assumption) -> begin
true
end
| _83_2487 -> begin
false
end))))
in (

let constructor_or_logic_type_decl = (fun c -> if is_logical then begin
(

let _83_2499 = c
in (match (_83_2499) with
| (name, args, _83_2494, _83_2496, _83_2498) -> begin
(let _173_1944 = (let _173_1943 = (let _173_1942 = (FStar_All.pipe_right args (FStar_List.map Prims.snd))
in (name, _173_1942, FStar_SMTEncoding_Term.Term_sort, None))
in FStar_SMTEncoding_Term.DeclFun (_173_1943))
in (_173_1944)::[])
end))
end else begin
(FStar_SMTEncoding_Term.constructor_to_decl c)
end)
in (

let inversion_axioms = (fun tapp vars -> if (FStar_All.pipe_right datas (FStar_Util.for_some (fun l -> (let _173_1950 = (FStar_TypeChecker_Env.try_lookup_lid env.tcenv l)
in (FStar_All.pipe_right _173_1950 FStar_Option.isNone))))) then begin
[]
end else begin
(

let _83_2506 = (fresh_fvar "x" FStar_SMTEncoding_Term.Term_sort)
in (match (_83_2506) with
| (xxsym, xx) -> begin
(

let _83_2542 = (FStar_All.pipe_right datas (FStar_List.fold_left (fun _83_2509 l -> (match (_83_2509) with
| (out, decls) -> begin
(

let _83_2514 = (FStar_TypeChecker_Env.lookup_datacon env.tcenv l)
in (match (_83_2514) with
| (_83_2512, data_t) -> begin
(

let _83_2517 = (FStar_Syntax_Util.arrow_formals data_t)
in (match (_83_2517) with
| (args, res) -> begin
(

let indices = (match ((let _173_1953 = (FStar_Syntax_Subst.compress res)
in _173_1953.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_app (_83_2519, indices) -> begin
indices
end
| _83_2524 -> begin
[]
end)
in (

let env = (FStar_All.pipe_right args (FStar_List.fold_left (fun env _83_2530 -> (match (_83_2530) with
| (x, _83_2529) -> begin
(let _173_1958 = (let _173_1957 = (let _173_1956 = (mk_term_projector_name l x)
in (_173_1956, (xx)::[]))
in (FStar_SMTEncoding_Term.mkApp _173_1957))
in (push_term_var env x _173_1958))
end)) env))
in (

let _83_2534 = (encode_args indices env)
in (match (_83_2534) with
| (indices, decls') -> begin
(

let _83_2535 = if ((FStar_List.length indices) <> (FStar_List.length vars)) then begin
(FStar_All.failwith "Impossible")
end else begin
()
end
in (

let eqs = (let _173_1963 = (FStar_List.map2 (fun v a -> (let _173_1962 = (let _173_1961 = (FStar_SMTEncoding_Term.mkFreeV v)
in (_173_1961, a))
in (FStar_SMTEncoding_Term.mkEq _173_1962))) vars indices)
in (FStar_All.pipe_right _173_1963 FStar_SMTEncoding_Term.mk_and_l))
in (let _173_1968 = (let _173_1967 = (let _173_1966 = (let _173_1965 = (let _173_1964 = (mk_data_tester env l xx)
in (_173_1964, eqs))
in (FStar_SMTEncoding_Term.mkAnd _173_1965))
in (out, _173_1966))
in (FStar_SMTEncoding_Term.mkOr _173_1967))
in (_173_1968, (FStar_List.append decls decls')))))
end))))
end))
end))
end)) (FStar_SMTEncoding_Term.mkFalse, [])))
in (match (_83_2542) with
| (data_ax, decls) -> begin
(

let _83_2545 = (fresh_fvar "f" FStar_SMTEncoding_Term.Fuel_sort)
in (match (_83_2545) with
| (ffsym, ff) -> begin
(

let fuel_guarded_inversion = (

let xx_has_type_sfuel = if ((FStar_List.length datas) > 1) then begin
(let _173_1969 = (FStar_SMTEncoding_Term.mkApp ("SFuel", (ff)::[]))
in (FStar_SMTEncoding_Term.mk_HasTypeFuel _173_1969 xx tapp))
end else begin
(FStar_SMTEncoding_Term.mk_HasTypeFuel ff xx tapp)
end
in (let _173_1976 = (let _173_1975 = (let _173_1972 = (let _173_1971 = (add_fuel (ffsym, FStar_SMTEncoding_Term.Fuel_sort) (((xxsym, FStar_SMTEncoding_Term.Term_sort))::vars))
in (let _173_1970 = (FStar_SMTEncoding_Term.mkImp (xx_has_type_sfuel, data_ax))
in (((xx_has_type_sfuel)::[])::[], _173_1971, _173_1970)))
in (FStar_SMTEncoding_Term.mkForall _173_1972))
in (let _173_1974 = (let _173_1973 = (varops.fresh (Prims.strcat "fuel_guarded_inversion_" t.FStar_Ident.str))
in Some (_173_1973))
in (_173_1975, Some ("inversion axiom"), _173_1974)))
in FStar_SMTEncoding_Term.Assume (_173_1976)))
in (

let pattern_guarded_inversion = if ((contains_name env "Prims.inversion") && ((FStar_List.length datas) > 1)) then begin
(

let xx_has_type_fuel = (FStar_SMTEncoding_Term.mk_HasTypeFuel ff xx tapp)
in (

let pattern_guard = (FStar_SMTEncoding_Term.mkApp ("Prims.inversion", (tapp)::[]))
in (let _173_1984 = (let _173_1983 = (let _173_1982 = (let _173_1979 = (let _173_1978 = (add_fuel (ffsym, FStar_SMTEncoding_Term.Fuel_sort) (((xxsym, FStar_SMTEncoding_Term.Term_sort))::vars))
in (let _173_1977 = (FStar_SMTEncoding_Term.mkImp (xx_has_type_fuel, data_ax))
in (((xx_has_type_fuel)::(pattern_guard)::[])::[], _173_1978, _173_1977)))
in (FStar_SMTEncoding_Term.mkForall _173_1979))
in (let _173_1981 = (let _173_1980 = (varops.fresh (Prims.strcat "pattern_guarded_inversion_" t.FStar_Ident.str))
in Some (_173_1980))
in (_173_1982, Some ("inversion axiom"), _173_1981)))
in FStar_SMTEncoding_Term.Assume (_173_1983))
in (_173_1984)::[])))
end else begin
[]
end
in (FStar_List.append (FStar_List.append decls ((fuel_guarded_inversion)::[])) pattern_guarded_inversion)))
end))
end))
end))
end)
in (

let _83_2559 = (match ((let _173_1985 = (FStar_Syntax_Subst.compress k)
in _173_1985.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (formals, kres) -> begin
((FStar_List.append tps formals), (FStar_Syntax_Util.comp_result kres))
end
| _83_2556 -> begin
(tps, k)
end)
in (match (_83_2559) with
| (formals, res) -> begin
(

let _83_2562 = (FStar_Syntax_Subst.open_term formals res)
in (match (_83_2562) with
| (formals, res) -> begin
(

let _83_2569 = (encode_binders None formals env)
in (match (_83_2569) with
| (vars, guards, env', binder_decls, _83_2568) -> begin
(

let _83_2573 = (new_term_constant_and_tok_from_lid env t)
in (match (_83_2573) with
| (tname, ttok, env) -> begin
(

let ttok_tm = (FStar_SMTEncoding_Term.mkApp (ttok, []))
in (

let guard = (FStar_SMTEncoding_Term.mk_and_l guards)
in (

let tapp = (let _173_1987 = (let _173_1986 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (tname, _173_1986))
in (FStar_SMTEncoding_Term.mkApp _173_1987))
in (

let _83_2594 = (

let tname_decl = (let _173_1991 = (let _173_1990 = (FStar_All.pipe_right vars (FStar_List.map (fun _83_2579 -> (match (_83_2579) with
| (n, s) -> begin
((Prims.strcat tname n), s)
end))))
in (let _173_1989 = (varops.next_id ())
in (tname, _173_1990, FStar_SMTEncoding_Term.Term_sort, _173_1989, false)))
in (constructor_or_logic_type_decl _173_1991))
in (

let _83_2591 = (match (vars) with
| [] -> begin
(let _173_1995 = (let _173_1994 = (let _173_1993 = (FStar_SMTEncoding_Term.mkApp (tname, []))
in (FStar_All.pipe_left (fun _173_1992 -> Some (_173_1992)) _173_1993))
in (push_free_var env t tname _173_1994))
in ([], _173_1995))
end
| _83_2583 -> begin
(

let ttok_decl = FStar_SMTEncoding_Term.DeclFun ((ttok, [], FStar_SMTEncoding_Term.Term_sort, Some ("token")))
in (

let ttok_fresh = (let _173_1996 = (varops.next_id ())
in (FStar_SMTEncoding_Term.fresh_token (ttok, FStar_SMTEncoding_Term.Term_sort) _173_1996))
in (

let ttok_app = (mk_Apply ttok_tm vars)
in (

let pats = ((ttok_app)::[])::((tapp)::[])::[]
in (

let name_tok_corr = (let _173_2000 = (let _173_1999 = (let _173_1998 = (let _173_1997 = (FStar_SMTEncoding_Term.mkEq (ttok_app, tapp))
in (pats, None, vars, _173_1997))
in (FStar_SMTEncoding_Term.mkForall' _173_1998))
in (_173_1999, Some ("name-token correspondence"), Some ((Prims.strcat "token_correspondence_" ttok))))
in FStar_SMTEncoding_Term.Assume (_173_2000))
in ((ttok_decl)::(ttok_fresh)::(name_tok_corr)::[], env))))))
end)
in (match (_83_2591) with
| (tok_decls, env) -> begin
((FStar_List.append tname_decl tok_decls), env)
end)))
in (match (_83_2594) with
| (decls, env) -> begin
(

let kindingAx = (

let _83_2597 = (encode_term_pred None res env' tapp)
in (match (_83_2597) with
| (k, decls) -> begin
(

let karr = if ((FStar_List.length formals) > 0) then begin
(let _173_2004 = (let _173_2003 = (let _173_2002 = (let _173_2001 = (FStar_SMTEncoding_Term.mk_PreType ttok_tm)
in (FStar_SMTEncoding_Term.mk_tester "Tm_arrow" _173_2001))
in (_173_2002, Some ("kinding"), Some ((Prims.strcat "pre_kinding_" ttok))))
in FStar_SMTEncoding_Term.Assume (_173_2003))
in (_173_2004)::[])
end else begin
[]
end
in (let _173_2010 = (let _173_2009 = (let _173_2008 = (let _173_2007 = (let _173_2006 = (let _173_2005 = (FStar_SMTEncoding_Term.mkImp (guard, k))
in (((tapp)::[])::[], vars, _173_2005))
in (FStar_SMTEncoding_Term.mkForall _173_2006))
in (_173_2007, None, Some ((Prims.strcat "kinding_" ttok))))
in FStar_SMTEncoding_Term.Assume (_173_2008))
in (_173_2009)::[])
in (FStar_List.append (FStar_List.append decls karr) _173_2010)))
end))
in (

let aux = (let _173_2014 = (let _173_2011 = (inversion_axioms tapp vars)
in (FStar_List.append kindingAx _173_2011))
in (let _173_2013 = (let _173_2012 = (pretype_axiom tapp vars)
in (_173_2012)::[])
in (FStar_List.append _173_2014 _173_2013)))
in (

let g = (FStar_List.append (FStar_List.append decls binder_decls) aux)
in (g, env))))
end)))))
end))
end))
end))
end)))))
end
| FStar_Syntax_Syntax.Sig_datacon (d, _83_2604, _83_2606, _83_2608, _83_2610, _83_2612, _83_2614, _83_2616) when (FStar_Ident.lid_equals d FStar_Syntax_Const.lexcons_lid) -> begin
([], env)
end
| FStar_Syntax_Syntax.Sig_datacon (d, _83_2621, t, _83_2624, n_tps, quals, _83_2628, drange) -> begin
(

let _83_2635 = (new_term_constant_and_tok_from_lid env d)
in (match (_83_2635) with
| (ddconstrsym, ddtok, env) -> begin
(

let ddtok_tm = (FStar_SMTEncoding_Term.mkApp (ddtok, []))
in (

let _83_2639 = (FStar_Syntax_Util.arrow_formals t)
in (match (_83_2639) with
| (formals, t_res) -> begin
(

let _83_2642 = (fresh_fvar "f" FStar_SMTEncoding_Term.Fuel_sort)
in (match (_83_2642) with
| (fuel_var, fuel_tm) -> begin
(

let s_fuel_tm = (FStar_SMTEncoding_Term.mkApp ("SFuel", (fuel_tm)::[]))
in (

let _83_2649 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_83_2649) with
| (vars, guards, env', binder_decls, names) -> begin
(

let projectors = (FStar_All.pipe_right names (FStar_List.map (fun x -> (let _173_2016 = (mk_term_projector_name d x)
in (_173_2016, FStar_SMTEncoding_Term.Term_sort)))))
in (

let datacons = (let _173_2018 = (let _173_2017 = (varops.next_id ())
in (ddconstrsym, projectors, FStar_SMTEncoding_Term.Term_sort, _173_2017, true))
in (FStar_All.pipe_right _173_2018 FStar_SMTEncoding_Term.constructor_to_decl))
in (

let app = (mk_Apply ddtok_tm vars)
in (

let guard = (FStar_SMTEncoding_Term.mk_and_l guards)
in (

let xvars = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (

let dapp = (FStar_SMTEncoding_Term.mkApp (ddconstrsym, xvars))
in (

let _83_2659 = (encode_term_pred None t env ddtok_tm)
in (match (_83_2659) with
| (tok_typing, decls3) -> begin
(

let _83_2666 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_83_2666) with
| (vars', guards', env'', decls_formals, _83_2665) -> begin
(

let _83_2671 = (

let xvars = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars')
in (

let dapp = (FStar_SMTEncoding_Term.mkApp (ddconstrsym, xvars))
in (encode_term_pred (Some (fuel_tm)) t_res env'' dapp)))
in (match (_83_2671) with
| (ty_pred', decls_pred) -> begin
(

let guard' = (FStar_SMTEncoding_Term.mk_and_l guards')
in (

let proxy_fresh = (match (formals) with
| [] -> begin
[]
end
| _83_2675 -> begin
(let _173_2020 = (let _173_2019 = (varops.next_id ())
in (FStar_SMTEncoding_Term.fresh_token (ddtok, FStar_SMTEncoding_Term.Term_sort) _173_2019))
in (_173_2020)::[])
end)
in (

let encode_elim = (fun _83_2678 -> (match (()) with
| () -> begin
(

let _83_2681 = (FStar_Syntax_Util.head_and_args t_res)
in (match (_83_2681) with
| (head, args) -> begin
(match ((let _173_2023 = (FStar_Syntax_Subst.compress head)
in _173_2023.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_fvar (fv)) -> begin
(

let encoded_head = (lookup_free_var_name env' fv.FStar_Syntax_Syntax.fv_name)
in (

let _83_2699 = (encode_args args env')
in (match (_83_2699) with
| (encoded_args, arg_decls) -> begin
(

let _83_2714 = (FStar_List.fold_left (fun _83_2703 arg -> (match (_83_2703) with
| (env, arg_vars, eqns) -> begin
(

let _83_2709 = (let _173_2026 = (FStar_Syntax_Syntax.new_bv None FStar_Syntax_Syntax.tun)
in (gen_term_var env _173_2026))
in (match (_83_2709) with
| (_83_2706, xv, env) -> begin
(let _173_2028 = (let _173_2027 = (FStar_SMTEncoding_Term.mkEq (arg, xv))
in (_173_2027)::eqns)
in (env, (xv)::arg_vars, _173_2028))
end))
end)) (env', [], []) encoded_args)
in (match (_83_2714) with
| (_83_2711, arg_vars, eqns) -> begin
(

let arg_vars = (FStar_List.rev arg_vars)
in (

let ty = (FStar_SMTEncoding_Term.mkApp (encoded_head, arg_vars))
in (

let xvars = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (

let dapp = (FStar_SMTEncoding_Term.mkApp (ddconstrsym, xvars))
in (

let ty_pred = (FStar_SMTEncoding_Term.mk_HasTypeWithFuel (Some (s_fuel_tm)) dapp ty)
in (

let arg_binders = (FStar_List.map FStar_SMTEncoding_Term.fv_of_term arg_vars)
in (

let typing_inversion = (let _173_2035 = (let _173_2034 = (let _173_2033 = (let _173_2032 = (add_fuel (fuel_var, FStar_SMTEncoding_Term.Fuel_sort) (FStar_List.append vars arg_binders))
in (let _173_2031 = (let _173_2030 = (let _173_2029 = (FStar_SMTEncoding_Term.mk_and_l (FStar_List.append eqns guards))
in (ty_pred, _173_2029))
in (FStar_SMTEncoding_Term.mkImp _173_2030))
in (((ty_pred)::[])::[], _173_2032, _173_2031)))
in (FStar_SMTEncoding_Term.mkForall _173_2033))
in (_173_2034, Some ("data constructor typing elim"), Some ((Prims.strcat "data_elim_" ddconstrsym))))
in FStar_SMTEncoding_Term.Assume (_173_2035))
in (

let subterm_ordering = if (FStar_Ident.lid_equals d FStar_Syntax_Const.lextop_lid) then begin
(

let x = (let _173_2036 = (varops.fresh "x")
in (_173_2036, FStar_SMTEncoding_Term.Term_sort))
in (

let xtm = (FStar_SMTEncoding_Term.mkFreeV x)
in (let _173_2048 = (let _173_2047 = (let _173_2044 = (let _173_2043 = (let _173_2038 = (let _173_2037 = (FStar_SMTEncoding_Term.mk_Precedes xtm dapp)
in (_173_2037)::[])
in (_173_2038)::[])
in (let _173_2042 = (let _173_2041 = (let _173_2040 = (FStar_SMTEncoding_Term.mk_tester "LexCons" xtm)
in (let _173_2039 = (FStar_SMTEncoding_Term.mk_Precedes xtm dapp)
in (_173_2040, _173_2039)))
in (FStar_SMTEncoding_Term.mkImp _173_2041))
in (_173_2043, (x)::[], _173_2042)))
in (FStar_SMTEncoding_Term.mkForall _173_2044))
in (let _173_2046 = (let _173_2045 = (varops.fresh "lextop")
in Some (_173_2045))
in (_173_2047, Some ("lextop is top"), _173_2046)))
in FStar_SMTEncoding_Term.Assume (_173_2048))))
end else begin
(

let prec = (FStar_All.pipe_right vars (FStar_List.collect (fun v -> (match ((Prims.snd v)) with
| FStar_SMTEncoding_Term.Fuel_sort -> begin
[]
end
| FStar_SMTEncoding_Term.Term_sort -> begin
(let _173_2051 = (let _173_2050 = (FStar_SMTEncoding_Term.mkFreeV v)
in (FStar_SMTEncoding_Term.mk_Precedes _173_2050 dapp))
in (_173_2051)::[])
end
| _83_2728 -> begin
(FStar_All.failwith "unexpected sort")
end))))
in (let _173_2058 = (let _173_2057 = (let _173_2056 = (let _173_2055 = (add_fuel (fuel_var, FStar_SMTEncoding_Term.Fuel_sort) (FStar_List.append vars arg_binders))
in (let _173_2054 = (let _173_2053 = (let _173_2052 = (FStar_SMTEncoding_Term.mk_and_l prec)
in (ty_pred, _173_2052))
in (FStar_SMTEncoding_Term.mkImp _173_2053))
in (((ty_pred)::[])::[], _173_2055, _173_2054)))
in (FStar_SMTEncoding_Term.mkForall _173_2056))
in (_173_2057, Some ("subterm ordering"), Some ((Prims.strcat "subterm_ordering_" ddconstrsym))))
in FStar_SMTEncoding_Term.Assume (_173_2058)))
end
in (arg_decls, (typing_inversion)::(subterm_ordering)::[])))))))))
end))
end)))
end
| _83_2732 -> begin
(

let _83_2733 = (let _173_2061 = (let _173_2060 = (FStar_Syntax_Print.lid_to_string d)
in (let _173_2059 = (FStar_Syntax_Print.term_to_string head)
in (FStar_Util.format2 "Constructor %s builds an unexpected type %s\n" _173_2060 _173_2059)))
in (FStar_TypeChecker_Errors.warn drange _173_2061))
in ([], []))
end)
end))
end))
in (

let _83_2737 = (encode_elim ())
in (match (_83_2737) with
| (decls2, elim) -> begin
(

let g = (let _173_2086 = (let _173_2085 = (let _173_2070 = (let _173_2069 = (let _173_2068 = (let _173_2067 = (let _173_2066 = (let _173_2065 = (let _173_2064 = (let _173_2063 = (let _173_2062 = (FStar_Syntax_Print.lid_to_string d)
in (FStar_Util.format1 "data constructor proxy: %s" _173_2062))
in Some (_173_2063))
in (ddtok, [], FStar_SMTEncoding_Term.Term_sort, _173_2064))
in FStar_SMTEncoding_Term.DeclFun (_173_2065))
in (_173_2066)::[])
in (FStar_List.append (FStar_List.append (FStar_List.append binder_decls decls2) decls3) _173_2067))
in (FStar_List.append _173_2068 proxy_fresh))
in (FStar_List.append _173_2069 decls_formals))
in (FStar_List.append _173_2070 decls_pred))
in (let _173_2084 = (let _173_2083 = (let _173_2082 = (let _173_2074 = (let _173_2073 = (let _173_2072 = (let _173_2071 = (FStar_SMTEncoding_Term.mkEq (app, dapp))
in (((app)::[])::[], vars, _173_2071))
in (FStar_SMTEncoding_Term.mkForall _173_2072))
in (_173_2073, Some ("equality for proxy"), Some ((Prims.strcat "equality_tok_" ddtok))))
in FStar_SMTEncoding_Term.Assume (_173_2074))
in (let _173_2081 = (let _173_2080 = (let _173_2079 = (let _173_2078 = (let _173_2077 = (let _173_2076 = (add_fuel (fuel_var, FStar_SMTEncoding_Term.Fuel_sort) vars')
in (let _173_2075 = (FStar_SMTEncoding_Term.mkImp (guard', ty_pred'))
in (((ty_pred')::[])::[], _173_2076, _173_2075)))
in (FStar_SMTEncoding_Term.mkForall _173_2077))
in (_173_2078, Some ("data constructor typing intro"), Some ((Prims.strcat "data_typing_intro_" ddtok))))
in FStar_SMTEncoding_Term.Assume (_173_2079))
in (_173_2080)::[])
in (_173_2082)::_173_2081))
in (FStar_SMTEncoding_Term.Assume ((tok_typing, Some ("typing for data constructor proxy"), Some ((Prims.strcat "typing_tok_" ddtok)))))::_173_2083)
in (FStar_List.append _173_2085 _173_2084)))
in (FStar_List.append _173_2086 elim))
in ((FStar_List.append datacons g), env))
end)))))
end))
end))
end))))))))
end)))
end))
end)))
end))
end)))))
and declare_top_level_let : env_t  ->  FStar_Syntax_Syntax.fv  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  ((Prims.string * FStar_SMTEncoding_Term.term Prims.option) * FStar_SMTEncoding_Term.decl Prims.list * env_t) = (fun env x t t_norm -> (match ((try_lookup_lid env x.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)) with
| None -> begin
(

let _83_2746 = (encode_free_var env x t t_norm [])
in (match (_83_2746) with
| (decls, env) -> begin
(

let _83_2751 = (lookup_lid env x.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (match (_83_2751) with
| (n, x', _83_2750) -> begin
((n, x'), decls, env)
end))
end))
end
| Some (n, x, _83_2755) -> begin
((n, x), [], env)
end))
and encode_smt_lemma : env_t  ->  FStar_Syntax_Syntax.fv  ->  FStar_Syntax_Syntax.term  ->  FStar_SMTEncoding_Term.decl Prims.list = (fun env fv t -> (

let lid = fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in (

let _83_2764 = (encode_function_type_as_formula None None t env)
in (match (_83_2764) with
| (form, decls) -> begin
(FStar_List.append decls ((FStar_SMTEncoding_Term.Assume ((form, Some ((Prims.strcat "Lemma: " lid.FStar_Ident.str)), Some ((Prims.strcat "lemma_" lid.FStar_Ident.str)))))::[]))
end))))
and encode_free_var : env_t  ->  FStar_Syntax_Syntax.fv  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  (FStar_SMTEncoding_Term.decl Prims.list * env_t) = (fun env fv tt t_norm quals -> (

let lid = fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in if ((let _173_2099 = (FStar_Syntax_Util.is_pure_or_ghost_function t_norm)
in (FStar_All.pipe_left Prims.op_Negation _173_2099)) || (FStar_Syntax_Util.is_lemma t_norm)) then begin
(

let _83_2774 = (new_term_constant_and_tok_from_lid env lid)
in (match (_83_2774) with
| (vname, vtok, env) -> begin
(

let arg_sorts = (match ((let _173_2100 = (FStar_Syntax_Subst.compress t_norm)
in _173_2100.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, _83_2777) -> begin
(FStar_All.pipe_right binders (FStar_List.map (fun _83_2780 -> FStar_SMTEncoding_Term.Term_sort)))
end
| _83_2783 -> begin
[]
end)
in (

let d = FStar_SMTEncoding_Term.DeclFun ((vname, arg_sorts, FStar_SMTEncoding_Term.Term_sort, Some ("Uninterpreted function symbol for impure function")))
in (

let dd = FStar_SMTEncoding_Term.DeclFun ((vtok, [], FStar_SMTEncoding_Term.Term_sort, Some ("Uninterpreted name for impure function")))
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

let _83_2798 = (

let _83_2793 = (curried_arrow_formals_comp t_norm)
in (match (_83_2793) with
| (args, comp) -> begin
if encode_non_total_function_typ then begin
(let _173_2102 = (FStar_TypeChecker_Util.pure_or_ghost_pre_and_post env.tcenv comp)
in (args, _173_2102))
end else begin
(args, (None, (FStar_Syntax_Util.comp_result comp)))
end
end))
in (match (_83_2798) with
| (formals, (pre_opt, res_t)) -> begin
(

let _83_2802 = (new_term_constant_and_tok_from_lid env lid)
in (match (_83_2802) with
| (vname, vtok, env) -> begin
(

let vtok_tm = (match (formals) with
| [] -> begin
(FStar_SMTEncoding_Term.mkFreeV (vname, FStar_SMTEncoding_Term.Term_sort))
end
| _83_2805 -> begin
(FStar_SMTEncoding_Term.mkApp (vtok, []))
end)
in (

let mk_disc_proj_axioms = (fun guard encoded_res_t vapp vars -> (FStar_All.pipe_right quals (FStar_List.collect (fun _83_21 -> (match (_83_21) with
| FStar_Syntax_Syntax.Discriminator (d) -> begin
(

let _83_2821 = (FStar_Util.prefix vars)
in (match (_83_2821) with
| (_83_2816, (xxsym, _83_2819)) -> begin
(

let xx = (FStar_SMTEncoding_Term.mkFreeV (xxsym, FStar_SMTEncoding_Term.Term_sort))
in (let _173_2119 = (let _173_2118 = (let _173_2117 = (let _173_2116 = (let _173_2115 = (let _173_2114 = (let _173_2113 = (let _173_2112 = (FStar_SMTEncoding_Term.mk_tester (escape d.FStar_Ident.str) xx)
in (FStar_All.pipe_left FStar_SMTEncoding_Term.boxBool _173_2112))
in (vapp, _173_2113))
in (FStar_SMTEncoding_Term.mkEq _173_2114))
in (((vapp)::[])::[], vars, _173_2115))
in (FStar_SMTEncoding_Term.mkForall _173_2116))
in (_173_2117, Some ("Discriminator equation"), Some ((Prims.strcat "disc_equation_" (escape d.FStar_Ident.str)))))
in FStar_SMTEncoding_Term.Assume (_173_2118))
in (_173_2119)::[]))
end))
end
| FStar_Syntax_Syntax.Projector (d, f) -> begin
(

let _83_2833 = (FStar_Util.prefix vars)
in (match (_83_2833) with
| (_83_2828, (xxsym, _83_2831)) -> begin
(

let xx = (FStar_SMTEncoding_Term.mkFreeV (xxsym, FStar_SMTEncoding_Term.Term_sort))
in (

let f = {FStar_Syntax_Syntax.ppname = f; FStar_Syntax_Syntax.index = 0; FStar_Syntax_Syntax.sort = FStar_Syntax_Syntax.tun}
in (

let tp_name = (mk_term_projector_name d f)
in (

let prim_app = (FStar_SMTEncoding_Term.mkApp (tp_name, (xx)::[]))
in (let _173_2124 = (let _173_2123 = (let _173_2122 = (let _173_2121 = (let _173_2120 = (FStar_SMTEncoding_Term.mkEq (vapp, prim_app))
in (((vapp)::[])::[], vars, _173_2120))
in (FStar_SMTEncoding_Term.mkForall _173_2121))
in (_173_2122, Some ("Projector equation"), Some ((Prims.strcat "proj_equation_" tp_name))))
in FStar_SMTEncoding_Term.Assume (_173_2123))
in (_173_2124)::[])))))
end))
end
| _83_2839 -> begin
[]
end)))))
in (

let _83_2846 = (encode_binders None formals env)
in (match (_83_2846) with
| (vars, guards, env', decls1, _83_2845) -> begin
(

let _83_2855 = (match (pre_opt) with
| None -> begin
(let _173_2125 = (FStar_SMTEncoding_Term.mk_and_l guards)
in (_173_2125, decls1))
end
| Some (p) -> begin
(

let _83_2852 = (encode_formula p env')
in (match (_83_2852) with
| (g, ds) -> begin
(let _173_2126 = (FStar_SMTEncoding_Term.mk_and_l ((g)::guards))
in (_173_2126, (FStar_List.append decls1 ds)))
end))
end)
in (match (_83_2855) with
| (guard, decls1) -> begin
(

let vtok_app = (mk_Apply vtok_tm vars)
in (

let vapp = (let _173_2128 = (let _173_2127 = (FStar_List.map FStar_SMTEncoding_Term.mkFreeV vars)
in (vname, _173_2127))
in (FStar_SMTEncoding_Term.mkApp _173_2128))
in (

let _83_2879 = (

let vname_decl = (let _173_2131 = (let _173_2130 = (FStar_All.pipe_right formals (FStar_List.map (fun _83_2858 -> FStar_SMTEncoding_Term.Term_sort)))
in (vname, _173_2130, FStar_SMTEncoding_Term.Term_sort, None))
in FStar_SMTEncoding_Term.DeclFun (_173_2131))
in (

let _83_2866 = (

let env = (

let _83_2861 = env
in {bindings = _83_2861.bindings; depth = _83_2861.depth; tcenv = _83_2861.tcenv; warn = _83_2861.warn; cache = _83_2861.cache; nolabels = _83_2861.nolabels; use_zfuel_name = _83_2861.use_zfuel_name; encode_non_total_function_typ = encode_non_total_function_typ})
in if (not ((head_normal env tt))) then begin
(encode_term_pred None tt env vtok_tm)
end else begin
(encode_term_pred None t_norm env vtok_tm)
end)
in (match (_83_2866) with
| (tok_typing, decls2) -> begin
(

let tok_typing = FStar_SMTEncoding_Term.Assume ((tok_typing, Some ("function token typing"), Some ((Prims.strcat "function_token_typing_" vname))))
in (

let _83_2876 = (match (formals) with
| [] -> begin
(let _173_2135 = (let _173_2134 = (let _173_2133 = (FStar_SMTEncoding_Term.mkFreeV (vname, FStar_SMTEncoding_Term.Term_sort))
in (FStar_All.pipe_left (fun _173_2132 -> Some (_173_2132)) _173_2133))
in (push_free_var env lid vname _173_2134))
in ((FStar_List.append decls2 ((tok_typing)::[])), _173_2135))
end
| _83_2870 -> begin
(

let vtok_decl = FStar_SMTEncoding_Term.DeclFun ((vtok, [], FStar_SMTEncoding_Term.Term_sort, None))
in (

let vtok_fresh = (let _173_2136 = (varops.next_id ())
in (FStar_SMTEncoding_Term.fresh_token (vtok, FStar_SMTEncoding_Term.Term_sort) _173_2136))
in (

let name_tok_corr = (let _173_2140 = (let _173_2139 = (let _173_2138 = (let _173_2137 = (FStar_SMTEncoding_Term.mkEq (vtok_app, vapp))
in (((vtok_app)::[])::[], vars, _173_2137))
in (FStar_SMTEncoding_Term.mkForall _173_2138))
in (_173_2139, Some ("Name-token correspondence"), Some ((Prims.strcat "token_correspondence_" vname))))
in FStar_SMTEncoding_Term.Assume (_173_2140))
in ((FStar_List.append decls2 ((vtok_decl)::(vtok_fresh)::(name_tok_corr)::(tok_typing)::[])), env))))
end)
in (match (_83_2876) with
| (tok_decl, env) -> begin
((vname_decl)::tok_decl, env)
end)))
end)))
in (match (_83_2879) with
| (decls2, env) -> begin
(

let _83_2887 = (

let res_t = (FStar_Syntax_Subst.compress res_t)
in (

let _83_2883 = (encode_term res_t env')
in (match (_83_2883) with
| (encoded_res_t, decls) -> begin
(let _173_2141 = (FStar_SMTEncoding_Term.mk_HasType vapp encoded_res_t)
in (encoded_res_t, _173_2141, decls))
end)))
in (match (_83_2887) with
| (encoded_res_t, ty_pred, decls3) -> begin
(

let typingAx = (let _173_2145 = (let _173_2144 = (let _173_2143 = (let _173_2142 = (FStar_SMTEncoding_Term.mkImp (guard, ty_pred))
in (((vapp)::[])::[], vars, _173_2142))
in (FStar_SMTEncoding_Term.mkForall _173_2143))
in (_173_2144, Some ("free var typing"), Some ((Prims.strcat "typing_" vname))))
in FStar_SMTEncoding_Term.Assume (_173_2145))
in (

let freshness = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.New)) then begin
(let _173_2151 = (let _173_2148 = (let _173_2147 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in (let _173_2146 = (varops.next_id ())
in (vname, _173_2147, FStar_SMTEncoding_Term.Term_sort, _173_2146)))
in (FStar_SMTEncoding_Term.fresh_constructor _173_2148))
in (let _173_2150 = (let _173_2149 = (pretype_axiom vapp vars)
in (_173_2149)::[])
in (_173_2151)::_173_2150))
end else begin
[]
end
in (

let g = (let _173_2153 = (let _173_2152 = (mk_disc_proj_axioms guard encoded_res_t vapp vars)
in (typingAx)::_173_2152)
in (FStar_List.append (FStar_List.append (FStar_List.append (FStar_List.append decls1 decls2) decls3) freshness) _173_2153))
in (g, env))))
end))
end))))
end))
end))))
end))
end)))
end
end))
and encode_signature : env_t  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  (FStar_SMTEncoding_Term.decl Prims.list * env_t) = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.fold_left (fun _83_2895 se -> (match (_83_2895) with
| (g, env) -> begin
(

let _83_2899 = (encode_sigelt env se)
in (match (_83_2899) with
| (g', env) -> begin
((FStar_List.append g g'), env)
end))
end)) ([], env))))


let encode_env_bindings : env_t  ->  FStar_TypeChecker_Env.binding Prims.list  ->  (FStar_SMTEncoding_Term.decl Prims.list * env_t) = (fun env bindings -> (

let encode_binding = (fun b _83_2906 -> (match (_83_2906) with
| (decls, env) -> begin
(match (b) with
| FStar_TypeChecker_Env.Binding_univ (_83_2908) -> begin
([], env)
end
| FStar_TypeChecker_Env.Binding_var (x) -> begin
(

let _83_2915 = (new_term_constant env x)
in (match (_83_2915) with
| (xxsym, xx, env') -> begin
(

let t1 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Simplify)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv x.FStar_Syntax_Syntax.sort)
in (

let _83_2917 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _173_2168 = (FStar_Syntax_Print.bv_to_string x)
in (let _173_2167 = (FStar_Syntax_Print.term_to_string x.FStar_Syntax_Syntax.sort)
in (let _173_2166 = (FStar_Syntax_Print.term_to_string t1)
in (FStar_Util.print3 "Normalized %s : %s to %s\n" _173_2168 _173_2167 _173_2166))))
end else begin
()
end
in (

let _83_2921 = (encode_term_pred None t1 env xx)
in (match (_83_2921) with
| (t, decls') -> begin
(

let caption = if (FStar_Options.log_queries ()) then begin
(let _173_2172 = (let _173_2171 = (FStar_Syntax_Print.bv_to_string x)
in (let _173_2170 = (FStar_Syntax_Print.term_to_string x.FStar_Syntax_Syntax.sort)
in (let _173_2169 = (FStar_Syntax_Print.term_to_string t1)
in (FStar_Util.format3 "%s : %s (%s)" _173_2171 _173_2170 _173_2169))))
in Some (_173_2172))
end else begin
None
end
in (

let ax = (

let a_name = Some ((Prims.strcat "binder_" xxsym))
in FStar_SMTEncoding_Term.Assume ((t, a_name, a_name)))
in (

let g = (FStar_List.append (FStar_List.append ((FStar_SMTEncoding_Term.DeclFun ((xxsym, [], FStar_SMTEncoding_Term.Term_sort, caption)))::[]) decls') ((ax)::[]))
in ((FStar_List.append decls g), env'))))
end))))
end))
end
| FStar_TypeChecker_Env.Binding_lid (x, (_83_2928, t)) -> begin
(

let t_norm = (whnf env t)
in (

let fv = (FStar_Syntax_Syntax.lid_as_fv x FStar_Syntax_Syntax.Delta_constant None)
in (

let _83_2937 = (encode_free_var env fv t t_norm [])
in (match (_83_2937) with
| (g, env') -> begin
((FStar_List.append decls g), env')
end))))
end
| (FStar_TypeChecker_Env.Binding_sig_inst (_, se, _)) | (FStar_TypeChecker_Env.Binding_sig (_, se)) -> begin
(

let _83_2951 = (encode_sigelt env se)
in (match (_83_2951) with
| (g, env') -> begin
((FStar_List.append decls g), env')
end))
end)
end))
in (FStar_List.fold_right encode_binding bindings ([], env))))


let encode_labels = (fun labs -> (

let prefix = (FStar_All.pipe_right labs (FStar_List.map (fun _83_2958 -> (match (_83_2958) with
| (l, _83_2955, _83_2957) -> begin
FStar_SMTEncoding_Term.DeclFun (((Prims.fst l), [], FStar_SMTEncoding_Term.Bool_sort, None))
end))))
in (

let suffix = (FStar_All.pipe_right labs (FStar_List.collect (fun _83_2965 -> (match (_83_2965) with
| (l, _83_2962, _83_2964) -> begin
(let _173_2180 = (FStar_All.pipe_left (fun _173_2176 -> FStar_SMTEncoding_Term.Echo (_173_2176)) (Prims.fst l))
in (let _173_2179 = (let _173_2178 = (let _173_2177 = (FStar_SMTEncoding_Term.mkFreeV l)
in FStar_SMTEncoding_Term.Eval (_173_2177))
in (_173_2178)::[])
in (_173_2180)::_173_2179))
end))))
in (prefix, suffix))))


let last_env : env_t Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let init_env : FStar_TypeChecker_Env.env  ->  Prims.unit = (fun tcenv -> (let _173_2185 = (let _173_2184 = (let _173_2183 = (FStar_Util.smap_create 100)
in {bindings = []; depth = 0; tcenv = tcenv; warn = true; cache = _173_2183; nolabels = false; use_zfuel_name = false; encode_non_total_function_typ = true})
in (_173_2184)::[])
in (FStar_ST.op_Colon_Equals last_env _173_2185)))


let get_env : FStar_TypeChecker_Env.env  ->  env_t = (fun tcenv -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "No env; call init first!")
end
| (e)::_83_2971 -> begin
(

let _83_2974 = e
in {bindings = _83_2974.bindings; depth = _83_2974.depth; tcenv = tcenv; warn = _83_2974.warn; cache = _83_2974.cache; nolabels = _83_2974.nolabels; use_zfuel_name = _83_2974.use_zfuel_name; encode_non_total_function_typ = _83_2974.encode_non_total_function_typ})
end))


let set_env : env_t  ->  Prims.unit = (fun env -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Empty env stack")
end
| (_83_2980)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((env)::tl))
end))


let push_env : Prims.unit  ->  Prims.unit = (fun _83_2982 -> (match (()) with
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

let _83_2988 = hd
in {bindings = _83_2988.bindings; depth = _83_2988.depth; tcenv = _83_2988.tcenv; warn = _83_2988.warn; cache = refs; nolabels = _83_2988.nolabels; use_zfuel_name = _83_2988.use_zfuel_name; encode_non_total_function_typ = _83_2988.encode_non_total_function_typ})
in (FStar_ST.op_Colon_Equals last_env ((top)::(hd)::tl))))
end)
end))


let pop_env : Prims.unit  ->  Prims.unit = (fun _83_2991 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Popping an empty stack")
end
| (_83_2995)::tl -> begin
(FStar_ST.op_Colon_Equals last_env tl)
end)
end))


let mark_env : Prims.unit  ->  Prims.unit = (fun _83_2997 -> (match (()) with
| () -> begin
(push_env ())
end))


let reset_mark_env : Prims.unit  ->  Prims.unit = (fun _83_2998 -> (match (()) with
| () -> begin
(pop_env ())
end))


let commit_mark_env : Prims.unit  ->  Prims.unit = (fun _83_2999 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| (hd)::(_83_3002)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((hd)::tl))
end
| _83_3007 -> begin
(FStar_All.failwith "Impossible")
end)
end))


let init : FStar_TypeChecker_Env.env  ->  Prims.unit = (fun tcenv -> (

let _83_3009 = (init_env tcenv)
in (

let _83_3011 = (FStar_SMTEncoding_Z3.init ())
in (FStar_SMTEncoding_Z3.giveZ3 ((FStar_SMTEncoding_Term.DefPrelude)::[])))))


let push : Prims.string  ->  Prims.unit = (fun msg -> (

let _83_3014 = (push_env ())
in (

let _83_3016 = (varops.push ())
in (FStar_SMTEncoding_Z3.push msg))))


let pop : Prims.string  ->  Prims.unit = (fun msg -> (

let _83_3019 = (let _173_2206 = (pop_env ())
in (FStar_All.pipe_left Prims.ignore _173_2206))
in (

let _83_3021 = (varops.pop ())
in (FStar_SMTEncoding_Z3.pop msg))))


let mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _83_3024 = (mark_env ())
in (

let _83_3026 = (varops.mark ())
in (FStar_SMTEncoding_Z3.mark msg))))


let reset_mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _83_3029 = (reset_mark_env ())
in (

let _83_3031 = (varops.reset_mark ())
in (FStar_SMTEncoding_Z3.reset_mark msg))))


let commit_mark = (fun msg -> (

let _83_3034 = (commit_mark_env ())
in (

let _83_3036 = (varops.commit_mark ())
in (FStar_SMTEncoding_Z3.commit_mark msg))))


let encode_sig : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit = (fun tcenv se -> (

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(let _173_2222 = (let _173_2221 = (let _173_2220 = (let _173_2219 = (let _173_2218 = (FStar_Syntax_Util.lids_of_sigelt se)
in (FStar_All.pipe_right _173_2218 (FStar_List.map FStar_Syntax_Print.lid_to_string)))
in (FStar_All.pipe_right _173_2219 (FStar_String.concat ", ")))
in (Prims.strcat "encoding sigelt " _173_2220))
in FStar_SMTEncoding_Term.Caption (_173_2221))
in (_173_2222)::decls)
end else begin
decls
end)
in (

let env = (get_env tcenv)
in (

let _83_3045 = (encode_sigelt env se)
in (match (_83_3045) with
| (decls, env) -> begin
(

let _83_3046 = (set_env env)
in (let _173_2223 = (caption decls)
in (FStar_SMTEncoding_Z3.giveZ3 _173_2223)))
end)))))


let encode_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  Prims.unit = (fun tcenv modul -> (

let name = (FStar_Util.format2 "%s %s" (if modul.FStar_Syntax_Syntax.is_interface then begin
"interface"
end else begin
"module"
end) modul.FStar_Syntax_Syntax.name.FStar_Ident.str)
in (

let _83_3051 = if (FStar_TypeChecker_Env.debug tcenv FStar_Options.Low) then begin
(let _173_2228 = (FStar_All.pipe_right (FStar_List.length modul.FStar_Syntax_Syntax.exports) FStar_Util.string_of_int)
in (FStar_Util.print2 "+++++++++++Encoding externals for %s ... %s exports\n" name _173_2228))
end else begin
()
end
in (

let env = (get_env tcenv)
in (

let _83_3058 = (encode_signature (

let _83_3054 = env
in {bindings = _83_3054.bindings; depth = _83_3054.depth; tcenv = _83_3054.tcenv; warn = false; cache = _83_3054.cache; nolabels = _83_3054.nolabels; use_zfuel_name = _83_3054.use_zfuel_name; encode_non_total_function_typ = _83_3054.encode_non_total_function_typ}) modul.FStar_Syntax_Syntax.exports)
in (match (_83_3058) with
| (decls, env) -> begin
(

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(

let msg = (Prims.strcat "Externals for " name)
in (FStar_List.append ((FStar_SMTEncoding_Term.Caption (msg))::decls) ((FStar_SMTEncoding_Term.Caption ((Prims.strcat "End " msg)))::[])))
end else begin
decls
end)
in (

let _83_3064 = (set_env (

let _83_3062 = env
in {bindings = _83_3062.bindings; depth = _83_3062.depth; tcenv = _83_3062.tcenv; warn = true; cache = _83_3062.cache; nolabels = _83_3062.nolabels; use_zfuel_name = _83_3062.use_zfuel_name; encode_non_total_function_typ = _83_3062.encode_non_total_function_typ}))
in (

let _83_3066 = if (FStar_TypeChecker_Env.debug tcenv FStar_Options.Low) then begin
(FStar_Util.print1 "Done encoding externals for %s\n" name)
end else begin
()
end
in (

let decls = (caption decls)
in (FStar_SMTEncoding_Z3.giveZ3 decls)))))
end))))))


let encode_query : (Prims.unit  ->  Prims.string) Prims.option  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  (FStar_SMTEncoding_Term.decl Prims.list * label Prims.list * FStar_SMTEncoding_Term.decl * FStar_SMTEncoding_Term.decl Prims.list) = (fun use_env_msg tcenv q -> (

let env = (get_env tcenv)
in (

let bindings = (FStar_TypeChecker_Env.fold_env tcenv (fun bs b -> (b)::bs) [])
in (

let _83_3095 = (

let rec aux = (fun bindings -> (match (bindings) with
| (FStar_TypeChecker_Env.Binding_var (x))::rest -> begin
(

let _83_3084 = (aux rest)
in (match (_83_3084) with
| (out, rest) -> begin
(

let t = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Simplify)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.tcenv x.FStar_Syntax_Syntax.sort)
in (let _173_2250 = (let _173_2249 = (FStar_Syntax_Syntax.mk_binder (

let _83_3086 = x
in {FStar_Syntax_Syntax.ppname = _83_3086.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _83_3086.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}))
in (_173_2249)::out)
in (_173_2250, rest)))
end))
end
| _83_3089 -> begin
([], bindings)
end))
in (

let _83_3092 = (aux bindings)
in (match (_83_3092) with
| (closing, bindings) -> begin
(let _173_2251 = (FStar_Syntax_Util.close_forall (FStar_List.rev closing) q)
in (_173_2251, bindings))
end)))
in (match (_83_3095) with
| (q, bindings) -> begin
(

let _83_3104 = (let _173_2253 = (FStar_List.filter (fun _83_22 -> (match (_83_22) with
| FStar_TypeChecker_Env.Binding_sig (_83_3098) -> begin
false
end
| _83_3101 -> begin
true
end)) bindings)
in (encode_env_bindings env _173_2253))
in (match (_83_3104) with
| (env_decls, env) -> begin
(

let _83_3105 = if ((FStar_TypeChecker_Env.debug tcenv FStar_Options.Low) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug tcenv) (FStar_Options.Other ("SMTEncoding")))) then begin
(let _173_2254 = (FStar_Syntax_Print.term_to_string q)
in (FStar_Util.print1 "Encoding query formula: %s\n" _173_2254))
end else begin
()
end
in (

let _83_3109 = (encode_formula q env)
in (match (_83_3109) with
| (phi, qdecls) -> begin
(

let _83_3114 = (let _173_2255 = (FStar_TypeChecker_Env.get_range tcenv)
in (FStar_SMTEncoding_ErrorReporting.label_goals use_env_msg _173_2255 phi))
in (match (_83_3114) with
| (phi, labels, _83_3113) -> begin
(

let _83_3117 = (encode_labels labels)
in (match (_83_3117) with
| (label_prefix, label_suffix) -> begin
(

let query_prelude = (FStar_List.append (FStar_List.append env_decls label_prefix) qdecls)
in (

let qry = (let _173_2259 = (let _173_2258 = (FStar_SMTEncoding_Term.mkNot phi)
in (let _173_2257 = (let _173_2256 = (varops.fresh "@query")
in Some (_173_2256))
in (_173_2258, Some ("query"), _173_2257)))
in FStar_SMTEncoding_Term.Assume (_173_2259))
in (

let suffix = (FStar_List.append label_suffix ((FStar_SMTEncoding_Term.Echo ("Done!"))::[]))
in (query_prelude, labels, qry, suffix))))
end))
end))
end)))
end))
end)))))


let is_trivial : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun tcenv q -> (

let env = (get_env tcenv)
in (

let _83_3124 = (push "query")
in (

let _83_3129 = (encode_formula q env)
in (match (_83_3129) with
| (f, _83_3128) -> begin
(

let _83_3130 = (pop "query")
in (match (f.FStar_SMTEncoding_Term.tm) with
| FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.True, _83_3134) -> begin
true
end
| _83_3138 -> begin
false
end))
end)))))




