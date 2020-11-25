MvVis
=====

Move visually selected text

![demo](demo.gif)

## Installation

#### [minPlug](https://github.com/Jorengarenar/minPlug):
```vim
MinPlug Jorengarenar/vim-MvVis
```

#### [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'Jorengarenar/vim-MvVis'
```

#### Vim's packages
```bash
cd ~/.vim/pack/plugins/start
git clone git://github.com/Jorengarenar/vim-MvVis.git
```

## Usage

In visual mode, press <kbd>CTRL</kbd> and one of directional keys (<kbd>H</kbd>,
<kbd>J</kbd>, <kbd>K</kbd>, <kbd>L</kbd>) to move selected text.

You can also provide a number of amount of places you want to move it, e.g.
to move selection three columns to the left press `3<C-h>`.

## Configuration

To disable default mappings set variable `g:MvVis_mappings` to `0` and define
your own, e.g.:
```vim
vmap H <Plug>(MvVisLeft)
vmap J <Plug>(MvVisDown)
vmap K <Plug>(MvVisUp)
vmap L <Plug>(MvVisRight)
```
