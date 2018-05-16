let v:errors = []

function! huffman#test#Heap()
  " Empty Heap
  let x = huffman#heapqo#Heap([])
  call assert_true(x.__len__() == 0)
  
  let x = huffman#heapqo#Heap(reverse(range(10)))
  let data = []
  while x.__len__()
    call add(data, x.pop())
  endwhile
  call assert_equal(data, range(10))

  call assert_true(!x.__len__())
  for i in range(10)
    call x.push(i)
  endfor
  call assert_equal(x.__len__(), 10)
  for i in range(10)
    call assert_equal(i, x.pop())
  endfor
endfunction

function! huffman#test#Leaf()
  let leaf = huffman#huffman#Leaf('a', 2)
  call assert_equal(leaf.symbol, 'a')
  call assert_equal(leaf.weight, 2)
  call assert_equal(leaf.parent, v:none)
  echo leaf.__repr__()
  call assert_equal(leaf.code(), '')
endfunction

function! huffman#test#Node()
  let leaves = [['a',1],['b',2],['c',3]]
  call map(leaves, 'huffman#huffman#Leaf(v:val[0], v:val[1])')
  let node = huffman#huffman#Node(leaves[0], leaves[1])
  echo node.__repr__()
  call assert_equal(node.parent, v:none)
  call assert_true(leaves[0].parent is# node)
  call assert_true(leaves[1].parent is# node)
  call assert_true(node.left is# leaves[0])
  call assert_true(node.right is# leaves[1])
  call assert_equal(node.weight, leaves[0].weight+leaves[1].weight)
  call assert_false(node.__lt__(leaves[0]))
  call assert_false(node.__lt__(leaves[1]))
  call assert_true(leaves[0].__lt__(leaves[1]))
endfunction

function! huffman#test#Tree()
  let data = [['a',1],['b',2],['c',3]]
  let tree = huffman#huffman#Tree(data)
  call assert_true(has_key(tree, 'root'))
  let codebook = tree.codebook
  let codebook = huffman#huffman#codebook([['A', 2], ['B', 4], ['C', 1], ['D', 1]])
  let truth =  {'A': '10', 'B': '0', 'C': '110', 'D': '111'}
  call assert_equal(truth, codebook)
endfunction

function! huffman#test#codebook()
  let data = [['A', 2], ['B', 4], ['C', 1], ['D', 1]]
  let res = huffman#codebook(data)
  let truth =  {'A': '10', 'B': '0', 'C': '110', 'D': '111'}
  call assert_equal(truth, res)
  let data = {'A':2, 'B':4, 'C':1, 'D':1}
  let res = huffman#codebook(data)
  call assert_equal(truth, res)
endfunction

let s:tests=['Heap', 'Leaf', 'Node', 'Tree', 'codebook']
for s:x in s:tests
  call huffman#test#{s:x}()
endfor

echo v:errors
