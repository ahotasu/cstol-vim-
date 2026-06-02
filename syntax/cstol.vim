" Vim syntax file
" Language:	CSTOL
" Maintainer:	David S Gathright <david.gathright@lasp.colorado.edu>
" URL: 
" Last Change:	2002-10-18
" Converted from ada syntax file

" This vim syntax file works on vim 5.6, 5.7, 5.8 and 6.x.
" It implements Bram Moolenaar's April 25, 2001 recommendations to make
" the syntax file maximally portable across different versions of vim.
" If vim 6.0+ is available,
" this syntax file takes advantage of the vim 6.0 advanced pattern-matching
" functions to avoid highlighting uninteresting leading spaces in
" some expressions containing "with" and "use".

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
 syntax clear
elseif exists("b:current_syntax")
 finish
endif

" CSTOL is entirely case-insensitive.
syn case ignore

" We don't need to look backwards to highlight correctly;
" this speeds things up greatly.
syn sync minlines=1 maxlines=1

" Highlighting commands.

" Standard Exceptions (including I/O).
" We'll highlight the standard exceptions, similar to vim's Python mode.
" It's possible to redefine the standard exceptions as something else,
" but doing so is very bad practice, so simply highlighting them makes sense.
"syn keyword CSTOLException Constraint_Error Program_Error Storage_Error
"syn keyword CSTOLException Tasking_Error

"if exists("CSTOL_standard_types")
  "syn keyword CSTOLBuiltinType	Long_Float Long_Long_Float
"endif

"syn keyword CSTOLOperator       abs mod not rem xor
syn match CSTOLOperator		"\<and\>"
syn match CSTOLOperator		"\<or\>"
syn match CSTOLOperator		"[-+*/<>]"
syn keyword CSTOLOperator		**
syn match CSTOLOperator		"[/<>]="
syn match CSTOLOperator		"="
syn match CSTOLOperator         "&\s*$"
syn match CSTOLOperator         "\<let\>"

" Handle the box, <>, specially:
"syn keyword CSTOLSpecial	<>

" Numbers, including floating point, exponents, and alternate bases.
syn match   CSTOLNumber		"\<\d[0-9_]*\(\.\d[0-9_]*\)\=\([Ee][+-]\=\d[0-9_]*\)\=\>"
syn match   CSTOLNumber		"\<x#[0-9A-Fa-f]\([0-9A-Fa-f]*\)\>"

" Identify leading numeric signs. In "A-5" the "-" is an operator,
" but in "A:=-5" the "-" is a sign. This handles "A3+-5" (etc.) correctly.
" This assumes that if you put a don't put a space after +/- when it's used
" as an operator, you won't put a space before it either -- which is true
" in code I've seen.
syn match CSTOLSign "[[:space:]<>=(,|:;&*/+-][+-]\d"lc=1,hs=s+1,he=e-1,me=e-1

" Labels for the goto statement.
syn match  CSTOLLabel		"^\w*:"

" Boolean Constants.
syn keyword CSTOLBoolean	TRUE FALSE

" Variables
syn match  CSTOLVar		 "$[$0-9A-Za-z_-]*"
syn keyword  CSTOLVar		 time_out

" Warn people who try to use the wrong syntax
syn match CSTOLError "=="
syn match CSTOLError "!="
syn match CSTOLError " le "
syn match CSTOLError " ge "
syn match CSTOLError " lt "
syn match CSTOLError " gt "
syn match CSTOLError " ne "
syn match CSTOLError " eq "
syn match CSTOLError "||"
syn match CSTOLError "&&"
syn match CSTOLError "%"
syn match CSTOLError "\^"
syn match CSTOLError "^.\{80,\}"

if exists("CSTOL_space_errors")
  if !exists("CSTOL_no_trail_space_error")
    syn match   CSTOLSpaceError     excludenl "\s\+$"
  endif
  if !exists("CSTOL_no_tab_space_error")
    syn match   CSTOLSpaceError     " \+\t"me=e-1
  endif
endif

" Unless special ("end loop", "end if", etc.), "end" marks the end of a
" begin, package, task etc. Assiging it to CSTOLEnd.
syn match CSTOLEnd		"\<end\>"

"syn keyword CSTOLPreproc		pragma

syn keyword CSTOLRepeat		loop 
syn match CSTOLRepeat		"\<end\s\+loop\>"

"syn keyword CSTOLSpecial	message 
"syn match CSTOLStatement        "\<send\s*message\>"
syn region  CSTOLSpecial	start="\<message\>"  end="\<send\s* message\>"

syn keyword CSTOLSpecial	fwrite check write ask cancel
syn keyword CSTOLSpecial	display clear

syn keyword CSTOLStatement	start new_proc goto proc macro run
syn keyword CSTOLStatement	decompile compile return wait
syn match CSTOLStatement        "\<end\s*proc\>"
syn match CSTOLStatement        "\<end\s*macro\>"
syn match CSTOLStatement	"\<return\s\+all\>"
syn match CSTOLStatement	"\<return\s\+wait\>"

syn match CSTOLStorageClass	"\<declare input\>"
syn match CSTOLStorageClass     "\<declare variable\>"

" Conditionals. 
syn match CSTOLConditional	"\<else\>"
syn match CSTOLConditional	"\<end\s*if\>"
syn match CSTOLConditional	"\<else if\>"
syn keyword CSTOLConditional	if 


" String and character constants.
syn region  CSTOLString		start=+"+  skip=+""+  end=+"+
syn region  CSTOLString		start=+'+  skip=+""+  end=+'+
syn match   CSTOLCharacter	"'.'"

" Todo (only highlighted in comments)
syn keyword CSTOLTodo contained	TODO FIXME XXX TBD

" Comments.
syn region  CSTOLComment	oneline contains=CSTOLTodo start=";"  end="$"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_CSTOL_syn_inits")
  if version < 508
    let did_CSTOL_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting. Can be overridden later.
  HiLink CSTOLCharacter	        Character
  HiLink CSTOLComment	        Comment
  HiLink CSTOLConditional	Conditional
  HiLink CSTOLKeyword	        Keyword
  HiLink CSTOLLabel	        Label
  HiLink CSTOLNumber	        Number
  HiLink CSTOLSign	        Number
  HiLink CSTOLOperator	        Operator
  HiLink CSTOLPreproc	        PreProc
  HiLink CSTOLRepeat	        Repeat
  HiLink CSTOLSpecial	        Special
  HiLink CSTOLStatement	        Statement
  HiLink CSTOLString	        String
  HiLink CSTOLStructure	        Structure
  HiLink CSTOLTodo	        Todo
  HiLink CSTOLType	        Type
  HiLink CSTOLTypedef	        Typedef
  HiLink CSTOLStorageClass	StorageClass
  HiLink CSTOLBoolean	        Boolean
  HiLink CSTOLException	        Exception
  HiLink CSTOLInc	        Include
  HiLink CSTOLError	        Error
  HiLink CSTOLSpaceError	Error
  HiLink CSTOLVar               Identifier
  HiLink CSTOLBuiltinType       Type

  if exists("CSTOL_begin_preproc")
   " This is the old default display:
   HiLink CSTOLBegin	PreProc
   HiLink CSTOLEnd	PreProc
  else
   " This is the new default display:
   HiLink CSTOLBegin	Keyword
   HiLink CSTOLEnd	Keyword
  endif

  delcommand HiLink
endif

let b:current_syntax = "CSTOL"

" vim: ts=8
