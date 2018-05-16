## vim-huffman
A quick and dirty hack of [nicktimko/huffman](https://github.com/nicktimko/huffman.git) and transportation to vimscript.

Basically this plugin allows you to do the same things as in [nicktimko/huffman](https://github.com/nicktimko/huffman.git):
```vim
echo huffman#codebook([['A', 2], ['B', 4], ['C', 1], ['D', 1]])
{'A': '10', 'B': '0', 'C': '110', 'D': '111'}

echo huffman#codebook({'A':2, 'B':4, 'C':1, 'D':1})
{'A': '10', 'B': '0', 'C': '110', 'D': '111'}
```

# Install
Put
```vim
Plugin 'cgsdfc/vim-huffman'
```
in you ``.vimrc`` for [Vundle](https://github.com/VundleVim/Vundle.vim).
