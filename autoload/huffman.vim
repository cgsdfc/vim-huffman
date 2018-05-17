""
" @section Introduction, intro
" @stylized Huffman
" @library
" @order intro functions dicts exceptions
" Provided a List of 2-Lists in (symbol, weight) format, generate a
" Huffman codebook, returned as a Dict in {symbol: code} format.
" Examples:
" >
"   echo huffman#codebook([['A', 2], ['B', 4], ['C', 1], ['D', 1]])
"
"   {'A': '10', 'B': '0', 'C': '110', 'D': '111'}
" <

function! huffman#codebook(symbolweights) abort
  if type([]) == type(a:symbolweights)
    return huffman#huffman#codebook(a:symbolweights)
  else
    throw huffman#util#ValueError('expected a List')
  endif
endfunction
