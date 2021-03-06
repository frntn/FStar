
open Prims

let process_args : Prims.unit  ->  (FStar_Getopt.parse_cmdline_res * Prims.string Prims.list) = (fun _89_1 -> (match (()) with
| () -> begin
(FStar_Options.parse_cmd_line ())
end))


let cleanup : Prims.unit  ->  Prims.unit = (fun _89_2 -> (match (()) with
| () -> begin
(FStar_Util.kill_all ())
end))


let report_errors : Prims.unit  ->  Prims.unit = (fun _89_3 -> (match (()) with
| () -> begin
(

let errs = if (FStar_Options.universes ()) then begin
(FStar_TypeChecker_Errors.get_err_count ())
end else begin
(FStar_Tc_Errors.get_err_count ())
end
in if (errs > 0) then begin
(

let _89_5 = (let _179_7 = (FStar_Util.string_of_int errs)
in (FStar_Util.print1_error "%s errors were reported (see above)\n" _179_7))
in (FStar_All.exit 1))
end else begin
()
end)
end))


let finished_message : (Prims.bool * FStar_Ident.lident) Prims.list  ->  Prims.unit = (fun fmods -> if (not ((FStar_Options.silent ()))) then begin
(

let _89_12 = (FStar_All.pipe_right fmods (FStar_List.iter (fun _89_10 -> (match (_89_10) with
| (iface, name) -> begin
(

let tag = if iface then begin
"i\'face"
end else begin
"module"
end
in if (FStar_Options.should_print_message name.FStar_Ident.str) then begin
(let _179_11 = (FStar_Util.format2 "Verifying %s: %s\n" tag (FStar_Ident.text_of_lid name))
in (FStar_Util.print_string _179_11))
end else begin
()
end)
end))))
in (let _179_13 = (let _179_12 = (FStar_Util.colorize_bold "All verification conditions discharged successfully")
in (FStar_Util.format1 "%s\n" _179_12))
in (FStar_Util.print_string _179_13)))
end else begin
()
end)


let codegen : ((FStar_Absyn_Syntax.modul Prims.list * FStar_Tc_Env.env), (FStar_Syntax_Syntax.modul Prims.list * FStar_TypeChecker_Env.env)) FStar_Util.either  ->  Prims.unit = (fun uf_mods_env -> if (((FStar_Options.codegen ()) = Some ("OCaml")) || ((FStar_Options.codegen ()) = Some ("FSharp"))) then begin
(

let mllibs = (match (uf_mods_env) with
| FStar_Util.Inl (fmods, env) -> begin
(let _179_17 = (let _179_16 = (FStar_Extraction_ML_Env.mkContext env)
in (FStar_Util.fold_map FStar_Extraction_ML_ExtractMod.extract _179_16 fmods))
in (FStar_All.pipe_left Prims.snd _179_17))
end
| FStar_Util.Inr (umods, env) -> begin
(let _179_19 = (let _179_18 = (FStar_Extraction_ML_UEnv.mkContext env)
in (FStar_Util.fold_map FStar_Extraction_ML_Modul.extract _179_18 umods))
in (FStar_All.pipe_left Prims.snd _179_19))
end)
in (

let mllibs = (FStar_List.flatten mllibs)
in (

let ext = if ((FStar_Options.codegen ()) = Some ("FSharp")) then begin
".fs"
end else begin
".ml"
end
in (

let newDocs = (FStar_List.collect FStar_Extraction_ML_Code.doc_of_mllib mllibs)
in (FStar_List.iter (fun _89_29 -> (match (_89_29) with
| (n, d) -> begin
(let _179_22 = (FStar_Options.prepend_output_dir (Prims.strcat n ext))
in (let _179_21 = (FStar_Format.pretty 120 d)
in (FStar_Util.write_file _179_22 _179_21)))
end)) newDocs)))))
end else begin
()
end)


let go = (fun _89_30 -> (

let _89_34 = (process_args ())
in (match (_89_34) with
| (res, filenames) -> begin
(match (res) with
| FStar_Getopt.Help -> begin
(

let _89_36 = (FStar_Options.display_usage ())
in (FStar_All.exit 0))
end
| FStar_Getopt.Die (msg) -> begin
(FStar_Util.print_string msg)
end
| FStar_Getopt.GoOn -> begin
if ((FStar_Options.dep ()) <> None) then begin
(let _179_24 = (FStar_Parser_Dep.collect filenames)
in (FStar_Parser_Dep.print _179_24))
end else begin
if (FStar_Options.interactive ()) then begin
(

let filenames = if (FStar_Options.explicit_deps ()) then begin
(

let _89_41 = if ((FStar_List.length filenames) = 0) then begin
(FStar_Util.print_error "--explicit_deps was provided without a file list!\n")
end else begin
()
end
in filenames)
end else begin
(

let _89_43 = if ((FStar_List.length filenames) > 0) then begin
(FStar_Util.print_warning "ignoring the file list (no --explicit_deps)\n")
end else begin
()
end
in (FStar_Interactive.detect_dependencies_with_first_interactive_chunk ()))
end
in if (FStar_Options.universes ()) then begin
(

let _89_49 = (FStar_Universal.batch_mode_tc filenames)
in (match (_89_49) with
| (fmods, dsenv, env) -> begin
(FStar_Interactive.interactive_mode (dsenv, env) None FStar_Universal.interactive_tc)
end))
end else begin
(

let _89_53 = (FStar_Stratified.batch_mode_tc filenames)
in (match (_89_53) with
| (fmods, dsenv, env) -> begin
(FStar_Interactive.interactive_mode (dsenv, env) None FStar_Stratified.interactive_tc)
end))
end)
end else begin
if ((FStar_List.length filenames) >= 1) then begin
(

let _89_61 = if ((not ((FStar_Options.explicit_deps ()))) && (not (((FStar_Options.verify_module ()) <> [])))) then begin
(

let files = (FStar_List.map (fun f -> (match ((let _179_26 = (FStar_Util.basename f)
in (FStar_Parser_Dep.check_and_strip_suffix _179_26))) with
| None -> begin
(

let _89_56 = (FStar_Util.print1 "Unrecognized file type: %s\n" f)
in (FStar_All.exit 1))
end
| Some (f) -> begin
(FStar_String.lowercase f)
end)) filenames)
in (FStar_List.iter FStar_Options.add_verify_module files))
end else begin
()
end
in if (FStar_Options.universes ()) then begin
(

let _89_66 = (FStar_Universal.batch_mode_tc filenames)
in (match (_89_66) with
| (fmods, dsenv, env) -> begin
(

let _89_67 = (report_errors ())
in (

let _89_69 = (codegen (FStar_Util.Inr ((fmods, env))))
in (let _179_27 = (FStar_All.pipe_right fmods (FStar_List.map FStar_Universal.module_or_interface_name))
in (finished_message _179_27))))
end))
end else begin
(

let _89_74 = (FStar_Stratified.batch_mode_tc filenames)
in (match (_89_74) with
| (fmods, dsenv, env) -> begin
(

let _89_75 = (report_errors ())
in (

let _89_77 = (codegen (FStar_Util.Inl ((fmods, env))))
in (let _179_28 = (FStar_All.pipe_right fmods (FStar_List.map FStar_Stratified.module_or_interface_name))
in (finished_message _179_28))))
end))
end)
end else begin
(FStar_Util.print_error "no file provided\n")
end
end
end
end)
end)))


let main = (fun _89_79 -> (match (()) with
| () -> begin
try
(match (()) with
| () -> begin
(

let _89_98 = (go ())
in (

let _89_100 = (cleanup ())
in (FStar_All.exit 0)))
end)
with
| e -> begin
(

let _89_88 = (

let _89_84 = if (FStar_Absyn_Util.handleable e) then begin
(FStar_Absyn_Util.handle_err false () e)
end else begin
()
end
in (

let _89_86 = if (FStar_Syntax_Util.handleable e) then begin
(FStar_Syntax_Util.handle_err false e)
end else begin
()
end
in if (FStar_Options.trace_error ()) then begin
(let _179_33 = (FStar_Util.message_of_exn e)
in (let _179_32 = (FStar_Util.trace_of_exn e)
in (FStar_Util.print2_error "Unexpected error\n%s\n%s\n" _179_33 _179_32)))
end else begin
if (not (((FStar_Absyn_Util.handleable e) || (FStar_Syntax_Util.handleable e)))) then begin
(let _179_34 = (FStar_Util.message_of_exn e)
in (FStar_Util.print1_error "Unexpected error; please file a bug report, ideally with a minimized version of the source program that triggered the error.\n%s\n" _179_34))
end else begin
()
end
end))
in (

let _89_90 = (cleanup ())
in (

let _89_92 = (let _179_35 = (FStar_TypeChecker_Errors.report_all ())
in (FStar_All.pipe_right _179_35 Prims.ignore))
in (

let _89_94 = (report_errors ())
in (FStar_All.exit 1)))))
end
end))




