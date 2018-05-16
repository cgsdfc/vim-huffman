function! huffman#util#new(cls, args) 
  let x = deepcopy(a:cls)
  call call(x.__init__, a:args)
  return x
endfunction

function! huffman#util#repr(x)
  return x.__repr__()
endfunction

function! huffman#util#ValueError(msg)
  return 'ValueError: '.a:msg
endfunction

function! huffman#util#hasattr(o, attr)
  return type(a:o) == type({}) && has_key(a:o, a:attr)
endfunction

function! huffman#util#len(o)
  return a:o.__len__()
endfunction

