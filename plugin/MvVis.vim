" MvVis - move visually selected text
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_MvVis') | finish | endif
let s:cpo_save = &cpo | set cpo&vim

function! s:moveLines(d, c, lines_N) abort
  if a:d == 'h'
    execute 'normal! ' . a:c . 'k"sP'
  else
    if a:c > 1
      execute 'normal! ' . (a:c-1) . 'j'
    endif
    normal! "sp
  endif

  normal! V
  if a:lines_N > 1
    execute "normal! " . (a:lines_N-1) . "jo"
  endif
endfunction

function! s:moveInline(d, c, lines_N, lines, m, flag) abort
  execute "normal! " . a:c . a:d

  if a:d == 'l' && a:flag
    normal! "sp
  else
    if a:d == 'h' && a:flag
      normal! l
    endif
    normal! "sP
  endif

  let maxLine = 1
  for x in a:lines
    if strchars(x) > maxLine
      let maxLine = strchars(x)
    endif
  endfor
  if maxLine > 1
    let maxLine -= 1
  endif

  if a:lines_N > 1
    execute "normal! \<C-v>" . (a:lines_N-1) . "j" . maxLine . "lo"
  else
    if a:m == "\<C-v>"
      execute "normal! \<C-v>" . maxLine . "lo"
    else
      execute "normal! v" . maxLine . "ho"
    endif
  endif
endfunction

function! s:MvVis(d) abort range
  let c = v:count1

  normal! gv
  let m = mode()

  if a:d == 'h'
    if (m ==# "v" || m == "\<C-v>") && virtcol('.') == 0
      return
    elseif m ==# "V" && line('.') == 1
      return
    endif
  else
    if (m ==# "v" || m == "\<C-v>") && virtcol('.') == virtcol('$')-1
      return
    endif
  endif

  let s_old = @s
  let flag = virtcol('.') == virtcol('$') - (a:d == 'h' ? 1 : 2)

  normal! "sd

  let lines = split(@s, "\n")
  let lines_N = len(lines)

  if m ==# "V"
    call s:moveLines(a:d, c, lines_N)
  else
    call s:moveInline(a:d, c, lines_N, lines, m, flag)
  endif

  let @s = s_old
endfunction

vnoremap <silent> <Plug>(MvVisLeft)  :<C-u>call <SID>MvVis('h')<CR>
vnoremap <silent> <Plug>(MvVisRight) :<C-u>call <SID>MvVis('l')<CR>

if get(g:, "MvVis_mappings", 1)
  vmap H <Plug>(MvVisLeft)
  vmap L <Plug>(MvVisRight)
endif

let g:loaded_MvVis = 1
let &cpo = s:cpo_save | unlet s:cpo_save
