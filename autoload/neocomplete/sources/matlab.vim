let s:source = {
      \ 'name'      : 'matlab',
      \ 'kind'      : 'keyword',
      \ 'filetypes' : { 'matlab' : 1 },
      \ 'hooks'     : {}
      \ }

function! s:source.hooks.on_init(context)
  call neco_matlab#cache_candidates()
endfunction

function! s:source.gather_candidates(context)
  return neocomplete#matlab#gather_candidates(a:context.complete_str)
endfunction

function! neocomplete#sources#matlab#define()
  return s:source
endfunction
