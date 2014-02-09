function! s:word_prefix(dict, keyword)
  let l:len = strlen(a:keyword)
  return strpart(a:dict.word, 0, l:len) ==# a:keyword
endfunction

function! neco_matlab#cache_candidates()
  let l:function_dict = globpath(&runtimepath, 'dict/matlab/functions.dict', 1)
  let s:candidates = []
  for line_str in readfile(l:function_dict)
    let list = split(line_str, "\t", 1)
    if len(list) == 3
      let [func_name, func_type, func_desc] = list
      let s:candidate = { 'word': func_name, 'kind': '[matlab '.func_type.']', 'menu': func_desc }
    elseif len(list) == 2
      let [func_name, func_desc] = list
      let s:candidate = { 'word': func_name, 'kind': '[matlab]', 'menu': func_desc }
    elseif len(list) >= 1
      let func_name = list[0]
      let s:candidate = { 'word': func_name }
    else
      continue
    endif
    call add(s:candidates, s:candidate)
  endfor
endfunction

function neco_matlab#gather_candidates(cur_keyword_str)
  let l:list = copy(s:candidates)
  return filter(l:list, 's:word_prefix(v:val, a:cur_keyword_str)')
endfunction
