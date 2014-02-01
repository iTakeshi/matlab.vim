function neocomplete#matlab#gather_candidates(context)
  echomsg expand('<amatch>')
  let s:function_dict = globpath(&runtimepath, 'dict/matlab/functions.dict', 1)
  let s:candidates = []
  for line_str in readfile(s:function_dict)
    let list = split(line_str, "\t", 1)
    if len(list) == 2
      let [func_name, func_desc] = list
      let s:candidate = { 'word': func_name, 'kind': '', 'menu': func_desc }
    elseif len(list) == 3
      let [func_name, arg_note, func_desc] = list
      let s:candidate = { 'word': func_name, 'kind': '('.arg_note.')', 'menu': func_desc }
    else
      continue
    endif
    call add(s:candidates, s:candidate)
  endfor
  return s:candidates
endfunction
