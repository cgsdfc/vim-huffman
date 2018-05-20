""
" @dict Node
" A node in the Huffman tree.

let s:Node = {}

function! s:Node.__init__(left, right)
  let self.parent = v:none
  let a:left.parent = self
  let a:right.parent = self

  let self.left = a:left
  let self.right = a:right

  let self.weight = a:left.weight + a:right.weight
endfunction

function! s:Node.__lt__(other)
  return self.weight < a:other.weight
endfunction

function! s:Node.__repr__()
  return printf('<Node with weight %d>', self.weight)
endfunction

function! huffman#huffman#Node(...)
  return huffman#util#new(s:Node, a:000)
endfunction

""
" @dict Leaf
" A subclass of @dict(Node) with symbol but no left or right children.

let s:Leaf = copy(s:Node)

function! s:Leaf.__init__(symbol, weight)
  let self.parent = v:none
  let self.symbol = a:symbol
  let self.weight = a:weight
endfunction

function! s:Leaf.__repr__()
  return printf("<Leaf '%s' with weight %d, code '%s'>",
        \ self.symbol, self.weight, self.code())
endfunction

" Generate code for a @dict(Leaf).
function! s:Leaf.code()
  let code = ''
  let n = self
  while n.parent isnot# v:none
    let codebit = n is# n.parent.left ? '0' : '1'
    let code = codebit.code
    let n = n.parent
  endwhile
  return code
endfunction

function! huffman#huffman#Leaf(...)
  return huffman#util#new(s:Leaf, a:000)
endfunction

""
" @dict Tree
" A tree that holds all the binary nodes.

let s:Tree = {}

""
" {symbolweights} should not be empty.
function! s:Tree.__init__(symbolweights)
  let leaves = map(copy(a:symbolweights), 'huffman#huffman#Leaf(v:val[0], v:val[1])')
  " This leaves[:] is really really important as it copies the List, which
  " will be reused later.
  let heap = huffman#heapqo#Heap(leaves[:])

  while huffman#util#len(heap) >= 2
    call heap.push(huffman#huffman#Node(heap.pop(), heap.pop()))
  endwhile

  let self.root = heap.pop()
  let self.codebook = {}
  for x in leaves
    let self.codebook[x.symbol] = x.code()
  endfor
endfunction

function! huffman#huffman#Tree(...)
  return huffman#util#new(s:Tree, a:000)
endfunction

""
" @private
" Turn the {symbolweights} into a codebook.
" {symbolweights} should be a List or a Dict.
" If {symbolweights} is empty, an empty Dict is returned.
function! huffman#huffman#codebook(symbolweights)
  if type([]) == type(a:symbolweights)
    if empty(a:symbolweights)
      return {}
    endif
    return huffman#huffman#Tree(a:symbolweights).codebook
  endif
  throw huffman#util#ValueError('expected a List')
endfunction
