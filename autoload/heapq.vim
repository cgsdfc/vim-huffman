""
" heapq is a dirty copy-and-paste of the Python module
" heapq.py.

" Try to use __lt__ but failback to operator<.
function! heapq#_cmp_lt(x, y)
  if huffman#util#hasattr(a:x, '__lt__')
    return a:x.__lt__(a:y)
  else
    return a:x < a:y
  endif
endfunction

""
" Push an {item} to {heap} and maintain heap invariant.
function! heapq#heappush(heap, item)
  call add(a:heap, a:item)
  call heapq#_siftdown(a:heap, 0, len(a:heap)-1)
endfunction

""
" Pop and return the smallest item in {heap}.
" @throws E684 list index out of range.
function! heapq#heappop(heap)
  let lastelt = remove(a:heap, -1)
  if len(a:heap)
    let returnitem = a:heap[0]
    let a:heap[0] = lastelt
    call heapq#_siftup(a:heap, 0)
  else
    let returnitem = lastelt
  endif
  return returnitem
endfunction

""
" Replace the smallest item in {heap} with {item}
" and return it.
" @throws E684 list index out of range.
function! heapq#heapreplace(heap, item)
  let returnitem = a:heap[0]
  let a:heap[0] = a:item
  call heapq#_siftup(a:heap, 0)
  return returnitem
endfunction

""
" A faster shortcut to a |heappush()| followed by |heappop()|.
function! heapq#heappushpop(heap, item)
  let item = a:item
  if len(a:heap) && heapq#_cmp_lt(a:heap[0], a:item)
    let [item, a:heap[0]] = [a:heap[0], a:item]
    call heapq#_siftup(a:heap, 0)
  endif
  return item
endfunction

""
" Turn a List {x} into a heap in place in O(N).
function! heapq#heapify(x)
  for i in reverse(range(len(a:x)/2))
    call heapq#_siftup(a:x, i)
  endfor
endfunction

function! heapq#_siftdown(heap, startpos, pos)
  let pos = a:pos
  let newitem = a:heap[a:pos]
  while pos > a:startpos
    let parentpos = (pos-1) / 2
    let parent = a:heap[parentpos]
    if heapq#_cmp_lt(newitem, parent)
      let a:heap[pos] = parent
      let pos = parentpos
      continue
    endif
    break
  endwhile
  let a:heap[pos] = newitem
endfunction

function! heapq#_siftup(heap, pos)
  let pos = a:pos
  let endpos = len(a:heap)
  let startpos = a:pos
  let newitem = a:heap[a:pos]
  let childpos = 2*a:pos+1

  while childpos < endpos
    let rightpos = childpos + 1
    if rightpos < endpos && !heapq#_cmp_lt(a:heap[childpos],
          \ a:heap[rightpos])
      let childpos = rightpos
    endif
    let a:heap[pos] = a:heap[childpos]
    let pos = childpos
    let childpos = 2*pos+1
  endwhile

  let a:heap[pos] = newitem
  call heapq#_siftdown(a:heap, startpos, pos)
endfunction
