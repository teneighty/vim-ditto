" Vim color file
" Maintainer: Tim Horton

if !filereadable(expand("$HOME/.Xdefaults"))
  echoerr 'Unable to find .Xdefaults. Aborting'
  finish
endif

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name="ditto"
if !exists("g:ditto_black")
  let g:ditto_black = 0
endif
let g:ditto_name_map = {
    \'black': '0',
    \'darkblue': '4',
    \'darkgreen': '2',
    \'darkcyan': '6',
    \'darkred': '1',
    \'darkmagenta': '5',
    \'brown': '6',
    \'darkyellow': '3',
    \'lightgray': '7',
    \'lightgrey': '7',
    \'gray': '7',
    \'grey': '7',
    \'darkgray': '8',
    \'darkgrey': '8',
    \'blue': '12',
    \'lightblue': '12',
    \'green': '10',
    \'lightgreen': '10',
    \'cyan': '14',
    \'lightcyan': '14',
    \'red': '9',
    \'lightred': '9',
    \'magenta': '13',
    \'lightmagenta': '13',
    \'yellow': '11',
    \'lightyellow': '11',
    \'white': '15'
  \}

" define g:ditto_colors which is used by gui
function! s:loadXDefaults()
  let xdef = expand("$HOME/.Xdefaults")
  if !filereadable(xdef)
    return
  endif
  let g:ditto_colors = {}
  let lines = readfile(xdef)
  if exists('g:ditto_term') | let term = g:ditto_term | endif
  for l in lines
    let m = matchlist(l, 'color\(\d\+\):\s\+\(\S\+\)')
    if !empty(m)
      let g:ditto_colors[m[1]] = m[2]
    endif
  endfor
endfunction

function! s:glu(c)
  let color = a:c
  if has_key(g:ditto_name_map, color)
    let key = g:ditto_name_map[color]
    if has_key(g:ditto_colors, key) 
      return g:ditto_colors[key]
    endif
  endif
  return 'NONE'
endfunction

function! s:makehi(key, rep)
  let d = b:layout[a:key]
  let hi = ''
  if has("gui_running")
    let [f, b] = map(['fg', 'bg'], 's:glu(d[v:val])')
  else
    let [f, b] = map(['fg', 'bg'], 's:lu(d[v:val])')
  endif
  let o = d['other']
  if !empty(f) | let hi .= a:rep . 'fg=' . f . ' '  | endif
  if !empty(b) | let hi .= a:rep . 'bg=' . b  . ' ' | endif
  if !empty(o) | let hi .= a:rep . '=' . o . ' '    | endif
  if !empty(o) | let hi .= 'term=' . o . ' '    | endif
  return hi
endfunction

function! s:lu(c)
  let color = a:c
  if has_key(g:ditto_name_map, color)
    return g:ditto_name_map[color]
  endif
  return 'NONE'
endfunction


let b:layout = {
  \'Comment'      : { 'fg' : 'darkblue',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Constant'     : { 'fg' : 'red',         'bg' : 'NONE',        'other' : 'NONE'},
  \'DiffAdd'      : { 'fg' : 'NONE',        'bg' : 'darkred',     'other' : 'NONE'},
  \'DiffChange'   : { 'fg' : 'NONE',        'bg' : 'darkmagenta', 'other' : 'NONE'},
  \'DiffDelete'   : { 'fg' : 'darkred',     'bg' : 'darkyellow',  'other' : 'NONE'},
  \'DiffText'     : { 'fg' : 'NONE',        'bg' : 'darkblue',    'other' : 'NONE'},
  \'Directory'    : { 'fg' : 'darkyellow',  'bg' : 'NONE',        'other' : 'NONE'},
  \'Error'        : { 'fg' : 'lightgrey',   'bg' : 'darkred',     'other' : 'NONE'},
  \'ErrorMsg'     : { 'fg' : 'white',       'bg' : 'darkred',     'other' : 'NONE'},
  \'FoldColumn'   : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Folded'       : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Identifier'   : { 'fg' : 'darkcyan',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Ignore'       : { 'fg' : 'lightgrey',   'bg' : 'NONE',        'other' : 'NONE'},
  \'IncSearch'    : { 'fg' : 'NONE',        'bg' : 'NONE',        'other' : 'reverse'},
  \'LineNr'       : { 'fg' : 'darkyellow',  'bg' : 'NONE',        'other' : 'NONE'},
  \'ModeMsg'      : { 'fg' : 'darkyellow',  'bg' : 'NONE',        'other' : 'NONE'},
  \'MoreMsg'      : { 'fg' : 'darkgreen',   'bg' : 'NONE',        'other' : 'NONE'},
  \'NonText'      : { 'fg' : 'darkblue',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Normal'       : { 'fg' : 'NONE',        'bg' : 'NONE',        'other' : 'NONE'},
  \'PreProc'      : { 'fg' : 'darkmagenta', 'bg' : 'NONE',        'other' : 'NONE'},
  \'Question'     : { 'fg' : 'green',       'bg' : 'NONE',        'other' : 'NONE'},
  \'Search'       : { 'fg' : 'NONE',        'bg' : 'NONE',        'other' : 'reverse'},
  \'Special'      : { 'fg' : 'darkmagenta', 'bg' : 'NONE',        'other' : 'NONE'},
  \'SpecialKey'   : { 'fg' : 'darkgreen',   'bg' : 'NONE',        'other' : 'NONE'},
  \'Statement'    : { 'fg' : 'darkyellow',  'bg' : 'NONE',        'other' : 'NONE'},
  \'StatusLine'   : { 'fg' : 'black',       'bg' : 'darkgrey',    'other' : 'NONE'},
  \'StatusLineNC' : { 'fg' : 'black',       'bg' : 'darkgrey',    'other' : 'NONE'},
  \'TabLine'      : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'TabLineFill'  : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'TabLineSel'   : { 'fg' : 'white',       'bg' : 'NONE',        'other' : 'NONE'},
  \'Title'        : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Type'         : { 'fg' : 'darkgreen',   'bg' : 'NONE',        'other' : 'NONE'},
  \'Underlined'   : { 'fg' : 'darkmagenta', 'bg' : 'NONE',        'other' : 'underline'},
  \'VertSplit'    : { 'fg' : 'darkgrey',    'bg' : 'NONE',        'other' : 'NONE'},
  \'Visual'       : { 'fg' : 'NONE',        'bg' : 'NONE',        'other' : 'reverse'},
  \'VisualNOS'    : { 'fg' : 'NONE',        'bg' : 'NONE',        'other' : 'underline'},
  \'WarningMsg'   : { 'fg' : 'darkblue',    'bg' : 'NONE',        'other' : 'NONE'},
  \'WildMenu'     : { 'fg' : 'black',       'bg' : 'darkblue',    'other' : 'NONE'},
  \}

if has("gui_running")
  if g:ditto_black
    let b:layout['Normal'] = {'fg' : 'black', 'bg' : 'white', 'other' : 'NONE'}
  else
    let b:layout['Normal'] = {'fg' : 'white', 'bg' : 'black', 'other' : 'NONE'}
  endif
endif

call s:loadXDefaults()

if has("gui_running") && exists("g:ditto_colors")
  for key in keys(b:layout)
    let cmd = s:makehi(key, 'gui')
    if !empty(cmd)
      exe 'hi! ' . key . ' ' . cmd
    endif
  endfor
else
  for key in keys(b:layout)
    let cmd = s:makehi(key, 'cterm')
    if !empty(cmd)
      exe 'hi! ' . key . ' ' . cmd
    endif
  endfor
endif

" vim:set sw=2 ts=2 fdm=marker fdl=0: 
