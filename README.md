vim-antelope
==========

Make vim more Antelope friendly!

Provides
--------

  * Automatic filetype detection for Antelope file extensions such as xpl and xpy

Additional useful plugins
-------------------------

 * [syntastic](https://github.com/scrooloose/syntastic) plugin for automatic
   syntax checking while in vim.
   [snipmate](https://github.com/garbas/vim-snipmate) and
   [ultisnips](https://github.com/SirVer/ultisnips).

Installation
------------

If you're using [pathogen](https://github.com/tpope/vim-pathogen) to manage your vim modules (and if you're not, why
aren't you), you can simply add this as a submodule in your `~/.vim/bundle/`
directory.

My entire home directory is a git repository, so for me it's simply a case of

    $ git submodule add -f git://github.com/rodjek/vim-antelope.git .vim/bundle/antelope

If you're not using pathogen, you can just manually place the files in the
appropriate places under `~/.vim/`
