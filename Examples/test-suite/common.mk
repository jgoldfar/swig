#######################################################################
# SWIG test suite makefile.
# The test suite comprises many different test cases, which have
# typically produced bugs in the past. The aim is to have the test 
# cases compiling for every language modules. Some testcase have
# a runtime test which is written in each of the module's language.
#
# This makefile runs SWIG on the testcases, compiles the c/c++ code
# then builds the object code for use by the language.
# To complete a test in a language follow these guidelines: 
# 1) Add testcases to CPP_TEST_CASES (c++) or C_TEST_CASES (c) or
#    MULTI_CPP_TEST_CASES (multi-module c++ tests)
# 2) If not already done, create a makefile which:
#    a) Defines LANGUAGE matching a language rule in Examples/Makefile, 
#       for example LANGUAGE = java
#    b) Define rules for %.ctest, %.cpptest, %.multicpptest and %.clean.
#    c) Define srcdir, top_srcdir and top_builddir (these are the
#       equivalent to configure's variables of the same name).
# 3) One off special commandline options for a testcase can be added.
#    See custom tests below.
#
# The 'check' target runs the testcases including SWIG invocation,
# C/C++ compilation, target language compilation (if any) and runtime
# test (if there is an associated 'runme' test).
# The 'partialcheck' target only invokes SWIG.
# The 'all' target is the same as the 'check' target but also includes
# known broken testcases.
# The 'clean' target cleans up.
#
# Note that the RUNTOOL, COMPILETOOL and SWIGTOOL variables can be used
# for invoking tools for the runtime tests and target language 
# compiler (eg javac), and on SWIG respectively. For example, valgrind
# can be used for memory checking of the runtime tests using:
#   make RUNTOOL="valgrind --leak-check=full"
# and valgrind can be used when invoking SWIG using:
#   make SWIGTOOL="valgrind --tool=memcheck"
#
# An individual test run can be debugged easily:
#   make director_string.cpptest RUNTOOL="gdb --args"
#
# The variables below can be overridden after including this makefile
#######################################################################

#######################################################################
# Variables
#######################################################################

ifneq (,$(USE_VALGRIND))
VALGRIND_OPT = --leak-check=full
RUNTOOL    = valgrind $(VALGRIND_OPT)
else
RUNTOOL    =
endif
COMPILETOOL=
SWIGTOOL   =

SWIGEXE   = $(top_builddir)/swig
SWIG_LIB_DIR = $(top_srcdir)/Lib
TEST_SUITE = test-suite
EXAMPLES   = Examples
CXXSRCS    = 
CSRCS      = 
TARGETPREFIX = 
TARGETSUFFIX = 
SWIGOPT    = -outcurrentdir -I$(top_srcdir)/$(EXAMPLES)/$(TEST_SUITE)
INCLUDES   = -I$(top_srcdir)/$(EXAMPLES)/$(TEST_SUITE)
LIBS       = -L.
LIBPREFIX  = lib
ACTION     = check
INTERFACEDIR = ../
SRCDIR     = $(srcdir)/
SCRIPTDIR  = $(srcdir)

# This can be set to ":" on make command line to suppress progress messages.
ECHO_PROGRESS := echo

# Portable dos2unix / fromdos for stripping CR
FROMDOS    = tr -d '\r'

# Regenerate Makefile if Makefile.in or config.status have changed.
Makefile: $(srcdir)/Makefile.in ../../../config.status
	cd ../../../ && $(SHELL) ./config.status $(EXAMPLES)/$(TEST_SUITE)/$(LANGUAGE)/Makefile

#
# Please keep test cases in alphabetical order.
# Note that any whitespace after the last entry in each list will break make
#

# Broken C++ test cases. (Can be run individually using: make testcase.cpptest)
CPP_TEST_BROKEN += \
	constants \
	director_nested_class \
	exception_partial_info \
	extend_variable \
	li_boost_shared_ptr_template \
	nested_private \
	template_default_pointer \
	$(CPP11_TEST_BROKEN) \
	$(CPP14_TEST_BROKEN) \
	$(CPP17_TEST_BROKEN) \
	$(CPP20_TEST_BROKEN)


# Broken C test cases. (Can be run individually using: make testcase.ctest)
C_TEST_BROKEN += \
	tag_no_clash_with_variable \

# C++ test cases. (Can be run individually using: make testcase.cpptest)
CPP_TEST_CASES += \
	abstract_access \
	abstract_basecast \
	abstract_inherit \
	abstract_inherit_ok \
	abstract_inherit_using \
	abstract_signature \
	abstract_typedef \
	abstract_typedef2 \
	abstract_virtual \
	access_change \
	add_link \
	aggregate \
	allowexcept \
	allprotected \
	allprotected_not \
	anonymous_bitfield \
	apply_signed_char \
	apply_strings \
	apply_typemap_typedefs \
	argcargvtest \
	argout \
	array_member \
	array_typedef_memberin \
	arrayref \
	arrays_dimensionless \
	arrays_global \
	arrays_global_twodim \
	arrays_scope \
	assign_const \
	assign_reference \
	autodoc \
	begin_code \
	bloody_hell \
	bools \
	catches \
	catches_strings \
	cast_operator \
	casts \
	char_binary \
	char_binary_rev_len \
	char_strings \
	chartest \
	class_case \
	class_scope_namespace \
	class_forward \
	class_ignore \
	class_scope_weird \
	compactdefaultargs \
	const_const_2 \
	constant_directive \
	constant_expr \
	constant_pointers \
	constover \
	constructor_copy \
	constructor_copy_non_const \
	constructor_exception \
	constructor_explicit \
	constructor_ignore \
	constructor_rename \
	constructor_value \
	contract \
	conversion \
	conversion_namespace \
	conversion_ns_template \
	conversion_operators \
	copyctor \
	cplusplus_throw \
	cpp_basic \
	cpp_enum \
	cpp_namespace \
	cpp_nodefault \
	cpp_parameters \
	cpp_static \
	cpp_typedef \
	curiously_recurring_template_pattern \
	default_args \
	default_arg_expressions \
	default_arg_values \
	default_constructor \
	defvalue_constructor \
	derived_byvalue \
	derived_nested \
	destructor_methodmodifiers \
	destructor_reprotected \
	director_abstract \
	director_alternating \
	director_basic \
	director_binary_string \
	director_binary_string_rev_len \
	director_classes \
	director_classic \
	director_constructor \
	director_comparison_operators \
	director_conversion_operators \
	director_default \
	director_detect \
	director_enum \
	director_exception \
	director_exception_catches \
	director_exception_nothrow \
	director_extend \
	director_finalizer \
	director_frob \
	director_ignore \
	director_keywords \
	director_multiple_inheritance \
	director_namespace_clash \
	director_nested \
	director_nspace \
	director_nspace_director_name_collision \
	director_overload \
	director_overload2 \
	director_ownership \
	director_pass_by_value \
	director_primitives \
	director_property \
	director_protected \
	director_protected_overloaded \
	director_redefined \
	director_ref \
	director_simple \
	director_smartptr \
	director_template \
	director_thread \
	director_unroll \
	director_unwrap_result \
	director_using \
	director_using_member_scopes \
	director_void \
	director_wombat \
	disown \
	duplicate_class_name_in_ns \
	duplicate_parm_names \
	dynamic_cast \
	empty \
	enum_ignore \
	enum_plus \
	enum_rename \
	enum_scope_template \
	enum_template \
	enum_thorough \
	enum_var \
	equality \
	evil_diamond \
	evil_diamond_ns \
	evil_diamond_prop \
	exception_classname \
	exception_memory_leak \
	exception_order \
	extend \
	extend_constructor_destructor \
	extend_default \
	extend_placement \
	extend_special_variables \
	extend_template \
	extend_template_method \
	extend_template_ns \
	extend_typedef_class \
	extern_c \
	extern_namespace \
	extern_throws \
	expressions \
	features \
	fragments \
	friends \
	friends_nested \
	friends_operator_overloading \
	friends_template \
	funcptr_cpp \
	functors \
	fvirtual \
	global_immutable_vars_cpp \
	global_namespace \
	global_ns_arg \
	global_scope_types \
	global_vars \
	grouping \
	ignore_parameter \
	import_fragments \
	import_nomodule \
	inherit \
	inherit_member \
	inherit_missing \
	inherit_same_name \
	inherit_target_language \
	inherit_void_arg \
	inline_initializer \
	inout_typemaps \
	insert_directive \
	keyword_rename \
	kind \
	kwargs_feature \
	langobj \
	li_attribute \
	li_attribute_template \
	li_boost_shared_ptr \
	li_boost_shared_ptr_attribute \
	li_boost_shared_ptr_bits \
	li_boost_shared_ptr_director \
	li_boost_shared_ptr_template \
	li_carrays_cpp \
	li_cdata_cpp \
	li_cpointer_cpp \
	li_std_auto_ptr \
	li_stdint \
	li_swigtype_inout \
	li_typemaps \
	li_typemaps_apply \
	li_windows \
	long_long_apply \
	memberin_extend \
	member_funcptr_galore \
	member_pointer \
	member_pointer_const \
	member_template \
	minherit \
	minherit2 \
	mixed_types \
	multiple_inheritance \
	multiple_inheritance_abstract \
	multiple_inheritance_interfaces \
	multiple_inheritance_nspace \
	multiple_inheritance_overload \
	multiple_inheritance_shared_ptr \
	name_cxx \
	name_warnings \
	namespace_chase \
	namespace_class \
	namespace_enum \
	namespace_extend \
	namespace_forward_declaration \
	namespace_nested \
	namespace_spaces \
	namespace_struct \
	namespace_template \
	namespace_typedef_class \
	namespace_typemap \
	namespace_union \
	namespace_virtual_method \
	native_directive \
	naturalvar \
	naturalvar_more \
	naturalvar_onoff \
	nested_class \
	nested_directors \
	nested_comment \
	nested_ignore \
	nested_inheritance_interface \
	nested_in_template \
	nested_scope_flat \
	nested_template_base \
	nested_workaround \
	newobject1 \
	newobject3 \
	nspace \
	nspace_extend \
	nspacemove \
	nspacemove_nested \
	nspacemove_stl \
	null_pointer \
	numeric_bounds_checking \
	operator_overload \
	operator_overload_break \
	operator_pointer_ref \
	operbool \
	ordering \
	overload_arrays \
	overload_bool \
	overload_complicated \
	overload_copy \
	overload_extend \
	overload_method \
	overload_numeric \
	overload_null \
	overload_polymorphic \
	overload_rename \
	overload_return_type \
	overload_simple \
	overload_subtype \
	overload_template \
	overload_template_fast \
	pointer_reference \
	preproc_constants \
	preproc_cpp \
	preproc_predefined_stdcpp \
	primitive_ref \
	private_assign \
	proxycode \
	protected_rename \
	pure_virtual \
	redefined \
	redefined_not \
	refcount \
	reference_global_vars \
	rename1 \
	rename2 \
	rename3 \
	rename4 \
	rename_camel \
	rename_rstrip_encoder \
	rename_scope \
	rename_simple \
	rename_strip_encoder \
	rename_pcre_encoder \
	rename_pcre_enum \
	rename_predicates \
	rename_wildcard \
	restrict_cplusplus \
	return_const_value \
	return_value_scope \
	rname \
	samename \
	sizet \
	smart_pointer_const \
	smart_pointer_const2 \
	smart_pointer_const_overload \
	smart_pointer_extend \
	smart_pointer_ignore \
	smart_pointer_member \
	smart_pointer_multi \
	smart_pointer_multi_typedef \
	smart_pointer_namespace \
	smart_pointer_namespace2 \
	smart_pointer_not \
	smart_pointer_overload \
	smart_pointer_protected \
	smart_pointer_rename \
	smart_pointer_simple \
	smart_pointer_static \
	smart_pointer_template_const_overload \
	smart_pointer_template_defaults_overload \
	smart_pointer_templatemethods \
	smart_pointer_templatevariables \
	smart_pointer_typedef \
	special_variables \
	special_variable_attributes \
	special_variable_macros \
	static_array_member \
	static_const_member \
	static_const_member_2 \
	stl_no_default_constructor \
	string_constants \
	struct_initialization_cpp \
	struct_value \
	swig_exception \
	symbol_clash \
	sym \
	template_arg_replace \
	template_arg_scope \
	template_arg_typename \
	template_array_numeric \
	template_basic \
	template_base_template \
	template_classes \
	template_class_reuse_name \
	template_const_ref \
	template_construct \
	template_templated_constructors \
	template_default \
	template_default2 \
	template_default_arg \
	template_default_arg_overloaded \
	template_default_arg_overloaded_extend \
	template_default_arg_virtual_destructor \
	template_default_cache \
	template_default_class_parms \
	template_default_class_parms_typedef \
	template_default_inherit \
	template_default_qualify \
	template_default_vw \
	template_duplicate \
	template_empty_inherit \
	template_enum \
	template_enum_ns_inherit \
	template_enum_typedef \
	template_explicit \
	template_expr \
	template_extend1 \
	template_extend2 \
	template_extend_overload \
	template_extend_overload_2 \
	template_function_parm \
	template_forward \
	template_inherit \
	template_inherit_abstract \
	template_int_const \
	template_keyword_in_type \
	template_methods \
	template_namespace_forward_declaration \
	template_private_assignment \
	template_using_directive_and_declaration_forward \
	template_using_directive_typedef \
	template_using_member_default_arg \
	template_nested \
	template_nested_flat \
	template_nested_typemaps \
	template_ns \
	template_ns2 \
	template_ns3 \
	template_ns4 \
	template_ns_enum \
	template_ns_enum2 \
	template_ns_inherit \
	template_ns_scope \
	template_parameters_global_scope \
	template_partial_arg \
	template_partial_specialization \
	template_partial_specialization_more \
	template_partial_specialization_typedef \
	template_qualifier \
	template_ref_type \
	template_rename \
	template_retvalue \
	template_specialization \
	template_specialization_defarg \
	template_specialization_enum \
	template_specialization_using_declaration \
	template_static \
	template_tbase_template \
	template_template_parameters \
	template_template_template_parameters \
	template_type_collapse \
	template_typedef \
	template_typedef_class_template \
	template_typedef_cplx \
	template_typedef_cplx2 \
	template_typedef_cplx3 \
	template_typedef_cplx4 \
	template_typedef_cplx5 \
	template_typedef_funcptr \
	template_typedef_inherit \
	template_typedef_ns \
	template_typedef_ptr \
	template_typedef_rec \
	template_typedef_typedef \
	template_typemaps \
	template_typemaps_typedef \
	template_typemaps_typedef2 \
	template_using \
	template_virtual \
	template_whitespace \
	threads \
	threads_exception \
	throw_exception \
	typedef_array_member \
	typedef_class \
	typedef_classforward_same_name \
	typedef_funcptr \
	typedef_inherit \
	typedef_mptr \
	typedef_reference \
	typedef_scope \
	typedef_sizet \
	typedef_struct_cpp \
	typedef_typedef \
	typemap_arrays \
	typemap_array_qualifiers \
	typemap_delete \
	typemap_directorout \
	typemap_documentation \
	typemap_global_scope \
	typemap_isvoid \
	typemap_manyargs \
	typemap_namespace \
	typemap_ns_using \
	typemap_numinputs \
	typemap_template \
	typemap_template_parm_typedef \
	typemap_template_parms \
	typemap_template_typedef \
	typemap_out_optimal \
	typemap_qualifier_strip \
	typemap_variables \
	typemap_various \
	typename \
	types_directive \
	unicode_strings \
	union_scope \
	using1 \
	using2 \
	using_composition \
	using_directive_and_declaration \
	using_directive_and_declaration_forward \
	using_extend \
	using_extend_flatten \
	using_inherit \
	using_member \
	using_member_multiple_inherit \
	using_member_scopes \
	using_namespace \
	using_namespace_loop \
	using_pointers \
	using_private \
	using_protected \
	valuewrapper \
	valuewrapper_base \
	valuewrapper_const \
	valuewrapper_opaque \
	varargs \
	varargs_overload \
	variable_replacement \
	virtual_destructor \
	virtual_derivation \
	virtual_poly \
	virtual_vs_nonvirtual_base \
	voidtest \
	wallkw \
	wrapmacro \

# C++11 test cases.
CPP11_TEST_CASES += \
	cpp11_alias_nested_template_scoping \
	cpp11_alignment \
	cpp11_alternate_function_syntax \
	cpp11_assign_delete \
	cpp11_assign_rvalue_reference \
	cpp11_attribute_specifiers \
	cpp11_auto_variable \
	cpp11_brackets_expression \
	cpp11_constexpr \
	cpp11_constexpr_friend \
	cpp11_copyctor_delete \
	cpp11_decltype \
	cpp11_default_delete \
	cpp11_delegating_constructors \
	cpp11_director_enums \
	cpp11_director_using_constructor \
	cpp11_directors \
	cpp11_explicit_conversion_operators \
	cpp11_final_class \
	cpp11_final_directors \
	cpp11_final_override \
	cpp11_function_objects \
	cpp11_inheriting_constructors \
	cpp11_initializer_list \
	cpp11_initializer_list_extend \
	cpp11_lambda_functions \
        cpp11_move_only \
        cpp11_move_typemaps \
        cpp11_move_only_valuewrapper \
	cpp11_noexcept \
	cpp11_null_pointer_constant \
	cpp11_raw_string_literals \
	cpp11_ref_qualifiers \
	cpp11_ref_qualifiers_rvalue_unignore \
	cpp11_ref_qualifiers_typemaps \
	cpp11_result_of \
	cpp11_rvalue_reference \
	cpp11_rvalue_reference2 \
	cpp11_rvalue_reference3 \
	cpp11_rvalue_reference_move \
	cpp11_sizeof_object \
	cpp11_static_assert \
	cpp11_std_array \
	cpp11_std_unique_ptr \
	cpp11_strongly_typed_enumerations \
	cpp11_thread_local \
	cpp11_template_double_brackets \
	cpp11_template_explicit \
	cpp11_template_parameters_decltype \
	cpp11_template_templated_methods \
	cpp11_template_typedefs \
	cpp11_type_traits \
	cpp11_type_aliasing \
	cpp11_uniform_initialization \
	cpp11_unrestricted_unions \
	cpp11_userdefined_literals \
	cpp11_using_constructor \
	cpp11_using_typedef_struct \
	cpp11_variadic_function_templates \
	cpp11_variadic_templates \

# Broken C++11 test cases.
CPP11_TEST_BROKEN = \
#	cpp11_reference_wrapper \     # No typemaps

# C++14 test cases.
CPP14_TEST_CASES += \
	cpp14_auto_return_type \
	cpp14_binary_integer_literals \

# Broken C++14 test cases.
CPP14_TEST_BROKEN = \

# C++17 test cases.
CPP17_TEST_CASES += \
	cpp17_director_string_view \
	cpp17_enable_if_t \
	cpp17_hex_floating_literals \
	cpp17_map_no_default_ctor \
	cpp17_nested_namespaces \
	cpp17_nspace_nested_namespaces \
	cpp17_string_view \
	cpp17_u8_char_literals \

# Broken C++17 test cases.
CPP17_TEST_BROKEN = \

# C++20 test cases.
CPP20_TEST_CASES += \
	cpp20_constexpr_destructor \
	cpp20_lambda_template \
	cpp20_spaceship_operator \

# Broken C++20 test cases.
CPP20_TEST_BROKEN = \

# Doxygen support test cases: can only be used with languages supporting
# Doxygen comment translation (currently a subset of languages) and only if not
# disabled by configure via SKIP_DOXYGEN_TEST_CASES.
ifneq ($(SKIP_DOXYGEN_TEST_CASES),1)
csharp_HAS_DOXYGEN := 1
java_HAS_DOXYGEN := 1
python_HAS_DOXYGEN := 1

HAS_DOXYGEN := $($(LANGUAGE)_HAS_DOXYGEN)
endif

ifdef HAS_DOXYGEN
DOXYGEN_TEST_CASES += \
	doxygen_alias \
	doxygen_autodoc_docstring \
	doxygen_basic_notranslate \
	doxygen_basic_translate \
	doxygen_basic_translate_style2 \
	doxygen_basic_translate_style3 \
	doxygen_code_blocks \
	doxygen_ignore \
	doxygen_misc_constructs \
	doxygen_nested_class \
	doxygen_overloads \
	doxygen_parsing \
	doxygen_parsing_enums \
	doxygen_translate \
	doxygen_translate_all_tags \
	doxygen_translate_links \

$(DOXYGEN_TEST_CASES:=.cpptest): SWIGOPT += -doxygen

CPP_TEST_CASES += $(DOXYGEN_TEST_CASES)
endif

#
# Put all the heavy STD/STL cases here, where they can be skipped if needed
#
CPP_STD_TEST_CASES += \
	director_string \
	ignore_template_constructor \
	li_std_combinations \
	li_std_containers_overload \
	li_std_deque \
	li_std_except \
	li_std_except_as_class \
	li_std_map \
	li_std_pair \
	li_std_pair_using \
	li_std_string \
	li_std_vector \
	li_std_vector_back_reference \
	li_std_vector_enum \
	li_std_vector_member_var\
	li_std_vector_ptr \
	li_std_vector_vector \
	li_std_wstring \
	smart_pointer_inherit \
	template_typedef_fnc \
	template_type_namespace \
	template_opaque \

ifndef SKIP_CPP_STD_CASES
CPP_TEST_CASES += ${CPP_STD_TEST_CASES}
endif

ifeq (1,$(HAVE_CXX11))
CPP_TEST_CASES += $(CPP11_TEST_CASES)
endif

ifeq (1,$(HAVE_CXX14))
CPP_TEST_CASES += $(CPP14_TEST_CASES)
endif

ifeq (1,$(HAVE_CXX17))
CPP_TEST_CASES += $(CPP17_TEST_CASES)
endif

ifeq (1,$(HAVE_CXX20))
CPP_TEST_CASES += $(CPP20_TEST_CASES)
endif

# C test cases. (Can be run individually using: make testcase.ctest)
C_TEST_CASES += \
	arrays \
	bom_utf8 \
	c_delete \
	c_delete_function \
	char_constant \
	command_line_define \
	const_const \
	constant_expr_c \
	contract_c \
	default_args_c \
	empty_c \
	enums \
	enum_forward \
	enum_macro \
	enum_missing \
	extern_declaration \
	final_c \
	funcptr \
	function_typedef \
	global_functions \
	global_immutable_vars \
	immutable_values \
	inctest \
	infinity \
	integers \
	keyword_rename_c \
	lextype \
	li_carrays \
	li_cdata \
	li_cmalloc \
	li_constraints \
	li_cpointer \
	li_math \
	long_long \
	memberin_extend_c \
	name \
	nested \
	nested_extend_c \
	nested_structs \
	newobject2 \
	not_c_keywords \
	overload_extend_c \
	overload_extend2 \
	preproc \
	preproc_constants_c \
	preproc_defined \
	preproc_expr \
	preproc_gcc_output \
	preproc_include \
	preproc_line_file \
	preproc_predefined \
	preproc_predefined_stdc \
	register_par \
	ret_by_value \
	simple_array \
	sizeof_pointer \
	sneaky1 \
	string_simple \
	struct_rename \
	struct_initialization \
	typedef_classforward_same_name \
	typedef_struct \
	typemap_subst \
	union_parameter \
	unions \


# Multi-module C++ test cases . (Can be run individually using make testcase.multicpptest)
MULTI_CPP_TEST_CASES += \
	clientdata_prop \
	import_stl \
	imports \
	mod \
	multi_import \
	packageoption \
	template_typedef_import \

# Custom tests - tests with additional commandline options
wallkw.cpptest: SWIGOPT += -Wallkw
preproc_include.ctest: SWIGOPT += -includeall
command_line_define.ctest: SWIGOPT += -DFOO -DBAR=123 -DBAZ -UBAZ -UNOTSET
preproc_predefined_stdc.ctest: SWIGOPT += -std=c23
preproc_predefined_stdcpp.cpptest: SWIGOPT += -std=c++23

# Allow modules to define temporarily failing tests.
C_TEST_CASES := $(filter-out $(FAILING_C_TESTS),$(C_TEST_CASES))
CPP_TEST_CASES := $(filter-out $(FAILING_CPP_TESTS),$(CPP_TEST_CASES))
CPP11_TEST_CASES := $(filter-out $(FAILING_CPP_TESTS),$(CPP11_TEST_CASES))
CPP14_TEST_CASES := $(filter-out $(FAILING_CPP_TESTS),$(CPP14_TEST_CASES))
CPP17_TEST_CASES := $(filter-out $(FAILING_CPP_TESTS),$(CPP17_TEST_CASES))
CPP20_TEST_CASES := $(filter-out $(FAILING_CPP_TESTS),$(CPP20_TEST_CASES))
MULTI_CPP_TEST_CASES := $(filter-out $(FAILING_MULTI_CPP_TESTS),$(MULTI_CPP_TEST_CASES))


NOT_BROKEN_TEST_CASES =	$(CPP_TEST_CASES:=.cpptest) \
			$(C_TEST_CASES:=.ctest) \
			$(MULTI_CPP_TEST_CASES:=.multicpptest) \
			$(EXTRA_TEST_CASES)

BROKEN_TEST_CASES = 	$(CPP_TEST_BROKEN:=.cpptest) \
			$(C_TEST_BROKEN:=.ctest)

ALL_CLEAN = 		$(CPP_TEST_CASES:=.clean) \
			$(CPP11_TEST_CASES:=.clean) \
			$(CPP14_TEST_CASES:=.clean) \
			$(CPP17_TEST_CASES:=.clean) \
			$(CPP20_TEST_CASES:=.clean) \
			$(C_TEST_CASES:=.clean) \
			$(MULTI_CPP_TEST_CASES:=.clean) \
			$(CPP_TEST_BROKEN:=.clean) \
			$(C_TEST_BROKEN:=.clean)

#######################################################################
# Error test suite has its own set of test cases
#######################################################################
ifneq (,$(ERROR_TEST_CASES))
check: $(ERROR_TEST_CASES)
else

#######################################################################
# The following applies for all module languages
#######################################################################
all: $(NOT_BROKEN_TEST_CASES) $(BROKEN_TEST_CASES)

broken: $(BROKEN_TEST_CASES)

check: $(NOT_BROKEN_TEST_CASES)
	@echo $(words $^) $(LANGUAGE) tests passed

check-c: $(C_TEST_CASES:=.ctest)

check-cpp: $(CPP_TEST_CASES:=.cpptest)

check-cpp11: $(CPP11_TEST_CASES:=.cpptest)

check-cpp14: $(CPP14_TEST_CASES:=.cpptest)

check-cpp17: $(CPP17_TEST_CASES:=.cpptest)

check-cpp20: $(CPP20_TEST_CASES:=.cpptest)

check-multicpp: $(MULTI_CPP_TEST_CASES:=.multicpptest)

ifdef HAS_DOXYGEN
check-doxygen: $(DOXYGEN_TEST_CASES:=.cpptest)
endif

check-failing-test = \
	$(MAKE) -s $1.$2 >/dev/null 2>/dev/null && echo "Failing test $1 passed."

check-failing:
	+-$(foreach t,$(FAILING_C_TESTS),$(call check-failing-test,$t,ctest);)
	+-$(foreach t,$(FAILING_CPP_TESTS),$(call check-failing-test,$t,cpptest);)
	+-$(foreach t,$(FAILING_MULTI_CPP_TESTS),$(call check-failing-test,$t,multicpptest);)
endif

# partialcheck target runs SWIG only, ie no compilation or running of tests (for a subset of languages)
partialcheck:
	$(MAKE) check CC=true CXX=true LDSHARED=true CXXSHARED=true RUNTOOL=true COMPILETOOL=true

swig_and_compile_cpp_helper = \
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile SRCDIR='$(SRCDIR)' CXXSRCS='$(CXXSRCS)' \
	SWIG_LIB_DIR='$(SWIG_LIB_DIR)' SWIGEXE='$(SWIGEXE)' \
	LIBS='$(LIBS)' INCLUDES='$(INCLUDES)' SWIGOPT=$(2) NOLINK=true \
	TARGET="$(TARGETPREFIX)$(1)$(TARGETSUFFIX)" INTERFACEDIR='$(INTERFACEDIR)' INTERFACE="$(1).i" \
	$(LANGUAGE)$(VARIANT)_cpp

swig_and_compile_cpp =  \
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile SRCDIR='$(SRCDIR)' CXXSRCS='$(CXXSRCS)' \
	SWIG_LIB_DIR='$(SWIG_LIB_DIR)' SWIGEXE='$(SWIGEXE)' \
	INCLUDES='$(INCLUDES)' SWIGOPT='$(SWIGOPT)' NOLINK=true \
	TARGET='$(TARGETPREFIX)$*$(TARGETSUFFIX)' INTERFACEDIR='$(INTERFACEDIR)' INTERFACE='$*.i' \
	$(LANGUAGE)$(VARIANT)_cpp

swig_and_compile_c =  \
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile SRCDIR='$(SRCDIR)' CSRCS='$(CSRCS)' \
	SWIG_LIB_DIR='$(SWIG_LIB_DIR)' SWIGEXE='$(SWIGEXE)' \
	INCLUDES='$(INCLUDES)' SWIGOPT='$(SWIGOPT)' NOLINK=true \
	TARGET='$(TARGETPREFIX)$*$(TARGETSUFFIX)' INTERFACEDIR='$(INTERFACEDIR)' INTERFACE='$*.i' \
	$(LANGUAGE)$(VARIANT)

swig_and_compile_multi_cpp = \
	for f in `cat $(top_srcdir)/$(EXAMPLES)/$(TEST_SUITE)/$*.list | $(FROMDOS)` ; do \
	  $(call swig_and_compile_cpp_helper,$${f},'$(SWIGOPT)'); \
	done

swig_and_compile_external =  \
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile SRCDIR='$(SRCDIR)' \
	SWIG_LIB_DIR='$(SWIG_LIB_DIR)' SWIGEXE='$(SWIGEXE)' \
	TARGET='$*_wrap_hdr.h' \
	$(LANGUAGE)$(VARIANT)_externalhdr && \
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile SRCDIR='$(SRCDIR)' CXXSRCS='$(CXXSRCS) $*_external.cxx' \
	SWIG_LIB_DIR='$(SWIG_LIB_DIR)' SWIGEXE='$(SWIGEXE)' \
	INCLUDES='$(INCLUDES)' SWIGOPT='$(SWIGOPT)' NOLINK=true \
	TARGET='$(TARGETPREFIX)$*$(TARGETSUFFIX)' INTERFACEDIR='$(INTERFACEDIR)' INTERFACE='$*.i' \
	$(LANGUAGE)$(VARIANT)_cpp

swig_and_compile_runtime = \

setup = \
	if [ -f $(SCRIPTDIR)/$(SCRIPTPREFIX)$*$(SCRIPTSUFFIX) ]; then	  \
	  $(ECHO_PROGRESS) "$(ACTION)ing $(LANGUAGE) testcase $* (with run test)" ; \
	else								  \
	  $(ECHO_PROGRESS) "$(ACTION)ing $(LANGUAGE) testcase $*" ;		  \
	fi

#######################################################################
# Clean
#######################################################################
clean: $(ALL_CLEAN)

distclean: clean
	@rm -f Makefile

.PHONY: all check partialcheck broken clean distclean 

