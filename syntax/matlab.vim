" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" Flow Control
syn region  matlabIfExpression     matchgroup=matlabFlowControl start="\<if\>"     end="\<end\>"
syn region  matlabForExpression    matchgroup=matlabFlowControl start="\<for\>"    end="\<end\>"
syn region  matlabParforExpression matchgroup=matlabFlowControl start="\<parfor\>" end="\<end\>"
syn region  matlabSwitchExpression matchgroup=matlabFlowControl start="\<switch\>" end="\<end\>"
syn region  matlabTryExpression    matchgroup=matlabFlowControl start="\<try\>"    end="\<end\>"
syn region  matlabWhileExpression  matchgroup=matlabFlowControl start="\<while\>"  end="\<end\>"

syn match   matlabFlowControl "\<\%(elseif\|else\)\>"    contained containedin=matlabIfExpression
syn match   matlabFlowControl "\<\%(case\|otherwise\)\>" contained containedin=matlabSwitchExpression
syn match   matlabFlowControl "\<catch\>"                contained containedin=matlabTryExpression

" Function Declaration
syn match   matlabFunctionName "\%([a-z][A-Za-z0-9_]*\|\[[a-z][A-Za-z0-9]*\%(,\s*[a-z][A-Za-z0-9]*\)*\]\)\s*=\s*\zs[a-z][A-Za-z0-9]*" contained containedin=matlabFunctionDeclaration
syn region  matlabFunctionDeclaration matchgroup=matlabFunctiondef start="\<function\>" end="\<end\>" end="\%$"

" Class Declaration
syn match   matlabClassName "\<[A-Z][A-Za-z0-9]*\>"
syn match   matlabClassdef  "\<classdef\>" skipwhite skipnl nextgroup=matlabClassName
syn region  matlabClassDeclaration matchgroup=matlabClassdef  start="\<classdef\>" end="\<end\>"
syn region  matlabClassAttribution matchgroup=matlabClassAttr start="\<\%(properties\|methods\|events\|enumeration\)\>" end="\<end\>" contained containedin=matlabClassDeclaration

" Other Keywords
syn keyword matlabKeyword pause return

" Number
syn match   matlabNumber "\%(\%(\w\|[]})\"']\s*\)\@<![+-]\)\=\.\d\+\%([dDeE][-+]\=\d\+\)\=[ij]\=\>" display
syn match   matlabNumber "\%(\%(\w\|[]})\"']\s*\)\@<![+-]\)\=\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([dDeE][-+]\=\d\+\)\=[ij]\=\>" display
syn keyword matlabNumber pi

" Functions
let s:function_dict = globpath(&runtimepath, 'dict/matlab/functions.dict', 1)
for line in readfile(s:function_dict)
  let list = split(line, '\t', 1)
  if len(list) >= 1
    let function_name = list[0]
  else
    continue
  endif
  let com = printf('syn keyword matlabFunction %s', function_name)
  execute com
endfor

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_matlab_syntax_inits")
  if version < 508
    let did_matlab_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink matlabFlowControl  Statement
  HiLink matlabFunctionName Function
  HiLink matlabFunctiondef  Define
  HiLink matlabClassName    Type
  HiLink matlabClassdef     Define
  HiLink matlabNumber       Number
  HiLink matlabFunction     Function

  HiLink matlabString            String
  HiLink matlabCharacter         String
  HiLink matlabStringSequence    SpecialChar
  HiLink matlabCharacterSequence SpecialChar
  HiLink matlabOperator          Operator
  HiLink matlabBoolean           Boolean
  HiLink matlabSemicolon         SpecialChar
  HiLink matlabComment           Comment
  HiLink matlabTODO              TODO
  HiLink matlabFunction          Function

  delcommand HiLink
endif

let b:current_syntax = "matlab"

let &cpo = s:save_cpo
unlet s:save_cpo
