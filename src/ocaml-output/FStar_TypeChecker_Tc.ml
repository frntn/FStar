
open Prims
# 40 "FStar.TypeChecker.Tc.fst"
let log : FStar_TypeChecker_Env.env  ->  Prims.bool = (fun env -> ((FStar_ST.read FStar_Options.log_types) && (not ((let _151_3 = (FStar_TypeChecker_Env.current_module env)
in (FStar_Ident.lid_equals FStar_Syntax_Const.prims_lid _151_3))))))

# 41 "FStar.TypeChecker.Tc.fst"
let rng : FStar_TypeChecker_Env.env  ->  FStar_Range.range = (fun env -> (FStar_TypeChecker_Env.get_range env))

# 42 "FStar.TypeChecker.Tc.fst"
let instantiate_both : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.env = (fun env -> (
# 42 "FStar.TypeChecker.Tc.fst"
let _72_17 = env
in {FStar_TypeChecker_Env.solver = _72_17.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_17.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_17.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_17.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_17.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_17.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_17.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_17.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_17.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = true; FStar_TypeChecker_Env.effects = _72_17.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_17.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_17.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_17.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_17.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_17.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_17.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_17.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_17.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_17.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_17.FStar_TypeChecker_Env.use_bv_sorts}))

# 43 "FStar.TypeChecker.Tc.fst"
let no_inst : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.env = (fun env -> (
# 43 "FStar.TypeChecker.Tc.fst"
let _72_20 = env
in {FStar_TypeChecker_Env.solver = _72_20.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_20.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_20.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_20.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_20.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_20.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_20.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_20.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_20.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = false; FStar_TypeChecker_Env.effects = _72_20.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_20.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_20.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_20.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_20.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_20.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_20.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_20.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_20.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_20.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_20.FStar_TypeChecker_Env.use_bv_sorts}))

# 44 "FStar.TypeChecker.Tc.fst"
let mk_lex_list : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax Prims.list  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun vs -> (FStar_List.fold_right (fun v tl -> (
# 46 "FStar.TypeChecker.Tc.fst"
let r = if (tl.FStar_Syntax_Syntax.pos = FStar_Range.dummyRange) then begin
v.FStar_Syntax_Syntax.pos
end else begin
(FStar_Range.union_ranges v.FStar_Syntax_Syntax.pos tl.FStar_Syntax_Syntax.pos)
end
in (let _151_17 = (let _151_16 = (FStar_Syntax_Syntax.as_arg v)
in (let _151_15 = (let _151_14 = (FStar_Syntax_Syntax.as_arg tl)
in (_151_14)::[])
in (_151_16)::_151_15))
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.lex_pair _151_17 (Some (FStar_Syntax_Util.lex_t.FStar_Syntax_Syntax.n)) r)))) vs FStar_Syntax_Util.lex_top))

# 49 "FStar.TypeChecker.Tc.fst"
let is_eq : FStar_Syntax_Syntax.arg_qualifier Prims.option  ->  Prims.bool = (fun _72_1 -> (match (_72_1) with
| Some (FStar_Syntax_Syntax.Equality) -> begin
true
end
| _72_30 -> begin
false
end))

# 52 "FStar.TypeChecker.Tc.fst"
let steps : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Normalize.step Prims.list = (fun env -> if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.SNComp)::[]
end else begin
(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::[]
end)

# 56 "FStar.TypeChecker.Tc.fst"
let unfold_whnf : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.Unfold)::(FStar_TypeChecker_Normalize.Beta)::[]) env t))

# 57 "FStar.TypeChecker.Tc.fst"
let norm : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _151_30 = (steps env)
in (FStar_TypeChecker_Normalize.normalize _151_30 env t)))

# 58 "FStar.TypeChecker.Tc.fst"
let norm_c : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun env c -> (let _151_35 = (steps env)
in (FStar_TypeChecker_Normalize.normalize_comp _151_35 env c)))

# 59 "FStar.TypeChecker.Tc.fst"
let fxv_check : FStar_Syntax_Syntax.term  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv Prims.list * (FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.bv  ->  Prims.bool))  ->  Prims.unit = (fun head env kt fvs -> (
# 60 "FStar.TypeChecker.Tc.fst"
let rec aux = (fun try_norm t -> if (FStar_Util.set_is_empty fvs) then begin
()
end else begin
(
# 62 "FStar.TypeChecker.Tc.fst"
let fvs' = (let _151_54 = if try_norm then begin
(norm env t)
end else begin
t
end
in (FStar_Syntax_Free.names _151_54))
in (
# 63 "FStar.TypeChecker.Tc.fst"
let a = (FStar_Util.set_intersect fvs fvs')
in if (FStar_Util.set_is_empty a) then begin
()
end else begin
if (not (try_norm)) then begin
(aux true t)
end else begin
(
# 67 "FStar.TypeChecker.Tc.fst"
let fail = (fun _72_48 -> (match (()) with
| () -> begin
(
# 68 "FStar.TypeChecker.Tc.fst"
let escaping = (let _151_58 = (let _151_57 = (FStar_Util.set_elements a)
in (FStar_All.pipe_right _151_57 (FStar_List.map FStar_Syntax_Print.bv_to_string)))
in (FStar_All.pipe_right _151_58 (FStar_String.concat ", ")))
in (
# 69 "FStar.TypeChecker.Tc.fst"
let msg = if ((FStar_Util.set_count a) > 1) then begin
(let _151_59 = (FStar_TypeChecker_Normalize.term_to_string env head)
in (FStar_Util.format2 "Bound variables \'{%s}\' in the type of \'%s\' escape because of impure applications; add explicit let-bindings" escaping _151_59))
end else begin
(let _151_60 = (FStar_TypeChecker_Normalize.term_to_string env head)
in (FStar_Util.format2 "Bound variable \'%s\' in the type of \'%s\' escapes because of impure applications; add explicit let-bindings" escaping _151_60))
end
in (let _151_63 = (let _151_62 = (let _151_61 = (FStar_TypeChecker_Env.get_range env)
in (msg, _151_61))
in FStar_Syntax_Syntax.Error (_151_62))
in (Prims.raise _151_63))))
end))
in (
# 75 "FStar.TypeChecker.Tc.fst"
let s = (let _151_64 = (FStar_TypeChecker_Recheck.check t)
in (FStar_TypeChecker_Util.new_uvar env _151_64))
in (match ((FStar_TypeChecker_Rel.try_teq env t s)) with
| Some (g) -> begin
(FStar_TypeChecker_Rel.force_trivial_guard env g)
end
| _72_55 -> begin
(fail ())
end)))
end
end))
end)
in (aux false kt)))

# 82 "FStar.TypeChecker.Tc.fst"
let check_no_escape : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.bv Prims.list  ->  FStar_Syntax_Syntax.term  ->  Prims.unit = (fun env bs t -> (
# 83 "FStar.TypeChecker.Tc.fst"
let fvs = (FStar_Syntax_Free.names t)
in if (FStar_Util.for_some (fun x -> (FStar_Util.set_mem x fvs)) bs) then begin
(
# 85 "FStar.TypeChecker.Tc.fst"
let _72_64 = (FStar_Syntax_Util.type_u ())
in (match (_72_64) with
| (k, _72_63) -> begin
(
# 86 "FStar.TypeChecker.Tc.fst"
let tnarrow = (FStar_TypeChecker_Util.new_uvar env k)
in (let _151_72 = (FStar_TypeChecker_Rel.teq env t tnarrow)
in (FStar_All.pipe_left (FStar_TypeChecker_Rel.force_trivial_guard env) _151_72)))
end))
end else begin
()
end))

# 89 "FStar.TypeChecker.Tc.fst"
let maybe_push_binding : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binder  ->  FStar_TypeChecker_Env.env = (fun env b -> if (FStar_Syntax_Syntax.is_null_binder b) then begin
env
end else begin
(
# 91 "FStar.TypeChecker.Tc.fst"
let _72_68 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_78 = (FStar_Syntax_Print.bv_to_string (Prims.fst b))
in (let _151_77 = (FStar_Syntax_Print.term_to_string (Prims.fst b).FStar_Syntax_Syntax.sort)
in (FStar_Util.print2 "Pushing binder %s at type %s\n" _151_78 _151_77)))
end else begin
()
end
in (FStar_TypeChecker_Env.push_bv env (Prims.fst b)))
end)

# 95 "FStar.TypeChecker.Tc.fst"
let maybe_make_subst = (fun _72_2 -> (match (_72_2) with
| FStar_Util.Inr (Some (x), e) -> begin
(FStar_Syntax_Syntax.NT ((x, e)))::[]
end
| _72_77 -> begin
[]
end))

# 99 "FStar.TypeChecker.Tc.fst"
let maybe_extend_subst : FStar_Syntax_Syntax.subst_t  ->  FStar_Syntax_Syntax.binder  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.subst_t = (fun s b v -> if (FStar_Syntax_Syntax.is_null_binder b) then begin
s
end else begin
(FStar_Syntax_Syntax.NT (((Prims.fst b), v)))::s
end)

# 103 "FStar.TypeChecker.Tc.fst"
let set_lcomp_result : FStar_Syntax_Syntax.lcomp  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.lcomp = (fun lc t -> (
# 104 "FStar.TypeChecker.Tc.fst"
let _72_83 = lc
in {FStar_Syntax_Syntax.eff_name = _72_83.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = t; FStar_Syntax_Syntax.cflags = _72_83.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _72_85 -> (match (()) with
| () -> begin
(let _151_91 = (lc.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Util.set_result_typ _151_91 t))
end))}))

# 106 "FStar.TypeChecker.Tc.fst"
let value_check_expected_typ : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term, FStar_Syntax_Syntax.lcomp) FStar_Util.either  ->  FStar_TypeChecker_Env.guard_t  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e tlc guard -> (
# 107 "FStar.TypeChecker.Tc.fst"
let lc = (match (tlc) with
| FStar_Util.Inl (t) -> begin
(let _151_100 = if (not ((FStar_Syntax_Util.is_pure_or_ghost_function t))) then begin
(FStar_Syntax_Syntax.mk_Total t)
end else begin
(FStar_TypeChecker_Util.return_value env t e)
end
in (FStar_Syntax_Util.lcomp_of_comp _151_100))
end
| FStar_Util.Inr (lc) -> begin
lc
end)
in (
# 112 "FStar.TypeChecker.Tc.fst"
let t = lc.FStar_Syntax_Syntax.res_typ
in (
# 113 "FStar.TypeChecker.Tc.fst"
let _72_117 = (match ((FStar_TypeChecker_Env.expected_typ env)) with
| None -> begin
(e, lc, guard)
end
| Some (t') -> begin
(
# 116 "FStar.TypeChecker.Tc.fst"
let _72_99 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_102 = (FStar_Syntax_Print.term_to_string t)
in (let _151_101 = (FStar_Syntax_Print.term_to_string t')
in (FStar_Util.print2 "Computed return type %s; expected type %s\n" _151_102 _151_101)))
end else begin
()
end
in (
# 118 "FStar.TypeChecker.Tc.fst"
let _72_103 = (FStar_TypeChecker_Util.maybe_coerce_bool_to_type env e lc t')
in (match (_72_103) with
| (e, lc) -> begin
(
# 119 "FStar.TypeChecker.Tc.fst"
let t = lc.FStar_Syntax_Syntax.res_typ
in (
# 120 "FStar.TypeChecker.Tc.fst"
let _72_107 = (FStar_TypeChecker_Util.check_and_ascribe env e t t')
in (match (_72_107) with
| (e, g) -> begin
(
# 121 "FStar.TypeChecker.Tc.fst"
let _72_108 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_104 = (FStar_Syntax_Print.term_to_string t)
in (let _151_103 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (FStar_Util.print2 "check_and_ascribe: type is %s\n\tguard is %s\n" _151_104 _151_103)))
end else begin
()
end
in (
# 123 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.conj_guard g guard)
in (
# 124 "FStar.TypeChecker.Tc.fst"
let _72_113 = (let _151_110 = (FStar_All.pipe_left (fun _151_109 -> Some (_151_109)) (FStar_TypeChecker_Errors.subtyping_failed env t t'))
in (FStar_TypeChecker_Util.strengthen_precondition _151_110 env e lc g))
in (match (_72_113) with
| (lc, g) -> begin
(e, (set_lcomp_result lc t'), g)
end))))
end)))
end)))
end)
in (match (_72_117) with
| (e, lc, g) -> begin
(
# 126 "FStar.TypeChecker.Tc.fst"
let _72_118 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_111 = (FStar_Syntax_Print.lcomp_to_string lc)
in (FStar_Util.print1 "Return comp type is %s\n" _151_111))
end else begin
()
end
in (e, lc, g))
end)))))

# 130 "FStar.TypeChecker.Tc.fst"
let comp_check_expected_typ : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e lc -> (match ((FStar_TypeChecker_Env.expected_typ env)) with
| None -> begin
(e, lc, FStar_TypeChecker_Rel.trivial_guard)
end
| Some (t) -> begin
(
# 134 "FStar.TypeChecker.Tc.fst"
let _72_128 = (FStar_TypeChecker_Util.maybe_coerce_bool_to_type env e lc t)
in (match (_72_128) with
| (e, lc) -> begin
(FStar_TypeChecker_Util.weaken_result_typ env e lc t)
end))
end))

# 137 "FStar.TypeChecker.Tc.fst"
let check_expected_effect : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp Prims.option  ->  (FStar_Syntax_Syntax.term * (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax)  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp * FStar_TypeChecker_Env.guard_t) = (fun env copt _72_133 -> (match (_72_133) with
| (e, c) -> begin
(
# 138 "FStar.TypeChecker.Tc.fst"
let expected_c_opt = (match (copt) with
| Some (_72_135) -> begin
copt
end
| None -> begin
if (FStar_Syntax_Util.is_tot_or_gtot_comp c) then begin
None
end else begin
(
# 143 "FStar.TypeChecker.Tc.fst"
let c1 = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c)
in (
# 144 "FStar.TypeChecker.Tc.fst"
let md = (FStar_TypeChecker_Env.get_effect_decl env c1.FStar_Syntax_Syntax.effect_name)
in (match ((FStar_TypeChecker_Env.default_effect env md.FStar_Syntax_Syntax.mname)) with
| None -> begin
None
end
| Some (l) -> begin
(
# 148 "FStar.TypeChecker.Tc.fst"
let flags = if (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Tot_lid) then begin
(FStar_Syntax_Syntax.TOTAL)::[]
end else begin
if (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_ML_lid) then begin
(FStar_Syntax_Syntax.MLEFFECT)::[]
end else begin
[]
end
end
in (
# 152 "FStar.TypeChecker.Tc.fst"
let def = (FStar_Syntax_Syntax.mk_Comp {FStar_Syntax_Syntax.effect_name = l; FStar_Syntax_Syntax.result_typ = c1.FStar_Syntax_Syntax.result_typ; FStar_Syntax_Syntax.effect_args = []; FStar_Syntax_Syntax.flags = flags})
in Some (def)))
end)))
end
end)
in (match (expected_c_opt) with
| None -> begin
(let _151_124 = (norm_c env c)
in (e, _151_124, FStar_TypeChecker_Rel.trivial_guard))
end
| Some (expected_c) -> begin
(
# 161 "FStar.TypeChecker.Tc.fst"
let _72_149 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_127 = (FStar_Syntax_Print.term_to_string e)
in (let _151_126 = (FStar_Syntax_Print.comp_to_string c)
in (let _151_125 = (FStar_Syntax_Print.comp_to_string expected_c)
in (FStar_Util.print3 "\n\n(%s) About to check\n\t%s\nagainst expected effect\n\t%s\n" _151_127 _151_126 _151_125))))
end else begin
()
end
in (
# 164 "FStar.TypeChecker.Tc.fst"
let c = (norm_c env c)
in (
# 165 "FStar.TypeChecker.Tc.fst"
let _72_152 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_130 = (FStar_Syntax_Print.term_to_string e)
in (let _151_129 = (FStar_Syntax_Print.comp_to_string c)
in (let _151_128 = (FStar_Syntax_Print.comp_to_string expected_c)
in (FStar_Util.print3 "\n\nAfter normalization (%s) About to check\n\t%s\nagainst expected effect\n\t%s\n" _151_130 _151_129 _151_128))))
end else begin
()
end
in (
# 170 "FStar.TypeChecker.Tc.fst"
let _72_158 = (FStar_TypeChecker_Util.check_comp env e c expected_c)
in (match (_72_158) with
| (e, _72_156, g) -> begin
(
# 171 "FStar.TypeChecker.Tc.fst"
let g = (let _151_131 = (FStar_TypeChecker_Env.get_range env)
in (FStar_TypeChecker_Util.label_guard _151_131 "could not prove post-condition" g))
in (
# 172 "FStar.TypeChecker.Tc.fst"
let _72_160 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_133 = (FStar_Range.string_of_range e.FStar_Syntax_Syntax.pos)
in (let _151_132 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (FStar_Util.print2 "(%s) DONE check_expected_effect; guard is: %s\n" _151_133 _151_132)))
end else begin
()
end
in (e, expected_c, g)))
end)))))
end))
end))

# 175 "FStar.TypeChecker.Tc.fst"
let no_logical_guard = (fun env _72_166 -> (match (_72_166) with
| (te, kt, f) -> begin
(match ((FStar_TypeChecker_Rel.guard_form f)) with
| FStar_TypeChecker_Common.Trivial -> begin
(te, kt, f)
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(let _151_139 = (let _151_138 = (let _151_137 = (FStar_TypeChecker_Errors.unexpected_non_trivial_precondition_on_term env f)
in (let _151_136 = (FStar_TypeChecker_Env.get_range env)
in (_151_137, _151_136)))
in FStar_Syntax_Syntax.Error (_151_138))
in (Prims.raise _151_139))
end)
end))

# 180 "FStar.TypeChecker.Tc.fst"
let print_expected_ty : FStar_TypeChecker_Env.env  ->  Prims.unit = (fun env -> (match ((FStar_TypeChecker_Env.expected_typ env)) with
| None -> begin
(FStar_Util.print_string "Expected type is None")
end
| Some (t) -> begin
(let _151_142 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print1 "Expected type is %s" _151_142))
end))

# 184 "FStar.TypeChecker.Tc.fst"
let with_implicits = (fun imps _72_178 -> (match (_72_178) with
| (e, l, g) -> begin
(e, l, (
# 184 "FStar.TypeChecker.Tc.fst"
let _72_179 = g
in {FStar_TypeChecker_Env.guard_f = _72_179.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _72_179.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_179.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (FStar_List.append imps g.FStar_TypeChecker_Env.implicits)}))
end))

# 185 "FStar.TypeChecker.Tc.fst"
let add_implicit : (FStar_TypeChecker_Env.env * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_Range.range)  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun u g -> (
# 185 "FStar.TypeChecker.Tc.fst"
let _72_183 = g
in {FStar_TypeChecker_Env.guard_f = _72_183.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _72_183.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_183.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (u)::g.FStar_TypeChecker_Env.implicits}))

# 190 "FStar.TypeChecker.Tc.fst"
let check_smt_pat = (fun env t bs c -> if (FStar_Syntax_Util.is_smt_lemma t) then begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp ({FStar_Syntax_Syntax.effect_name = _72_207; FStar_Syntax_Syntax.result_typ = _72_205; FStar_Syntax_Syntax.effect_args = (pre, _72_201)::(post, _72_197)::(pats, _72_193)::[]; FStar_Syntax_Syntax.flags = _72_190}) -> begin
(
# 194 "FStar.TypeChecker.Tc.fst"
let rec extract_pats = (fun pats -> (match ((let _151_155 = (FStar_Syntax_Subst.compress pats)
in _151_155.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (cons, _72_220); FStar_Syntax_Syntax.tk = _72_217; FStar_Syntax_Syntax.pos = _72_215; FStar_Syntax_Syntax.vars = _72_213}, _72_233::(hd, _72_230)::(tl, _72_226)::[]) when (FStar_Ident.lid_equals cons.FStar_Syntax_Syntax.v FStar_Syntax_Const.cons_lid) -> begin
(
# 196 "FStar.TypeChecker.Tc.fst"
let _72_239 = (FStar_Syntax_Util.head_and_args hd)
in (match (_72_239) with
| (head, args) -> begin
(
# 197 "FStar.TypeChecker.Tc.fst"
let pat = (match (args) with
| (_::arg::[]) | (arg::[]) -> begin
(arg)::[]
end
| _72_246 -> begin
[]
end)
in (let _151_156 = (extract_pats tl)
in (FStar_List.append pat _151_156)))
end))
end
| _72_249 -> begin
[]
end))
in (
# 203 "FStar.TypeChecker.Tc.fst"
let pats = (let _151_157 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env pats)
in (extract_pats _151_157))
in (
# 204 "FStar.TypeChecker.Tc.fst"
let fvs = (let _151_161 = (FStar_Syntax_Syntax.new_bv_set ())
in (FStar_List.fold_left (fun out _72_255 -> (match (_72_255) with
| (a, _72_254) -> begin
(let _151_160 = (FStar_Syntax_Free.names a)
in (FStar_Util.set_union out _151_160))
end)) _151_161 pats))
in (match ((FStar_All.pipe_right bs (FStar_Util.find_opt (fun _72_260 -> (match (_72_260) with
| (b, _72_259) -> begin
(not ((FStar_Util.set_mem b fvs)))
end))))) with
| None -> begin
()
end
| Some (x, _72_264) -> begin
(let _151_164 = (let _151_163 = (FStar_Syntax_Print.bv_to_string x)
in (FStar_Util.format1 "Pattern misses at least one bound variables: %s" _151_163))
in (FStar_TypeChecker_Errors.warn t.FStar_Syntax_Syntax.pos _151_164))
end))))
end
| _72_268 -> begin
(FStar_All.failwith "Impossible")
end)
end else begin
()
end)

# 215 "FStar.TypeChecker.Tc.fst"
let guard_letrecs : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ) Prims.list = (fun env actuals expected_c -> (match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
[]
end
| letrecs -> begin
(
# 219 "FStar.TypeChecker.Tc.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 220 "FStar.TypeChecker.Tc.fst"
let env = (
# 220 "FStar.TypeChecker.Tc.fst"
let _72_275 = env
in {FStar_TypeChecker_Env.solver = _72_275.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_275.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_275.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_275.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_275.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_275.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_275.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_275.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_275.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_275.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_275.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_275.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = []; FStar_TypeChecker_Env.top_level = _72_275.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_275.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_275.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_275.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_275.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_275.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_275.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_275.FStar_TypeChecker_Env.use_bv_sorts})
in (
# 221 "FStar.TypeChecker.Tc.fst"
let precedes = (let _151_171 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.precedes_lid _151_171))
in (
# 223 "FStar.TypeChecker.Tc.fst"
let decreases_clause = (fun bs c -> (
# 225 "FStar.TypeChecker.Tc.fst"
let filter_types_and_functions = (fun bs -> (FStar_All.pipe_right bs (FStar_List.collect (fun _72_287 -> (match (_72_287) with
| (b, _72_286) -> begin
(
# 227 "FStar.TypeChecker.Tc.fst"
let t = (let _151_179 = (FStar_Syntax_Util.unrefine b.FStar_Syntax_Syntax.sort)
in (unfold_whnf env _151_179))
in (match (t.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) -> begin
[]
end
| _72_296 -> begin
(let _151_180 = (FStar_Syntax_Syntax.bv_to_name b)
in (_151_180)::[])
end))
end)))))
in (
# 232 "FStar.TypeChecker.Tc.fst"
let as_lex_list = (fun dec -> (
# 233 "FStar.TypeChecker.Tc.fst"
let _72_302 = (FStar_Syntax_Util.head_and_args dec)
in (match (_72_302) with
| (head, _72_301) -> begin
(match (head.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv, _72_305) when (FStar_Ident.lid_equals fv.FStar_Syntax_Syntax.v FStar_Syntax_Const.lexcons_lid) -> begin
dec
end
| _72_309 -> begin
(mk_lex_list ((dec)::[]))
end)
end)))
in (
# 237 "FStar.TypeChecker.Tc.fst"
let ct = (FStar_Syntax_Util.comp_to_comp_typ c)
in (match ((FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags (FStar_List.tryFind (fun _72_3 -> (match (_72_3) with
| FStar_Syntax_Syntax.DECREASES (_72_313) -> begin
true
end
| _72_316 -> begin
false
end))))) with
| Some (FStar_Syntax_Syntax.DECREASES (dec)) -> begin
(as_lex_list dec)
end
| _72_321 -> begin
(
# 241 "FStar.TypeChecker.Tc.fst"
let xs = (FStar_All.pipe_right bs filter_types_and_functions)
in (match (xs) with
| x::[] -> begin
x
end
| _72_326 -> begin
(mk_lex_list xs)
end))
end)))))
in (
# 246 "FStar.TypeChecker.Tc.fst"
let previous_dec = (decreases_clause actuals expected_c)
in (
# 247 "FStar.TypeChecker.Tc.fst"
let guard_one_letrec = (fun _72_331 -> (match (_72_331) with
| (l, t) -> begin
(match ((let _151_186 = (FStar_Syntax_Subst.compress t)
in _151_186.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (formals, c) -> begin
(
# 251 "FStar.TypeChecker.Tc.fst"
let formals = (FStar_All.pipe_right formals (FStar_List.map (fun _72_338 -> (match (_72_338) with
| (x, imp) -> begin
if (FStar_Syntax_Syntax.is_null_bv x) then begin
(let _151_190 = (let _151_189 = (let _151_188 = (FStar_Syntax_Syntax.range_of_bv x)
in Some (_151_188))
in (FStar_Syntax_Syntax.new_bv _151_189 x.FStar_Syntax_Syntax.sort))
in (_151_190, imp))
end else begin
(x, imp)
end
end))))
in (
# 252 "FStar.TypeChecker.Tc.fst"
let _72_342 = (FStar_Syntax_Subst.open_comp formals c)
in (match (_72_342) with
| (formals, c) -> begin
(
# 253 "FStar.TypeChecker.Tc.fst"
let dec = (decreases_clause formals c)
in (
# 254 "FStar.TypeChecker.Tc.fst"
let precedes = (let _151_194 = (let _151_193 = (FStar_Syntax_Syntax.as_arg dec)
in (let _151_192 = (let _151_191 = (FStar_Syntax_Syntax.as_arg previous_dec)
in (_151_191)::[])
in (_151_193)::_151_192))
in (FStar_Syntax_Syntax.mk_Tm_app precedes _151_194 None r))
in (
# 255 "FStar.TypeChecker.Tc.fst"
let _72_349 = (FStar_Util.prefix formals)
in (match (_72_349) with
| (bs, (last, imp)) -> begin
(
# 256 "FStar.TypeChecker.Tc.fst"
let last = (
# 256 "FStar.TypeChecker.Tc.fst"
let _72_350 = last
in (let _151_195 = (FStar_Syntax_Util.refine last precedes)
in {FStar_Syntax_Syntax.ppname = _72_350.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_350.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _151_195}))
in (
# 257 "FStar.TypeChecker.Tc.fst"
let refined_formals = (FStar_List.append bs (((last, imp))::[]))
in (
# 258 "FStar.TypeChecker.Tc.fst"
let t' = (FStar_Syntax_Util.arrow refined_formals c)
in (
# 259 "FStar.TypeChecker.Tc.fst"
let _72_355 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_198 = (FStar_Syntax_Print.lbname_to_string l)
in (let _151_197 = (FStar_Syntax_Print.term_to_string t)
in (let _151_196 = (FStar_Syntax_Print.term_to_string t')
in (FStar_Util.print3 "Refined let rec %s\n\tfrom type %s\n\tto type %s\n" _151_198 _151_197 _151_196))))
end else begin
()
end
in (l, t')))))
end))))
end)))
end
| _72_358 -> begin
(FStar_All.failwith "Impossible: Annotated type of \'let rec\' is not an arrow")
end)
end))
in (FStar_All.pipe_right letrecs (FStar_List.map guard_one_letrec))))))))
end))

# 271 "FStar.TypeChecker.Tc.fst"
let rec tc_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (tc_maybe_toplevel_term (
# 271 "FStar.TypeChecker.Tc.fst"
let _72_361 = env
in {FStar_TypeChecker_Env.solver = _72_361.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_361.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_361.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_361.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_361.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_361.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_361.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_361.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_361.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_361.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_361.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_361.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_361.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = _72_361.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_361.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_361.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_361.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_361.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_361.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_361.FStar_TypeChecker_Env.use_bv_sorts}) e))
and tc_maybe_toplevel_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 276 "FStar.TypeChecker.Tc.fst"
let env = if (e.FStar_Syntax_Syntax.pos = FStar_Range.dummyRange) then begin
env
end else begin
(FStar_TypeChecker_Env.set_range env e.FStar_Syntax_Syntax.pos)
end
in (
# 277 "FStar.TypeChecker.Tc.fst"
let _72_366 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_264 = (let _151_262 = (FStar_TypeChecker_Env.get_range env)
in (FStar_All.pipe_left FStar_Range.string_of_range _151_262))
in (let _151_263 = (FStar_Syntax_Print.tag_of_term e)
in (FStar_Util.print2 "%s (%s)\n" _151_264 _151_263)))
end else begin
()
end
in (
# 278 "FStar.TypeChecker.Tc.fst"
let top = e
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (_72_370) -> begin
(let _151_268 = (FStar_Syntax_Subst.compress e)
in (tc_term env _151_268))
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_refine (_)) | (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
(tc_value env e)
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_pattern (pats)) -> begin
(
# 295 "FStar.TypeChecker.Tc.fst"
let _72_410 = (FStar_Syntax_Util.type_u ())
in (match (_72_410) with
| (t, u) -> begin
(
# 296 "FStar.TypeChecker.Tc.fst"
let _72_414 = (tc_check_tot_or_gtot_term env e t)
in (match (_72_414) with
| (e, c, g) -> begin
(
# 297 "FStar.TypeChecker.Tc.fst"
let _72_421 = (
# 298 "FStar.TypeChecker.Tc.fst"
let _72_418 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_418) with
| (env, _72_417) -> begin
(tc_pats env pats)
end))
in (match (_72_421) with
| (pats, g') -> begin
(
# 300 "FStar.TypeChecker.Tc.fst"
let g' = (
# 300 "FStar.TypeChecker.Tc.fst"
let _72_422 = g'
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _72_422.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_422.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _72_422.FStar_TypeChecker_Env.implicits})
in (let _151_270 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((e, FStar_Syntax_Syntax.Meta_pattern (pats)))) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _151_269 = (FStar_TypeChecker_Rel.conj_guard g g')
in (_151_270, c, _151_269))))
end))
end))
end))
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)) -> begin
(match ((let _151_271 = (FStar_Syntax_Subst.compress e)
in _151_271.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_let ((_72_431, {FStar_Syntax_Syntax.lbname = x; FStar_Syntax_Syntax.lbunivs = _72_438; FStar_Syntax_Syntax.lbtyp = _72_436; FStar_Syntax_Syntax.lbeff = _72_434; FStar_Syntax_Syntax.lbdef = e1}::[]), e2) -> begin
(
# 308 "FStar.TypeChecker.Tc.fst"
let _72_449 = (let _151_272 = (FStar_TypeChecker_Env.set_expected_typ env FStar_TypeChecker_Recheck.t_unit)
in (tc_term _151_272 e1))
in (match (_72_449) with
| (e1, c1, g1) -> begin
(
# 309 "FStar.TypeChecker.Tc.fst"
let _72_453 = (tc_term env e2)
in (match (_72_453) with
| (e2, c2, g2) -> begin
(
# 310 "FStar.TypeChecker.Tc.fst"
let c = (FStar_TypeChecker_Util.bind env (Some (e1)) c1 (None, c2))
in (
# 311 "FStar.TypeChecker.Tc.fst"
let e = (let _151_277 = (let _151_276 = (let _151_275 = (let _151_274 = (let _151_273 = (FStar_Syntax_Syntax.mk_lb (x, [], c1.FStar_Syntax_Syntax.eff_name, FStar_TypeChecker_Recheck.t_unit, e1))
in (_151_273)::[])
in (false, _151_274))
in (_151_275, e2))
in FStar_Syntax_Syntax.Tm_let (_151_276))
in (FStar_Syntax_Syntax.mk _151_277 (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos))
in (
# 312 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((e, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _151_278 = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in (e, c, _151_278)))))
end))
end))
end
| _72_458 -> begin
(
# 315 "FStar.TypeChecker.Tc.fst"
let _72_462 = (tc_term env e)
in (match (_72_462) with
| (e, c, g) -> begin
(
# 316 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((e, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (e, c, g))
end))
end)
end
| FStar_Syntax_Syntax.Tm_meta (e, m) -> begin
(
# 321 "FStar.TypeChecker.Tc.fst"
let _72_471 = (tc_term env e)
in (match (_72_471) with
| (e, c, g) -> begin
(
# 322 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((e, m))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (e, c, g))
end))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, t, _72_476) -> begin
(
# 326 "FStar.TypeChecker.Tc.fst"
let _72_481 = (FStar_Syntax_Util.type_u ())
in (match (_72_481) with
| (k, u) -> begin
(
# 327 "FStar.TypeChecker.Tc.fst"
let _72_486 = (tc_check_tot_or_gtot_term env t k)
in (match (_72_486) with
| (t, _72_484, f) -> begin
(
# 328 "FStar.TypeChecker.Tc.fst"
let _72_490 = (let _151_279 = (FStar_TypeChecker_Env.set_expected_typ env t)
in (tc_term _151_279 e))
in (match (_72_490) with
| (e, c, g) -> begin
(
# 329 "FStar.TypeChecker.Tc.fst"
let _72_494 = (let _151_283 = (FStar_TypeChecker_Env.set_range env t.FStar_Syntax_Syntax.pos)
in (FStar_TypeChecker_Util.strengthen_precondition (Some ((fun _72_491 -> (match (()) with
| () -> begin
FStar_TypeChecker_Errors.ill_kinded_type
end)))) _151_283 e c f))
in (match (_72_494) with
| (c, f) -> begin
(
# 330 "FStar.TypeChecker.Tc.fst"
let _72_498 = (let _151_284 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed ((e, t, Some (c.FStar_Syntax_Syntax.eff_name)))) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (comp_check_expected_typ env _151_284 c))
in (match (_72_498) with
| (e, c, f2) -> begin
(let _151_286 = (let _151_285 = (FStar_TypeChecker_Rel.conj_guard g f2)
in (FStar_TypeChecker_Rel.conj_guard f _151_285))
in (e, c, _151_286))
end))
end))
end))
end))
end))
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(
# 334 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 335 "FStar.TypeChecker.Tc.fst"
let env = (let _151_288 = (let _151_287 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _151_287 Prims.fst))
in (FStar_All.pipe_right _151_288 instantiate_both))
in (
# 336 "FStar.TypeChecker.Tc.fst"
let _72_505 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_290 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _151_289 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print2 "(%s) Checking app %s\n" _151_290 _151_289)))
end else begin
()
end
in (
# 340 "FStar.TypeChecker.Tc.fst"
let _72_510 = (tc_term (no_inst env) head)
in (match (_72_510) with
| (head, chead, g_head) -> begin
(
# 341 "FStar.TypeChecker.Tc.fst"
let _72_514 = if (FStar_TypeChecker_Util.short_circuit_head head) then begin
(let _151_291 = (FStar_TypeChecker_Env.expected_typ env0)
in (check_short_circuit_args env head chead g_head args _151_291))
end else begin
(let _151_292 = (FStar_TypeChecker_Env.expected_typ env0)
in (check_application_args env head chead g_head args _151_292))
end
in (match (_72_514) with
| (e, c, g) -> begin
(
# 344 "FStar.TypeChecker.Tc.fst"
let _72_515 = if (FStar_TypeChecker_Env.debug env FStar_Options.Extreme) then begin
(let _151_293 = (FStar_TypeChecker_Rel.print_pending_implicits g)
in (FStar_Util.print1 "Introduced {%s} implicits in application\n" _151_293))
end else begin
()
end
in (
# 346 "FStar.TypeChecker.Tc.fst"
let c = if (((FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) && (not ((FStar_Syntax_Util.is_lcomp_partial_return c)))) && (FStar_Syntax_Util.is_pure_or_ghost_lcomp c)) then begin
(FStar_TypeChecker_Util.maybe_assume_result_eq_pure_term env e c)
end else begin
c
end
in (
# 351 "FStar.TypeChecker.Tc.fst"
let _72_522 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_299 = (FStar_Syntax_Print.term_to_string e)
in (let _151_298 = (let _151_294 = (c.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_294))
in (let _151_297 = (let _151_296 = (FStar_TypeChecker_Env.expected_typ env0)
in (FStar_All.pipe_right _151_296 (fun x -> (match (x) with
| None -> begin
"None"
end
| Some (t) -> begin
(FStar_Syntax_Print.term_to_string t)
end))))
in (FStar_Util.print3 "(%s) About to check %s against expected typ %s\n" _151_299 _151_298 _151_297))))
end else begin
()
end
in (
# 356 "FStar.TypeChecker.Tc.fst"
let _72_527 = (comp_check_expected_typ env0 e c)
in (match (_72_527) with
| (e, c, g') -> begin
(
# 357 "FStar.TypeChecker.Tc.fst"
let _72_528 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_302 = (FStar_Syntax_Print.term_to_string e)
in (let _151_301 = (let _151_300 = (c.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_300))
in (FStar_Util.print2 "(%s) checked ... got %s\n" _151_302 _151_301)))
end else begin
()
end
in (
# 361 "FStar.TypeChecker.Tc.fst"
let gimp = (match ((let _151_303 = (FStar_Syntax_Subst.compress head)
in _151_303.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (u, _72_532) -> begin
(
# 364 "FStar.TypeChecker.Tc.fst"
let imp = (env0, u, e, c.FStar_Syntax_Syntax.res_typ, e.FStar_Syntax_Syntax.pos)
in (
# 365 "FStar.TypeChecker.Tc.fst"
let _72_536 = FStar_TypeChecker_Rel.trivial_guard
in {FStar_TypeChecker_Env.guard_f = _72_536.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _72_536.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_536.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (imp)::[]}))
end
| _72_539 -> begin
FStar_TypeChecker_Rel.trivial_guard
end)
in (
# 367 "FStar.TypeChecker.Tc.fst"
let gres = (let _151_304 = (FStar_TypeChecker_Rel.conj_guard g' gimp)
in (FStar_TypeChecker_Rel.conj_guard g _151_304))
in (
# 368 "FStar.TypeChecker.Tc.fst"
let _72_542 = if (FStar_TypeChecker_Env.debug env FStar_Options.Extreme) then begin
(let _151_305 = (FStar_TypeChecker_Rel.guard_to_string env gres)
in (FStar_Util.print1 "Guard from application node is %s\n" _151_305))
end else begin
()
end
in (e, c, gres)))))
end)))))
end))
end)))))
end
| FStar_Syntax_Syntax.Tm_match (e1, eqns) -> begin
(
# 373 "FStar.TypeChecker.Tc.fst"
let _72_550 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_550) with
| (env1, topt) -> begin
(
# 374 "FStar.TypeChecker.Tc.fst"
let env1 = (instantiate_both env1)
in (
# 375 "FStar.TypeChecker.Tc.fst"
let _72_555 = (tc_term env1 e1)
in (match (_72_555) with
| (e1, c1, g1) -> begin
(
# 376 "FStar.TypeChecker.Tc.fst"
let _72_566 = (match (topt) with
| Some (t) -> begin
(env, t)
end
| None -> begin
(
# 379 "FStar.TypeChecker.Tc.fst"
let _72_562 = (FStar_Syntax_Util.type_u ())
in (match (_72_562) with
| (k, _72_561) -> begin
(
# 380 "FStar.TypeChecker.Tc.fst"
let res_t = (FStar_TypeChecker_Util.new_uvar env k)
in (let _151_306 = (FStar_TypeChecker_Env.set_expected_typ env res_t)
in (_151_306, res_t)))
end))
end)
in (match (_72_566) with
| (env_branches, res_t) -> begin
(
# 383 "FStar.TypeChecker.Tc.fst"
let guard_x = (FStar_Syntax_Syntax.gen_bv "scrutinee" (Some (e1.FStar_Syntax_Syntax.pos)) c1.FStar_Syntax_Syntax.res_typ)
in (
# 384 "FStar.TypeChecker.Tc.fst"
let t_eqns = (FStar_All.pipe_right eqns (FStar_List.map (tc_eqn guard_x env_branches)))
in (
# 385 "FStar.TypeChecker.Tc.fst"
let _72_583 = (
# 386 "FStar.TypeChecker.Tc.fst"
let _72_580 = (FStar_List.fold_right (fun _72_574 _72_577 -> (match ((_72_574, _72_577)) with
| ((_72_570, f, c, g), (caccum, gaccum)) -> begin
(let _151_309 = (FStar_TypeChecker_Rel.conj_guard g gaccum)
in (((f, c))::caccum, _151_309))
end)) t_eqns ([], FStar_TypeChecker_Rel.trivial_guard))
in (match (_72_580) with
| (cases, g) -> begin
(let _151_310 = (FStar_TypeChecker_Util.bind_cases env res_t cases)
in (_151_310, g))
end))
in (match (_72_583) with
| (c_branches, g_branches) -> begin
(
# 390 "FStar.TypeChecker.Tc.fst"
let cres = (FStar_TypeChecker_Util.bind env (Some (e1)) c1 (Some (guard_x), c_branches))
in (
# 391 "FStar.TypeChecker.Tc.fst"
let e = (let _151_314 = (let _151_313 = (let _151_312 = (FStar_List.map (fun _72_592 -> (match (_72_592) with
| (f, _72_587, _72_589, _72_591) -> begin
f
end)) t_eqns)
in (e1, _151_312))
in FStar_Syntax_Syntax.Tm_match (_151_313))
in (FStar_Syntax_Syntax.mk _151_314 (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos))
in (
# 392 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed ((e, cres.FStar_Syntax_Syntax.res_typ, Some (cres.FStar_Syntax_Syntax.eff_name)))) None e.FStar_Syntax_Syntax.pos)
in (
# 393 "FStar.TypeChecker.Tc.fst"
let _72_595 = if (FStar_TypeChecker_Env.debug env FStar_Options.Extreme) then begin
(let _151_317 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _151_316 = (let _151_315 = (cres.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_315))
in (FStar_Util.print2 "(%s) comp type = %s\n" _151_317 _151_316)))
end else begin
()
end
in (let _151_318 = (FStar_TypeChecker_Rel.conj_guard g1 g_branches)
in (e, cres, _151_318))))))
end))))
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_let ((false, {FStar_Syntax_Syntax.lbname = FStar_Util.Inr (_72_607); FStar_Syntax_Syntax.lbunivs = _72_605; FStar_Syntax_Syntax.lbtyp = _72_603; FStar_Syntax_Syntax.lbeff = _72_601; FStar_Syntax_Syntax.lbdef = _72_599}::[]), _72_613) -> begin
(
# 400 "FStar.TypeChecker.Tc.fst"
let _72_616 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_319 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print1 "%s\n" _151_319))
end else begin
()
end
in (check_top_level_let env top))
end
| FStar_Syntax_Syntax.Tm_let ((false, _72_620), _72_623) -> begin
(check_inner_let env top)
end
| FStar_Syntax_Syntax.Tm_let ((true, {FStar_Syntax_Syntax.lbname = FStar_Util.Inr (_72_638); FStar_Syntax_Syntax.lbunivs = _72_636; FStar_Syntax_Syntax.lbtyp = _72_634; FStar_Syntax_Syntax.lbeff = _72_632; FStar_Syntax_Syntax.lbdef = _72_630}::_72_628), _72_644) -> begin
(
# 407 "FStar.TypeChecker.Tc.fst"
let _72_647 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_320 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print1 "%s\n" _151_320))
end else begin
()
end
in (check_top_level_let_rec env top))
end
| FStar_Syntax_Syntax.Tm_let ((true, _72_651), _72_654) -> begin
(check_inner_let_rec env top)
end)))))
and tc_value : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 420 "FStar.TypeChecker.Tc.fst"
let check_instantiated_fvar = (fun env v dc e t -> (
# 421 "FStar.TypeChecker.Tc.fst"
let _72_668 = (FStar_TypeChecker_Util.maybe_instantiate env e t)
in (match (_72_668) with
| (e, t, implicits) -> begin
(
# 423 "FStar.TypeChecker.Tc.fst"
let tc = if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
FStar_Util.Inl (t)
end else begin
(let _151_334 = (let _151_333 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _151_333))
in FStar_Util.Inr (_151_334))
end
in (
# 424 "FStar.TypeChecker.Tc.fst"
let is_data_ctor = (fun _72_4 -> (match (_72_4) with
| (Some (FStar_Syntax_Syntax.Data_ctor)) | (Some (FStar_Syntax_Syntax.Record_ctor (_))) -> begin
true
end
| _72_678 -> begin
false
end))
in if ((is_data_ctor dc) && (not ((FStar_TypeChecker_Env.is_datacon env v.FStar_Syntax_Syntax.v)))) then begin
(let _151_340 = (let _151_339 = (let _151_338 = (FStar_Util.format1 "Expected a data constructor; got %s" v.FStar_Syntax_Syntax.v.FStar_Ident.str)
in (let _151_337 = (FStar_TypeChecker_Env.get_range env)
in (_151_338, _151_337)))
in FStar_Syntax_Syntax.Error (_151_339))
in (Prims.raise _151_340))
end else begin
(value_check_expected_typ env e tc implicits)
end))
end)))
in (
# 434 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env e.FStar_Syntax_Syntax.pos)
in (
# 435 "FStar.TypeChecker.Tc.fst"
let top = (FStar_Syntax_Subst.compress e)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_bvar (x) -> begin
(FStar_All.failwith "Impossible: Violation of locally nameless convention")
end
| FStar_Syntax_Syntax.Tm_uvar (u, t1) -> begin
(
# 441 "FStar.TypeChecker.Tc.fst"
let g = (match ((let _151_341 = (FStar_Syntax_Subst.compress t1)
in _151_341.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (_72_689) -> begin
FStar_TypeChecker_Rel.trivial_guard
end
| _72_692 -> begin
(
# 443 "FStar.TypeChecker.Tc.fst"
let imp = (env, u, top, t1, top.FStar_Syntax_Syntax.pos)
in (
# 444 "FStar.TypeChecker.Tc.fst"
let _72_694 = FStar_TypeChecker_Rel.trivial_guard
in {FStar_TypeChecker_Env.guard_f = _72_694.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _72_694.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_694.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (imp)::[]}))
end)
in (value_check_expected_typ env e (FStar_Util.Inl (t1)) g))
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
(
# 449 "FStar.TypeChecker.Tc.fst"
let _72_700 = (FStar_Syntax_Util.type_u ())
in (match (_72_700) with
| (t, u) -> begin
(
# 450 "FStar.TypeChecker.Tc.fst"
let e = (FStar_TypeChecker_Util.new_uvar env t)
in (value_check_expected_typ env e (FStar_Util.Inl (t)) FStar_TypeChecker_Rel.trivial_guard))
end))
end
| FStar_Syntax_Syntax.Tm_name (x) -> begin
(
# 454 "FStar.TypeChecker.Tc.fst"
let t = if env.FStar_TypeChecker_Env.use_bv_sorts then begin
x.FStar_Syntax_Syntax.sort
end else begin
(FStar_TypeChecker_Env.lookup_bv env x)
end
in (
# 455 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.bv_to_name (
# 455 "FStar.TypeChecker.Tc.fst"
let _72_705 = x
in {FStar_Syntax_Syntax.ppname = _72_705.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_705.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}))
in (
# 456 "FStar.TypeChecker.Tc.fst"
let _72_711 = (FStar_TypeChecker_Util.maybe_instantiate env e t)
in (match (_72_711) with
| (e, t, implicits) -> begin
(
# 457 "FStar.TypeChecker.Tc.fst"
let tc = if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
FStar_Util.Inl (t)
end else begin
(let _151_343 = (let _151_342 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _151_342))
in FStar_Util.Inr (_151_343))
end
in (value_check_expected_typ env e tc implicits))
end))))
end
| FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (v, dc); FStar_Syntax_Syntax.tk = _72_718; FStar_Syntax_Syntax.pos = _72_716; FStar_Syntax_Syntax.vars = _72_714}, us) -> begin
(
# 461 "FStar.TypeChecker.Tc.fst"
let us = (FStar_List.map (tc_universe env) us)
in (
# 462 "FStar.TypeChecker.Tc.fst"
let _72_730 = (FStar_TypeChecker_Env.lookup_lid env v.FStar_Syntax_Syntax.v)
in (match (_72_730) with
| (us', t) -> begin
(
# 463 "FStar.TypeChecker.Tc.fst"
let _72_737 = if ((FStar_List.length us) <> (FStar_List.length us')) then begin
(let _151_346 = (let _151_345 = (let _151_344 = (FStar_TypeChecker_Env.get_range env)
in ("Unexpected number of universe instantiations", _151_344))
in FStar_Syntax_Syntax.Error (_151_345))
in (Prims.raise _151_346))
end else begin
(FStar_List.iter2 (fun u' u -> (match (u') with
| FStar_Syntax_Syntax.U_unif (u'') -> begin
(FStar_Unionfind.change u'' (Some (u)))
end
| _72_736 -> begin
(FStar_All.failwith "Impossible")
end)) us' us)
end
in (
# 468 "FStar.TypeChecker.Tc.fst"
let e = (let _151_349 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_fvar (((
# 468 "FStar.TypeChecker.Tc.fst"
let _72_739 = v
in {FStar_Syntax_Syntax.v = _72_739.FStar_Syntax_Syntax.v; FStar_Syntax_Syntax.ty = t; FStar_Syntax_Syntax.p = _72_739.FStar_Syntax_Syntax.p}), dc))) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Tm_uinst _151_349 us))
in (check_instantiated_fvar env v dc e t)))
end)))
end
| FStar_Syntax_Syntax.Tm_fvar (v, dc) -> begin
(
# 472 "FStar.TypeChecker.Tc.fst"
let _72_748 = (FStar_TypeChecker_Env.lookup_lid env v.FStar_Syntax_Syntax.v)
in (match (_72_748) with
| (us, t) -> begin
(
# 473 "FStar.TypeChecker.Tc.fst"
let e = (let _151_350 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_fvar (((
# 473 "FStar.TypeChecker.Tc.fst"
let _72_749 = v
in {FStar_Syntax_Syntax.v = _72_749.FStar_Syntax_Syntax.v; FStar_Syntax_Syntax.ty = t; FStar_Syntax_Syntax.p = _72_749.FStar_Syntax_Syntax.p}), dc))) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Tm_uinst _151_350 us))
in (check_instantiated_fvar env v dc e t))
end))
end
| FStar_Syntax_Syntax.Tm_constant (c) -> begin
(
# 477 "FStar.TypeChecker.Tc.fst"
let t = (FStar_TypeChecker_Recheck.check e)
in (
# 478 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (c)) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (value_check_expected_typ env e (FStar_Util.Inl (t)) FStar_TypeChecker_Rel.trivial_guard)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(
# 482 "FStar.TypeChecker.Tc.fst"
let _72_762 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_72_762) with
| (bs, c) -> begin
(
# 483 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 484 "FStar.TypeChecker.Tc.fst"
let _72_767 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_767) with
| (env, _72_766) -> begin
(
# 485 "FStar.TypeChecker.Tc.fst"
let _72_772 = (tc_binders env bs)
in (match (_72_772) with
| (bs, env, g, us) -> begin
(
# 486 "FStar.TypeChecker.Tc.fst"
let _72_776 = (tc_comp env c)
in (match (_72_776) with
| (c, uc, f) -> begin
(
# 487 "FStar.TypeChecker.Tc.fst"
let e = (
# 487 "FStar.TypeChecker.Tc.fst"
let _72_777 = (FStar_Syntax_Util.arrow bs c)
in {FStar_Syntax_Syntax.n = _72_777.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _72_777.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = top.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _72_777.FStar_Syntax_Syntax.vars})
in (
# 488 "FStar.TypeChecker.Tc.fst"
let _72_780 = (check_smt_pat env e bs c)
in (
# 489 "FStar.TypeChecker.Tc.fst"
let u = FStar_Syntax_Syntax.U_max ((uc)::us)
in (
# 490 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u)) None top.FStar_Syntax_Syntax.pos)
in (
# 491 "FStar.TypeChecker.Tc.fst"
let g = (let _151_351 = (FStar_TypeChecker_Rel.close_guard bs f)
in (FStar_TypeChecker_Rel.conj_guard g _151_351))
in (value_check_expected_typ env0 e (FStar_Util.Inl (t)) g))))))
end))
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(
# 495 "FStar.TypeChecker.Tc.fst"
let u = (tc_universe env u)
in (
# 496 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_succ (u))) None top.FStar_Syntax_Syntax.pos)
in (
# 497 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u)) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (value_check_expected_typ env e (FStar_Util.Inl (t)) FStar_TypeChecker_Rel.trivial_guard))))
end
| FStar_Syntax_Syntax.Tm_refine (x, phi) -> begin
(
# 501 "FStar.TypeChecker.Tc.fst"
let _72_796 = (let _151_353 = (let _151_352 = (FStar_Syntax_Syntax.mk_binder x)
in (_151_352)::[])
in (FStar_Syntax_Subst.open_term _151_353 phi))
in (match (_72_796) with
| (x, phi) -> begin
(
# 502 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 503 "FStar.TypeChecker.Tc.fst"
let _72_801 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_801) with
| (env, _72_800) -> begin
(
# 504 "FStar.TypeChecker.Tc.fst"
let _72_806 = (let _151_354 = (FStar_List.hd x)
in (tc_binder env _151_354))
in (match (_72_806) with
| (x, env, f1, u) -> begin
(
# 505 "FStar.TypeChecker.Tc.fst"
let _72_807 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_357 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _151_356 = (FStar_Syntax_Print.term_to_string phi)
in (let _151_355 = (FStar_Syntax_Print.bv_to_string (Prims.fst x))
in (FStar_Util.print3 "(%s) Checking refinement formula %s; binder is %s\n" _151_357 _151_356 _151_355))))
end else begin
()
end
in (
# 508 "FStar.TypeChecker.Tc.fst"
let _72_812 = (FStar_Syntax_Util.type_u ())
in (match (_72_812) with
| (t_phi, _72_811) -> begin
(
# 509 "FStar.TypeChecker.Tc.fst"
let _72_817 = (tc_check_tot_or_gtot_term env phi t_phi)
in (match (_72_817) with
| (phi, _72_815, f2) -> begin
(
# 510 "FStar.TypeChecker.Tc.fst"
let e = (
# 510 "FStar.TypeChecker.Tc.fst"
let _72_818 = (FStar_Syntax_Util.refine (Prims.fst x) phi)
in {FStar_Syntax_Syntax.n = _72_818.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _72_818.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = top.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _72_818.FStar_Syntax_Syntax.vars})
in (
# 511 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u)) None top.FStar_Syntax_Syntax.pos)
in (
# 512 "FStar.TypeChecker.Tc.fst"
let g = (let _151_358 = (FStar_TypeChecker_Rel.close_guard ((x)::[]) f2)
in (FStar_TypeChecker_Rel.conj_guard f1 _151_358))
in (value_check_expected_typ env0 e (FStar_Util.Inl (t)) g))))
end))
end)))
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_abs (bs, body, _72_826) -> begin
(
# 516 "FStar.TypeChecker.Tc.fst"
let bs = (FStar_TypeChecker_Util.maybe_add_implicit_binders env bs)
in (
# 517 "FStar.TypeChecker.Tc.fst"
let _72_832 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_359 = (FStar_Syntax_Print.term_to_string (
# 518 "FStar.TypeChecker.Tc.fst"
let _72_830 = top
in {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs ((bs, body, None)); FStar_Syntax_Syntax.tk = _72_830.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = _72_830.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _72_830.FStar_Syntax_Syntax.vars}))
in (FStar_Util.print1 "Abstraction is: %s\n" _151_359))
end else begin
()
end
in (
# 519 "FStar.TypeChecker.Tc.fst"
let _72_836 = (FStar_Syntax_Subst.open_term bs body)
in (match (_72_836) with
| (bs, body) -> begin
(tc_abs env top bs body)
end))))
end
| _72_838 -> begin
(let _151_361 = (let _151_360 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.format1 "Unexpected value: %s" _151_360))
in (FStar_All.failwith _151_361))
end)))))
and tc_comp : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.comp * FStar_Syntax_Syntax.universe * FStar_TypeChecker_Env.guard_t) = (fun env c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t) -> begin
(
# 533 "FStar.TypeChecker.Tc.fst"
let _72_845 = (FStar_Syntax_Util.type_u ())
in (match (_72_845) with
| (k, u) -> begin
(
# 534 "FStar.TypeChecker.Tc.fst"
let _72_850 = (tc_check_tot_or_gtot_term env t k)
in (match (_72_850) with
| (t, _72_848, g) -> begin
(let _151_364 = (FStar_Syntax_Syntax.mk_Total t)
in (_151_364, u, g))
end))
end))
end
| FStar_Syntax_Syntax.GTotal (t) -> begin
(
# 538 "FStar.TypeChecker.Tc.fst"
let _72_855 = (FStar_Syntax_Util.type_u ())
in (match (_72_855) with
| (k, u) -> begin
(
# 539 "FStar.TypeChecker.Tc.fst"
let _72_860 = (tc_check_tot_or_gtot_term env t k)
in (match (_72_860) with
| (t, _72_858, g) -> begin
(let _151_365 = (FStar_Syntax_Syntax.mk_GTotal t)
in (_151_365, u, g))
end))
end))
end
| FStar_Syntax_Syntax.Comp (c) -> begin
(
# 543 "FStar.TypeChecker.Tc.fst"
let kc = (FStar_TypeChecker_Env.lookup_effect_lid env c.FStar_Syntax_Syntax.effect_name)
in (
# 544 "FStar.TypeChecker.Tc.fst"
let _72_864 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_367 = (FStar_Syntax_Print.lid_to_string c.FStar_Syntax_Syntax.effect_name)
in (let _151_366 = (FStar_Syntax_Print.term_to_string kc)
in (FStar_Util.print2 "Type of effect %s is %s\n" _151_367 _151_366)))
end else begin
()
end
in (
# 545 "FStar.TypeChecker.Tc.fst"
let head = (FStar_Syntax_Syntax.fvar None c.FStar_Syntax_Syntax.effect_name (FStar_Ident.range_of_lid c.FStar_Syntax_Syntax.effect_name))
in (
# 546 "FStar.TypeChecker.Tc.fst"
let tc = (let _151_369 = (let _151_368 = (FStar_Syntax_Syntax.as_arg c.FStar_Syntax_Syntax.result_typ)
in (_151_368)::c.FStar_Syntax_Syntax.effect_args)
in (FStar_Syntax_Syntax.mk_Tm_app head _151_369 None c.FStar_Syntax_Syntax.result_typ.FStar_Syntax_Syntax.pos))
in (
# 547 "FStar.TypeChecker.Tc.fst"
let _72_872 = (tc_check_tot_or_gtot_term env tc FStar_Syntax_Syntax.teff)
in (match (_72_872) with
| (tc, _72_870, f) -> begin
(
# 548 "FStar.TypeChecker.Tc.fst"
let _72_876 = (FStar_Syntax_Util.head_and_args tc)
in (match (_72_876) with
| (_72_874, args) -> begin
(
# 549 "FStar.TypeChecker.Tc.fst"
let _72_879 = (let _151_371 = (FStar_List.hd args)
in (let _151_370 = (FStar_List.tl args)
in (_151_371, _151_370)))
in (match (_72_879) with
| (res, args) -> begin
(
# 550 "FStar.TypeChecker.Tc.fst"
let _72_895 = (let _151_373 = (FStar_All.pipe_right c.FStar_Syntax_Syntax.flags (FStar_List.map (fun _72_5 -> (match (_72_5) with
| FStar_Syntax_Syntax.DECREASES (e) -> begin
(
# 552 "FStar.TypeChecker.Tc.fst"
let _72_886 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_886) with
| (env, _72_885) -> begin
(
# 553 "FStar.TypeChecker.Tc.fst"
let _72_891 = (tc_tot_or_gtot_term env e)
in (match (_72_891) with
| (e, _72_889, g) -> begin
(FStar_Syntax_Syntax.DECREASES (e), g)
end))
end))
end
| f -> begin
(f, FStar_TypeChecker_Rel.trivial_guard)
end))))
in (FStar_All.pipe_right _151_373 FStar_List.unzip))
in (match (_72_895) with
| (flags, guards) -> begin
(
# 556 "FStar.TypeChecker.Tc.fst"
let u = (match ((FStar_TypeChecker_Recheck.check (Prims.fst res))) with
| {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_type (u); FStar_Syntax_Syntax.tk = _72_901; FStar_Syntax_Syntax.pos = _72_899; FStar_Syntax_Syntax.vars = _72_897} -> begin
u
end
| _72_906 -> begin
(FStar_All.failwith "Impossible")
end)
in (let _151_375 = (FStar_Syntax_Syntax.mk_Comp (
# 559 "FStar.TypeChecker.Tc.fst"
let _72_908 = c
in {FStar_Syntax_Syntax.effect_name = _72_908.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = (Prims.fst res); FStar_Syntax_Syntax.effect_args = args; FStar_Syntax_Syntax.flags = _72_908.FStar_Syntax_Syntax.flags}))
in (let _151_374 = (FStar_List.fold_left FStar_TypeChecker_Rel.conj_guard f guards)
in (_151_375, u, _151_374))))
end))
end))
end))
end))))))
end))
and tc_universe : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun env u -> (
# 566 "FStar.TypeChecker.Tc.fst"
let rec aux = (fun u -> (
# 567 "FStar.TypeChecker.Tc.fst"
let u = (FStar_Syntax_Subst.compress_univ u)
in (match (u) with
| FStar_Syntax_Syntax.U_bvar (_72_916) -> begin
(FStar_All.failwith "Impossible: locally nameless")
end
| FStar_Syntax_Syntax.U_unknown -> begin
(FStar_All.failwith "Unknown universe")
end
| (FStar_Syntax_Syntax.U_unif (_)) | (FStar_Syntax_Syntax.U_zero) -> begin
u
end
| FStar_Syntax_Syntax.U_succ (u) -> begin
(let _151_380 = (aux u)
in FStar_Syntax_Syntax.U_succ (_151_380))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(let _151_381 = (FStar_List.map aux us)
in FStar_Syntax_Syntax.U_max (_151_381))
end
| FStar_Syntax_Syntax.U_name (x) -> begin
if (env.FStar_TypeChecker_Env.use_bv_sorts || (FStar_TypeChecker_Env.lookup_univ env x)) then begin
u
end else begin
(let _151_385 = (let _151_384 = (let _151_383 = (FStar_Util.format1 "Universe variable \'%s\' not found" x.FStar_Ident.idText)
in (let _151_382 = (FStar_TypeChecker_Env.get_range env)
in (_151_383, _151_382)))
in FStar_Syntax_Syntax.Error (_151_384))
in (Prims.raise _151_385))
end
end)))
in (match (u) with
| FStar_Syntax_Syntax.U_unknown -> begin
(let _151_386 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_386 Prims.snd))
end
| _72_931 -> begin
(aux u)
end)))
and tc_abs : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top bs body -> (
# 589 "FStar.TypeChecker.Tc.fst"
let fail = (fun msg t -> (let _151_395 = (let _151_394 = (let _151_393 = (FStar_TypeChecker_Errors.expected_a_term_of_type_t_got_a_function env msg t top)
in (_151_393, top.FStar_Syntax_Syntax.pos))
in FStar_Syntax_Syntax.Error (_151_394))
in (Prims.raise _151_395)))
in (
# 598 "FStar.TypeChecker.Tc.fst"
let check_binders = (fun env bs bs_expected -> (
# 603 "FStar.TypeChecker.Tc.fst"
let rec aux = (fun _72_949 bs bs_expected -> (match (_72_949) with
| (env, out, g, subst) -> begin
(match ((bs, bs_expected)) with
| ([], []) -> begin
(env, (FStar_List.rev out), None, g, subst)
end
| ((hd, imp)::bs, (hd_expected, imp')::bs_expected) -> begin
(
# 607 "FStar.TypeChecker.Tc.fst"
let _72_976 = (match ((imp, imp')) with
| ((None, Some (FStar_Syntax_Syntax.Implicit))) | ((Some (FStar_Syntax_Syntax.Implicit), None)) -> begin
(let _151_412 = (let _151_411 = (let _151_410 = (let _151_408 = (FStar_Syntax_Print.bv_to_string hd)
in (FStar_Util.format1 "Inconsistent implicit argument annotation on argument %s" _151_408))
in (let _151_409 = (FStar_Syntax_Syntax.range_of_bv hd)
in (_151_410, _151_409)))
in FStar_Syntax_Syntax.Error (_151_411))
in (Prims.raise _151_412))
end
| _72_975 -> begin
()
end)
in (
# 614 "FStar.TypeChecker.Tc.fst"
let expected_t = (FStar_Syntax_Subst.subst subst hd_expected.FStar_Syntax_Syntax.sort)
in (
# 615 "FStar.TypeChecker.Tc.fst"
let _72_993 = (match ((let _151_413 = (FStar_Syntax_Util.unmeta hd.FStar_Syntax_Syntax.sort)
in _151_413.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
(expected_t, g)
end
| _72_981 -> begin
(
# 618 "FStar.TypeChecker.Tc.fst"
let _72_982 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_414 = (FStar_Syntax_Print.bv_to_string hd)
in (FStar_Util.print1 "Checking binder %s\n" _151_414))
end else begin
()
end
in (
# 619 "FStar.TypeChecker.Tc.fst"
let _72_988 = (tc_tot_or_gtot_term env hd.FStar_Syntax_Syntax.sort)
in (match (_72_988) with
| (t, _72_986, g1) -> begin
(
# 620 "FStar.TypeChecker.Tc.fst"
let g2 = (FStar_TypeChecker_Rel.teq env t expected_t)
in (
# 621 "FStar.TypeChecker.Tc.fst"
let g = (let _151_415 = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in (FStar_TypeChecker_Rel.conj_guard g _151_415))
in (t, g)))
end)))
end)
in (match (_72_993) with
| (t, g) -> begin
(
# 623 "FStar.TypeChecker.Tc.fst"
let hd = (
# 623 "FStar.TypeChecker.Tc.fst"
let _72_994 = hd
in {FStar_Syntax_Syntax.ppname = _72_994.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_994.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})
in (
# 624 "FStar.TypeChecker.Tc.fst"
let b = (hd, imp)
in (
# 625 "FStar.TypeChecker.Tc.fst"
let b_expected = (hd_expected, imp')
in (
# 626 "FStar.TypeChecker.Tc.fst"
let env = (maybe_push_binding env b)
in (
# 627 "FStar.TypeChecker.Tc.fst"
let subst = (let _151_416 = (FStar_Syntax_Syntax.bv_to_name hd)
in (maybe_extend_subst subst b_expected _151_416))
in (aux (env, (b)::out, g, subst) bs bs_expected))))))
end))))
end
| (rest, []) -> begin
(env, (FStar_List.rev out), Some (FStar_Util.Inl (rest)), g, subst)
end
| ([], rest) -> begin
(env, (FStar_List.rev out), Some (FStar_Util.Inr (rest)), g, subst)
end)
end))
in (aux (env, [], FStar_TypeChecker_Rel.trivial_guard, []) bs bs_expected)))
in (
# 637 "FStar.TypeChecker.Tc.fst"
let rec expected_function_typ = (fun env t0 -> (match (t0) with
| None -> begin
(
# 647 "FStar.TypeChecker.Tc.fst"
let _72_1014 = (match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
()
end
| _72_1013 -> begin
(FStar_All.failwith "Impossible: Can\'t have a let rec annotation but no expected type")
end)
in (
# 648 "FStar.TypeChecker.Tc.fst"
let _72_1021 = (tc_binders env bs)
in (match (_72_1021) with
| (bs, envbody, g, _72_1020) -> begin
(None, bs, [], None, envbody, g)
end)))
end
| Some (t) -> begin
(
# 652 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Subst.compress t)
in (
# 653 "FStar.TypeChecker.Tc.fst"
let rec as_function_typ = (fun norm t -> (match ((let _151_425 = (FStar_Syntax_Subst.compress t)
in _151_425.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) -> begin
(
# 657 "FStar.TypeChecker.Tc.fst"
let _72_1048 = (match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
()
end
| _72_1047 -> begin
(FStar_All.failwith "Impossible")
end)
in (
# 658 "FStar.TypeChecker.Tc.fst"
let _72_1055 = (tc_binders env bs)
in (match (_72_1055) with
| (bs, envbody, g, _72_1054) -> begin
(
# 659 "FStar.TypeChecker.Tc.fst"
let _72_1059 = (FStar_TypeChecker_Env.clear_expected_typ envbody)
in (match (_72_1059) with
| (envbody, _72_1058) -> begin
(Some ((t, true)), bs, [], None, envbody, g)
end))
end)))
end
| FStar_Syntax_Syntax.Tm_refine (b, _72_1062) -> begin
(
# 665 "FStar.TypeChecker.Tc.fst"
let _72_1072 = (as_function_typ norm b.FStar_Syntax_Syntax.sort)
in (match (_72_1072) with
| (_72_1066, bs, bs', copt, env, g) -> begin
(Some ((t, false)), bs, bs', copt, env, g)
end))
end
| FStar_Syntax_Syntax.Tm_arrow (bs_expected, c_expected) -> begin
(
# 669 "FStar.TypeChecker.Tc.fst"
let _72_1079 = (FStar_Syntax_Subst.open_comp bs_expected c_expected)
in (match (_72_1079) with
| (bs_expected, c_expected) -> begin
(
# 676 "FStar.TypeChecker.Tc.fst"
let check_actuals_against_formals = (fun env bs bs_expected -> (
# 677 "FStar.TypeChecker.Tc.fst"
let rec handle_more = (fun _72_1090 c_expected -> (match (_72_1090) with
| (env, bs, more, guard, subst) -> begin
(match (more) with
| None -> begin
(let _151_436 = (FStar_Syntax_Subst.subst_comp subst c_expected)
in (env, bs, guard, _151_436))
end
| Some (FStar_Util.Inr (more_bs_expected)) -> begin
(
# 682 "FStar.TypeChecker.Tc.fst"
let c = (let _151_437 = (FStar_Syntax_Util.arrow more_bs_expected c_expected)
in (FStar_Syntax_Syntax.mk_Total _151_437))
in (let _151_438 = (FStar_Syntax_Subst.subst_comp subst c)
in (env, bs, guard, _151_438)))
end
| Some (FStar_Util.Inl (more_bs)) -> begin
(
# 686 "FStar.TypeChecker.Tc.fst"
let c = (FStar_Syntax_Subst.subst_comp subst c_expected)
in if (FStar_Syntax_Util.is_total_comp c) then begin
(
# 689 "FStar.TypeChecker.Tc.fst"
let t = (unfold_whnf env (FStar_Syntax_Util.comp_result c))
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs_expected, c_expected) -> begin
(
# 692 "FStar.TypeChecker.Tc.fst"
let _72_1111 = (check_binders env more_bs bs_expected)
in (match (_72_1111) with
| (env, bs', more, guard', subst) -> begin
(let _151_440 = (let _151_439 = (FStar_TypeChecker_Rel.conj_guard guard guard')
in (env, (FStar_List.append bs bs'), more, _151_439, subst))
in (handle_more _151_440 c_expected))
end))
end
| _72_1113 -> begin
(let _151_442 = (let _151_441 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "More arguments than annotated type (%s)" _151_441))
in (fail _151_442 t))
end))
end else begin
(fail "Function definition takes more arguments than expected from its annotated type" t)
end)
end)
end))
in (let _151_443 = (check_binders env bs bs_expected)
in (handle_more _151_443 c_expected))))
in (
# 699 "FStar.TypeChecker.Tc.fst"
let mk_letrec_env = (fun envbody bs c -> (
# 700 "FStar.TypeChecker.Tc.fst"
let letrecs = (guard_letrecs envbody bs c)
in (
# 701 "FStar.TypeChecker.Tc.fst"
let envbody = (
# 701 "FStar.TypeChecker.Tc.fst"
let _72_1119 = envbody
in {FStar_TypeChecker_Env.solver = _72_1119.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1119.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1119.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1119.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1119.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1119.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1119.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1119.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1119.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1119.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1119.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1119.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = []; FStar_TypeChecker_Env.top_level = _72_1119.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_1119.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_1119.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1119.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1119.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1119.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1119.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1119.FStar_TypeChecker_Env.use_bv_sorts})
in (FStar_All.pipe_right letrecs (FStar_List.fold_left (fun _72_1124 _72_1127 -> (match ((_72_1124, _72_1127)) with
| ((env, letrec_binders), (l, t)) -> begin
(
# 703 "FStar.TypeChecker.Tc.fst"
let _72_1133 = (let _151_453 = (let _151_452 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _151_452 Prims.fst))
in (tc_term _151_453 t))
in (match (_72_1133) with
| (t, _72_1130, _72_1132) -> begin
(
# 704 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_let_binding env l ([], t))
in (
# 705 "FStar.TypeChecker.Tc.fst"
let lb = (match (l) with
| FStar_Util.Inl (x) -> begin
(let _151_454 = (FStar_Syntax_Syntax.mk_binder (
# 706 "FStar.TypeChecker.Tc.fst"
let _72_1137 = x
in {FStar_Syntax_Syntax.ppname = _72_1137.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_1137.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}))
in (_151_454)::letrec_binders)
end
| _72_1140 -> begin
letrec_binders
end)
in (env, lb)))
end))
end)) (envbody, []))))))
in (
# 711 "FStar.TypeChecker.Tc.fst"
let _72_1146 = (check_actuals_against_formals env bs bs_expected)
in (match (_72_1146) with
| (envbody, bs, g, c) -> begin
(
# 712 "FStar.TypeChecker.Tc.fst"
let _72_1149 = if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
(mk_letrec_env envbody bs c)
end else begin
(envbody, [])
end
in (match (_72_1149) with
| (envbody, letrecs) -> begin
(
# 713 "FStar.TypeChecker.Tc.fst"
let envbody = (FStar_TypeChecker_Env.set_expected_typ envbody (FStar_Syntax_Util.comp_result c))
in (Some ((t, false)), bs, letrecs, Some (c), envbody, g))
end))
end))))
end))
end
| _72_1152 -> begin
if (not (norm)) then begin
(let _151_455 = (unfold_whnf env t)
in (as_function_typ true _151_455))
end else begin
(
# 721 "FStar.TypeChecker.Tc.fst"
let _72_1161 = (expected_function_typ env None)
in (match (_72_1161) with
| (_72_1154, bs, _72_1157, c_opt, envbody, g) -> begin
(Some ((t, false)), bs, [], c_opt, envbody, g)
end))
end
end))
in (as_function_typ false t)))
end))
in (
# 725 "FStar.TypeChecker.Tc.fst"
let use_eq = env.FStar_TypeChecker_Env.use_eq
in (
# 726 "FStar.TypeChecker.Tc.fst"
let _72_1165 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_1165) with
| (env, topt) -> begin
(
# 727 "FStar.TypeChecker.Tc.fst"
let _72_1169 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_456 = (match (topt) with
| None -> begin
"None"
end
| Some (t) -> begin
(FStar_Syntax_Print.term_to_string t)
end)
in (FStar_Util.print2 "!!!!!!!!!!!!!!!Expected type is %s, top_level=%s\n" _151_456 (if env.FStar_TypeChecker_Env.top_level then begin
"true"
end else begin
"false"
end)))
end else begin
()
end
in (
# 731 "FStar.TypeChecker.Tc.fst"
let _72_1177 = (expected_function_typ env topt)
in (match (_72_1177) with
| (tfun_opt, bs, letrec_binders, c_opt, envbody, g) -> begin
(
# 732 "FStar.TypeChecker.Tc.fst"
let _72_1183 = (tc_term (
# 732 "FStar.TypeChecker.Tc.fst"
let _72_1178 = envbody
in {FStar_TypeChecker_Env.solver = _72_1178.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1178.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1178.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1178.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1178.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1178.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1178.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1178.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1178.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1178.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1178.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1178.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1178.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = _72_1178.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = use_eq; FStar_TypeChecker_Env.is_iface = _72_1178.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1178.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1178.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1178.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1178.FStar_TypeChecker_Env.use_bv_sorts}) body)
in (match (_72_1183) with
| (body, cbody, guard_body) -> begin
(
# 733 "FStar.TypeChecker.Tc.fst"
let _72_1184 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_462 = (FStar_Syntax_Print.term_to_string body)
in (let _151_461 = (let _151_457 = (cbody.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_457))
in (let _151_460 = (FStar_TypeChecker_Rel.guard_to_string env guard_body)
in (let _151_459 = (let _151_458 = (cbody.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_458))
in (FStar_Util.print4 "!!!!!!!!!!!!!!!body %s has type %s\nguard is %s\nAgain cbody=%s\n" _151_462 _151_461 _151_460 _151_459)))))
end else begin
()
end
in (
# 737 "FStar.TypeChecker.Tc.fst"
let guard_body = (FStar_TypeChecker_Rel.solve_deferred_constraints envbody guard_body)
in (
# 739 "FStar.TypeChecker.Tc.fst"
let _72_1187 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Implicits"))) then begin
(let _151_465 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length guard_body.FStar_TypeChecker_Env.implicits))
in (let _151_464 = (let _151_463 = (cbody.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _151_463))
in (FStar_Util.print2 "Introduced %s implicits in body of abstraction\nAfter solving constraints, cbody is %s\n" _151_465 _151_464)))
end else begin
()
end
in (
# 743 "FStar.TypeChecker.Tc.fst"
let _72_1194 = (let _151_467 = (let _151_466 = (cbody.FStar_Syntax_Syntax.comp ())
in (body, _151_466))
in (check_expected_effect (
# 743 "FStar.TypeChecker.Tc.fst"
let _72_1189 = envbody
in {FStar_TypeChecker_Env.solver = _72_1189.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1189.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1189.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1189.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1189.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1189.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1189.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1189.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1189.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1189.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1189.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1189.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1189.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_1189.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_1189.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = use_eq; FStar_TypeChecker_Env.is_iface = _72_1189.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1189.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1189.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1189.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1189.FStar_TypeChecker_Env.use_bv_sorts}) c_opt _151_467))
in (match (_72_1194) with
| (body, cbody, guard) -> begin
(
# 744 "FStar.TypeChecker.Tc.fst"
let guard = (FStar_TypeChecker_Rel.conj_guard guard_body guard)
in (
# 745 "FStar.TypeChecker.Tc.fst"
let guard = if (env.FStar_TypeChecker_Env.top_level || (not ((FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str)))) then begin
(let _151_468 = (FStar_TypeChecker_Rel.conj_guard g guard)
in (FStar_TypeChecker_Rel.discharge_guard envbody _151_468))
end else begin
(
# 747 "FStar.TypeChecker.Tc.fst"
let guard = (FStar_TypeChecker_Rel.close_guard (FStar_List.append bs letrec_binders) guard)
in (FStar_TypeChecker_Rel.conj_guard g guard))
end
in (
# 750 "FStar.TypeChecker.Tc.fst"
let tfun_computed = (FStar_Syntax_Util.arrow bs cbody)
in (
# 751 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Util.abs bs body (Some ((FStar_Syntax_Util.lcomp_of_comp cbody))))
in (
# 752 "FStar.TypeChecker.Tc.fst"
let _72_1217 = (match (tfun_opt) with
| Some (t, use_teq) -> begin
(
# 754 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (_72_1206) -> begin
(e, t, guard)
end
| _72_1209 -> begin
(
# 763 "FStar.TypeChecker.Tc.fst"
let _72_1212 = if use_teq then begin
(let _151_469 = (FStar_TypeChecker_Rel.teq env t tfun_computed)
in (e, _151_469))
end else begin
(FStar_TypeChecker_Util.check_and_ascribe env e tfun_computed t)
end
in (match (_72_1212) with
| (e, guard') -> begin
(let _151_470 = (FStar_TypeChecker_Rel.conj_guard guard guard')
in (e, t, _151_470))
end))
end))
end
| None -> begin
(e, tfun_computed, guard)
end)
in (match (_72_1217) with
| (e, tfun, guard) -> begin
(
# 773 "FStar.TypeChecker.Tc.fst"
let c = if env.FStar_TypeChecker_Env.top_level then begin
(FStar_Syntax_Syntax.mk_Total tfun)
end else begin
(FStar_TypeChecker_Util.return_value env tfun e)
end
in (
# 774 "FStar.TypeChecker.Tc.fst"
let _72_1221 = (FStar_TypeChecker_Util.strengthen_precondition None env e (FStar_Syntax_Util.lcomp_of_comp c) guard)
in (match (_72_1221) with
| (c, g) -> begin
(e, c, g)
end)))
end))))))
end)))))
end))
end)))
end)))))))
and check_application_args : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.typ Prims.option  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env head chead ghead args expected_topt -> (
# 782 "FStar.TypeChecker.Tc.fst"
let n_args = (FStar_List.length args)
in (
# 783 "FStar.TypeChecker.Tc.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 784 "FStar.TypeChecker.Tc.fst"
let thead = chead.FStar_Syntax_Syntax.res_typ
in (
# 785 "FStar.TypeChecker.Tc.fst"
let _72_1231 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_479 = (FStar_Range.string_of_range head.FStar_Syntax_Syntax.pos)
in (let _151_478 = (FStar_Syntax_Print.term_to_string thead)
in (FStar_Util.print2 "(%s) Type of head is %s\n" _151_479 _151_478)))
end else begin
()
end
in (
# 786 "FStar.TypeChecker.Tc.fst"
let rec check_function_app = (fun norm tf -> (match ((let _151_484 = (FStar_Syntax_Util.unrefine tf)
in _151_484.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) -> begin
(
# 790 "FStar.TypeChecker.Tc.fst"
let rec tc_args = (fun env args -> (match (args) with
| [] -> begin
([], [], FStar_TypeChecker_Rel.trivial_guard)
end
| (e, imp)::tl -> begin
(
# 793 "FStar.TypeChecker.Tc.fst"
let _72_1265 = (tc_term env e)
in (match (_72_1265) with
| (e, c, g_e) -> begin
(
# 794 "FStar.TypeChecker.Tc.fst"
let _72_1269 = (tc_args env tl)
in (match (_72_1269) with
| (args, comps, g_rest) -> begin
(let _151_489 = (FStar_TypeChecker_Rel.conj_guard g_e g_rest)
in (((e, imp))::args, (c)::comps, _151_489))
end))
end))
end))
in (
# 802 "FStar.TypeChecker.Tc.fst"
let _72_1273 = (tc_args env args)
in (match (_72_1273) with
| (args, comps, g_args) -> begin
(
# 803 "FStar.TypeChecker.Tc.fst"
let bs = (let _151_491 = (FStar_All.pipe_right comps (FStar_List.map (fun c -> (c.FStar_Syntax_Syntax.res_typ, None))))
in (FStar_Syntax_Util.null_binders_of_tks _151_491))
in (
# 804 "FStar.TypeChecker.Tc.fst"
let ml_or_tot = (match ((FStar_TypeChecker_Env.try_lookup_effect_lid env FStar_Syntax_Const.effect_ML_lid)) with
| None -> begin
(fun t r -> (FStar_Syntax_Syntax.mk_Total t))
end
| _72_1280 -> begin
FStar_Syntax_Util.ml_comp
end)
in (
# 807 "FStar.TypeChecker.Tc.fst"
let ml_or_tot = (match (expected_topt) with
| None -> begin
ml_or_tot
end
| Some (t) -> begin
(match ((let _151_506 = (FStar_Syntax_Subst.compress t)
in _151_506.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_72_1286) -> begin
(fun t r -> (FStar_Syntax_Syntax.mk_GTotal t))
end
| _72_1291 -> begin
ml_or_tot
end)
end)
in (
# 814 "FStar.TypeChecker.Tc.fst"
let cres = (let _151_511 = (let _151_510 = (let _151_509 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_509 Prims.fst))
in (FStar_TypeChecker_Util.new_uvar env _151_510))
in (ml_or_tot _151_511 r))
in (
# 815 "FStar.TypeChecker.Tc.fst"
let bs_cres = (FStar_Syntax_Util.arrow bs cres)
in (
# 816 "FStar.TypeChecker.Tc.fst"
let _72_1295 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) FStar_Options.Extreme) then begin
(let _151_514 = (FStar_Syntax_Print.term_to_string head)
in (let _151_513 = (FStar_Syntax_Print.term_to_string tf)
in (let _151_512 = (FStar_Syntax_Print.term_to_string bs_cres)
in (FStar_Util.print3 "Forcing the type of %s from %s to %s\n" _151_514 _151_513 _151_512))))
end else begin
()
end
in (
# 821 "FStar.TypeChecker.Tc.fst"
let _72_1297 = (let _151_515 = (FStar_TypeChecker_Rel.teq env tf bs_cres)
in (FStar_All.pipe_left (FStar_TypeChecker_Rel.force_trivial_guard env) _151_515))
in (
# 822 "FStar.TypeChecker.Tc.fst"
let comp = (let _151_518 = (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp cres)
in (FStar_List.fold_right (fun c out -> (FStar_TypeChecker_Util.bind env None c (None, out))) ((chead)::comps) _151_518))
in (let _151_520 = (FStar_Syntax_Syntax.mk_Tm_app head args (Some (comp.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (let _151_519 = (FStar_TypeChecker_Rel.conj_guard ghead g_args)
in (_151_520, comp, _151_519)))))))))))
end)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(
# 826 "FStar.TypeChecker.Tc.fst"
let _72_1308 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_72_1308) with
| (bs, c) -> begin
(
# 828 "FStar.TypeChecker.Tc.fst"
let rec tc_args = (fun _72_1316 bs cres args -> (match (_72_1316) with
| (subst, outargs, arg_rets, comps, g, fvs) -> begin
(match ((bs, args)) with
| ((x, Some (FStar_Syntax_Syntax.Implicit))::rest, (_72_1329, None)::_72_1327) -> begin
(
# 839 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in (
# 840 "FStar.TypeChecker.Tc.fst"
let _72_1335 = (fxv_check head env t fvs)
in (
# 841 "FStar.TypeChecker.Tc.fst"
let _72_1340 = (FStar_TypeChecker_Util.new_implicit_var env t)
in (match (_72_1340) with
| (varg, u, implicits) -> begin
(
# 842 "FStar.TypeChecker.Tc.fst"
let subst = (FStar_Syntax_Syntax.NT ((x, varg)))::subst
in (
# 843 "FStar.TypeChecker.Tc.fst"
let arg = (let _151_555 = (FStar_Syntax_Syntax.as_implicit true)
in (varg, _151_555))
in (let _151_561 = (let _151_560 = (FStar_TypeChecker_Rel.conj_guard implicits g)
in (subst, (arg)::outargs, (arg)::arg_rets, comps, _151_560, fvs))
in (tc_args _151_561 rest cres args))))
end))))
end
| ((x, aqual)::rest, (e, aq)::rest') -> begin
(
# 847 "FStar.TypeChecker.Tc.fst"
let _72_1368 = (match ((aqual, aq)) with
| ((Some (FStar_Syntax_Syntax.Implicit), Some (FStar_Syntax_Syntax.Implicit))) | ((None, None)) | ((Some (FStar_Syntax_Syntax.Equality), None)) -> begin
()
end
| _72_1367 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Inconsistent implicit qualifier", e.FStar_Syntax_Syntax.pos))))
end)
in (
# 852 "FStar.TypeChecker.Tc.fst"
let targ = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in (
# 853 "FStar.TypeChecker.Tc.fst"
let x = (
# 853 "FStar.TypeChecker.Tc.fst"
let _72_1371 = x
in {FStar_Syntax_Syntax.ppname = _72_1371.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_1371.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = targ})
in (
# 854 "FStar.TypeChecker.Tc.fst"
let _72_1374 = if (FStar_TypeChecker_Env.debug env FStar_Options.Extreme) then begin
(let _151_562 = (FStar_Syntax_Print.term_to_string targ)
in (FStar_Util.print1 "\tType of arg (after subst) = %s\n" _151_562))
end else begin
()
end
in (
# 855 "FStar.TypeChecker.Tc.fst"
let _72_1376 = (fxv_check head env targ fvs)
in (
# 856 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_expected_typ env targ)
in (
# 857 "FStar.TypeChecker.Tc.fst"
let env = (
# 857 "FStar.TypeChecker.Tc.fst"
let _72_1379 = env
in {FStar_TypeChecker_Env.solver = _72_1379.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1379.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1379.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1379.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1379.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1379.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1379.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1379.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1379.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1379.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1379.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1379.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1379.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_1379.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_1379.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = (is_eq aqual); FStar_TypeChecker_Env.is_iface = _72_1379.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1379.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1379.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1379.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1379.FStar_TypeChecker_Env.use_bv_sorts})
in (
# 858 "FStar.TypeChecker.Tc.fst"
let _72_1382 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_565 = (FStar_Syntax_Print.tag_of_term e)
in (let _151_564 = (FStar_Syntax_Print.term_to_string e)
in (let _151_563 = (FStar_Syntax_Print.term_to_string targ)
in (FStar_Util.print3 "Checking arg (%s) %s at type %s\n" _151_565 _151_564 _151_563))))
end else begin
()
end
in (
# 859 "FStar.TypeChecker.Tc.fst"
let _72_1387 = (tc_term env e)
in (match (_72_1387) with
| (e, c, g_e) -> begin
(
# 860 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.conj_guard g g_e)
in (
# 862 "FStar.TypeChecker.Tc.fst"
let arg = (e, aq)
in if (FStar_Syntax_Util.is_tot_or_gtot_lcomp c) then begin
(
# 864 "FStar.TypeChecker.Tc.fst"
let subst = (let _151_566 = (FStar_List.hd bs)
in (maybe_extend_subst subst _151_566 e))
in (tc_args (subst, (arg)::outargs, (arg)::arg_rets, comps, g, fvs) rest cres rest'))
end else begin
if (FStar_TypeChecker_Util.is_pure_or_ghost_effect env c.FStar_Syntax_Syntax.eff_name) then begin
(
# 867 "FStar.TypeChecker.Tc.fst"
let subst = (let _151_571 = (FStar_List.hd bs)
in (maybe_extend_subst subst _151_571 e))
in (
# 868 "FStar.TypeChecker.Tc.fst"
let _72_1394 = (((Some (x), c))::comps, g)
in (match (_72_1394) with
| (comps, guard) -> begin
(tc_args (subst, (arg)::outargs, (arg)::arg_rets, comps, guard, fvs) rest cres rest')
end)))
end else begin
if (let _151_576 = (FStar_List.hd bs)
in (FStar_Syntax_Syntax.is_null_binder _151_576)) then begin
(
# 872 "FStar.TypeChecker.Tc.fst"
let newx = (FStar_Syntax_Syntax.new_bv (Some (e.FStar_Syntax_Syntax.pos)) c.FStar_Syntax_Syntax.res_typ)
in (
# 873 "FStar.TypeChecker.Tc.fst"
let arg' = (let _151_577 = (FStar_Syntax_Syntax.bv_to_name newx)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _151_577))
in (tc_args (subst, (arg)::outargs, (arg')::arg_rets, ((Some (newx), c))::comps, g, fvs) rest cres rest')))
end else begin
(let _151_586 = (let _151_585 = (let _151_583 = (let _151_582 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Syntax.as_arg _151_582))
in (_151_583)::arg_rets)
in (let _151_584 = (FStar_Util.set_add x fvs)
in (subst, (arg)::outargs, _151_585, ((Some (x), c))::comps, g, _151_584)))
in (tc_args _151_586 rest cres rest'))
end
end
end))
end))))))))))
end
| (_72_1398, []) -> begin
(
# 882 "FStar.TypeChecker.Tc.fst"
let _72_1401 = (fxv_check head env cres.FStar_Syntax_Syntax.res_typ fvs)
in (
# 883 "FStar.TypeChecker.Tc.fst"
let _72_1419 = (match (bs) with
| [] -> begin
(
# 886 "FStar.TypeChecker.Tc.fst"
let cres = (FStar_TypeChecker_Util.subst_lcomp subst cres)
in (
# 892 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.conj_guard ghead g)
in (
# 894 "FStar.TypeChecker.Tc.fst"
let refine_with_equality = ((FStar_Syntax_Util.is_pure_or_ghost_lcomp cres) && (FStar_All.pipe_right comps (FStar_Util.for_some (fun _72_1409 -> (match (_72_1409) with
| (_72_1407, c) -> begin
(not ((FStar_Syntax_Util.is_pure_or_ghost_lcomp c)))
end)))))
in (
# 901 "FStar.TypeChecker.Tc.fst"
let cres = if refine_with_equality then begin
(let _151_588 = (FStar_Syntax_Syntax.mk_Tm_app head (FStar_List.rev arg_rets) (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (FStar_TypeChecker_Util.maybe_assume_result_eq_pure_term env _151_588 cres))
end else begin
(
# 907 "FStar.TypeChecker.Tc.fst"
let _72_1411 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_591 = (FStar_Syntax_Print.term_to_string head)
in (let _151_590 = (FStar_Syntax_Print.lcomp_to_string cres)
in (let _151_589 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (FStar_Util.print3 "Not refining result: f=%s; cres=%s; guard=%s\n" _151_591 _151_590 _151_589))))
end else begin
()
end
in cres)
end
in (cres, g)))))
end
| _72_1415 -> begin
(
# 916 "FStar.TypeChecker.Tc.fst"
let g = (let _151_592 = (FStar_TypeChecker_Rel.conj_guard ghead g)
in (FStar_All.pipe_right _151_592 (FStar_TypeChecker_Rel.solve_deferred_constraints env)))
in (let _151_597 = (let _151_596 = (let _151_595 = (let _151_594 = (let _151_593 = (cres.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Util.arrow bs _151_593))
in (FStar_All.pipe_left (FStar_Syntax_Subst.subst subst) _151_594))
in (FStar_Syntax_Syntax.mk_Total _151_595))
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _151_596))
in (_151_597, g)))
end)
in (match (_72_1419) with
| (cres, g) -> begin
(
# 919 "FStar.TypeChecker.Tc.fst"
let _72_1420 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_598 = (FStar_Syntax_Print.lcomp_to_string cres)
in (FStar_Util.print1 "\t Type of result cres is %s\n" _151_598))
end else begin
()
end
in (
# 920 "FStar.TypeChecker.Tc.fst"
let comp = (FStar_List.fold_left (fun out c -> (FStar_TypeChecker_Util.bind env None (Prims.snd c) ((Prims.fst c), out))) cres comps)
in (
# 921 "FStar.TypeChecker.Tc.fst"
let comp = (FStar_TypeChecker_Util.bind env None chead (None, comp))
in (
# 922 "FStar.TypeChecker.Tc.fst"
let app = (FStar_Syntax_Syntax.mk_Tm_app head (FStar_List.rev outargs) (Some (comp.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (
# 923 "FStar.TypeChecker.Tc.fst"
let comp = (FStar_TypeChecker_Util.record_application_site env app comp)
in (
# 924 "FStar.TypeChecker.Tc.fst"
let _72_1430 = (FStar_TypeChecker_Util.strengthen_precondition None env app comp g)
in (match (_72_1430) with
| (comp, g) -> begin
(
# 925 "FStar.TypeChecker.Tc.fst"
let _72_1431 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_604 = (FStar_TypeChecker_Normalize.term_to_string env app)
in (let _151_603 = (let _151_602 = (comp.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Print.comp_to_string _151_602))
in (FStar_Util.print2 "\t Type of app term %s is %s\n" _151_604 _151_603)))
end else begin
()
end
in (app, comp, g))
end)))))))
end)))
end
| ([], arg::_72_1435) -> begin
(
# 931 "FStar.TypeChecker.Tc.fst"
let rec aux = (fun norm tres -> (
# 932 "FStar.TypeChecker.Tc.fst"
let tres = (let _151_609 = (FStar_Syntax_Subst.compress tres)
in (FStar_All.pipe_right _151_609 FStar_Syntax_Util.unrefine))
in (match (tres.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, cres') -> begin
(
# 935 "FStar.TypeChecker.Tc.fst"
let _72_1447 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_610 = (FStar_Range.string_of_range tres.FStar_Syntax_Syntax.pos)
in (FStar_Util.print1 "%s: Warning: Potentially redundant explicit currying of a function type \n" _151_610))
end else begin
()
end
in (tc_args (subst, outargs, arg_rets, ((None, cres))::comps, g, fvs) bs (FStar_Syntax_Util.lcomp_of_comp cres') args))
end
| _72_1450 when (not (norm)) -> begin
(let _151_615 = (unfold_whnf env tres)
in (aux true _151_615))
end
| _72_1452 -> begin
(let _151_621 = (let _151_620 = (let _151_619 = (let _151_617 = (FStar_TypeChecker_Normalize.term_to_string env tf)
in (let _151_616 = (FStar_Util.string_of_int n_args)
in (FStar_Util.format2 "Too many arguments to function of type %s; got %s arguments" _151_617 _151_616)))
in (let _151_618 = (FStar_Syntax_Syntax.argpos arg)
in (_151_619, _151_618)))
in FStar_Syntax_Syntax.Error (_151_620))
in (Prims.raise _151_621))
end)))
in (aux false cres.FStar_Syntax_Syntax.res_typ))
end)
end))
in (let _151_623 = (let _151_622 = (FStar_Syntax_Syntax.new_bv_set ())
in ([], [], [], [], FStar_TypeChecker_Rel.trivial_guard, _151_622))
in (tc_args _151_623 bs (FStar_Syntax_Util.lcomp_of_comp c) args)))
end))
end
| _72_1454 -> begin
if (not (norm)) then begin
(let _151_624 = (unfold_whnf env tf)
in (check_function_app true _151_624))
end else begin
(let _151_627 = (let _151_626 = (let _151_625 = (FStar_TypeChecker_Errors.expected_function_typ env tf)
in (_151_625, head.FStar_Syntax_Syntax.pos))
in FStar_Syntax_Syntax.Error (_151_626))
in (Prims.raise _151_627))
end
end))
in (let _151_629 = (let _151_628 = (FStar_Syntax_Util.unrefine thead)
in (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::[]) env _151_628))
in (check_function_app false _151_629))))))))
and check_short_circuit_args : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.typ Prims.option  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env head chead g_head args expected_topt -> (
# 961 "FStar.TypeChecker.Tc.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 962 "FStar.TypeChecker.Tc.fst"
let tf = (FStar_Syntax_Subst.compress chead.FStar_Syntax_Syntax.res_typ)
in (match (tf.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) when ((FStar_Syntax_Util.is_total_comp c) && ((FStar_List.length bs) = (FStar_List.length args))) -> begin
(
# 965 "FStar.TypeChecker.Tc.fst"
let res_t = (FStar_Syntax_Util.comp_result c)
in (
# 966 "FStar.TypeChecker.Tc.fst"
let _72_1490 = (FStar_List.fold_left2 (fun _72_1471 _72_1474 _72_1477 -> (match ((_72_1471, _72_1474, _72_1477)) with
| ((seen, guard, ghost), (e, aq), (b, aq')) -> begin
(
# 967 "FStar.TypeChecker.Tc.fst"
let _72_1478 = if (aq <> aq') then begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Inconsistent implicit qualifiers", e.FStar_Syntax_Syntax.pos))))
end else begin
()
end
in (
# 968 "FStar.TypeChecker.Tc.fst"
let _72_1483 = (tc_check_tot_or_gtot_term env e b.FStar_Syntax_Syntax.sort)
in (match (_72_1483) with
| (e, c, g) -> begin
(
# 969 "FStar.TypeChecker.Tc.fst"
let short = (FStar_TypeChecker_Util.short_circuit head seen)
in (
# 970 "FStar.TypeChecker.Tc.fst"
let g = (let _151_639 = (FStar_TypeChecker_Rel.guard_of_guard_formula short)
in (FStar_TypeChecker_Rel.imp_guard _151_639 g))
in (
# 971 "FStar.TypeChecker.Tc.fst"
let ghost = (ghost || ((not ((FStar_Syntax_Util.is_total_lcomp c))) && (not ((FStar_TypeChecker_Util.is_pure_effect env c.FStar_Syntax_Syntax.eff_name)))))
in (let _151_643 = (let _151_641 = (let _151_640 = (FStar_Syntax_Syntax.as_arg e)
in (_151_640)::[])
in (FStar_List.append seen _151_641))
in (let _151_642 = (FStar_TypeChecker_Rel.conj_guard guard g)
in (_151_643, _151_642, ghost))))))
end)))
end)) ([], g_head, false) args bs)
in (match (_72_1490) with
| (args, guard, ghost) -> begin
(
# 975 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk_Tm_app head args (Some (res_t.FStar_Syntax_Syntax.n)) r)
in (
# 976 "FStar.TypeChecker.Tc.fst"
let c = if ghost then begin
(let _151_644 = (FStar_Syntax_Syntax.mk_GTotal res_t)
in (FStar_All.pipe_right _151_644 FStar_Syntax_Util.lcomp_of_comp))
end else begin
(FStar_Syntax_Util.lcomp_of_comp c)
end
in (
# 977 "FStar.TypeChecker.Tc.fst"
let _72_1495 = (FStar_TypeChecker_Util.strengthen_precondition None env e c guard)
in (match (_72_1495) with
| (c, g) -> begin
(e, c, g)
end))))
end)))
end
| _72_1497 -> begin
(check_application_args env head chead g_head args expected_topt)
end))))
and tc_eqn : FStar_Syntax_Syntax.bv  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.branch  ->  ((FStar_Syntax_Syntax.pat * FStar_Syntax_Syntax.term Prims.option * FStar_Syntax_Syntax.term) * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun scrutinee env branch -> (
# 997 "FStar.TypeChecker.Tc.fst"
let _72_1504 = (FStar_Syntax_Subst.open_branch branch)
in (match (_72_1504) with
| (pattern, when_clause, branch_exp) -> begin
(
# 998 "FStar.TypeChecker.Tc.fst"
let _72_1509 = branch
in (match (_72_1509) with
| (cpat, _72_1507, cbr) -> begin
(
# 1001 "FStar.TypeChecker.Tc.fst"
let tc_pat = (fun allow_implicits pat_t p0 -> (
# 1008 "FStar.TypeChecker.Tc.fst"
let _72_1517 = (FStar_TypeChecker_Util.pat_as_exps allow_implicits env p0)
in (match (_72_1517) with
| (pat_bvs, exps, p) -> begin
(
# 1009 "FStar.TypeChecker.Tc.fst"
let _72_1518 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_656 = (FStar_Syntax_Print.pat_to_string p0)
in (let _151_655 = (FStar_Syntax_Print.pat_to_string p)
in (FStar_Util.print2 "Pattern %s elaborated to %s\n" _151_656 _151_655)))
end else begin
()
end
in (
# 1011 "FStar.TypeChecker.Tc.fst"
let pat_env = (FStar_List.fold_left FStar_TypeChecker_Env.push_bv env pat_bvs)
in (
# 1012 "FStar.TypeChecker.Tc.fst"
let _72_1524 = (FStar_TypeChecker_Env.clear_expected_typ pat_env)
in (match (_72_1524) with
| (env1, _72_1523) -> begin
(
# 1013 "FStar.TypeChecker.Tc.fst"
let env1 = (
# 1013 "FStar.TypeChecker.Tc.fst"
let _72_1525 = env1
in {FStar_TypeChecker_Env.solver = _72_1525.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1525.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1525.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1525.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1525.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1525.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1525.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1525.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = true; FStar_TypeChecker_Env.instantiate_imp = _72_1525.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1525.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1525.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1525.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_1525.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_1525.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_1525.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1525.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1525.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1525.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1525.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1525.FStar_TypeChecker_Env.use_bv_sorts})
in (
# 1014 "FStar.TypeChecker.Tc.fst"
let expected_pat_t = (FStar_TypeChecker_Rel.unrefine env pat_t)
in (
# 1015 "FStar.TypeChecker.Tc.fst"
let _72_1564 = (let _151_679 = (FStar_All.pipe_right exps (FStar_List.map (fun e -> (
# 1016 "FStar.TypeChecker.Tc.fst"
let _72_1530 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_659 = (FStar_Syntax_Print.term_to_string e)
in (let _151_658 = (FStar_Syntax_Print.term_to_string pat_t)
in (FStar_Util.print2 "Checking pattern expression %s against expected type %s\n" _151_659 _151_658)))
end else begin
()
end
in (
# 1019 "FStar.TypeChecker.Tc.fst"
let _72_1535 = (tc_term env1 e)
in (match (_72_1535) with
| (e, lc, g) -> begin
(
# 1021 "FStar.TypeChecker.Tc.fst"
let _72_1536 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_661 = (FStar_TypeChecker_Normalize.term_to_string env e)
in (let _151_660 = (FStar_TypeChecker_Normalize.term_to_string env lc.FStar_Syntax_Syntax.res_typ)
in (FStar_Util.print2 "Pre-checked pattern expression %s at type %s\n" _151_661 _151_660)))
end else begin
()
end
in (
# 1024 "FStar.TypeChecker.Tc.fst"
let g' = (FStar_TypeChecker_Rel.teq env lc.FStar_Syntax_Syntax.res_typ expected_pat_t)
in (
# 1025 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.conj_guard g g')
in (
# 1026 "FStar.TypeChecker.Tc.fst"
let _72_1542 = (let _151_662 = (FStar_TypeChecker_Rel.discharge_guard env (
# 1026 "FStar.TypeChecker.Tc.fst"
let _72_1540 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _72_1540.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_1540.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _72_1540.FStar_TypeChecker_Env.implicits}))
in (FStar_All.pipe_right _151_662 FStar_TypeChecker_Rel.resolve_implicits))
in (
# 1027 "FStar.TypeChecker.Tc.fst"
let e' = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env e)
in (
# 1028 "FStar.TypeChecker.Tc.fst"
let uvars_to_string = (fun uvs -> (let _151_667 = (let _151_666 = (FStar_All.pipe_right uvs FStar_Util.set_elements)
in (FStar_All.pipe_right _151_666 (FStar_List.map (fun _72_1550 -> (match (_72_1550) with
| (u, _72_1549) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end)))))
in (FStar_All.pipe_right _151_667 (FStar_String.concat ", "))))
in (
# 1029 "FStar.TypeChecker.Tc.fst"
let uvs1 = (FStar_Syntax_Free.uvars e')
in (
# 1030 "FStar.TypeChecker.Tc.fst"
let uvs2 = (FStar_Syntax_Free.uvars expected_pat_t)
in (
# 1031 "FStar.TypeChecker.Tc.fst"
let _72_1558 = if (let _151_668 = (FStar_Util.set_is_subset_of uvs1 uvs2)
in (FStar_All.pipe_left Prims.op_Negation _151_668)) then begin
(
# 1032 "FStar.TypeChecker.Tc.fst"
let unresolved = (let _151_669 = (FStar_Util.set_difference uvs1 uvs2)
in (FStar_All.pipe_right _151_669 FStar_Util.set_elements))
in (let _151_677 = (let _151_676 = (let _151_675 = (let _151_674 = (FStar_TypeChecker_Normalize.term_to_string env e')
in (let _151_673 = (FStar_TypeChecker_Normalize.term_to_string env expected_pat_t)
in (let _151_672 = (let _151_671 = (FStar_All.pipe_right unresolved (FStar_List.map (fun _72_1557 -> (match (_72_1557) with
| (u, _72_1556) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end))))
in (FStar_All.pipe_right _151_671 (FStar_String.concat ", ")))
in (FStar_Util.format3 "Implicit pattern variables in %s could not be resolved against expected type %s;Variables {%s} were unresolved; please bind them explicitly" _151_674 _151_673 _151_672))))
in (_151_675, p.FStar_Syntax_Syntax.p))
in FStar_Syntax_Syntax.Error (_151_676))
in (Prims.raise _151_677)))
end else begin
()
end
in (
# 1039 "FStar.TypeChecker.Tc.fst"
let _72_1560 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_678 = (FStar_TypeChecker_Normalize.term_to_string env e)
in (FStar_Util.print1 "Done checking pattern expression %s\n" _151_678))
end else begin
()
end
in (e, e')))))))))))
end))))))
in (FStar_All.pipe_right _151_679 FStar_List.unzip))
in (match (_72_1564) with
| (exps, norm_exps) -> begin
(
# 1044 "FStar.TypeChecker.Tc.fst"
let p = (FStar_TypeChecker_Util.decorate_pattern env p exps)
in (p, pat_bvs, pat_env, exps, norm_exps))
end))))
end))))
end)))
in (
# 1048 "FStar.TypeChecker.Tc.fst"
let pat_t = scrutinee.FStar_Syntax_Syntax.sort
in (
# 1049 "FStar.TypeChecker.Tc.fst"
let scrutinee_tm = (FStar_Syntax_Syntax.bv_to_name scrutinee)
in (
# 1050 "FStar.TypeChecker.Tc.fst"
let _72_1571 = (let _151_680 = (FStar_TypeChecker_Env.push_bv env scrutinee)
in (FStar_All.pipe_right _151_680 FStar_TypeChecker_Env.clear_expected_typ))
in (match (_72_1571) with
| (scrutinee_env, _72_1570) -> begin
(
# 1053 "FStar.TypeChecker.Tc.fst"
let _72_1577 = (tc_pat true pat_t pattern)
in (match (_72_1577) with
| (pattern, pat_bvs, pat_env, disj_exps, norm_disj_exps) -> begin
(
# 1056 "FStar.TypeChecker.Tc.fst"
let _72_1587 = (match (when_clause) with
| None -> begin
(None, FStar_TypeChecker_Rel.trivial_guard)
end
| Some (e) -> begin
if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
(Prims.raise (FStar_Syntax_Syntax.Error (("When clauses are not yet supported in --verify mode; they will be some day", e.FStar_Syntax_Syntax.pos))))
end else begin
(
# 1063 "FStar.TypeChecker.Tc.fst"
let _72_1584 = (let _151_681 = (FStar_TypeChecker_Env.set_expected_typ pat_env FStar_TypeChecker_Recheck.t_bool)
in (tc_term _151_681 e))
in (match (_72_1584) with
| (e, c, g) -> begin
(Some (e), g)
end))
end
end)
in (match (_72_1587) with
| (when_clause, g_when) -> begin
(
# 1067 "FStar.TypeChecker.Tc.fst"
let _72_1591 = (tc_term pat_env branch_exp)
in (match (_72_1591) with
| (branch_exp, c, g_branch) -> begin
(
# 1071 "FStar.TypeChecker.Tc.fst"
let when_condition = (match (when_clause) with
| None -> begin
None
end
| Some (w) -> begin
(let _151_683 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Util.t_bool FStar_Syntax_Util.t_bool w FStar_Syntax_Const.exp_true_bool)
in (FStar_All.pipe_left (fun _151_682 -> Some (_151_682)) _151_683))
end)
in (
# 1078 "FStar.TypeChecker.Tc.fst"
let _72_1645 = (
# 1081 "FStar.TypeChecker.Tc.fst"
let eqs = (FStar_All.pipe_right disj_exps (FStar_List.fold_left (fun fopt e -> (
# 1082 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Subst.compress e)
in (match (e.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
fopt
end
| _72_1609 -> begin
(
# 1088 "FStar.TypeChecker.Tc.fst"
let clause = (FStar_Syntax_Util.mk_eq pat_t pat_t scrutinee_tm e)
in (match (fopt) with
| None -> begin
Some (clause)
end
| Some (f) -> begin
(let _151_687 = (FStar_Syntax_Util.mk_disj clause f)
in (FStar_All.pipe_left (fun _151_686 -> Some (_151_686)) _151_687))
end))
end))) None))
in (
# 1093 "FStar.TypeChecker.Tc.fst"
let _72_1640 = (match ((eqs, when_condition)) with
| (None, None) -> begin
(c, g_when, g_branch)
end
| (Some (f), None) -> begin
(
# 1099 "FStar.TypeChecker.Tc.fst"
let gf = FStar_TypeChecker_Common.NonTrivial (f)
in (
# 1100 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.guard_of_guard_formula gf)
in (let _151_690 = (FStar_TypeChecker_Util.weaken_precondition env c gf)
in (let _151_689 = (FStar_TypeChecker_Rel.imp_guard g g_when)
in (let _151_688 = (FStar_TypeChecker_Rel.imp_guard g g_branch)
in (_151_690, _151_689, _151_688))))))
end
| (Some (f), Some (w)) -> begin
(
# 1106 "FStar.TypeChecker.Tc.fst"
let g_f = FStar_TypeChecker_Common.NonTrivial (f)
in (
# 1107 "FStar.TypeChecker.Tc.fst"
let g_fw = (let _151_691 = (FStar_Syntax_Util.mk_conj f w)
in FStar_TypeChecker_Common.NonTrivial (_151_691))
in (let _151_696 = (FStar_TypeChecker_Util.weaken_precondition env c g_fw)
in (let _151_695 = (let _151_692 = (FStar_TypeChecker_Rel.guard_of_guard_formula g_f)
in (FStar_TypeChecker_Rel.imp_guard _151_692 g_when))
in (let _151_694 = (let _151_693 = (FStar_TypeChecker_Rel.guard_of_guard_formula g_fw)
in (FStar_TypeChecker_Rel.imp_guard _151_693 g_branch))
in (_151_696, _151_695, _151_694))))))
end
| (None, Some (w)) -> begin
(
# 1113 "FStar.TypeChecker.Tc.fst"
let g_w = FStar_TypeChecker_Common.NonTrivial (w)
in (
# 1114 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.guard_of_guard_formula g_w)
in (let _151_698 = (FStar_TypeChecker_Util.weaken_precondition env c g_w)
in (let _151_697 = (FStar_TypeChecker_Rel.imp_guard g g_branch)
in (_151_698, g_when, _151_697)))))
end)
in (match (_72_1640) with
| (c_weak, g_when_weak, g_branch_weak) -> begin
(
# 1120 "FStar.TypeChecker.Tc.fst"
let binders = (FStar_List.map FStar_Syntax_Syntax.mk_binder pat_bvs)
in (let _151_701 = (FStar_TypeChecker_Util.close_comp env pat_bvs c_weak)
in (let _151_700 = (FStar_TypeChecker_Rel.close_guard binders g_when_weak)
in (let _151_699 = (FStar_TypeChecker_Rel.close_guard binders g_branch_weak)
in (_151_701, _151_700, _151_699)))))
end)))
in (match (_72_1645) with
| (c, g_when, g_branch) -> begin
(
# 1138 "FStar.TypeChecker.Tc.fst"
let branch_guard = (
# 1140 "FStar.TypeChecker.Tc.fst"
let rec build_branch_guard = (fun scrutinee_tm pat_exp -> (
# 1141 "FStar.TypeChecker.Tc.fst"
let discriminate = (fun scrutinee_tm f -> if ((let _151_711 = (let _151_710 = (FStar_TypeChecker_Env.typ_of_datacon env f.FStar_Syntax_Syntax.v)
in (FStar_TypeChecker_Env.datacons_of_typ env _151_710))
in (FStar_List.length _151_711)) > 1) then begin
(
# 1144 "FStar.TypeChecker.Tc.fst"
let disc = (let _151_712 = (FStar_Syntax_Util.mk_discriminator f.FStar_Syntax_Syntax.v)
in (FStar_Syntax_Syntax.fvar None _151_712 (FStar_Ident.range_of_lid f.FStar_Syntax_Syntax.v)))
in (
# 1145 "FStar.TypeChecker.Tc.fst"
let disc = (let _151_714 = (let _151_713 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (_151_713)::[])
in (FStar_Syntax_Syntax.mk_Tm_app disc _151_714 None scrutinee_tm.FStar_Syntax_Syntax.pos))
in (let _151_715 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Util.t_bool FStar_Syntax_Util.t_bool disc FStar_Syntax_Const.exp_true_bool)
in (_151_715)::[])))
end else begin
[]
end)
in (
# 1149 "FStar.TypeChecker.Tc.fst"
let fail = (fun _72_1655 -> (match (()) with
| () -> begin
(let _151_721 = (let _151_720 = (FStar_Range.string_of_range pat_exp.FStar_Syntax_Syntax.pos)
in (let _151_719 = (FStar_Syntax_Print.term_to_string pat_exp)
in (let _151_718 = (FStar_Syntax_Print.tag_of_term pat_exp)
in (FStar_Util.format3 "tc_eqn: Impossible (%s) %s (%s)" _151_720 _151_719 _151_718))))
in (FStar_All.failwith _151_721))
end))
in (
# 1155 "FStar.TypeChecker.Tc.fst"
let rec head_constructor = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (f, _72_1660) -> begin
f
end
| FStar_Syntax_Syntax.Tm_uinst (t, _72_1665) -> begin
(head_constructor t)
end
| _72_1669 -> begin
(fail ())
end))
in (
# 1160 "FStar.TypeChecker.Tc.fst"
let pat_exp = (let _151_724 = (FStar_Syntax_Subst.compress pat_exp)
in (FStar_All.pipe_right _151_724 FStar_Syntax_Util.unmeta))
in (match (pat_exp.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit)) -> begin
[]
end
| FStar_Syntax_Syntax.Tm_constant (_72_1694) -> begin
(let _151_729 = (let _151_728 = (let _151_727 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (let _151_726 = (let _151_725 = (FStar_Syntax_Syntax.as_arg pat_exp)
in (_151_725)::[])
in (_151_727)::_151_726))
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.teq _151_728 None scrutinee_tm.FStar_Syntax_Syntax.pos))
in (_151_729)::[])
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
(
# 1169 "FStar.TypeChecker.Tc.fst"
let f = (head_constructor pat_exp)
in if (not ((FStar_TypeChecker_Env.is_datacon env f.FStar_Syntax_Syntax.v))) then begin
[]
end else begin
(let _151_730 = (head_constructor pat_exp)
in (discriminate scrutinee_tm _151_730))
end)
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(
# 1174 "FStar.TypeChecker.Tc.fst"
let f = (head_constructor head)
in if (not ((FStar_TypeChecker_Env.is_datacon env f.FStar_Syntax_Syntax.v))) then begin
[]
end else begin
(
# 1177 "FStar.TypeChecker.Tc.fst"
let sub_term_guards = (let _151_736 = (FStar_All.pipe_right args (FStar_List.mapi (fun i _72_1712 -> (match (_72_1712) with
| (ei, _72_1711) -> begin
(
# 1178 "FStar.TypeChecker.Tc.fst"
let projector = (FStar_TypeChecker_Env.lookup_projector env f.FStar_Syntax_Syntax.v i)
in (
# 1179 "FStar.TypeChecker.Tc.fst"
let sub_term = (let _151_735 = (FStar_Syntax_Syntax.fvar None projector f.FStar_Syntax_Syntax.p)
in (let _151_734 = (let _151_733 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (_151_733)::[])
in (FStar_Syntax_Syntax.mk_Tm_app _151_735 _151_734 None f.FStar_Syntax_Syntax.p)))
in (build_branch_guard sub_term ei)))
end))))
in (FStar_All.pipe_right _151_736 FStar_List.flatten))
in (let _151_737 = (discriminate scrutinee_tm f)
in (FStar_List.append _151_737 sub_term_guards)))
end)
end
| _72_1717 -> begin
[]
end))))))
in (
# 1185 "FStar.TypeChecker.Tc.fst"
let build_and_check_branch_guard = (fun scrutinee_tm pat -> if (not ((FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str))) then begin
(FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.true_lid scrutinee_tm.FStar_Syntax_Syntax.pos)
end else begin
(
# 1188 "FStar.TypeChecker.Tc.fst"
let t = (let _151_742 = (build_branch_guard scrutinee_tm pat)
in (FStar_All.pipe_left FStar_Syntax_Util.mk_conj_l _151_742))
in (
# 1189 "FStar.TypeChecker.Tc.fst"
let _72_1725 = (FStar_Syntax_Util.type_u ())
in (match (_72_1725) with
| (k, _72_1724) -> begin
(
# 1190 "FStar.TypeChecker.Tc.fst"
let _72_1731 = (tc_check_tot_or_gtot_term scrutinee_env t k)
in (match (_72_1731) with
| (t, _72_1728, _72_1730) -> begin
t
end))
end)))
end)
in (
# 1194 "FStar.TypeChecker.Tc.fst"
let branch_guard = (let _151_743 = (FStar_All.pipe_right norm_disj_exps (FStar_List.map (build_and_check_branch_guard scrutinee_tm)))
in (FStar_All.pipe_right _151_743 FStar_Syntax_Util.mk_disj_l))
in (
# 1197 "FStar.TypeChecker.Tc.fst"
let branch_guard = (match (when_condition) with
| None -> begin
branch_guard
end
| Some (w) -> begin
(FStar_Syntax_Util.mk_conj branch_guard w)
end)
in branch_guard))))
in (
# 1203 "FStar.TypeChecker.Tc.fst"
let guard = (FStar_TypeChecker_Rel.conj_guard g_when g_branch)
in (
# 1205 "FStar.TypeChecker.Tc.fst"
let _72_1739 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_744 = (FStar_TypeChecker_Rel.guard_to_string env guard)
in (FStar_All.pipe_left (FStar_Util.print1 "Carrying guard from match: %s\n") _151_744))
end else begin
()
end
in (let _151_745 = (FStar_Syntax_Subst.close_branch (pattern, when_clause, branch_exp))
in (_151_745, branch_guard, c, guard)))))
end)))
end))
end))
end))
end)))))
end))
end)))
and check_top_level_let : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 1219 "FStar.TypeChecker.Tc.fst"
let env = (instantiate_both env)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((false, lb::[]), e2) -> begin
(
# 1222 "FStar.TypeChecker.Tc.fst"
let _72_1756 = (check_let_bound_def true env lb)
in (match (_72_1756) with
| (e1, univ_vars, c1, g1, annotated) -> begin
(
# 1225 "FStar.TypeChecker.Tc.fst"
let _72_1768 = if (annotated && (not (env.FStar_TypeChecker_Env.generalize))) then begin
(g1, e1, univ_vars, c1)
end else begin
(
# 1228 "FStar.TypeChecker.Tc.fst"
let g1 = (let _151_748 = (FStar_TypeChecker_Rel.solve_deferred_constraints env g1)
in (FStar_All.pipe_right _151_748 FStar_TypeChecker_Rel.resolve_implicits))
in (
# 1229 "FStar.TypeChecker.Tc.fst"
let _72_1763 = (let _151_752 = (let _151_751 = (let _151_750 = (let _151_749 = (c1.FStar_Syntax_Syntax.comp ())
in (lb.FStar_Syntax_Syntax.lbname, e1, _151_749))
in (_151_750)::[])
in (FStar_TypeChecker_Util.generalize env _151_751))
in (FStar_List.hd _151_752))
in (match (_72_1763) with
| (_72_1759, univs, e1, c1) -> begin
(g1, e1, univs, (FStar_Syntax_Util.lcomp_of_comp c1))
end)))
end
in (match (_72_1768) with
| (g1, e1, univ_vars, c1) -> begin
(
# 1233 "FStar.TypeChecker.Tc.fst"
let _72_1778 = if (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str) then begin
(
# 1235 "FStar.TypeChecker.Tc.fst"
let _72_1771 = (FStar_TypeChecker_Util.check_top_level env g1 c1)
in (match (_72_1771) with
| (ok, c1) -> begin
if ok then begin
(e2, c1)
end else begin
(
# 1238 "FStar.TypeChecker.Tc.fst"
let _72_1772 = if (FStar_ST.read FStar_Options.warn_top_level_effects) then begin
(let _151_753 = (FStar_TypeChecker_Env.get_range env)
in (FStar_TypeChecker_Errors.warn _151_753 FStar_TypeChecker_Errors.top_level_effect))
end else begin
()
end
in (let _151_754 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((e2, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Masked_effect)))) None e2.FStar_Syntax_Syntax.pos)
in (_151_754, c1)))
end
end))
end else begin
(
# 1242 "FStar.TypeChecker.Tc.fst"
let _72_1774 = (FStar_TypeChecker_Rel.force_trivial_guard env g1)
in (let _151_755 = (c1.FStar_Syntax_Syntax.comp ())
in (e2, _151_755)))
end
in (match (_72_1778) with
| (e2, c1) -> begin
(
# 1247 "FStar.TypeChecker.Tc.fst"
let cres = (let _151_756 = (FStar_Syntax_Util.ml_comp FStar_TypeChecker_Recheck.t_unit e.FStar_Syntax_Syntax.pos)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _151_756))
in (
# 1248 "FStar.TypeChecker.Tc.fst"
let _72_1780 = (FStar_ST.op_Colon_Equals e2.FStar_Syntax_Syntax.tk (Some (FStar_TypeChecker_Recheck.t_unit.FStar_Syntax_Syntax.n)))
in (
# 1250 "FStar.TypeChecker.Tc.fst"
let lb = (FStar_Syntax_Util.close_univs_and_mk_letbinding None lb.FStar_Syntax_Syntax.lbname univ_vars (FStar_Syntax_Util.comp_result c1) (FStar_Syntax_Util.comp_effect_name c1) e1)
in (let _151_757 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((false, (lb)::[]), e2))) (Some (FStar_TypeChecker_Recheck.t_unit.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (_151_757, cres, FStar_TypeChecker_Rel.trivial_guard)))))
end))
end))
end))
end
| _72_1784 -> begin
(FStar_All.failwith "Impossible")
end)))
and check_inner_let : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 1267 "FStar.TypeChecker.Tc.fst"
let env = (instantiate_both env)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((false, lb::[]), e2) -> begin
(
# 1270 "FStar.TypeChecker.Tc.fst"
let env = (
# 1270 "FStar.TypeChecker.Tc.fst"
let _72_1795 = env
in {FStar_TypeChecker_Env.solver = _72_1795.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1795.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1795.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1795.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1795.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1795.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1795.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1795.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1795.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1795.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1795.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1795.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1795.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = _72_1795.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_1795.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1795.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1795.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1795.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1795.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1795.FStar_TypeChecker_Env.use_bv_sorts})
in (
# 1271 "FStar.TypeChecker.Tc.fst"
let _72_1804 = (let _151_761 = (let _151_760 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _151_760 Prims.fst))
in (check_let_bound_def false _151_761 lb))
in (match (_72_1804) with
| (e1, _72_1800, c1, g1, annotated) -> begin
(
# 1272 "FStar.TypeChecker.Tc.fst"
let lb = (FStar_Syntax_Util.mk_letbinding lb.FStar_Syntax_Syntax.lbname [] c1.FStar_Syntax_Syntax.res_typ c1.FStar_Syntax_Syntax.eff_name e1)
in (
# 1273 "FStar.TypeChecker.Tc.fst"
let x = (
# 1273 "FStar.TypeChecker.Tc.fst"
let _72_1806 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in {FStar_Syntax_Syntax.ppname = _72_1806.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_1806.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = c1.FStar_Syntax_Syntax.res_typ})
in (
# 1274 "FStar.TypeChecker.Tc.fst"
let _72_1811 = (let _151_763 = (let _151_762 = (FStar_Syntax_Syntax.mk_binder x)
in (_151_762)::[])
in (FStar_Syntax_Subst.open_term _151_763 e2))
in (match (_72_1811) with
| (xb, e2) -> begin
(
# 1275 "FStar.TypeChecker.Tc.fst"
let xbinder = (FStar_List.hd xb)
in (
# 1276 "FStar.TypeChecker.Tc.fst"
let x = (Prims.fst xbinder)
in (
# 1277 "FStar.TypeChecker.Tc.fst"
let _72_1817 = (let _151_764 = (FStar_TypeChecker_Env.push_bv env x)
in (tc_term _151_764 e2))
in (match (_72_1817) with
| (e2, c2, g2) -> begin
(
# 1278 "FStar.TypeChecker.Tc.fst"
let cres = (FStar_TypeChecker_Util.bind env (Some (e1)) c1 (Some (x), c2))
in (
# 1279 "FStar.TypeChecker.Tc.fst"
let e = (let _151_767 = (let _151_766 = (let _151_765 = (FStar_Syntax_Subst.close xb e2)
in ((false, (lb)::[]), _151_765))
in FStar_Syntax_Syntax.Tm_let (_151_766))
in (FStar_Syntax_Syntax.mk _151_767 (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos))
in (
# 1280 "FStar.TypeChecker.Tc.fst"
let x_eq_e1 = (let _151_770 = (let _151_769 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Util.mk_eq c1.FStar_Syntax_Syntax.res_typ c1.FStar_Syntax_Syntax.res_typ _151_769 e1))
in (FStar_All.pipe_left (fun _151_768 -> FStar_TypeChecker_Common.NonTrivial (_151_768)) _151_770))
in (
# 1281 "FStar.TypeChecker.Tc.fst"
let g2 = (let _151_772 = (let _151_771 = (FStar_TypeChecker_Rel.guard_of_guard_formula x_eq_e1)
in (FStar_TypeChecker_Rel.imp_guard _151_771 g2))
in (FStar_TypeChecker_Rel.close_guard xb _151_772))
in (
# 1283 "FStar.TypeChecker.Tc.fst"
let guard = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in if annotated then begin
(e, cres, guard)
end else begin
(
# 1287 "FStar.TypeChecker.Tc.fst"
let _72_1823 = (check_no_escape env ((x)::[]) cres.FStar_Syntax_Syntax.res_typ)
in (e, cres, guard))
end)))))
end))))
end))))
end)))
end
| _72_1826 -> begin
(FStar_All.failwith "Impossible")
end)))
and check_top_level_let_rec : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top -> (
# 1296 "FStar.TypeChecker.Tc.fst"
let env = (instantiate_both env)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((true, lbs), e2) -> begin
(
# 1299 "FStar.TypeChecker.Tc.fst"
let _72_1838 = (FStar_Syntax_Subst.open_let_rec lbs e2)
in (match (_72_1838) with
| (lbs, e2) -> begin
(
# 1301 "FStar.TypeChecker.Tc.fst"
let _72_1841 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_1841) with
| (env0, topt) -> begin
(
# 1302 "FStar.TypeChecker.Tc.fst"
let _72_1844 = (build_let_rec_env true env0 lbs)
in (match (_72_1844) with
| (lbs, rec_env) -> begin
(
# 1303 "FStar.TypeChecker.Tc.fst"
let _72_1847 = (check_let_recs rec_env lbs)
in (match (_72_1847) with
| (lbs, g_lbs) -> begin
(
# 1304 "FStar.TypeChecker.Tc.fst"
let g_lbs = (let _151_775 = (FStar_TypeChecker_Rel.solve_deferred_constraints env g_lbs)
in (FStar_All.pipe_right _151_775 FStar_TypeChecker_Rel.resolve_implicits))
in (
# 1306 "FStar.TypeChecker.Tc.fst"
let all_lb_names = (let _151_778 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (FStar_Util.right lb.FStar_Syntax_Syntax.lbname))))
in (FStar_All.pipe_right _151_778 (fun _151_777 -> Some (_151_777))))
in (
# 1308 "FStar.TypeChecker.Tc.fst"
let lbs = if (not (env.FStar_TypeChecker_Env.generalize)) then begin
(FStar_All.pipe_right lbs (FStar_List.map (fun lb -> if (lb.FStar_Syntax_Syntax.lbunivs = []) then begin
lb
end else begin
(FStar_Syntax_Util.close_univs_and_mk_letbinding all_lb_names lb.FStar_Syntax_Syntax.lbname lb.FStar_Syntax_Syntax.lbunivs lb.FStar_Syntax_Syntax.lbtyp lb.FStar_Syntax_Syntax.lbeff lb.FStar_Syntax_Syntax.lbdef)
end)))
end else begin
(
# 1314 "FStar.TypeChecker.Tc.fst"
let ecs = (let _151_782 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (let _151_781 = (FStar_Syntax_Syntax.mk_Total lb.FStar_Syntax_Syntax.lbtyp)
in (lb.FStar_Syntax_Syntax.lbname, lb.FStar_Syntax_Syntax.lbdef, _151_781)))))
in (FStar_TypeChecker_Util.generalize env _151_782))
in (FStar_All.pipe_right ecs (FStar_List.map (fun _72_1858 -> (match (_72_1858) with
| (x, uvs, e, c) -> begin
(FStar_Syntax_Util.close_univs_and_mk_letbinding all_lb_names x uvs (FStar_Syntax_Util.comp_result c) (FStar_Syntax_Util.comp_effect_name c) e)
end)))))
end
in (
# 1321 "FStar.TypeChecker.Tc.fst"
let cres = (let _151_784 = (FStar_Syntax_Syntax.mk_Total FStar_TypeChecker_Recheck.t_unit)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _151_784))
in (
# 1322 "FStar.TypeChecker.Tc.fst"
let _72_1861 = (FStar_ST.op_Colon_Equals e2.FStar_Syntax_Syntax.tk (Some (FStar_TypeChecker_Recheck.t_unit.FStar_Syntax_Syntax.n)))
in (
# 1324 "FStar.TypeChecker.Tc.fst"
let _72_1865 = (FStar_Syntax_Subst.close_let_rec lbs e2)
in (match (_72_1865) with
| (lbs, e2) -> begin
(let _151_786 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((true, lbs), e2))) (Some (FStar_TypeChecker_Recheck.t_unit.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _151_785 = (FStar_TypeChecker_Rel.discharge_guard env g_lbs)
in (_151_786, cres, _151_785)))
end)))))))
end))
end))
end))
end))
end
| _72_1867 -> begin
(FStar_All.failwith "Impossible")
end)))
and check_inner_let_rec : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top -> (
# 1335 "FStar.TypeChecker.Tc.fst"
let env = (instantiate_both env)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((true, lbs), e2) -> begin
(
# 1338 "FStar.TypeChecker.Tc.fst"
let _72_1879 = (FStar_Syntax_Subst.open_let_rec lbs e2)
in (match (_72_1879) with
| (lbs, e2) -> begin
(
# 1340 "FStar.TypeChecker.Tc.fst"
let _72_1882 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_1882) with
| (env0, topt) -> begin
(
# 1341 "FStar.TypeChecker.Tc.fst"
let _72_1885 = (build_let_rec_env false env0 lbs)
in (match (_72_1885) with
| (lbs, rec_env) -> begin
(
# 1342 "FStar.TypeChecker.Tc.fst"
let _72_1888 = (check_let_recs rec_env lbs)
in (match (_72_1888) with
| (lbs, g_lbs) -> begin
(
# 1344 "FStar.TypeChecker.Tc.fst"
let _72_1906 = (FStar_All.pipe_right lbs (FStar_List.fold_left (fun _72_1891 _72_1900 -> (match ((_72_1891, _72_1900)) with
| ((bvs, env), {FStar_Syntax_Syntax.lbname = x; FStar_Syntax_Syntax.lbunivs = _72_1898; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = _72_1895; FStar_Syntax_Syntax.lbdef = _72_1893}) -> begin
(
# 1345 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_let_binding env x ([], t))
in (let _151_792 = (let _151_791 = (
# 1346 "FStar.TypeChecker.Tc.fst"
let _72_1902 = (FStar_Util.left x)
in {FStar_Syntax_Syntax.ppname = _72_1902.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_1902.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})
in (_151_791)::bvs)
in (_151_792, env)))
end)) ([], env)))
in (match (_72_1906) with
| (bvs, env) -> begin
(
# 1347 "FStar.TypeChecker.Tc.fst"
let bvs = (FStar_List.rev bvs)
in (
# 1349 "FStar.TypeChecker.Tc.fst"
let _72_1911 = (tc_term env e2)
in (match (_72_1911) with
| (e2, cres, g2) -> begin
(
# 1350 "FStar.TypeChecker.Tc.fst"
let guard = (FStar_TypeChecker_Rel.conj_guard g_lbs g2)
in (
# 1351 "FStar.TypeChecker.Tc.fst"
let cres = (FStar_TypeChecker_Util.close_comp env bvs cres)
in (
# 1352 "FStar.TypeChecker.Tc.fst"
let tres = (norm env cres.FStar_Syntax_Syntax.res_typ)
in (
# 1353 "FStar.TypeChecker.Tc.fst"
let cres = (
# 1353 "FStar.TypeChecker.Tc.fst"
let _72_1915 = cres
in {FStar_Syntax_Syntax.eff_name = _72_1915.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = tres; FStar_Syntax_Syntax.cflags = _72_1915.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = _72_1915.FStar_Syntax_Syntax.comp})
in (
# 1355 "FStar.TypeChecker.Tc.fst"
let _72_1920 = (FStar_Syntax_Subst.close_let_rec lbs e2)
in (match (_72_1920) with
| (lbs, e2) -> begin
(
# 1356 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((true, lbs), e2))) (Some (tres.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (match (topt) with
| Some (_72_1923) -> begin
(e, cres, guard)
end
| None -> begin
(
# 1360 "FStar.TypeChecker.Tc.fst"
let _72_1926 = (check_no_escape env bvs tres)
in (e, cres, guard))
end))
end))))))
end)))
end))
end))
end))
end))
end))
end
| _72_1929 -> begin
(FStar_All.failwith "Impossible")
end)))
and build_let_rec_env : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding Prims.list  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_TypeChecker_Env.env_t) = (fun top_level env lbs -> (
# 1371 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 1372 "FStar.TypeChecker.Tc.fst"
let _72_1962 = (FStar_List.fold_left (fun _72_1936 lb -> (match (_72_1936) with
| (lbs, env) -> begin
(
# 1373 "FStar.TypeChecker.Tc.fst"
let _72_1941 = (FStar_TypeChecker_Util.extract_let_rec_annotation env lb)
in (match (_72_1941) with
| (univ_vars, t, check_t) -> begin
(
# 1374 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_univ_vars env univ_vars)
in (
# 1375 "FStar.TypeChecker.Tc.fst"
let e = (FStar_Syntax_Util.unascribe lb.FStar_Syntax_Syntax.lbdef)
in (
# 1376 "FStar.TypeChecker.Tc.fst"
let t = if (not (check_t)) then begin
t
end else begin
if (top_level && (not (env.FStar_TypeChecker_Env.generalize))) then begin
t
end else begin
(
# 1381 "FStar.TypeChecker.Tc.fst"
let _72_1950 = (let _151_799 = (let _151_798 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_left Prims.fst _151_798))
in (tc_check_tot_or_gtot_term (
# 1381 "FStar.TypeChecker.Tc.fst"
let _72_1944 = env0
in {FStar_TypeChecker_Env.solver = _72_1944.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1944.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1944.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1944.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1944.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1944.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1944.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1944.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1944.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1944.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1944.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1944.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1944.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_1944.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = true; FStar_TypeChecker_Env.use_eq = _72_1944.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1944.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1944.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1944.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1944.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1944.FStar_TypeChecker_Env.use_bv_sorts}) t _151_799))
in (match (_72_1950) with
| (t, _72_1948, g) -> begin
(
# 1382 "FStar.TypeChecker.Tc.fst"
let _72_1951 = (FStar_TypeChecker_Rel.force_trivial_guard env0 g)
in (norm env0 t))
end))
end
end
in (
# 1384 "FStar.TypeChecker.Tc.fst"
let env = if ((FStar_Syntax_Util.is_pure_or_ghost_function t) && (FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str)) then begin
(
# 1386 "FStar.TypeChecker.Tc.fst"
let _72_1954 = env
in {FStar_TypeChecker_Env.solver = _72_1954.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1954.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1954.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1954.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1954.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1954.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1954.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1954.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1954.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1954.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1954.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1954.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = ((lb.FStar_Syntax_Syntax.lbname, t))::env.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_1954.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_1954.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_1954.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1954.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1954.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1954.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1954.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1954.FStar_TypeChecker_Env.use_bv_sorts})
end else begin
(FStar_TypeChecker_Env.push_let_binding env lb.FStar_Syntax_Syntax.lbname ([], t))
end
in (
# 1388 "FStar.TypeChecker.Tc.fst"
let lb = (
# 1388 "FStar.TypeChecker.Tc.fst"
let _72_1957 = lb
in {FStar_Syntax_Syntax.lbname = _72_1957.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = univ_vars; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = _72_1957.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = e})
in ((lb)::lbs, env))))))
end))
end)) ([], env) lbs)
in (match (_72_1962) with
| (lbs, env) -> begin
((FStar_List.rev lbs), env)
end))))
and check_let_recs : FStar_TypeChecker_Env.env_t  ->  FStar_Syntax_Syntax.letbinding Prims.list  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_TypeChecker_Env.guard_t) = (fun env lbs -> (
# 1395 "FStar.TypeChecker.Tc.fst"
let _72_1975 = (let _151_804 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (
# 1396 "FStar.TypeChecker.Tc.fst"
let _72_1969 = (let _151_803 = (FStar_TypeChecker_Env.set_expected_typ env lb.FStar_Syntax_Syntax.lbtyp)
in (tc_tot_or_gtot_term _151_803 lb.FStar_Syntax_Syntax.lbdef))
in (match (_72_1969) with
| (e, c, g) -> begin
(
# 1397 "FStar.TypeChecker.Tc.fst"
let _72_1970 = if (not ((FStar_Syntax_Util.is_total_lcomp c))) then begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Expected let rec to be a Tot term; got effect GTot", e.FStar_Syntax_Syntax.pos))))
end else begin
()
end
in (
# 1399 "FStar.TypeChecker.Tc.fst"
let lb = (FStar_Syntax_Util.mk_letbinding lb.FStar_Syntax_Syntax.lbname lb.FStar_Syntax_Syntax.lbunivs lb.FStar_Syntax_Syntax.lbtyp FStar_Syntax_Const.effect_Tot_lid e)
in (lb, g)))
end)))))
in (FStar_All.pipe_right _151_804 FStar_List.unzip))
in (match (_72_1975) with
| (lbs, gs) -> begin
(
# 1401 "FStar.TypeChecker.Tc.fst"
let g_lbs = (FStar_List.fold_right FStar_TypeChecker_Rel.conj_guard gs FStar_TypeChecker_Rel.trivial_guard)
in (lbs, g_lbs))
end)))
and check_let_bound_def : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t * Prims.bool) = (fun top_level env lb -> (
# 1415 "FStar.TypeChecker.Tc.fst"
let _72_1983 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (_72_1983) with
| (env1, _72_1982) -> begin
(
# 1416 "FStar.TypeChecker.Tc.fst"
let e1 = lb.FStar_Syntax_Syntax.lbdef
in (
# 1419 "FStar.TypeChecker.Tc.fst"
let _72_1989 = (check_lbtyp top_level env lb)
in (match (_72_1989) with
| (topt, wf_annot, univ_vars, env1) -> begin
(
# 1421 "FStar.TypeChecker.Tc.fst"
let _72_1990 = if ((not (top_level)) && (univ_vars <> [])) then begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Inner let-bound definitions cannot be universe polymorphic", e1.FStar_Syntax_Syntax.pos))))
end else begin
()
end
in (
# 1425 "FStar.TypeChecker.Tc.fst"
let _72_1997 = (tc_maybe_toplevel_term (
# 1425 "FStar.TypeChecker.Tc.fst"
let _72_1992 = env1
in {FStar_TypeChecker_Env.solver = _72_1992.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_1992.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_1992.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_1992.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_1992.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_1992.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_1992.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_1992.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_1992.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_1992.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_1992.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_1992.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_1992.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = top_level; FStar_TypeChecker_Env.check_uvars = _72_1992.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_1992.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_1992.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_1992.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_1992.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_1992.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_1992.FStar_TypeChecker_Env.use_bv_sorts}) e1)
in (match (_72_1997) with
| (e1, c1, g1) -> begin
(
# 1428 "FStar.TypeChecker.Tc.fst"
let _72_2001 = (let _151_811 = (FStar_TypeChecker_Env.set_range env1 e1.FStar_Syntax_Syntax.pos)
in (FStar_TypeChecker_Util.strengthen_precondition (Some ((fun _72_1998 -> (match (()) with
| () -> begin
FStar_TypeChecker_Errors.ill_kinded_type
end)))) _151_811 e1 c1 wf_annot))
in (match (_72_2001) with
| (c1, guard_f) -> begin
(
# 1431 "FStar.TypeChecker.Tc.fst"
let g1 = (FStar_TypeChecker_Rel.conj_guard g1 guard_f)
in (
# 1433 "FStar.TypeChecker.Tc.fst"
let _72_2003 = if (FStar_TypeChecker_Env.debug env FStar_Options.Extreme) then begin
(let _151_812 = (FStar_TypeChecker_Rel.guard_to_string env g1)
in (FStar_Util.print1 "checked top-level def, guard is %s\n" _151_812))
end else begin
()
end
in (let _151_813 = (FStar_Option.isSome topt)
in (e1, univ_vars, c1, g1, _151_813))))
end))
end)))
end)))
end)))
and check_lbtyp : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding  ->  (FStar_Syntax_Syntax.typ Prims.option * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.univ_names * FStar_TypeChecker_Env.env) = (fun top_level env lb -> (
# 1445 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Subst.compress lb.FStar_Syntax_Syntax.lbtyp)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
(
# 1448 "FStar.TypeChecker.Tc.fst"
let _72_2010 = if (lb.FStar_Syntax_Syntax.lbunivs <> []) then begin
(FStar_All.failwith "Impossible: non-empty universe variables but the type is unknown")
end else begin
()
end
in (None, FStar_TypeChecker_Rel.trivial_guard, [], env))
end
| _72_2013 -> begin
(
# 1452 "FStar.TypeChecker.Tc.fst"
let _72_2016 = (FStar_Syntax_Subst.open_univ_vars lb.FStar_Syntax_Syntax.lbunivs t)
in (match (_72_2016) with
| (univ_vars, t) -> begin
(
# 1453 "FStar.TypeChecker.Tc.fst"
let env1 = (FStar_TypeChecker_Env.push_univ_vars env univ_vars)
in if (top_level && (not (env.FStar_TypeChecker_Env.generalize))) then begin
(let _151_817 = (FStar_TypeChecker_Env.set_expected_typ env1 t)
in (Some (t), FStar_TypeChecker_Rel.trivial_guard, univ_vars, _151_817))
end else begin
(
# 1460 "FStar.TypeChecker.Tc.fst"
let _72_2021 = (FStar_Syntax_Util.type_u ())
in (match (_72_2021) with
| (k, _72_2020) -> begin
(
# 1461 "FStar.TypeChecker.Tc.fst"
let _72_2026 = (tc_check_tot_or_gtot_term env1 t k)
in (match (_72_2026) with
| (t, _72_2024, g) -> begin
(
# 1462 "FStar.TypeChecker.Tc.fst"
let _72_2027 = if (FStar_TypeChecker_Env.debug env FStar_Options.Medium) then begin
(let _151_820 = (let _151_818 = (FStar_Syntax_Syntax.range_of_lbname lb.FStar_Syntax_Syntax.lbname)
in (FStar_Range.string_of_range _151_818))
in (let _151_819 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "(%s) Checked type annotation %s\n" _151_820 _151_819)))
end else begin
()
end
in (
# 1466 "FStar.TypeChecker.Tc.fst"
let t = (norm env1 t)
in (let _151_821 = (FStar_TypeChecker_Env.set_expected_typ env1 t)
in (Some (t), g, univ_vars, _151_821))))
end))
end))
end)
end))
end)))
and tc_binder : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option)  ->  ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) * FStar_TypeChecker_Env.env * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.universe) = (fun env _72_2033 -> (match (_72_2033) with
| (x, imp) -> begin
(
# 1471 "FStar.TypeChecker.Tc.fst"
let _72_2036 = (FStar_Syntax_Util.type_u ())
in (match (_72_2036) with
| (tu, u) -> begin
(
# 1472 "FStar.TypeChecker.Tc.fst"
let _72_2041 = (tc_check_tot_or_gtot_term env x.FStar_Syntax_Syntax.sort tu)
in (match (_72_2041) with
| (t, _72_2039, g) -> begin
(
# 1473 "FStar.TypeChecker.Tc.fst"
let x = ((
# 1473 "FStar.TypeChecker.Tc.fst"
let _72_2042 = x
in {FStar_Syntax_Syntax.ppname = _72_2042.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_2042.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}), imp)
in (
# 1474 "FStar.TypeChecker.Tc.fst"
let _72_2045 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_825 = (FStar_Syntax_Print.bv_to_string (Prims.fst x))
in (let _151_824 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "Pushing binder %s at type %s\n" _151_825 _151_824)))
end else begin
()
end
in (let _151_826 = (maybe_push_binding env x)
in (x, _151_826, g, u))))
end))
end))
end))
and tc_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list * FStar_TypeChecker_Env.env * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.universe Prims.list) = (fun env bs -> (
# 1479 "FStar.TypeChecker.Tc.fst"
let rec aux = (fun env bs -> (match (bs) with
| [] -> begin
([], env, FStar_TypeChecker_Rel.trivial_guard, [])
end
| b::bs -> begin
(
# 1482 "FStar.TypeChecker.Tc.fst"
let _72_2060 = (tc_binder env b)
in (match (_72_2060) with
| (b, env', g, u) -> begin
(
# 1483 "FStar.TypeChecker.Tc.fst"
let _72_2065 = (aux env' bs)
in (match (_72_2065) with
| (bs, env', g', us) -> begin
(let _151_834 = (let _151_833 = (FStar_TypeChecker_Rel.close_guard ((b)::[]) g')
in (FStar_TypeChecker_Rel.conj_guard g _151_833))
in ((b)::bs, env', _151_834, (u)::us))
end))
end))
end))
in (aux env bs)))
and tc_pats : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.args Prims.list  ->  (FStar_Syntax_Syntax.args Prims.list * FStar_TypeChecker_Env.guard_t) = (fun env pats -> (
# 1488 "FStar.TypeChecker.Tc.fst"
let tc_args = (fun env args -> (FStar_List.fold_right (fun _72_2073 _72_2076 -> (match ((_72_2073, _72_2076)) with
| ((t, imp), (args, g)) -> begin
(
# 1492 "FStar.TypeChecker.Tc.fst"
let _72_2081 = (tc_term env t)
in (match (_72_2081) with
| (t, _72_2079, g') -> begin
(let _151_843 = (FStar_TypeChecker_Rel.conj_guard g g')
in (((t, imp))::args, _151_843))
end))
end)) args ([], FStar_TypeChecker_Rel.trivial_guard)))
in (FStar_List.fold_right (fun p _72_2085 -> (match (_72_2085) with
| (pats, g) -> begin
(
# 1495 "FStar.TypeChecker.Tc.fst"
let _72_2088 = (tc_args env p)
in (match (_72_2088) with
| (args, g') -> begin
(let _151_846 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((args)::pats, _151_846))
end))
end)) pats ([], FStar_TypeChecker_Rel.trivial_guard))))
and tc_tot_or_gtot_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 1500 "FStar.TypeChecker.Tc.fst"
let _72_2094 = (tc_maybe_toplevel_term env e)
in (match (_72_2094) with
| (e, c, g) -> begin
if (FStar_Syntax_Util.is_tot_or_gtot_lcomp c) then begin
(e, c, g)
end else begin
(
# 1503 "FStar.TypeChecker.Tc.fst"
let g = (FStar_TypeChecker_Rel.solve_deferred_constraints env g)
in (
# 1504 "FStar.TypeChecker.Tc.fst"
let c = (c.FStar_Syntax_Syntax.comp ())
in (
# 1505 "FStar.TypeChecker.Tc.fst"
let _72_2097 = if (FStar_TypeChecker_Env.debug env FStar_Options.High) then begin
(let _151_849 = (FStar_Syntax_Print.comp_to_string c)
in (FStar_Util.print1 "About to normalize %s\n" _151_849))
end else begin
()
end
in (
# 1506 "FStar.TypeChecker.Tc.fst"
let c = (norm_c env c)
in (
# 1507 "FStar.TypeChecker.Tc.fst"
let _72_2102 = if (FStar_TypeChecker_Util.is_pure_effect env (FStar_Syntax_Util.comp_effect_name c)) then begin
(let _151_850 = (FStar_Syntax_Syntax.mk_Total (FStar_Syntax_Util.comp_result c))
in (_151_850, false))
end else begin
(let _151_851 = (FStar_Syntax_Syntax.mk_GTotal (FStar_Syntax_Util.comp_result c))
in (_151_851, true))
end
in (match (_72_2102) with
| (target_comp, allow_ghost) -> begin
(match ((FStar_TypeChecker_Rel.sub_comp env c target_comp)) with
| Some (g') -> begin
(let _151_852 = (FStar_TypeChecker_Rel.conj_guard g g')
in (e, (FStar_Syntax_Util.lcomp_of_comp target_comp), _151_852))
end
| _72_2106 -> begin
if allow_ghost then begin
(let _151_855 = (let _151_854 = (let _151_853 = (FStar_TypeChecker_Errors.expected_ghost_expression e c)
in (_151_853, e.FStar_Syntax_Syntax.pos))
in FStar_Syntax_Syntax.Error (_151_854))
in (Prims.raise _151_855))
end else begin
(let _151_858 = (let _151_857 = (let _151_856 = (FStar_TypeChecker_Errors.expected_pure_expression e c)
in (_151_856, e.FStar_Syntax_Syntax.pos))
in FStar_Syntax_Syntax.Error (_151_857))
in (Prims.raise _151_858))
end
end)
end))))))
end
end)))
and tc_check_tot_or_gtot_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e t -> (
# 1521 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_expected_typ env t)
in (tc_tot_or_gtot_term env e)))

# 1525 "FStar.TypeChecker.Tc.fst"
let tc_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp) = (fun env t -> (
# 1526 "FStar.TypeChecker.Tc.fst"
let _72_2116 = (tc_tot_or_gtot_term env t)
in (match (_72_2116) with
| (t, c, g) -> begin
(
# 1527 "FStar.TypeChecker.Tc.fst"
let _72_2117 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (t, c))
end)))

# 1530 "FStar.TypeChecker.Tc.fst"
let tc_check_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term = (fun env t k -> (
# 1531 "FStar.TypeChecker.Tc.fst"
let _72_2125 = (tc_check_tot_or_gtot_term env t k)
in (match (_72_2125) with
| (t, c, g) -> begin
(
# 1532 "FStar.TypeChecker.Tc.fst"
let _72_2126 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in t)
end)))

# 1535 "FStar.TypeChecker.Tc.fst"
let check_and_gen : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.tscheme = (fun env t k -> (let _151_878 = (tc_check_trivial_guard env t k)
in (FStar_TypeChecker_Util.generalize_universes env _151_878)))

# 1538 "FStar.TypeChecker.Tc.fst"
let check_nogen = (fun env t k -> (
# 1539 "FStar.TypeChecker.Tc.fst"
let t = (tc_check_trivial_guard env t k)
in (let _151_882 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env t)
in ([], _151_882))))

# 1542 "FStar.TypeChecker.Tc.fst"
let tc_tparams : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.binders * FStar_TypeChecker_Env.env * FStar_Syntax_Syntax.universes) = (fun env tps -> (
# 1543 "FStar.TypeChecker.Tc.fst"
let _72_2141 = (tc_binders env tps)
in (match (_72_2141) with
| (tps, env, g, us) -> begin
(
# 1544 "FStar.TypeChecker.Tc.fst"
let _72_2142 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (tps, env, us))
end)))

# 1547 "FStar.TypeChecker.Tc.fst"
let monad_signature : FStar_TypeChecker_Env.env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env m s -> (
# 1548 "FStar.TypeChecker.Tc.fst"
let fail = (fun _72_2148 -> (match (()) with
| () -> begin
(let _151_897 = (let _151_896 = (let _151_895 = (FStar_TypeChecker_Errors.unexpected_signature_for_monad env m s)
in (_151_895, (FStar_Ident.range_of_lid m)))
in FStar_Syntax_Syntax.Error (_151_896))
in (Prims.raise _151_897))
end))
in (
# 1549 "FStar.TypeChecker.Tc.fst"
let s = (FStar_Syntax_Subst.compress s)
in (match (s.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(
# 1552 "FStar.TypeChecker.Tc.fst"
let bs = (FStar_Syntax_Subst.open_binders bs)
in (match (bs) with
| (a, _72_2165)::(wp, _72_2161)::(_wlp, _72_2157)::[] -> begin
(a, wp.FStar_Syntax_Syntax.sort)
end
| _72_2169 -> begin
(fail ())
end))
end
| _72_2171 -> begin
(fail ())
end))))

# 1559 "FStar.TypeChecker.Tc.fst"
let open_univ_vars : FStar_Syntax_Syntax.univ_names  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.univ_names * (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list * FStar_Syntax_Syntax.comp) = (fun uvs binders c -> (match (binders) with
| [] -> begin
(
# 1562 "FStar.TypeChecker.Tc.fst"
let _72_2178 = (FStar_Syntax_Subst.open_univ_vars_comp uvs c)
in (match (_72_2178) with
| (uvs, c) -> begin
(uvs, [], c)
end))
end
| _72_2180 -> begin
(
# 1565 "FStar.TypeChecker.Tc.fst"
let t' = (FStar_Syntax_Util.arrow binders c)
in (
# 1566 "FStar.TypeChecker.Tc.fst"
let _72_2184 = (FStar_Syntax_Subst.open_univ_vars uvs t')
in (match (_72_2184) with
| (uvs, t') -> begin
(match ((let _151_904 = (FStar_Syntax_Subst.compress t')
in _151_904.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
(uvs, binders, c)
end
| _72_2190 -> begin
(FStar_All.failwith "Impossible")
end)
end)))
end))

# 1571 "FStar.TypeChecker.Tc.fst"
let open_effect_decl : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.eff_decl  ->  (FStar_Syntax_Syntax.eff_decl * FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env ed -> (
# 1572 "FStar.TypeChecker.Tc.fst"
let fail = (fun t -> (let _151_913 = (let _151_912 = (let _151_911 = (FStar_TypeChecker_Errors.unexpected_signature_for_monad env ed.FStar_Syntax_Syntax.mname t)
in (_151_911, (FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname)))
in FStar_Syntax_Syntax.Error (_151_912))
in (Prims.raise _151_913)))
in (
# 1573 "FStar.TypeChecker.Tc.fst"
let _72_2219 = (match ((let _151_914 = (FStar_Syntax_Subst.compress ed.FStar_Syntax_Syntax.signature)
in _151_914.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(
# 1575 "FStar.TypeChecker.Tc.fst"
let bs = (FStar_Syntax_Subst.open_binders bs)
in (match (bs) with
| (a, _72_2210)::(wp, _72_2206)::(_wlp, _72_2202)::[] -> begin
(a, wp.FStar_Syntax_Syntax.sort)
end
| _72_2214 -> begin
(fail ed.FStar_Syntax_Syntax.signature)
end))
end
| _72_2216 -> begin
(fail ed.FStar_Syntax_Syntax.signature)
end)
in (match (_72_2219) with
| (a, wp) -> begin
(
# 1581 "FStar.TypeChecker.Tc.fst"
let ed = (match (ed.FStar_Syntax_Syntax.binders) with
| [] -> begin
ed
end
| _72_2222 -> begin
(
# 1585 "FStar.TypeChecker.Tc.fst"
let opening = (FStar_Syntax_Subst.opening_of_binders ed.FStar_Syntax_Syntax.binders)
in (
# 1586 "FStar.TypeChecker.Tc.fst"
let op = (fun ts -> (
# 1587 "FStar.TypeChecker.Tc.fst"
let _72_2226 = ()
in (
# 1588 "FStar.TypeChecker.Tc.fst"
let t0 = (Prims.snd ts)
in (
# 1589 "FStar.TypeChecker.Tc.fst"
let t1 = (FStar_Syntax_Subst.subst opening (Prims.snd ts))
in ([], t1)))))
in (
# 1591 "FStar.TypeChecker.Tc.fst"
let _72_2230 = ed
in (let _151_929 = (op ed.FStar_Syntax_Syntax.ret)
in (let _151_928 = (op ed.FStar_Syntax_Syntax.bind_wp)
in (let _151_927 = (op ed.FStar_Syntax_Syntax.bind_wlp)
in (let _151_926 = (op ed.FStar_Syntax_Syntax.if_then_else)
in (let _151_925 = (op ed.FStar_Syntax_Syntax.ite_wp)
in (let _151_924 = (op ed.FStar_Syntax_Syntax.ite_wlp)
in (let _151_923 = (op ed.FStar_Syntax_Syntax.wp_binop)
in (let _151_922 = (op ed.FStar_Syntax_Syntax.wp_as_type)
in (let _151_921 = (op ed.FStar_Syntax_Syntax.close_wp)
in (let _151_920 = (op ed.FStar_Syntax_Syntax.assert_p)
in (let _151_919 = (op ed.FStar_Syntax_Syntax.assume_p)
in (let _151_918 = (op ed.FStar_Syntax_Syntax.null_wp)
in (let _151_917 = (op ed.FStar_Syntax_Syntax.trivial)
in {FStar_Syntax_Syntax.qualifiers = _72_2230.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _72_2230.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _72_2230.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = _72_2230.FStar_Syntax_Syntax.binders; FStar_Syntax_Syntax.signature = _72_2230.FStar_Syntax_Syntax.signature; FStar_Syntax_Syntax.ret = _151_929; FStar_Syntax_Syntax.bind_wp = _151_928; FStar_Syntax_Syntax.bind_wlp = _151_927; FStar_Syntax_Syntax.if_then_else = _151_926; FStar_Syntax_Syntax.ite_wp = _151_925; FStar_Syntax_Syntax.ite_wlp = _151_924; FStar_Syntax_Syntax.wp_binop = _151_923; FStar_Syntax_Syntax.wp_as_type = _151_922; FStar_Syntax_Syntax.close_wp = _151_921; FStar_Syntax_Syntax.assert_p = _151_920; FStar_Syntax_Syntax.assume_p = _151_919; FStar_Syntax_Syntax.null_wp = _151_918; FStar_Syntax_Syntax.trivial = _151_917}))))))))))))))))
end)
in (ed, a, wp))
end))))

# 1607 "FStar.TypeChecker.Tc.fst"
let tc_eff_decl : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.eff_decl  ->  FStar_Syntax_Syntax.eff_decl = (fun env0 ed -> (
# 1608 "FStar.TypeChecker.Tc.fst"
let _72_2235 = ()
in (
# 1609 "FStar.TypeChecker.Tc.fst"
let _72_2239 = (FStar_Syntax_Subst.open_term ed.FStar_Syntax_Syntax.binders ed.FStar_Syntax_Syntax.signature)
in (match (_72_2239) with
| (binders, signature) -> begin
(
# 1610 "FStar.TypeChecker.Tc.fst"
let _72_2244 = (tc_tparams env0 binders)
in (match (_72_2244) with
| (binders, env, _72_2243) -> begin
(
# 1611 "FStar.TypeChecker.Tc.fst"
let _72_2248 = (tc_trivial_guard env signature)
in (match (_72_2248) with
| (signature, _72_2247) -> begin
(
# 1612 "FStar.TypeChecker.Tc.fst"
let ed = (
# 1612 "FStar.TypeChecker.Tc.fst"
let _72_2249 = ed
in {FStar_Syntax_Syntax.qualifiers = _72_2249.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _72_2249.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _72_2249.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = binders; FStar_Syntax_Syntax.signature = signature; FStar_Syntax_Syntax.ret = _72_2249.FStar_Syntax_Syntax.ret; FStar_Syntax_Syntax.bind_wp = _72_2249.FStar_Syntax_Syntax.bind_wp; FStar_Syntax_Syntax.bind_wlp = _72_2249.FStar_Syntax_Syntax.bind_wlp; FStar_Syntax_Syntax.if_then_else = _72_2249.FStar_Syntax_Syntax.if_then_else; FStar_Syntax_Syntax.ite_wp = _72_2249.FStar_Syntax_Syntax.ite_wp; FStar_Syntax_Syntax.ite_wlp = _72_2249.FStar_Syntax_Syntax.ite_wlp; FStar_Syntax_Syntax.wp_binop = _72_2249.FStar_Syntax_Syntax.wp_binop; FStar_Syntax_Syntax.wp_as_type = _72_2249.FStar_Syntax_Syntax.wp_as_type; FStar_Syntax_Syntax.close_wp = _72_2249.FStar_Syntax_Syntax.close_wp; FStar_Syntax_Syntax.assert_p = _72_2249.FStar_Syntax_Syntax.assert_p; FStar_Syntax_Syntax.assume_p = _72_2249.FStar_Syntax_Syntax.assume_p; FStar_Syntax_Syntax.null_wp = _72_2249.FStar_Syntax_Syntax.null_wp; FStar_Syntax_Syntax.trivial = _72_2249.FStar_Syntax_Syntax.trivial})
in (
# 1615 "FStar.TypeChecker.Tc.fst"
let _72_2255 = (open_effect_decl env ed)
in (match (_72_2255) with
| (ed, a, wp_a) -> begin
(
# 1618 "FStar.TypeChecker.Tc.fst"
let env = (let _151_934 = (FStar_Syntax_Syntax.new_bv None ed.FStar_Syntax_Syntax.signature)
in (FStar_TypeChecker_Env.push_bv env _151_934))
in (
# 1620 "FStar.TypeChecker.Tc.fst"
let _72_2257 = if (FStar_TypeChecker_Env.debug env0 FStar_Options.Low) then begin
(let _151_937 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (let _151_936 = (FStar_Syntax_Print.binders_to_string " " ed.FStar_Syntax_Syntax.binders)
in (let _151_935 = (FStar_Syntax_Print.term_to_string ed.FStar_Syntax_Syntax.signature)
in (FStar_Util.print3 "Checked effect signature: %s %s : %s\n" _151_937 _151_936 _151_935))))
end else begin
()
end
in (
# 1626 "FStar.TypeChecker.Tc.fst"
let check_and_gen' = (fun env _72_2264 k -> (match (_72_2264) with
| (_72_2262, t) -> begin
(check_and_gen env t k)
end))
in (
# 1628 "FStar.TypeChecker.Tc.fst"
let ret = (
# 1629 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_949 = (let _151_947 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_946 = (let _151_945 = (let _151_944 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _151_944))
in (_151_945)::[])
in (_151_947)::_151_946))
in (let _151_948 = (FStar_Syntax_Syntax.mk_GTotal wp_a)
in (FStar_Syntax_Util.arrow _151_949 _151_948)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.ret expected_k))
in (
# 1632 "FStar.TypeChecker.Tc.fst"
let bind_wp = (
# 1633 "FStar.TypeChecker.Tc.fst"
let wlp_a = wp_a
in (
# 1634 "FStar.TypeChecker.Tc.fst"
let b = (let _151_951 = (let _151_950 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_950 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _151_951))
in (
# 1635 "FStar.TypeChecker.Tc.fst"
let wp_b = (let _151_955 = (let _151_954 = (let _151_953 = (let _151_952 = (FStar_Syntax_Syntax.bv_to_name b)
in (a, _151_952))
in FStar_Syntax_Syntax.NT (_151_953))
in (_151_954)::[])
in (FStar_Syntax_Subst.subst _151_955 wp_a))
in (
# 1636 "FStar.TypeChecker.Tc.fst"
let a_wp_b = (let _151_959 = (let _151_957 = (let _151_956 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _151_956))
in (_151_957)::[])
in (let _151_958 = (FStar_Syntax_Syntax.mk_Total wp_b)
in (FStar_Syntax_Util.arrow _151_959 _151_958)))
in (
# 1637 "FStar.TypeChecker.Tc.fst"
let a_wlp_b = a_wp_b
in (
# 1638 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_972 = (let _151_970 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_969 = (let _151_968 = (FStar_Syntax_Syntax.mk_binder b)
in (let _151_967 = (let _151_966 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _151_965 = (let _151_964 = (FStar_Syntax_Syntax.null_binder wlp_a)
in (let _151_963 = (let _151_962 = (FStar_Syntax_Syntax.null_binder a_wp_b)
in (let _151_961 = (let _151_960 = (FStar_Syntax_Syntax.null_binder a_wlp_b)
in (_151_960)::[])
in (_151_962)::_151_961))
in (_151_964)::_151_963))
in (_151_966)::_151_965))
in (_151_968)::_151_967))
in (_151_970)::_151_969))
in (let _151_971 = (FStar_Syntax_Syntax.mk_Total wp_b)
in (FStar_Syntax_Util.arrow _151_972 _151_971)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.bind_wp expected_k)))))))
in (
# 1644 "FStar.TypeChecker.Tc.fst"
let bind_wlp = (
# 1645 "FStar.TypeChecker.Tc.fst"
let wlp_a = wp_a
in (
# 1646 "FStar.TypeChecker.Tc.fst"
let b = (let _151_974 = (let _151_973 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_973 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _151_974))
in (
# 1647 "FStar.TypeChecker.Tc.fst"
let wlp_b = (let _151_978 = (let _151_977 = (let _151_976 = (let _151_975 = (FStar_Syntax_Syntax.bv_to_name b)
in (a, _151_975))
in FStar_Syntax_Syntax.NT (_151_976))
in (_151_977)::[])
in (FStar_Syntax_Subst.subst _151_978 wlp_a))
in (
# 1648 "FStar.TypeChecker.Tc.fst"
let a_wlp_b = (let _151_982 = (let _151_980 = (let _151_979 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _151_979))
in (_151_980)::[])
in (let _151_981 = (FStar_Syntax_Syntax.mk_Total wlp_b)
in (FStar_Syntax_Util.arrow _151_982 _151_981)))
in (
# 1649 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_991 = (let _151_989 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_988 = (let _151_987 = (FStar_Syntax_Syntax.mk_binder b)
in (let _151_986 = (let _151_985 = (FStar_Syntax_Syntax.null_binder wlp_a)
in (let _151_984 = (let _151_983 = (FStar_Syntax_Syntax.null_binder a_wlp_b)
in (_151_983)::[])
in (_151_985)::_151_984))
in (_151_987)::_151_986))
in (_151_989)::_151_988))
in (let _151_990 = (FStar_Syntax_Syntax.mk_Total wlp_b)
in (FStar_Syntax_Util.arrow _151_991 _151_990)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.bind_wlp expected_k))))))
in (
# 1655 "FStar.TypeChecker.Tc.fst"
let if_then_else = (
# 1656 "FStar.TypeChecker.Tc.fst"
let p = (let _151_993 = (let _151_992 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_992 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _151_993))
in (
# 1657 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1002 = (let _151_1000 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_999 = (let _151_998 = (FStar_Syntax_Syntax.mk_binder p)
in (let _151_997 = (let _151_996 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _151_995 = (let _151_994 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_994)::[])
in (_151_996)::_151_995))
in (_151_998)::_151_997))
in (_151_1000)::_151_999))
in (let _151_1001 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1002 _151_1001)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.if_then_else expected_k)))
in (
# 1663 "FStar.TypeChecker.Tc.fst"
let ite_wp = (
# 1664 "FStar.TypeChecker.Tc.fst"
let wlp_a = wp_a
in (
# 1665 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1009 = (let _151_1007 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1006 = (let _151_1005 = (FStar_Syntax_Syntax.null_binder wlp_a)
in (let _151_1004 = (let _151_1003 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1003)::[])
in (_151_1005)::_151_1004))
in (_151_1007)::_151_1006))
in (let _151_1008 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1009 _151_1008)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.ite_wp expected_k)))
in (
# 1671 "FStar.TypeChecker.Tc.fst"
let ite_wlp = (
# 1672 "FStar.TypeChecker.Tc.fst"
let wlp_a = wp_a
in (
# 1673 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1014 = (let _151_1012 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1011 = (let _151_1010 = (FStar_Syntax_Syntax.null_binder wlp_a)
in (_151_1010)::[])
in (_151_1012)::_151_1011))
in (let _151_1013 = (FStar_Syntax_Syntax.mk_Total wlp_a)
in (FStar_Syntax_Util.arrow _151_1014 _151_1013)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.ite_wlp expected_k)))
in (
# 1678 "FStar.TypeChecker.Tc.fst"
let wp_binop = (
# 1679 "FStar.TypeChecker.Tc.fst"
let bin_op = (
# 1680 "FStar.TypeChecker.Tc.fst"
let _72_2292 = (FStar_Syntax_Util.type_u ())
in (match (_72_2292) with
| (t1, u1) -> begin
(
# 1681 "FStar.TypeChecker.Tc.fst"
let _72_2295 = (FStar_Syntax_Util.type_u ())
in (match (_72_2295) with
| (t2, u2) -> begin
(
# 1682 "FStar.TypeChecker.Tc.fst"
let t = (let _151_1015 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_max ((u1)::(u2)::[]))) None _151_1015))
in (let _151_1020 = (let _151_1018 = (FStar_Syntax_Syntax.null_binder t1)
in (let _151_1017 = (let _151_1016 = (FStar_Syntax_Syntax.null_binder t2)
in (_151_1016)::[])
in (_151_1018)::_151_1017))
in (let _151_1019 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow _151_1020 _151_1019))))
end))
end))
in (
# 1684 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1029 = (let _151_1027 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1026 = (let _151_1025 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _151_1024 = (let _151_1023 = (FStar_Syntax_Syntax.null_binder bin_op)
in (let _151_1022 = (let _151_1021 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1021)::[])
in (_151_1023)::_151_1022))
in (_151_1025)::_151_1024))
in (_151_1027)::_151_1026))
in (let _151_1028 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1029 _151_1028)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.wp_binop expected_k)))
in (
# 1691 "FStar.TypeChecker.Tc.fst"
let wp_as_type = (
# 1692 "FStar.TypeChecker.Tc.fst"
let _72_2303 = (FStar_Syntax_Util.type_u ())
in (match (_72_2303) with
| (t, _72_2302) -> begin
(
# 1693 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1034 = (let _151_1032 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1031 = (let _151_1030 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1030)::[])
in (_151_1032)::_151_1031))
in (let _151_1033 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow _151_1034 _151_1033)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.wp_as_type expected_k))
end))
in (
# 1698 "FStar.TypeChecker.Tc.fst"
let close_wp = (
# 1699 "FStar.TypeChecker.Tc.fst"
let b = (let _151_1036 = (let _151_1035 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_1035 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _151_1036))
in (
# 1700 "FStar.TypeChecker.Tc.fst"
let b_wp_a = (let _151_1040 = (let _151_1038 = (let _151_1037 = (FStar_Syntax_Syntax.bv_to_name b)
in (FStar_Syntax_Syntax.null_binder _151_1037))
in (_151_1038)::[])
in (let _151_1039 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1040 _151_1039)))
in (
# 1701 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1047 = (let _151_1045 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1044 = (let _151_1043 = (FStar_Syntax_Syntax.mk_binder b)
in (let _151_1042 = (let _151_1041 = (FStar_Syntax_Syntax.null_binder b_wp_a)
in (_151_1041)::[])
in (_151_1043)::_151_1042))
in (_151_1045)::_151_1044))
in (let _151_1046 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1047 _151_1046)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.close_wp expected_k))))
in (
# 1705 "FStar.TypeChecker.Tc.fst"
let assert_p = (
# 1706 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1056 = (let _151_1054 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1053 = (let _151_1052 = (let _151_1049 = (let _151_1048 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_1048 Prims.fst))
in (FStar_Syntax_Syntax.null_binder _151_1049))
in (let _151_1051 = (let _151_1050 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1050)::[])
in (_151_1052)::_151_1051))
in (_151_1054)::_151_1053))
in (let _151_1055 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1056 _151_1055)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.assert_p expected_k))
in (
# 1712 "FStar.TypeChecker.Tc.fst"
let assume_p = (
# 1713 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1065 = (let _151_1063 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1062 = (let _151_1061 = (let _151_1058 = (let _151_1057 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _151_1057 Prims.fst))
in (FStar_Syntax_Syntax.null_binder _151_1058))
in (let _151_1060 = (let _151_1059 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1059)::[])
in (_151_1061)::_151_1060))
in (_151_1063)::_151_1062))
in (let _151_1064 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1065 _151_1064)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.assume_p expected_k))
in (
# 1719 "FStar.TypeChecker.Tc.fst"
let null_wp = (
# 1720 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1068 = (let _151_1066 = (FStar_Syntax_Syntax.mk_binder a)
in (_151_1066)::[])
in (let _151_1067 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _151_1068 _151_1067)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.null_wp expected_k))
in (
# 1724 "FStar.TypeChecker.Tc.fst"
let trivial_wp = (
# 1725 "FStar.TypeChecker.Tc.fst"
let _72_2319 = (FStar_Syntax_Util.type_u ())
in (match (_72_2319) with
| (t, _72_2318) -> begin
(
# 1726 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1073 = (let _151_1071 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1070 = (let _151_1069 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_151_1069)::[])
in (_151_1071)::_151_1070))
in (let _151_1072 = (FStar_Syntax_Syntax.mk_GTotal t)
in (FStar_Syntax_Util.arrow _151_1073 _151_1072)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.trivial expected_k))
end))
in (
# 1732 "FStar.TypeChecker.Tc.fst"
let t = (let _151_1074 = (FStar_Syntax_Syntax.mk_Total ed.FStar_Syntax_Syntax.signature)
in (FStar_Syntax_Util.arrow ed.FStar_Syntax_Syntax.binders _151_1074))
in (
# 1733 "FStar.TypeChecker.Tc.fst"
let _72_2325 = (FStar_TypeChecker_Util.generalize_universes env0 t)
in (match (_72_2325) with
| (univs, t) -> begin
(
# 1734 "FStar.TypeChecker.Tc.fst"
let _72_2341 = (match ((let _151_1076 = (let _151_1075 = (FStar_Syntax_Subst.compress t)
in _151_1075.FStar_Syntax_Syntax.n)
in (binders, _151_1076))) with
| ([], _72_2328) -> begin
([], t)
end
| (_72_2331, FStar_Syntax_Syntax.Tm_arrow (binders, c)) -> begin
(binders, (FStar_Syntax_Util.comp_result c))
end
| _72_2338 -> begin
(FStar_All.failwith "Impossible")
end)
in (match (_72_2341) with
| (binders, signature) -> begin
(
# 1738 "FStar.TypeChecker.Tc.fst"
let close = (fun ts -> (let _151_1079 = (FStar_Syntax_Subst.close_tscheme binders ts)
in (FStar_Syntax_Subst.close_univ_vars_tscheme univs _151_1079)))
in (
# 1739 "FStar.TypeChecker.Tc.fst"
let ed = (
# 1739 "FStar.TypeChecker.Tc.fst"
let _72_2344 = ed
in (let _151_1092 = (close ret)
in (let _151_1091 = (close bind_wp)
in (let _151_1090 = (close bind_wlp)
in (let _151_1089 = (close if_then_else)
in (let _151_1088 = (close ite_wp)
in (let _151_1087 = (close ite_wlp)
in (let _151_1086 = (close wp_binop)
in (let _151_1085 = (close wp_as_type)
in (let _151_1084 = (close close_wp)
in (let _151_1083 = (close assert_p)
in (let _151_1082 = (close assume_p)
in (let _151_1081 = (close null_wp)
in (let _151_1080 = (close trivial_wp)
in {FStar_Syntax_Syntax.qualifiers = _72_2344.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _72_2344.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = univs; FStar_Syntax_Syntax.binders = binders; FStar_Syntax_Syntax.signature = signature; FStar_Syntax_Syntax.ret = _151_1092; FStar_Syntax_Syntax.bind_wp = _151_1091; FStar_Syntax_Syntax.bind_wlp = _151_1090; FStar_Syntax_Syntax.if_then_else = _151_1089; FStar_Syntax_Syntax.ite_wp = _151_1088; FStar_Syntax_Syntax.ite_wlp = _151_1087; FStar_Syntax_Syntax.wp_binop = _151_1086; FStar_Syntax_Syntax.wp_as_type = _151_1085; FStar_Syntax_Syntax.close_wp = _151_1084; FStar_Syntax_Syntax.assert_p = _151_1083; FStar_Syntax_Syntax.assume_p = _151_1082; FStar_Syntax_Syntax.null_wp = _151_1081; FStar_Syntax_Syntax.trivial = _151_1080}))))))))))))))
in (
# 1757 "FStar.TypeChecker.Tc.fst"
let _72_2347 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1093 = (FStar_Syntax_Print.eff_decl_to_string ed)
in (FStar_Util.print_string _151_1093))
end else begin
()
end
in ed)))
end))
end)))))))))))))))))))
end)))
end))
end))
end))))

# 1761 "FStar.TypeChecker.Tc.fst"
let tc_lex_t = (fun env ses quals lids -> (
# 1768 "FStar.TypeChecker.Tc.fst"
let _72_2353 = ()
in (
# 1769 "FStar.TypeChecker.Tc.fst"
let _72_2361 = ()
in (match (ses) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lex_t, [], [], t, _72_2390, _72_2392, [], r)::FStar_Syntax_Syntax.Sig_datacon (lex_top, [], _t_top, _lex_t_top, 0, [], _72_2381, r1)::FStar_Syntax_Syntax.Sig_datacon (lex_cons, [], _t_cons, _lex_t_cons, 0, [], _72_2370, r2)::[] when (((FStar_Ident.lid_equals lex_t FStar_Syntax_Const.lex_t_lid) && (FStar_Ident.lid_equals lex_top FStar_Syntax_Const.lextop_lid)) && (FStar_Ident.lid_equals lex_cons FStar_Syntax_Const.lexcons_lid)) -> begin
(
# 1784 "FStar.TypeChecker.Tc.fst"
let u = (FStar_Syntax_Syntax.new_univ_name (Some (r)))
in (
# 1785 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_name (u))) None r)
in (
# 1786 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Subst.close_univ_vars ((u)::[]) t)
in (
# 1787 "FStar.TypeChecker.Tc.fst"
let tc = FStar_Syntax_Syntax.Sig_inductive_typ ((lex_t, (u)::[], [], t, [], (FStar_Syntax_Const.lextop_lid)::(FStar_Syntax_Const.lexcons_lid)::[], [], r))
in (
# 1789 "FStar.TypeChecker.Tc.fst"
let utop = (FStar_Syntax_Syntax.new_univ_name (Some (r1)))
in (
# 1790 "FStar.TypeChecker.Tc.fst"
let lex_top_t = (let _151_1100 = (let _151_1099 = (let _151_1098 = (FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.lex_t_lid r1)
in (_151_1098, (FStar_Syntax_Syntax.U_name (utop))::[]))
in FStar_Syntax_Syntax.Tm_uinst (_151_1099))
in (FStar_Syntax_Syntax.mk _151_1100 None r1))
in (
# 1791 "FStar.TypeChecker.Tc.fst"
let lex_top_t = (FStar_Syntax_Subst.close_univ_vars ((utop)::[]) lex_top_t)
in (
# 1792 "FStar.TypeChecker.Tc.fst"
let dc_lextop = FStar_Syntax_Syntax.Sig_datacon ((lex_top, (utop)::[], lex_top_t, FStar_Syntax_Const.lex_t_lid, 0, [], [], r1))
in (
# 1794 "FStar.TypeChecker.Tc.fst"
let ucons1 = (FStar_Syntax_Syntax.new_univ_name (Some (r2)))
in (
# 1795 "FStar.TypeChecker.Tc.fst"
let ucons2 = (FStar_Syntax_Syntax.new_univ_name (Some (r2)))
in (
# 1796 "FStar.TypeChecker.Tc.fst"
let lex_cons_t = (
# 1797 "FStar.TypeChecker.Tc.fst"
let a = (let _151_1101 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_name (ucons1))) None r2)
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _151_1101))
in (
# 1798 "FStar.TypeChecker.Tc.fst"
let hd = (let _151_1102 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _151_1102))
in (
# 1799 "FStar.TypeChecker.Tc.fst"
let tl = (let _151_1106 = (let _151_1105 = (let _151_1104 = (let _151_1103 = (FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.lex_t_lid r2)
in (_151_1103, (FStar_Syntax_Syntax.U_name (ucons2))::[]))
in FStar_Syntax_Syntax.Tm_uinst (_151_1104))
in (FStar_Syntax_Syntax.mk _151_1105 None r2))
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _151_1106))
in (
# 1800 "FStar.TypeChecker.Tc.fst"
let res = (let _151_1109 = (let _151_1108 = (let _151_1107 = (FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.lex_t_lid r2)
in (_151_1107, (FStar_Syntax_Syntax.U_max ((FStar_Syntax_Syntax.U_name (ucons1))::(FStar_Syntax_Syntax.U_name (ucons2))::[]))::[]))
in FStar_Syntax_Syntax.Tm_uinst (_151_1108))
in (FStar_Syntax_Syntax.mk _151_1109 None r2))
in (let _151_1110 = (FStar_Syntax_Syntax.mk_Total res)
in (FStar_Syntax_Util.arrow (((a, Some (FStar_Syntax_Syntax.Implicit)))::((hd, None))::((tl, None))::[]) _151_1110))))))
in (
# 1802 "FStar.TypeChecker.Tc.fst"
let lex_cons_t = (FStar_Syntax_Subst.close_univ_vars ((ucons1)::(ucons2)::[]) lex_cons_t)
in (
# 1803 "FStar.TypeChecker.Tc.fst"
let dc_lexcons = FStar_Syntax_Syntax.Sig_datacon ((lex_cons, (ucons1)::(ucons2)::[], lex_cons_t, FStar_Syntax_Const.lex_t_lid, 0, [], [], r2))
in (let _151_1112 = (let _151_1111 = (FStar_TypeChecker_Env.get_range env)
in ((tc)::(dc_lextop)::(dc_lexcons)::[], [], lids, _151_1111))
in FStar_Syntax_Syntax.Sig_bundle (_151_1112)))))))))))))))
end
| _72_2416 -> begin
(let _151_1114 = (let _151_1113 = (FStar_Syntax_Print.sigelt_to_string (FStar_Syntax_Syntax.Sig_bundle ((ses, [], lids, FStar_Range.dummyRange))))
in (FStar_Util.format1 "Unexpected lex_t: %s\n" _151_1113))
in (FStar_All.failwith _151_1114))
end))))

# 1809 "FStar.TypeChecker.Tc.fst"
let tc_inductive : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt = (fun env ses quals lids -> (
# 1872 "FStar.TypeChecker.Tc.fst"
let warn_positivity = (fun l r -> (let _151_1128 = (let _151_1127 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format1 "Positivity check is not yet implemented (%s)" _151_1127))
in (FStar_TypeChecker_Errors.warn r _151_1128)))
in (
# 1874 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 1877 "FStar.TypeChecker.Tc.fst"
let tc_tycon = (fun env s -> (match (s) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tc, uvs, tps, k, mutuals, data, quals, r) -> begin
(
# 1882 "FStar.TypeChecker.Tc.fst"
let _72_2438 = ()
in (
# 1883 "FStar.TypeChecker.Tc.fst"
let _72_2440 = (warn_positivity tc r)
in (
# 1884 "FStar.TypeChecker.Tc.fst"
let _72_2444 = (FStar_Syntax_Subst.open_term tps k)
in (match (_72_2444) with
| (tps, k) -> begin
(
# 1885 "FStar.TypeChecker.Tc.fst"
let _72_2448 = (tc_tparams env tps)
in (match (_72_2448) with
| (tps, env_tps, us) -> begin
(
# 1886 "FStar.TypeChecker.Tc.fst"
let _72_2451 = (FStar_Syntax_Util.arrow_formals k)
in (match (_72_2451) with
| (indices, t) -> begin
(
# 1887 "FStar.TypeChecker.Tc.fst"
let _72_2455 = (tc_tparams env_tps indices)
in (match (_72_2455) with
| (indices, env', us') -> begin
(
# 1888 "FStar.TypeChecker.Tc.fst"
let _72_2459 = (tc_trivial_guard env' t)
in (match (_72_2459) with
| (t, _72_2458) -> begin
(
# 1889 "FStar.TypeChecker.Tc.fst"
let k = (let _151_1133 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow indices _151_1133))
in (
# 1890 "FStar.TypeChecker.Tc.fst"
let _72_2463 = (FStar_Syntax_Util.type_u ())
in (match (_72_2463) with
| (t_type, u) -> begin
(
# 1891 "FStar.TypeChecker.Tc.fst"
let _72_2464 = (let _151_1134 = (FStar_TypeChecker_Rel.teq env' t t_type)
in (FStar_TypeChecker_Rel.force_trivial_guard env' _151_1134))
in (
# 1893 "FStar.TypeChecker.Tc.fst"
let refined_tps = (FStar_All.pipe_right tps (FStar_List.map (fun _72_2468 -> (match (_72_2468) with
| (x, imp) -> begin
(
# 1894 "FStar.TypeChecker.Tc.fst"
let y = (FStar_Syntax_Syntax.freshen_bv x)
in (
# 1895 "FStar.TypeChecker.Tc.fst"
let refined = (let _151_1138 = (let _151_1137 = (FStar_Syntax_Syntax.bv_to_name x)
in (let _151_1136 = (FStar_Syntax_Syntax.bv_to_name y)
in (FStar_Syntax_Util.mk_eq x.FStar_Syntax_Syntax.sort x.FStar_Syntax_Syntax.sort _151_1137 _151_1136)))
in (FStar_Syntax_Util.refine y _151_1138))
in ((
# 1896 "FStar.TypeChecker.Tc.fst"
let _72_2471 = x
in {FStar_Syntax_Syntax.ppname = _72_2471.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _72_2471.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = refined}), imp)))
end))))
in (
# 1898 "FStar.TypeChecker.Tc.fst"
let t_tc = (let _151_1139 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow (FStar_List.append refined_tps indices) _151_1139))
in (
# 1899 "FStar.TypeChecker.Tc.fst"
let tps = (FStar_Syntax_Subst.close_binders tps)
in (
# 1900 "FStar.TypeChecker.Tc.fst"
let k = (FStar_Syntax_Subst.close tps k)
in (let _151_1140 = (FStar_TypeChecker_Env.push_let_binding env_tps (FStar_Util.Inr (tc)) ([], t_tc))
in (_151_1140, FStar_Syntax_Syntax.Sig_inductive_typ ((tc, [], tps, k, mutuals, data, quals, r)), u)))))))
end)))
end))
end))
end))
end))
end))))
end
| _72_2478 -> begin
(FStar_All.failwith "impossible")
end))
in (
# 1907 "FStar.TypeChecker.Tc.fst"
let positive_if_pure = (fun _72_2480 l -> ())
in (
# 1910 "FStar.TypeChecker.Tc.fst"
let tc_data = (fun env tcs _72_6 -> (match (_72_6) with
| FStar_Syntax_Syntax.Sig_datacon (c, _uvs, t, tc_lid, ntps, quals, _mutual_tcs, r) -> begin
(
# 1912 "FStar.TypeChecker.Tc.fst"
let _72_2497 = ()
in (
# 1914 "FStar.TypeChecker.Tc.fst"
let _72_2528 = (let _151_1155 = (FStar_Util.find_map tcs (fun _72_2501 -> (match (_72_2501) with
| (se, u_tc) -> begin
if (let _151_1153 = (let _151_1152 = (FStar_Syntax_Util.lid_of_sigelt se)
in (FStar_Util.must _151_1152))
in (FStar_Ident.lid_equals tc_lid _151_1153)) then begin
(
# 1917 "FStar.TypeChecker.Tc.fst"
let tps = (match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_72_2503, _72_2505, tps, _72_2508, _72_2510, _72_2512, _72_2514, _72_2516) -> begin
(FStar_All.pipe_right tps (FStar_List.map (fun _72_2522 -> (match (_72_2522) with
| (x, _72_2521) -> begin
(x, Some (FStar_Syntax_Syntax.Implicit))
end))))
end
| _72_2524 -> begin
(FStar_All.failwith "Impossible")
end)
in Some ((tps, u_tc)))
end else begin
None
end
end)))
in (FStar_All.pipe_right _151_1155 FStar_Util.must))
in (match (_72_2528) with
| (tps, u_tc) -> begin
(
# 1924 "FStar.TypeChecker.Tc.fst"
let _72_2548 = (match ((let _151_1156 = (FStar_Syntax_Subst.compress t)
in _151_1156.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, res) -> begin
(
# 1929 "FStar.TypeChecker.Tc.fst"
let _72_2536 = (FStar_Util.first_N ntps bs)
in (match (_72_2536) with
| (_72_2534, bs') -> begin
(
# 1930 "FStar.TypeChecker.Tc.fst"
let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((bs', res))) None t.FStar_Syntax_Syntax.pos)
in (
# 1931 "FStar.TypeChecker.Tc.fst"
let subst = (FStar_All.pipe_right tps (FStar_List.mapi (fun i _72_2542 -> (match (_72_2542) with
| (x, _72_2541) -> begin
(let _151_1160 = (let _151_1159 = (FStar_Syntax_Syntax.bv_to_name x)
in ((ntps - (1 + i)), _151_1159))
in FStar_Syntax_Syntax.DB (_151_1160))
end))))
in (let _151_1161 = (FStar_Syntax_Subst.subst subst t)
in (FStar_Syntax_Util.arrow_formals _151_1161))))
end))
end
| _72_2545 -> begin
([], t)
end)
in (match (_72_2548) with
| (arguments, result) -> begin
(
# 1935 "FStar.TypeChecker.Tc.fst"
let _72_2549 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1164 = (FStar_Syntax_Print.lid_to_string c)
in (let _151_1163 = (FStar_Syntax_Print.binders_to_string "->" arguments)
in (let _151_1162 = (FStar_Syntax_Print.term_to_string result)
in (FStar_Util.print3 "Checking datacon  %s : %s -> %s \n" _151_1164 _151_1163 _151_1162))))
end else begin
()
end
in (
# 1941 "FStar.TypeChecker.Tc.fst"
let _72_2554 = (tc_tparams env arguments)
in (match (_72_2554) with
| (arguments, env', us) -> begin
(
# 1942 "FStar.TypeChecker.Tc.fst"
let _72_2558 = (tc_trivial_guard env' result)
in (match (_72_2558) with
| (result, _72_2557) -> begin
(
# 1943 "FStar.TypeChecker.Tc.fst"
let _72_2562 = (FStar_Syntax_Util.head_and_args result)
in (match (_72_2562) with
| (head, _72_2561) -> begin
(
# 1944 "FStar.TypeChecker.Tc.fst"
let _72_2570 = (match ((let _151_1165 = (FStar_Syntax_Subst.compress head)
in _151_1165.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv, _72_2565) when (FStar_Ident.lid_equals fv.FStar_Syntax_Syntax.v tc_lid) -> begin
()
end
| _72_2569 -> begin
(let _151_1169 = (let _151_1168 = (let _151_1167 = (let _151_1166 = (FStar_Syntax_Print.lid_to_string tc_lid)
in (FStar_Util.format1 "Expected a constructor of type %s" _151_1166))
in (_151_1167, r))
in FStar_Syntax_Syntax.Error (_151_1168))
in (Prims.raise _151_1169))
end)
in (
# 1947 "FStar.TypeChecker.Tc.fst"
let g = (FStar_List.fold_left2 (fun g _72_2576 u_x -> (match (_72_2576) with
| (x, _72_2575) -> begin
(
# 1948 "FStar.TypeChecker.Tc.fst"
let _72_2578 = ()
in (let _151_1173 = (FStar_TypeChecker_Rel.universe_inequality u_x u_tc)
in (FStar_TypeChecker_Rel.conj_guard g _151_1173)))
end)) FStar_TypeChecker_Rel.trivial_guard arguments us)
in (
# 1954 "FStar.TypeChecker.Tc.fst"
let t = (let _151_1174 = (FStar_Syntax_Syntax.mk_Total result)
in (FStar_Syntax_Util.arrow (FStar_List.append tps arguments) _151_1174))
in (FStar_Syntax_Syntax.Sig_datacon ((c, [], t, tc_lid, ntps, quals, [], r)), g))))
end))
end))
end)))
end))
end)))
end
| _72_2583 -> begin
(FStar_All.failwith "impossible")
end))
in (
# 1961 "FStar.TypeChecker.Tc.fst"
let generalize_and_recheck = (fun env g tcs datas -> (
# 1962 "FStar.TypeChecker.Tc.fst"
let _72_2589 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (
# 1963 "FStar.TypeChecker.Tc.fst"
let binders = (FStar_All.pipe_right tcs (FStar_List.map (fun _72_7 -> (match (_72_7) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_72_2593, _72_2595, tps, k, _72_2599, _72_2601, _72_2603, _72_2605) -> begin
(let _151_1185 = (let _151_1184 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_All.pipe_left (FStar_Syntax_Util.arrow tps) _151_1184))
in (FStar_Syntax_Syntax.null_binder _151_1185))
end
| _72_2609 -> begin
(FStar_All.failwith "Impossible")
end))))
in (
# 1966 "FStar.TypeChecker.Tc.fst"
let binders' = (FStar_All.pipe_right datas (FStar_List.map (fun _72_8 -> (match (_72_8) with
| FStar_Syntax_Syntax.Sig_datacon (_72_2613, _72_2615, t, _72_2618, _72_2620, _72_2622, _72_2624, _72_2626) -> begin
(FStar_Syntax_Syntax.null_binder t)
end
| _72_2630 -> begin
(FStar_All.failwith "Impossible")
end))))
in (
# 1969 "FStar.TypeChecker.Tc.fst"
let t = (let _151_1187 = (FStar_Syntax_Syntax.mk_Total FStar_TypeChecker_Recheck.t_unit)
in (FStar_Syntax_Util.arrow (FStar_List.append binders binders') _151_1187))
in (
# 1970 "FStar.TypeChecker.Tc.fst"
let _72_2633 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1188 = (FStar_TypeChecker_Normalize.term_to_string env t)
in (FStar_Util.print1 "@@@@@@Trying to generalize universes in %s\n" _151_1188))
end else begin
()
end
in (
# 1971 "FStar.TypeChecker.Tc.fst"
let _72_2637 = (FStar_TypeChecker_Util.generalize_universes env t)
in (match (_72_2637) with
| (uvs, t) -> begin
(
# 1972 "FStar.TypeChecker.Tc.fst"
let _72_2639 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1192 = (let _151_1190 = (FStar_All.pipe_right uvs (FStar_List.map (fun u -> u.FStar_Ident.idText)))
in (FStar_All.pipe_right _151_1190 (FStar_String.concat ", ")))
in (let _151_1191 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "@@@@@@Generalized to (%s, %s)\n" _151_1192 _151_1191)))
end else begin
()
end
in (
# 1975 "FStar.TypeChecker.Tc.fst"
let _72_2643 = (FStar_Syntax_Subst.open_univ_vars uvs t)
in (match (_72_2643) with
| (uvs, t) -> begin
(
# 1976 "FStar.TypeChecker.Tc.fst"
let _72_2647 = (FStar_Syntax_Util.arrow_formals t)
in (match (_72_2647) with
| (args, _72_2646) -> begin
(
# 1977 "FStar.TypeChecker.Tc.fst"
let _72_2650 = (FStar_Util.first_N (FStar_List.length binders) args)
in (match (_72_2650) with
| (tc_types, data_types) -> begin
(
# 1978 "FStar.TypeChecker.Tc.fst"
let tcs = (FStar_List.map2 (fun _72_2654 se -> (match (_72_2654) with
| (x, _72_2653) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tc, _72_2658, tps, _72_2661, mutuals, datas, quals, r) -> begin
(
# 1980 "FStar.TypeChecker.Tc.fst"
let ty = (FStar_Syntax_Subst.close_univ_vars uvs x.FStar_Syntax_Syntax.sort)
in (
# 1981 "FStar.TypeChecker.Tc.fst"
let _72_2684 = (match ((let _151_1195 = (FStar_Syntax_Subst.compress ty)
in _151_1195.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
(
# 1983 "FStar.TypeChecker.Tc.fst"
let _72_2675 = (FStar_Util.first_N (FStar_List.length tps) binders)
in (match (_72_2675) with
| (tps, rest) -> begin
(
# 1984 "FStar.TypeChecker.Tc.fst"
let t = (match (rest) with
| [] -> begin
(FStar_Syntax_Util.comp_result c)
end
| _72_2678 -> begin
(let _151_1196 = (FStar_ST.read x.FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.tk)
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((rest, c))) _151_1196 x.FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.pos))
end)
in (tps, t))
end))
end
| _72_2681 -> begin
([], ty)
end)
in (match (_72_2684) with
| (tps, t) -> begin
FStar_Syntax_Syntax.Sig_inductive_typ ((tc, uvs, tps, t, mutuals, datas, quals, r))
end)))
end
| _72_2686 -> begin
(FStar_All.failwith "Impossible")
end)
end)) tc_types tcs)
in (
# 1996 "FStar.TypeChecker.Tc.fst"
let env_data = (FStar_TypeChecker_Env.push_univ_vars env uvs)
in (
# 1997 "FStar.TypeChecker.Tc.fst"
let uvs_universes = (FStar_All.pipe_right uvs (FStar_List.map (fun _151_1197 -> FStar_Syntax_Syntax.U_name (_151_1197))))
in (
# 1998 "FStar.TypeChecker.Tc.fst"
let env_data = (FStar_List.fold_left (fun env tc -> (FStar_TypeChecker_Env.push_sigelt_inst env tc uvs_universes)) env_data tcs)
in (
# 1999 "FStar.TypeChecker.Tc.fst"
let datas = (FStar_List.map2 (fun _72_2696 -> (match (_72_2696) with
| (t, _72_2695) -> begin
(fun _72_9 -> (match (_72_9) with
| FStar_Syntax_Syntax.Sig_datacon (l, _72_2700, _72_2702, tc, ntps, quals, mutuals, r) -> begin
(
# 2001 "FStar.TypeChecker.Tc.fst"
let ty = (match (uvs) with
| [] -> begin
t.FStar_Syntax_Syntax.sort
end
| _72_2712 -> begin
(
# 2004 "FStar.TypeChecker.Tc.fst"
let _72_2713 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1205 = (FStar_Syntax_Print.lid_to_string l)
in (let _151_1204 = (FStar_Syntax_Print.term_to_string t.FStar_Syntax_Syntax.sort)
in (FStar_Util.print2 "Rechecking datacon %s : %s\n" _151_1205 _151_1204)))
end else begin
()
end
in (
# 2006 "FStar.TypeChecker.Tc.fst"
let _72_2719 = (tc_tot_or_gtot_term env_data t.FStar_Syntax_Syntax.sort)
in (match (_72_2719) with
| (ty, _72_2717, g) -> begin
(
# 2007 "FStar.TypeChecker.Tc.fst"
let g = (
# 2007 "FStar.TypeChecker.Tc.fst"
let _72_2720 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _72_2720.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _72_2720.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _72_2720.FStar_TypeChecker_Env.implicits})
in (
# 2008 "FStar.TypeChecker.Tc.fst"
let _72_2723 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (FStar_Syntax_Subst.close_univ_vars uvs ty)))
end)))
end)
in FStar_Syntax_Syntax.Sig_datacon ((l, uvs, ty, tc, ntps, quals, mutuals, r)))
end
| _72_2727 -> begin
(FStar_All.failwith "Impossible")
end))
end)) data_types datas)
in (tcs, datas))))))
end))
end))
end)))
end))))))))
in (
# 2014 "FStar.TypeChecker.Tc.fst"
let _72_2737 = (FStar_All.pipe_right ses (FStar_List.partition (fun _72_10 -> (match (_72_10) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_72_2731) -> begin
true
end
| _72_2734 -> begin
false
end))))
in (match (_72_2737) with
| (tys, datas) -> begin
(
# 2016 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 2019 "FStar.TypeChecker.Tc.fst"
let _72_2754 = (FStar_List.fold_right (fun tc _72_2743 -> (match (_72_2743) with
| (env, all_tcs, g) -> begin
(
# 2020 "FStar.TypeChecker.Tc.fst"
let _72_2747 = (tc_tycon env tc)
in (match (_72_2747) with
| (env, tc, tc_u) -> begin
(
# 2021 "FStar.TypeChecker.Tc.fst"
let g' = (FStar_TypeChecker_Rel.universe_inequality FStar_Syntax_Syntax.U_zero tc_u)
in (
# 2022 "FStar.TypeChecker.Tc.fst"
let _72_2749 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1209 = (FStar_Syntax_Print.sigelt_to_string tc)
in (FStar_Util.print1 "Checked inductive: %s\n" _151_1209))
end else begin
()
end
in (let _151_1210 = (FStar_TypeChecker_Rel.conj_guard g g')
in (env, ((tc, tc_u))::all_tcs, _151_1210))))
end))
end)) tys (env, [], FStar_TypeChecker_Rel.trivial_guard))
in (match (_72_2754) with
| (env, tcs, g) -> begin
(
# 2029 "FStar.TypeChecker.Tc.fst"
let _72_2764 = (FStar_List.fold_right (fun se _72_2758 -> (match (_72_2758) with
| (datas, g) -> begin
(
# 2030 "FStar.TypeChecker.Tc.fst"
let _72_2761 = (tc_data env tcs se)
in (match (_72_2761) with
| (data, g') -> begin
(let _151_1213 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((data)::datas, _151_1213))
end))
end)) datas ([], g))
in (match (_72_2764) with
| (datas, g) -> begin
(
# 2035 "FStar.TypeChecker.Tc.fst"
let _72_2767 = (let _151_1214 = (FStar_List.map Prims.fst tcs)
in (generalize_and_recheck env0 g _151_1214 datas))
in (match (_72_2767) with
| (tcs, datas) -> begin
(let _151_1216 = (let _151_1215 = (FStar_TypeChecker_Env.get_range env0)
in ((FStar_List.append tcs datas), quals, lids, _151_1215))
in FStar_Syntax_Syntax.Sig_bundle (_151_1216))
end))
end))
end)))
end)))))))))

# 2038 "FStar.TypeChecker.Tc.fst"
let rec tc_decl : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.sigelt * FStar_TypeChecker_Env.env) = (fun env se -> (match (se) with
| (FStar_Syntax_Syntax.Sig_inductive_typ (_)) | (FStar_Syntax_Syntax.Sig_datacon (_)) -> begin
(FStar_All.failwith "Impossible bare data-constructor")
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, lids, r) when (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals FStar_Syntax_Const.lex_t_lid))) -> begin
(
# 2051 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2052 "FStar.TypeChecker.Tc.fst"
let se = (tc_lex_t env ses quals lids)
in (let _151_1221 = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, _151_1221))))
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, lids, r) -> begin
(
# 2056 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2057 "FStar.TypeChecker.Tc.fst"
let se = (tc_inductive env ses quals lids)
in (let _151_1222 = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, _151_1222))))
end
| FStar_Syntax_Syntax.Sig_pragma (p, r) -> begin
(match (p) with
| FStar_Syntax_Syntax.SetOptions (o) -> begin
(match ((FStar_Options.set_options o)) with
| FStar_Getopt.GoOn -> begin
(se, env)
end
| FStar_Getopt.Help -> begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Failed to process pragma: use \'fstar --help\' to see which options are available", r))))
end
| FStar_Getopt.Die (s) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error (((Prims.strcat "Failed to process pragma: " s), r))))
end)
end
| FStar_Syntax_Syntax.ResetOptions -> begin
(
# 2069 "FStar.TypeChecker.Tc.fst"
let _72_2803 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())
in (
# 2070 "FStar.TypeChecker.Tc.fst"
let _72_2805 = (let _151_1223 = (FStar_Options.reset_options ())
in (FStar_All.pipe_right _151_1223 Prims.ignore))
in (se, env)))
end)
end
| FStar_Syntax_Syntax.Sig_new_effect (ne, r) -> begin
(
# 2075 "FStar.TypeChecker.Tc.fst"
let ne = (tc_eff_decl env ne)
in (
# 2076 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_new_effect ((ne, r))
in (
# 2077 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env))))
end
| FStar_Syntax_Syntax.Sig_sub_effect (sub, r) -> begin
(
# 2081 "FStar.TypeChecker.Tc.fst"
let _72_2820 = (let _151_1224 = (FStar_TypeChecker_Env.lookup_effect_lid env sub.FStar_Syntax_Syntax.source)
in (monad_signature env sub.FStar_Syntax_Syntax.source _151_1224))
in (match (_72_2820) with
| (a, wp_a_src) -> begin
(
# 2082 "FStar.TypeChecker.Tc.fst"
let _72_2823 = (let _151_1225 = (FStar_TypeChecker_Env.lookup_effect_lid env sub.FStar_Syntax_Syntax.target)
in (monad_signature env sub.FStar_Syntax_Syntax.target _151_1225))
in (match (_72_2823) with
| (b, wp_b_tgt) -> begin
(
# 2083 "FStar.TypeChecker.Tc.fst"
let wp_a_tgt = (let _151_1229 = (let _151_1228 = (let _151_1227 = (let _151_1226 = (FStar_Syntax_Syntax.bv_to_name a)
in (b, _151_1226))
in FStar_Syntax_Syntax.NT (_151_1227))
in (_151_1228)::[])
in (FStar_Syntax_Subst.subst _151_1229 wp_b_tgt))
in (
# 2084 "FStar.TypeChecker.Tc.fst"
let expected_k = (let _151_1234 = (let _151_1232 = (FStar_Syntax_Syntax.mk_binder a)
in (let _151_1231 = (let _151_1230 = (FStar_Syntax_Syntax.null_binder wp_a_src)
in (_151_1230)::[])
in (_151_1232)::_151_1231))
in (let _151_1233 = (FStar_Syntax_Syntax.mk_Total wp_a_tgt)
in (FStar_Syntax_Util.arrow _151_1234 _151_1233)))
in (
# 2085 "FStar.TypeChecker.Tc.fst"
let lift = (check_and_gen env (Prims.snd sub.FStar_Syntax_Syntax.lift) expected_k)
in (
# 2086 "FStar.TypeChecker.Tc.fst"
let sub = (
# 2086 "FStar.TypeChecker.Tc.fst"
let _72_2827 = sub
in {FStar_Syntax_Syntax.source = _72_2827.FStar_Syntax_Syntax.source; FStar_Syntax_Syntax.target = _72_2827.FStar_Syntax_Syntax.target; FStar_Syntax_Syntax.lift = lift})
in (
# 2087 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_sub_effect ((sub, r))
in (
# 2088 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env)))))))
end))
end))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (lid, uvs, tps, c, tags, r) -> begin
(
# 2092 "FStar.TypeChecker.Tc.fst"
let _72_2840 = ()
in (
# 2093 "FStar.TypeChecker.Tc.fst"
let env0 = env
in (
# 2094 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2095 "FStar.TypeChecker.Tc.fst"
let _72_2846 = (FStar_Syntax_Subst.open_comp tps c)
in (match (_72_2846) with
| (tps, c) -> begin
(
# 2096 "FStar.TypeChecker.Tc.fst"
let _72_2850 = (tc_tparams env tps)
in (match (_72_2850) with
| (tps, env, us) -> begin
(
# 2097 "FStar.TypeChecker.Tc.fst"
let _72_2854 = (tc_comp env c)
in (match (_72_2854) with
| (c, g, u) -> begin
(
# 2098 "FStar.TypeChecker.Tc.fst"
let tags = (FStar_All.pipe_right tags (FStar_List.map (fun _72_11 -> (match (_72_11) with
| FStar_Syntax_Syntax.DefaultEffect (None) -> begin
(
# 2100 "FStar.TypeChecker.Tc.fst"
let c' = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c)
in (let _151_1237 = (FStar_All.pipe_right c'.FStar_Syntax_Syntax.effect_name (fun _151_1236 -> Some (_151_1236)))
in FStar_Syntax_Syntax.DefaultEffect (_151_1237)))
end
| t -> begin
t
end))))
in (
# 2103 "FStar.TypeChecker.Tc.fst"
let tps = (FStar_Syntax_Subst.close_binders tps)
in (
# 2104 "FStar.TypeChecker.Tc.fst"
let c = (FStar_Syntax_Subst.close_comp tps c)
in (
# 2105 "FStar.TypeChecker.Tc.fst"
let _72_2865 = (let _151_1238 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((tps, c))) None r)
in (FStar_TypeChecker_Util.generalize_universes env0 _151_1238))
in (match (_72_2865) with
| (uvs, t) -> begin
(
# 2106 "FStar.TypeChecker.Tc.fst"
let _72_2884 = (match ((let _151_1240 = (let _151_1239 = (FStar_Syntax_Subst.compress t)
in _151_1239.FStar_Syntax_Syntax.n)
in (tps, _151_1240))) with
| ([], FStar_Syntax_Syntax.Tm_arrow (_72_2868, c)) -> begin
([], c)
end
| (_72_2874, FStar_Syntax_Syntax.Tm_arrow (tps, c)) -> begin
(tps, c)
end
| _72_2881 -> begin
(FStar_All.failwith "Impossible")
end)
in (match (_72_2884) with
| (tps, c) -> begin
(
# 2110 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_effect_abbrev ((lid, uvs, tps, c, tags, r))
in (
# 2111 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env0 se)
in (se, env)))
end))
end)))))
end))
end))
end)))))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, uvs, t, quals, r) -> begin
(
# 2115 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2116 "FStar.TypeChecker.Tc.fst"
let _72_2895 = ()
in (
# 2117 "FStar.TypeChecker.Tc.fst"
let k = (let _151_1241 = (FStar_Syntax_Util.type_u ())
in (Prims.fst _151_1241))
in (
# 2118 "FStar.TypeChecker.Tc.fst"
let _72_2900 = (check_and_gen env t k)
in (match (_72_2900) with
| (uvs, t) -> begin
(
# 2119 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_declare_typ ((lid, uvs, t, quals, r))
in (
# 2120 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env)))
end)))))
end
| FStar_Syntax_Syntax.Sig_assume (lid, phi, quals, r) -> begin
(
# 2124 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2125 "FStar.TypeChecker.Tc.fst"
let _72_2913 = (FStar_Syntax_Util.type_u ())
in (match (_72_2913) with
| (k, _72_2912) -> begin
(
# 2126 "FStar.TypeChecker.Tc.fst"
let phi = (let _151_1242 = (tc_check_trivial_guard env phi k)
in (FStar_All.pipe_right _151_1242 (norm env)))
in (
# 2127 "FStar.TypeChecker.Tc.fst"
let _72_2915 = (FStar_TypeChecker_Util.check_uvars r phi)
in (
# 2128 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_assume ((lid, phi, quals, r))
in (
# 2129 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env)))))
end)))
end
| FStar_Syntax_Syntax.Sig_main (e, r) -> begin
(
# 2133 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2134 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_expected_typ env FStar_TypeChecker_Recheck.t_unit)
in (
# 2135 "FStar.TypeChecker.Tc.fst"
let _72_2928 = (tc_term env e)
in (match (_72_2928) with
| (e, c, g1) -> begin
(
# 2136 "FStar.TypeChecker.Tc.fst"
let _72_2933 = (let _151_1246 = (let _151_1243 = (FStar_Syntax_Util.ml_comp FStar_TypeChecker_Recheck.t_unit r)
in Some (_151_1243))
in (let _151_1245 = (let _151_1244 = (c.FStar_Syntax_Syntax.comp ())
in (e, _151_1244))
in (check_expected_effect env _151_1246 _151_1245)))
in (match (_72_2933) with
| (e, _72_2931, g) -> begin
(
# 2137 "FStar.TypeChecker.Tc.fst"
let _72_2934 = (let _151_1247 = (FStar_TypeChecker_Rel.conj_guard g1 g)
in (FStar_TypeChecker_Rel.force_trivial_guard env _151_1247))
in (
# 2138 "FStar.TypeChecker.Tc.fst"
let se = FStar_Syntax_Syntax.Sig_main ((e, r))
in (
# 2139 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env))))
end))
end))))
end
| FStar_Syntax_Syntax.Sig_let (lbs, r, lids, quals) -> begin
(
# 2143 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_range env r)
in (
# 2144 "FStar.TypeChecker.Tc.fst"
let check_quals_eq = (fun l qopt q -> (match (qopt) with
| None -> begin
Some (q)
end
| Some (q') -> begin
if (((FStar_List.length q) = (FStar_List.length q')) && (FStar_List.forall2 FStar_Syntax_Util.qualifier_equal q q')) then begin
Some (q)
end else begin
(let _151_1257 = (let _151_1256 = (let _151_1255 = (let _151_1254 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format1 "Inconsistent qualifier annotations on %s" _151_1254))
in (_151_1255, r))
in FStar_Syntax_Syntax.Error (_151_1256))
in (Prims.raise _151_1257))
end
end))
in (
# 2155 "FStar.TypeChecker.Tc.fst"
let _72_2978 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.fold_left (fun _72_2955 lb -> (match (_72_2955) with
| (gen, lbs, quals_opt) -> begin
(
# 2156 "FStar.TypeChecker.Tc.fst"
let lbname = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (
# 2157 "FStar.TypeChecker.Tc.fst"
let _72_2974 = (match ((FStar_TypeChecker_Env.try_lookup_val_decl env lbname)) with
| None -> begin
(gen, lb, quals_opt)
end
| Some ((uvs, tval), quals) -> begin
(
# 2161 "FStar.TypeChecker.Tc.fst"
let quals_opt = (check_quals_eq lbname quals_opt quals)
in (
# 2162 "FStar.TypeChecker.Tc.fst"
let _72_2969 = (match (lb.FStar_Syntax_Syntax.lbtyp.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
()
end
| _72_2968 -> begin
(FStar_TypeChecker_Errors.warn r "Annotation from val declaration overrides inline type annotation")
end)
in (let _151_1260 = (FStar_Syntax_Syntax.mk_lb (FStar_Util.Inr (lbname), uvs, FStar_Syntax_Const.effect_ALL_lid, tval, lb.FStar_Syntax_Syntax.lbdef))
in (false, _151_1260, quals_opt))))
end)
in (match (_72_2974) with
| (gen, lb, quals_opt) -> begin
(gen, (lb)::lbs, quals_opt)
end)))
end)) (true, [], if (quals = []) then begin
None
end else begin
Some (quals)
end)))
in (match (_72_2978) with
| (should_generalize, lbs', quals_opt) -> begin
(
# 2171 "FStar.TypeChecker.Tc.fst"
let quals = (match (quals_opt) with
| None -> begin
(FStar_Syntax_Syntax.Unfoldable)::[]
end
| Some (q) -> begin
if (FStar_All.pipe_right q (FStar_Util.for_some (fun _72_12 -> (match (_72_12) with
| (FStar_Syntax_Syntax.Irreducible) | (FStar_Syntax_Syntax.Unfoldable) | (FStar_Syntax_Syntax.Inline) -> begin
true
end
| _72_2987 -> begin
false
end)))) then begin
q
end else begin
(FStar_Syntax_Syntax.Unfoldable)::q
end
end)
in (
# 2178 "FStar.TypeChecker.Tc.fst"
let lbs' = (FStar_List.rev lbs')
in (
# 2181 "FStar.TypeChecker.Tc.fst"
let e = (let _151_1264 = (let _151_1263 = (let _151_1262 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit)) None r)
in (((Prims.fst lbs), lbs'), _151_1262))
in FStar_Syntax_Syntax.Tm_let (_151_1263))
in (FStar_Syntax_Syntax.mk _151_1264 None r))
in (
# 2184 "FStar.TypeChecker.Tc.fst"
let _72_3021 = (match ((tc_maybe_toplevel_term (
# 2184 "FStar.TypeChecker.Tc.fst"
let _72_2991 = env
in {FStar_TypeChecker_Env.solver = _72_2991.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_2991.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_2991.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_2991.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_2991.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_2991.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_2991.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_2991.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_2991.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_2991.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_2991.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = should_generalize; FStar_TypeChecker_Env.letrecs = _72_2991.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = true; FStar_TypeChecker_Env.check_uvars = _72_2991.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_2991.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_2991.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_2991.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_2991.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_2991.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_2991.FStar_TypeChecker_Env.use_bv_sorts}) e)) with
| ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_let (lbs, e); FStar_Syntax_Syntax.tk = _72_2998; FStar_Syntax_Syntax.pos = _72_2996; FStar_Syntax_Syntax.vars = _72_2994}, _72_3005, g) when (FStar_TypeChecker_Rel.is_trivial g) -> begin
(
# 2187 "FStar.TypeChecker.Tc.fst"
let quals = (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_meta (_72_3009, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Masked_effect)) -> begin
(FStar_Syntax_Syntax.HasMaskedEffect)::quals
end
| _72_3015 -> begin
quals
end)
in (FStar_Syntax_Syntax.Sig_let ((lbs, r, lids, quals)), lbs))
end
| _72_3018 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_72_3021) with
| (se, lbs) -> begin
(
# 2194 "FStar.TypeChecker.Tc.fst"
let _72_3027 = if (log env) then begin
(let _151_1270 = (let _151_1269 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (
# 2196 "FStar.TypeChecker.Tc.fst"
let should_log = (match ((let _151_1266 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (FStar_TypeChecker_Env.try_lookup_val_decl env _151_1266))) with
| None -> begin
true
end
| _72_3025 -> begin
false
end)
in if should_log then begin
(let _151_1268 = (FStar_Syntax_Print.lbname_to_string lb.FStar_Syntax_Syntax.lbname)
in (let _151_1267 = (FStar_Syntax_Print.term_to_string lb.FStar_Syntax_Syntax.lbtyp)
in (FStar_Util.format2 "let %s : %s" _151_1268 _151_1267)))
end else begin
""
end))))
in (FStar_All.pipe_right _151_1269 (FStar_String.concat "\n")))
in (FStar_Util.print1 "%s\n" _151_1270))
end else begin
()
end
in (
# 2203 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (se, env)))
end)))))
end))))
end))

# 2207 "FStar.TypeChecker.Tc.fst"
let for_export : FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_Ident.lident Prims.list) = (fun hidden se -> (
# 2232 "FStar.TypeChecker.Tc.fst"
let private_or_abstract = (fun quals -> (FStar_All.pipe_right quals (FStar_Util.for_some (fun x -> ((x = FStar_Syntax_Syntax.Private) || (x = FStar_Syntax_Syntax.Abstract))))))
in (
# 2233 "FStar.TypeChecker.Tc.fst"
let is_hidden_proj_or_disc = (fun q -> (match (q) with
| (FStar_Syntax_Syntax.Projector (l, _)) | (FStar_Syntax_Syntax.Discriminator (l)) -> begin
(FStar_All.pipe_right hidden (FStar_Util.for_some (FStar_Ident.lid_equals l)))
end
| _72_3044 -> begin
false
end))
in (match (se) with
| FStar_Syntax_Syntax.Sig_pragma (_72_3046) -> begin
([], hidden)
end
| (FStar_Syntax_Syntax.Sig_inductive_typ (_)) | (FStar_Syntax_Syntax.Sig_datacon (_)) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, _72_3057, _72_3059) -> begin
if (private_or_abstract quals) then begin
(FStar_List.fold_right (fun se _72_3065 -> (match (_72_3065) with
| (out, hidden) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (l, us, bs, t, _72_3071, _72_3073, quals, r) -> begin
(
# 2247 "FStar.TypeChecker.Tc.fst"
let dec = (let _151_1286 = (let _151_1285 = (let _151_1284 = (let _151_1283 = (let _151_1282 = (FStar_Syntax_Syntax.mk_Total t)
in (bs, _151_1282))
in FStar_Syntax_Syntax.Tm_arrow (_151_1283))
in (FStar_Syntax_Syntax.mk _151_1284 None r))
in (l, us, _151_1285, (FStar_Syntax_Syntax.Assumption)::quals, r))
in FStar_Syntax_Syntax.Sig_declare_typ (_151_1286))
in ((dec)::out, hidden))
end
| FStar_Syntax_Syntax.Sig_datacon (l, us, t, _72_3083, _72_3085, _72_3087, _72_3089, r) -> begin
(
# 2250 "FStar.TypeChecker.Tc.fst"
let dec = FStar_Syntax_Syntax.Sig_declare_typ ((l, us, t, (FStar_Syntax_Syntax.Assumption)::[], r))
in ((dec)::out, (l)::hidden))
end
| _72_3095 -> begin
(out, hidden)
end)
end)) ses ([], hidden))
end else begin
((se)::[], hidden)
end
end
| FStar_Syntax_Syntax.Sig_assume (_72_3097, _72_3099, quals, _72_3102) -> begin
if (private_or_abstract quals) then begin
([], hidden)
end else begin
((se)::[], hidden)
end
end
| FStar_Syntax_Syntax.Sig_declare_typ (l, us, t, quals, r) -> begin
if (FStar_All.pipe_right quals (FStar_Util.for_some is_hidden_proj_or_disc)) then begin
((FStar_Syntax_Syntax.Sig_declare_typ ((l, us, t, (FStar_Syntax_Syntax.Assumption)::[], r)))::[], (l)::hidden)
end else begin
if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _72_13 -> (match (_72_13) with
| (FStar_Syntax_Syntax.Assumption) | (FStar_Syntax_Syntax.Projector (_)) | (FStar_Syntax_Syntax.Discriminator (_)) -> begin
true
end
| _72_3121 -> begin
false
end)))) then begin
((se)::[], hidden)
end else begin
([], hidden)
end
end
end
| FStar_Syntax_Syntax.Sig_main (_72_3123) -> begin
([], hidden)
end
| (FStar_Syntax_Syntax.Sig_new_effect (_)) | (FStar_Syntax_Syntax.Sig_sub_effect (_)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (_)) -> begin
((se)::[], hidden)
end
| FStar_Syntax_Syntax.Sig_let ((false, lb::[]), _72_3139, _72_3141, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some is_hidden_proj_or_disc)) -> begin
(
# 2280 "FStar.TypeChecker.Tc.fst"
let lid = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in if (FStar_All.pipe_right hidden (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
([], hidden)
end else begin
(
# 2283 "FStar.TypeChecker.Tc.fst"
let dec = FStar_Syntax_Syntax.Sig_declare_typ ((lid, lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp, (FStar_Syntax_Syntax.Assumption)::[], (FStar_Ident.range_of_lid lid)))
in ((dec)::[], (lid)::hidden))
end)
end
| FStar_Syntax_Syntax.Sig_let (lbs, r, l, quals) -> begin
if (private_or_abstract quals) then begin
(let _151_1291 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (let _151_1290 = (let _151_1289 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (_151_1289, lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp, (FStar_Syntax_Syntax.Assumption)::quals, r))
in FStar_Syntax_Syntax.Sig_declare_typ (_151_1290)))))
in (_151_1291, hidden))
end else begin
((se)::[], hidden)
end
end))))

# 2292 "FStar.TypeChecker.Tc.fst"
let tc_decls : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env ses -> (
# 2293 "FStar.TypeChecker.Tc.fst"
let _72_3179 = (FStar_All.pipe_right ses (FStar_List.fold_left (fun _72_3160 se -> (match (_72_3160) with
| (ses, exports, env, hidden) -> begin
(
# 2295 "FStar.TypeChecker.Tc.fst"
let _72_3162 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _151_1298 = (FStar_Syntax_Print.sigelt_to_string se)
in (FStar_Util.print1 ">>>>>>>>>>>>>>Checking top-level decl %s\n" _151_1298))
end else begin
()
end
in (
# 2298 "FStar.TypeChecker.Tc.fst"
let _72_3166 = (tc_decl env se)
in (match (_72_3166) with
| (se, env) -> begin
(
# 2300 "FStar.TypeChecker.Tc.fst"
let _72_3167 = if ((FStar_ST.read FStar_Options.log_types) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("LogTypes")))) then begin
(let _151_1299 = (FStar_Syntax_Print.sigelt_to_string se)
in (FStar_Util.print1 "Checked: %s\n" _151_1299))
end else begin
()
end
in (
# 2303 "FStar.TypeChecker.Tc.fst"
let _72_3169 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_sig env se)
in (
# 2305 "FStar.TypeChecker.Tc.fst"
let _72_3173 = (for_export hidden se)
in (match (_72_3173) with
| (exported, hidden) -> begin
((se)::ses, (exported)::exports, env, hidden)
end))))
end)))
end)) ([], [], env, [])))
in (match (_72_3179) with
| (ses, exports, env, _72_3178) -> begin
(let _151_1300 = (FStar_All.pipe_right (FStar_List.rev exports) FStar_List.flatten)
in ((FStar_List.rev ses), _151_1300, env))
end)))

# 2310 "FStar.TypeChecker.Tc.fst"
let tc_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env modul -> (
# 2311 "FStar.TypeChecker.Tc.fst"
let name = (FStar_Util.format2 "%s %s" (if modul.FStar_Syntax_Syntax.is_interface then begin
"interface"
end else begin
"module"
end) modul.FStar_Syntax_Syntax.name.FStar_Ident.str)
in (
# 2312 "FStar.TypeChecker.Tc.fst"
let msg = (Prims.strcat "Internals for " name)
in (
# 2313 "FStar.TypeChecker.Tc.fst"
let env = (
# 2313 "FStar.TypeChecker.Tc.fst"
let _72_3184 = env
in (let _151_1305 = (not ((FStar_Options.should_verify modul.FStar_Syntax_Syntax.name.FStar_Ident.str)))
in {FStar_TypeChecker_Env.solver = _72_3184.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_3184.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_3184.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_3184.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_3184.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_3184.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_3184.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_3184.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_3184.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_3184.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_3184.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_3184.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_3184.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _72_3184.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _72_3184.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_3184.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = modul.FStar_Syntax_Syntax.is_interface; FStar_TypeChecker_Env.admit = _151_1305; FStar_TypeChecker_Env.default_effects = _72_3184.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_3184.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_3184.FStar_TypeChecker_Env.use_bv_sorts}))
in (
# 2314 "FStar.TypeChecker.Tc.fst"
let _72_3187 = if (not ((FStar_Ident.lid_equals modul.FStar_Syntax_Syntax.name FStar_Syntax_Const.prims_lid))) then begin
(env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.push msg)
end else begin
()
end
in (
# 2315 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.set_current_module env modul.FStar_Syntax_Syntax.name)
in (
# 2316 "FStar.TypeChecker.Tc.fst"
let _72_3193 = (tc_decls env modul.FStar_Syntax_Syntax.declarations)
in (match (_72_3193) with
| (ses, exports, env) -> begin
((
# 2317 "FStar.TypeChecker.Tc.fst"
let _72_3194 = modul
in {FStar_Syntax_Syntax.name = _72_3194.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = ses; FStar_Syntax_Syntax.exports = _72_3194.FStar_Syntax_Syntax.exports; FStar_Syntax_Syntax.is_interface = _72_3194.FStar_Syntax_Syntax.is_interface}), exports, env)
end))))))))

# 2319 "FStar.TypeChecker.Tc.fst"
let tc_more_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  (FStar_Syntax_Syntax.modul * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env modul decls -> (
# 2320 "FStar.TypeChecker.Tc.fst"
let _72_3202 = (tc_decls env decls)
in (match (_72_3202) with
| (ses, exports, env) -> begin
(
# 2321 "FStar.TypeChecker.Tc.fst"
let modul = (
# 2321 "FStar.TypeChecker.Tc.fst"
let _72_3203 = modul
in {FStar_Syntax_Syntax.name = _72_3203.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = (FStar_List.append modul.FStar_Syntax_Syntax.declarations ses); FStar_Syntax_Syntax.exports = _72_3203.FStar_Syntax_Syntax.exports; FStar_Syntax_Syntax.is_interface = _72_3203.FStar_Syntax_Syntax.is_interface})
in (modul, exports, env))
end)))

# 2324 "FStar.TypeChecker.Tc.fst"
let finish_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_Syntax_Syntax.sigelts  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env modul exports -> (
# 2325 "FStar.TypeChecker.Tc.fst"
let modul = (
# 2325 "FStar.TypeChecker.Tc.fst"
let _72_3209 = modul
in {FStar_Syntax_Syntax.name = _72_3209.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = _72_3209.FStar_Syntax_Syntax.declarations; FStar_Syntax_Syntax.exports = exports; FStar_Syntax_Syntax.is_interface = modul.FStar_Syntax_Syntax.is_interface})
in (
# 2326 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.finish_module env modul)
in (
# 2327 "FStar.TypeChecker.Tc.fst"
let _72_3219 = if (not ((FStar_Ident.lid_equals modul.FStar_Syntax_Syntax.name FStar_Syntax_Const.prims_lid))) then begin
(
# 2329 "FStar.TypeChecker.Tc.fst"
let _72_3213 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.pop (Prims.strcat "Ending modul " modul.FStar_Syntax_Syntax.name.FStar_Ident.str))
in (
# 2330 "FStar.TypeChecker.Tc.fst"
let _72_3215 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_modul env modul)
in (
# 2331 "FStar.TypeChecker.Tc.fst"
let _72_3217 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())
in (let _151_1318 = (FStar_Options.reset_options ())
in (FStar_All.pipe_right _151_1318 Prims.ignore)))))
end else begin
()
end
in (modul, env)))))

# 2336 "FStar.TypeChecker.Tc.fst"
let tc_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env modul -> (
# 2337 "FStar.TypeChecker.Tc.fst"
let _72_3226 = (tc_partial_modul env modul)
in (match (_72_3226) with
| (modul, non_private_decls, env) -> begin
(finish_partial_modul env modul non_private_decls)
end)))

# 2340 "FStar.TypeChecker.Tc.fst"
let add_modul_to_tcenv : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_TypeChecker_Env.env = (fun en m -> (
# 2341 "FStar.TypeChecker.Tc.fst"
let do_sigelt = (fun en elt -> (
# 2342 "FStar.TypeChecker.Tc.fst"
let env = (FStar_TypeChecker_Env.push_sigelt en elt)
in (
# 2343 "FStar.TypeChecker.Tc.fst"
let _72_3233 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_sig env elt)
in env)))
in (
# 2346 "FStar.TypeChecker.Tc.fst"
let en = (FStar_TypeChecker_Env.set_current_module en m.FStar_Syntax_Syntax.name)
in (let _151_1331 = (FStar_List.fold_left do_sigelt en m.FStar_Syntax_Syntax.exports)
in (FStar_TypeChecker_Env.finish_module _151_1331 m)))))

# 2349 "FStar.TypeChecker.Tc.fst"
let type_of : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * FStar_TypeChecker_Env.guard_t) = (fun env e -> (
# 2350 "FStar.TypeChecker.Tc.fst"
let _72_3238 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_1336 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.print1 "Checking term %s\n" _151_1336))
end else begin
()
end
in (
# 2352 "FStar.TypeChecker.Tc.fst"
let env = (
# 2352 "FStar.TypeChecker.Tc.fst"
let _72_3240 = env
in {FStar_TypeChecker_Env.solver = _72_3240.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _72_3240.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _72_3240.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _72_3240.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _72_3240.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _72_3240.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _72_3240.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _72_3240.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _72_3240.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _72_3240.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _72_3240.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _72_3240.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _72_3240.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = _72_3240.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _72_3240.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _72_3240.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _72_3240.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _72_3240.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _72_3240.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.use_bv_sorts = _72_3240.FStar_TypeChecker_Env.use_bv_sorts})
in (
# 2353 "FStar.TypeChecker.Tc.fst"
let _72_3246 = (tc_tot_or_gtot_term env e)
in (match (_72_3246) with
| (t, c, g) -> begin
if (FStar_Syntax_Util.is_total_lcomp c) then begin
(c.FStar_Syntax_Syntax.res_typ, g)
end else begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Expected a total term; got a ghost term", e.FStar_Syntax_Syntax.pos))))
end
end)))))

# 2358 "FStar.TypeChecker.Tc.fst"
let check_module : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env m -> (
# 2359 "FStar.TypeChecker.Tc.fst"
let _72_3249 = if ((let _151_1341 = (FStar_ST.read FStar_Options.debug)
in (FStar_List.length _151_1341)) <> 0) then begin
(let _151_1342 = (FStar_Syntax_Print.lid_to_string m.FStar_Syntax_Syntax.name)
in (FStar_Util.print2 "Checking %s: %s\n" (if m.FStar_Syntax_Syntax.is_interface then begin
"i\'face"
end else begin
"module"
end) _151_1342))
end else begin
()
end
in (
# 2361 "FStar.TypeChecker.Tc.fst"
let _72_3253 = (tc_modul env m)
in (match (_72_3253) with
| (m, env) -> begin
(
# 2362 "FStar.TypeChecker.Tc.fst"
let _72_3254 = if (FStar_Options.should_dump m.FStar_Syntax_Syntax.name.FStar_Ident.str) then begin
(let _151_1343 = (FStar_Syntax_Print.modul_to_string m)
in (FStar_Util.print1 "%s\n" _151_1343))
end else begin
()
end
in (m, env))
end))))



