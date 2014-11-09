hSATAC's vimrc
============
Author: Ash Wu (aka. cAt) <hsatac@gmail.com>

Forked from vgod's vimrc  https://github.com/vgod/vimrc

HOW TO INSTALL
--------------

1. Check out from github

 * Mac Os/Linux:

            $ git clone https://github.com/hSATAC/vimrc ~/.vim
            $ cd ~/.vim
            $ git submodule update --init

 * Windows: (or you could checkout into your $VIM if you want to build a portable gvim)

            $ git clone https://github.com/hSATAC/vimrc ~/vimfiles
            $ cd ~/vimfiles
            $ git submodule update --init            

2. Install ~/.vimrc and ~/.gvimrc

 * Mac Os/Linux:

            $ ./install-vimrc.sh

 * Windows7:

            > install-win32.bat

3. (Optional, if you want taglist) Install the Exuberant Ctags (http://ctags.sourceforge.net/)

 * Mac Os: The built-in ctags is not compitable with taglist.vim

            $ brew install ctags

 * ArchLinux:
            sudo pacman -S ctags

 * Windows:

            Download win32 ctags from http://ctags.sourceforge.net/
            put ctags.exe into your $VIM

UPGRADE PLUGIN BUNDLES
----------------------

All plugins were checked out as git submodules, 
which can be upgraded with `git pull`. For example, to upgrade Command-T 

     $ cd ~/.vim/bundle/command-t
     $ git pull
     
     // update all bundles
     $ git submodule foreach git pull origin master

HOW TO USE
----------

see the "USEFUL SHORTCUTS" section in vimrc to learn my shortcuts.

PLUGINS
-------

* [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332): Pathogen let us install a plugin as a bundle in ~/.vim/bundle seprately.

* [matchit](http://www.vim.org/scripts/script.php?script_id=39): extended % matching for HTML, LaTeX, and many other languages. 

* [Nerd Tree](http://www.vim.org/scripts/script.php?script_id=1658): A tree explorer plugin for navigating the filesystem. `<F5>` to toggle

  Useful commands:
  * `:Bookmark [name]` - bookmark any directory as name
  * `:NERDTree [name]` - open the bookmark [name] in Nerd Tree

* [vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt): deal with pairs of surroundings.
  
  * `ysiw` (you surround in word)
  * `cs` (change surround)
  * `ds` (delete surround)
  * `S` (surrond in visual mode)

* [SuperTab](http://www.vim.org/scripts/script.php?script_id=1643): Do all your insert-mode completion with Tab.

* [snipMate](http://www.vim.org/scripts/script.php?script_id=2540): TextMate-style snippets for Vim

  `:help snipMate` to see more info.

* [VisIncr](http://www.vim.org/scripts/script.php?script_id=670): Produce increasing/decreasing columns of numbers, dates, or daynames.
  
* [Zoom](https://github.com/vim-scripts/zoom.vim): Use `+`, `-`, `0` keys to zoom in/out like firefox or macvim.

* [taglist](https://github.com/vim-scripts/taglist.vim): taglist, list functions, structures. `<F8>` to toggle.

* [tagbar](http://majutsushi.github.com/tagbar/): tagbar, Vim plugin that displays tags in a window, ordered by class etc. `<F7>` toggle.

* [multiple-cursors](https://github.com/terryma/vim-multiple-cursors): `Ctrl + n` to multiple select, `v` to enter visual mode, `i` to enter insert mode.

* [fugitive](https://github.com/tpope/vim-fugitive): `:Gblame` to view git blame.

* [startify](https://github.com/mhinz/vim-startify): Start page replacement, shows recent files.

* [Turbux](https://github.com/jgdavey/vim-turbux): Run ruby tests in tmux window. `<leader>r` to run current line or last test, `<leader>t` to run whole test file.

* [Ag](https://github.com/epmatsw/ag.vim), [Ack](https://github.com/mileszs/ack.vi): Better than grep.

* [Align](https://github.com/vim-scripts/Align): Alignment tool. Add `:AlignHash` for Ruby Hashes.

* [CtrlP](https://github.com/kien/ctrlp.vim): Fuzzy finder. `<leader>f` to search. `Ctrl + x` (sp), `Ctrl + v` (vsp), `Ctrl + t` (tab)

* [vim-rails](https://github.com/tpope/vim-rails): `A` for alternate file, `R` for related file, `gf` fo partials, fixtures, etc.

* [vim-gitgutter](https://github.com/airblade/vim-gitgutter): Show git diff in gutter.

* [SingleCompile](https://github.com/xuhdev/SingleCompile): `<F10>` to compile current file.

* [NerdCommenter](https://github.com/scrooloose/nerdcommenter): `<leader>cc` to comment, `<leader>cu` to uncomment. `<leader>c<space>` to toggle.

Other good references
---------------------

* http://amix.dk/vim/vimrc.html
* http://spf13.com/post/perfect-vimrc-vim-config-file
