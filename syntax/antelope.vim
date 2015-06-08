" Antelope pf syntax file
" Filename:     antelope.vim
" Language:     Antelope configuration file
" Maintainer:   UC San Diego Array Network Facility
" URL:          https://github.com/UCSD-ANF/vim-antelope
" Last Change:
" Version:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" match anything between simple/double quotes.
syn region  antelopeString        start=+'+ skip=+\\\\\|\\'+ end=+'+
syn region  antelopeString        start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=antelopeVariable,antelopeNotVariable

" Parameters per `man rtexec` and/or `pfecho rtexec`...
syn keyword rtexecParams Buttons Chatter_limit Database Defines Edit_files
syn keyword rtexecParams Env Failure_repetitions Failure_retry_period
syn keyword rtexecParams Failure_threshold Limit Maximum_memory_in_use
syn keyword rtexecParams Minimum_period_between_starts Parameter_files
syn keyword rtexecParams Pf_restart Processes Run Shutdown_order
syn keyword rtexecParams Shutdown_tasks Shutdown_when_task_dies Start_period
syn keyword rtexecParams Startup_tasks Time_to_die crontab disks
syn keyword rtexecParams email_incident_reports include_corefile max_cron_gap
syn keyword rtexecParams network_code orbtasks pf_revision_time
syn keyword rtexecParams startup_shutdown_email status_email title umask
syn keyword rtexecParams __DATA__ __END__ __EOF__

" `man 5 pf` for details

" variables
syn match   antelopeVariable "$[_a-zA-Z0-9]\+"

" don't match variables if preceded by a backslash.
syn match   antelopeNotVariable   contained "\\$\w\+"

" references
syn match   antelopeReference "&[_a-zA-Z0-9]\+[^'(<{\[]"
syn match   antelopeReference "&{[_a-zA-Z0-9]\+}"

" functions
syn region  antelopeFunction    matchgroup=antelopeTypes keepend start="&[-_a-zA-Z0-9]\+(" end=")" contains=antelopeFuncDelim,antelopeString,antelopeVariable,antelopeReference
syn match   antelopeFuncDelim   contained ","

" Identify &Literal{ } clauses -- we want no special formatting here
syn region  antelopeLiteral  matchgroup=antelopeTypes keepend start="&Literal['(<{\[][^}]*$" end="^\s*[')>}\]]\s*$" contains=antelopeComment,antelopeLiteralString
syn match   antelopeLiteralString contained ".*"

" Identify &Undef{ } -- should only be parameter names
syn region  antelopeUndef      matchgroup=antelopeTypes keepend start="&Undef['(<{\[][^}]*$" end="^\s*[')>}\]]\s*$" contains=antelopeComment,antelopeUndefParam
syn match   antelopeUndefParam contained "[-_a-zA-Z0-9]\+"

" Identify &Tbl{ } clauses -- what we typically think of as an Array()
syn region  antelopeTbl      matchgroup=antelopeTypes keepend start="&Tbl['(<{\[][^}]*$" end="^\s*[')>}\]]\s*$" contains=antelopeTblFirst,@antelopeCommon
syn match   antelopeTblFirst  contained "^\s*\S\+"

" Identify &Arr{ } clauses -- what we typically think of as an Hash()
syn region  antelopeArr      matchgroup=antelopeTypes keepend start="&Arr['(<{\[][^}]*$" end="^\s*[')>}\]]\s*$" contains=antelopeArrKey,antelopePreserve,@antelopeCommon
syn match   antelopeArrKey   contained "^\s*[-_a-zA-Z0-9]\+"
syn match   antelopePreserve contained "PRESERVE"

syn cluster antelopeCommon add=antelopeString
syn cluster antelopeCommon add=antelopeVariable
syn cluster antelopeCommon add=antelopeNotVariable
syn cluster antelopeCommon add=antelopeComment
syn cluster antelopeCommon add=antelopeToDo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comments last, overriding everything else
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match   antelopeComment       "\s*#.*$" contains=antelopeTodo
syn keyword antelopeTodo          TODO NOTE FIXME XXX BUG HACK contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_antelope_syn_inits")
  if version < 508
    let did_antelope_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink rtexecParams                 Special
  HiLink antelopePreserve             Special
  HiLink antelopeTblFirst             Special
  HiLink antelopeFunction             Special
  HiLink antelopeFuncDelim            Special
  HiLink antelopeTypes                Special
  HiLink antelopeUndefParam           Identifier
  HiLink antelopeArrKey               Identifier
  HiLink antelopeReference            Identifier
  HiLink antelopeVariable             Identifier
  HiLink antelopeLiteralString        String
  HiLink antelopeNotVariable          String
  HiLink antelopeString               String
  HiLink antelopeComment              Comment
  HiLink antelopeTodo                 Todo

  delcommand HiLink
endif

let b:current_syntax = "antelope"
