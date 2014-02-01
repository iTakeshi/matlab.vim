let s:source = {
\   'name'      : 'neocomplete_matlab',
\   'kind'      : 'keyword',
\   'filetypes' : { 'matlab' : 1 },
\ }

function! s:source.gather_candidates(context)
  return neocomplete#matlab#gather_candidates(a:context)
endfunction

function! neocomplete#sources#neocomplete_matlab#define()
  return s:source
endfunction
