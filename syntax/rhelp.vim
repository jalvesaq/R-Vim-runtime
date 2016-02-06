" Vim syntax file
" Language:    R Help File
" Maintainer: Jakson Aquino <jalvesaq@gmail.com>
" Former Maintainer: Johannes Ranke <jranke@uni-bremen.de>
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change: Fri Feb 05, 2016  08:51PM
" Remarks:     - Includes R syntax highlighting in the appropriate
"                sections if an r.vim file is in the same directory or in the
"                default debian location.
"              - There is no Latex markup in equations
"              - Thanks to Will Gray for finding and fixing a bug
"              - No support for \var tag within quoted string

" Version Clears: {{{1
" For version 5.x: Clear all syntax items
" For version 6.x and 7.x: Quit when a syntax file was already loaded
if version < 600 
  syntax clear
elseif exists("b:current_syntax")
  finish
endif 

setlocal iskeyword=@,48-57,_,.

syn case match

" R help identifiers {{{1
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\name{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\alias{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\pkg{" end="}" contains=rhelpLink
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\CRANpkg{" end="}" contains=rhelpLink
syn region rhelpIdentifier matchgroup=rhelpSection start="\\method{" end="}" contained
syn region rhelpIdentifier matchgroup=rhelpSection start="\\Rdversion{" end="}"


" Highlighting of R code using an existing r.vim syntax file if available {{{1
syn include @R syntax/r.vim

" Strings {{{1
syn region rhelpString start=/"/ skip=/\\"/ end=/"/ contains=rhelpSpecialChar,rhelpCodeSpecial,rhelpLink contained

" Special characters in R strings
syn match rhelpCodeSpecial display contained "\\\\\(n\|r\|t\|b\|a\|f\|v\|'\|\"\)\|\\\\"

" Special characters  ( \$ \& \% \# \{ \} \_)
syn match rhelpSpecialChar        "\\[$&%#{}_]"


" R code {{{1
syn match rhelpDots		"\\dots" containedin=@R
syn region rhelpRcode matchgroup=Delimiter start="\\examples{" matchgroup=Delimiter transparent end="}" contains=@R,rhelpLink,rhelpIdentifier,rhelpString,rhelpSpecialChar,rhelpSection
syn region rhelpRcode matchgroup=Delimiter start="\\usage{" matchgroup=Delimiter transparent end="}" contains=@R,rhelpIdentifier,rhelpS4method
syn region rhelpRcode matchgroup=Delimiter start="\\synopsis{" matchgroup=Delimiter transparent end="}" contains=@R
syn region rhelpRcode matchgroup=Delimiter start="\\special{" matchgroup=Delimiter transparent end="}" contains=@R

if v:version > 703
  syn region rhelpRcode matchgroup=Delimiter start="\\code{" skip='\\\@1<!{.\{-}\\\@1<!}' transparent end="}" contains=@R,rhelpDots,rhelpString,rhelpSpecialChar,rhelpLink keepend
else
  syn region rhelpRcode matchgroup=Delimiter start="\\code{" skip='\\\@<!{.\{-}\\\@<!}' transparent end="}" contains=@R,rhelpDots,rhelpString,rhelpSpecialChar,rhelpLink keepend
endif
syn region rhelpS4method matchgroup=Delimiter start="\\S4method{.*}(" matchgroup=Delimiter transparent end=")" contains=@R,rhelpDots
syn region rhelpSexpr matchgroup=Delimiter start="\\Sexpr{" matchgroup=Delimiter transparent end="}" contains=@R

" PreProc {{{1
syn match rhelpPreProc "^#ifdef.*" 
syn match rhelpPreProc "^#endif.*" 

" Special Delimiters {{{1
syn match rhelpDelimiter		"\\cr"
syn match rhelpDelimiter		"\\tab "

" Keywords {{{1
syn match rhelpKeyword	"\\R\>"
syn match rhelpKeyword	"\\ldots\>"
syn match rhelpKeyword	"\\sspace\>"
syn match rhelpKeyword  "--"
syn match rhelpKeyword  "---"

" Condition Keywords {{{1
syn match rhelpKeyword	"\\if\>"
syn match rhelpKeyword	"\\ifelse\>"
syn match rhelpKeyword	"\\out\>"
" Examples of usage:
" \ifelse{latex}{\eqn{p = 5 + 6 - 7 \times 8}}{\eqn{p = 5 + 6 - 7 * 8}}
" \ifelse{latex}{\out{$\alpha$}}{\ifelse{html}{\out{&alpha;}}{alpha}}

" Keywords and operators valid only if in math mode {{{1
syn match rhelpMathOp  "<" contained
syn match rhelpMathOp  ">" contained
syn match rhelpMathOp  "+" contained
syn match rhelpMathOp  "-" contained
syn match rhelpMathOp  "=" contained
syn match rhelpMathSimb   	"\\infty\>" contained
syn match rhelpMathSimb   	"\\ge\>" contained
syn match rhelpMathSimb   	"\\le\>" contained
syn match rhelpMathSimb   	"\\alpha\>" contained
syn match rhelpMathSimb   	"\\beta\>" contained
syn match rhelpMathSimb   	"\\gamma\>" contained
syn match rhelpMathSimb   	"\\delta\>" contained
syn match rhelpMathSimb   	"\\epsilon\>" contained
syn match rhelpMathSimb   	"\\zeta\>" contained
syn match rhelpMathSimb   	"\\eta\>" contained
syn match rhelpMathSimb   	"\\theta\>" contained
syn match rhelpMathSimb   	"\\iota\>" contained
syn match rhelpMathSimb   	"\\kappa\>" contained
syn match rhelpMathSimb   	"\\lambda\>" contained
syn match rhelpMathSimb   	"\\mu\>" contained
syn match rhelpMathSimb   	"\\nu\>" contained
syn match rhelpMathSimb   	"\\xi\>" contained
syn match rhelpMathSimb   	"\\omicron\>" contained
syn match rhelpMathSimb   	"\\pi\>" contained
syn match rhelpMathSimb   	"\\rho\>" contained
syn match rhelpMathSimb   	"\\sigma\>" contained
syn match rhelpMathSimb   	"\\tau\>" contained
syn match rhelpMathSimb   	"\\upsilon\>" contained
syn match rhelpMathSimb   	"\\phi\>" contained
syn match rhelpMathSimb   	"\\chi\>" contained
syn match rhelpMathSimb   	"\\psi\>" contained
syn match rhelpMathSimb   	"\\omega\>" contained
syn match rhelpMathSimb   	"\\Alpha\>" contained
syn match rhelpMathSimb   	"\\Beta\>" contained
syn match rhelpMathSimb   	"\\Gamma\>" contained
syn match rhelpMathSimb   	"\\Delta\>" contained
syn match rhelpMathSimb   	"\\Epsilon\>" contained
syn match rhelpMathSimb   	"\\Zeta\>" contained
syn match rhelpMathSimb   	"\\Eta\>" contained
syn match rhelpMathSimb   	"\\Theta\>" contained
syn match rhelpMathSimb   	"\\Iota\>" contained
syn match rhelpMathSimb   	"\\Kappa\>" contained
syn match rhelpMathSimb   	"\\Lambda\>" contained
syn match rhelpMathSimb   	"\\Mu\>" contained
syn match rhelpMathSimb   	"\\Nu\>" contained
syn match rhelpMathSimb   	"\\Xi\>" contained
syn match rhelpMathSimb   	"\\Omicron\>" contained
syn match rhelpMathSimb   	"\\Pi\>" contained
syn match rhelpMathSimb   	"\\Rho\>" contained
syn match rhelpMathSimb   	"\\Sigma\>" contained
syn match rhelpMathSimb   	"\\Tau\>" contained
syn match rhelpMathSimb   	"\\Upsilon\>" contained
syn match rhelpMathSimb   	"\\Phi\>" contained
syn match rhelpMathSimb   	"\\Chi\>" contained
syn match rhelpMathSimb   	"\\Psi\>" contained
syn match rhelpMathSimb   	"\\Omega\>" contained

" Links {{{1
syn region rhelpLink matchgroup=rhelpType start="\\link{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\link\[.\{-}\]{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\linkS4class{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\url{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\href{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\figure{" end="}" contained keepend extend

" Verbatim like {{{1
syn region rhelpVerbatim matchgroup=rhelpType start="\\samp{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpSpecialChar,rhelpComment
syn region rhelpVerbatim matchgroup=rhelpType start="\\verb{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpSpecialChar,rhelpComment

syn region rhelpEquation matchgroup=rhelpType start="\\eqn{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpMathSimb,rhelpMathOp,rhelpRegion contained keepend extend
syn region rhelpEquation matchgroup=rhelpType start="\\deqn{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpMathSimb,rhelpMathOp,rhelpRegion contained keepend extend

" Type Styles {{{1
syn match rhelpType		"\\emph\>"
syn match rhelpType		"\\strong\>"
syn match rhelpType		"\\bold\>"
syn match rhelpType		"\\sQuote\>"
syn match rhelpType		"\\dQuote\>"
syn match rhelpType		"\\preformatted\>"
syn match rhelpType		"\\kbd\>"
"syn match rhelpType		"\\eqn\>"
"syn match rhelpType		"\\deqn\>"
syn match rhelpType		"\\file\>"
syn match rhelpType		"\\email\>"
syn match rhelpType		"\\enc\>"
syn match rhelpType		"\\var\>"
syn match rhelpType		"\\env\>"
syn match rhelpType		"\\option\>"
syn match rhelpType		"\\command\>"
syn match rhelpType		"\\newcommand\>"
syn match rhelpType		"\\renewcommand\>"
syn match rhelpType		"\\dfn\>"
syn match rhelpType		"\\cite\>"
syn match rhelpType		"\\acronym\>"
syn match rhelpType		"\\doi\>"

" rhelp sections {{{1
syn match rhelpSection		"\\encoding\>"
syn match rhelpSection		"\\title\>"
syn match rhelpSection		"\\item\>"
syn match rhelpSection		"\\description\>"
syn match rhelpSection		"\\concept\>"
syn match rhelpSection		"\\arguments\>"
syn match rhelpSection		"\\details\>"
syn match rhelpSection		"\\value\>"
syn match rhelpSection		"\\references\>"
syn match rhelpSection		"\\note\>"
syn match rhelpSection		"\\author\>"
syn match rhelpSection		"\\seealso\>"
syn match rhelpSection		"\\keyword\>"
syn match rhelpSection		"\\docType\>"
syn match rhelpSection		"\\format\>"
syn match rhelpSection		"\\source\>"
syn match rhelpSection    "\\itemize\>"
syn match rhelpSection    "\\describe\>"
syn match rhelpSection    "\\enumerate\>"
syn match rhelpSection    "\\item "
syn match rhelpSection    "\\item$"
syn match rhelpSection		"\\tabular{[lcr]*}"
syn match rhelpSection		"\\dontrun\>"
syn match rhelpSection		"\\dontshow\>"
syn match rhelpSection		"\\testonly\>"
syn match rhelpSection		"\\donttest\>"

" Freely named Sections {{{1
syn region rhelpFreesec matchgroup=Delimiter start="\\section{" matchgroup=Delimiter transparent end="}"
syn region rhelpFreesubsec matchgroup=Delimiter start="\\subsection{" matchgroup=Delimiter transparent end="}" 

syn match rhelpDelimiter "{\|\[\|(\|)\|\]\|}"

" R help file comments {{{1
syn match rhelpComment /%.*$/

" Error {{{1
syn region rhelpRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn region rhelpRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn region rhelpRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn match rhelpError      /[)\]}]/
syn match rhelpBraceError /[)}]/ contained
syn match rhelpCurlyError /[)\]]/ contained
syn match rhelpParenError /[\]}]/ contained

syntax sync match rhelpSyncRcode grouphere rhelpRcode "\\examples{"

" Define the default highlighting {{{1
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rhelp_syntax_inits")
  if version < 508
    let did_rhelp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink rhelpVerbatim    String
  HiLink rhelpDelimiter   Delimiter
  HiLink rhelpIdentifier  Identifier
  HiLink rhelpString      String
  HiLink rhelpCodeSpecial Special
  HiLink rhelpKeyword     Keyword
  HiLink rhelpDots        Keyword
  HiLink rhelpLink        Underlined
  HiLink rhelpType        Type
  HiLink rhelpSection     PreCondit
  HiLink rhelpError       Error
  HiLink rhelpBraceError  Error
  HiLink rhelpCurlyError  Error
  HiLink rhelpParenError  Error
  HiLink rhelpPreProc     PreProc
  HiLink rhelpDelimiter   Delimiter
  HiLink rhelpComment     Comment
  HiLink rhelpRComment    Comment
  HiLink rhelpSpecialChar SpecialChar
  HiLink rhelpMathSimb    Special
  HiLink rhelpMathOp      Operator
  delcommand HiLink
endif 

let   b:current_syntax = "rhelp"

" vim: foldmethod=marker sw=2
