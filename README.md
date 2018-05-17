# vim-huffman
A quick and dirty hack of [nicktimko/huffman](https://github.com/nicktimko/huffman.git) and transplant to vimscript.

This plugin allows you to do basically the same things as in [nicktimko/huffman](https://github.com/nicktimko/huffman.git), but you can also provide a ``Dict`` as well:
```vim
:echo huffman#codebook([['A', 2], ['B', 4], ['C', 1], ['D', 1]])
{'A': '10', 'B': '0', 'C': '110', 'D': '111'}

:echo huffman#codebook({'A':2, 'B':4, 'C':1, 'D':1})
{'A': '10', 'B': '0', 'C': '110', 'D': '111'}
```

# Install
Put the following line in you ``.vimrc`` if you are using [Vundle](https://github.com/VundleVim/Vundle.vim).
```vim
Plugin 'cgsdfc/vim-huffman'
```
