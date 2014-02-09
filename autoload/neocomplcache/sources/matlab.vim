let s:source = {
      \ 'name': 'matlab',
      \ 'kind': 'keyword',
      \ 'filetypes': { 'matlab': 1 },
      \ }

function! s:source.initialize()
  call neco_matlab#cache_candidates()
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
  return neco_matlab#gather_candidates(a:cur_keyword_str)
endfunction

function! neocomplcache#sources#matlab#define()
  return s:source
endfunction
