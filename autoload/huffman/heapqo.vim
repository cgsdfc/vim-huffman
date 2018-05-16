""
" @dict Heap
" A object interface to |heapq|.

let s:Heap = {}

function! s:Heap.__init__(heap)
  let self.heap = a:heap
  call heapq#heapify(self.heap)
endfunction

function! s:Heap.__len__()
  return len(self.heap)
endfunction

function! s:Heap.push(item)
  call heapq#heappush(self.heap, a:item)
endfunction

function! s:Heap.pop()
  return heapq#heappop(self.heap)
endfunction

function! s:Heap.pushpop(item)
  return heapq#heappushpop(self.heap, a:item)
endfunction

function! s:Heap.replace(item)
  return heapq#heapreplace(self.heap, a:item)
endfunction

function! huffman#heapqo#Heap(...)
  return huffman#util#new(s:Heap, a:000)
endfunction
