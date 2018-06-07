#!/bin/bash

cd ..
mv ~/.emacs.d ~/.emacs.d-pre-lazy
ln -s $(pwd)/emacs.d ~/.emacs.d
