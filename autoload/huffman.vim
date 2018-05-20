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

function! huffman#codebook(...) abort
  return call('huffman#huffman#codebook', a:000)
endfunction
