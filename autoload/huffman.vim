""
"
"   Provided an iterable of 2-tuples in (symbol, weight) format, generate a
"   Huffman codebook, returned as a dictionary in {symbol: code} format.
"   Examples:
"   >>> huffman#codebook([['A', 2], ['B', 4], ['C', 1], ['D', 1]])
"   {'A': '10', 'B': '0', 'C': '110', 'D': '111'}
"   >>> huffman#codebook(collections.Counter('man the stand banana man').items())
"   {' ': '111',
"    'a': '10',
"    'b': '0100',
"    'd': '0110',
"    'e': '11010',
"    'h': '0101',
"    'm': '1100',
"    'n': '00',
"    's': '11011',
"    't': '0111'}
"
"
function! huffman#codebook(symbolweights)
  let typ = type(a:symbolweights)
  if typ == type([])
    return huffman#huffman#codebook(a:symbolweights)
  elseif typ == type({})
    return huffman#huffman#codebook(items(a:symbolweights))
  else
    throw huffman#util#ValueError('expected a List or a Dict')
  endif
endfunction
