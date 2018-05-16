""
" Handy routine to create an instance for {cls} and {args}
" {cls} should have a __init__() method like in Python.
function! huffman#util#new(cls, args) 
  let x = deepcopy(a:cls)
  call call(x.__init__, a:args)
  return x
endfunction

""
" Display nice string representation of {x}.
" {x} should have a __repr__() method.
function! huffman#util#repr(x)
  return x.__repr__()
endfunction

""
" @exception
" Bad value has been seen.
function! huffman#util#ValueError(msg)
  return 'ValueError: '.a:msg
endfunction

""
" Test whether {o} has attribute {attr}.
function! huffman#util#hasattr(o, attr)
  return type(a:o) == type({}) && has_key(a:o, a:attr)
endfunction

""
" Call __len__() of {o}.
function! huffman#util#len(o)
  return a:o.__len__()
endfunction
