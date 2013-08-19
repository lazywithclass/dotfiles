(add-to-list 'load-path "/usr/lib/go/misc/emacs")
(add-to-list 'load-path "/home/lazywithclass/go/src/github.com/nsf/gocode/emacs")
(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")

(require 'go-mode-load)
(require 'go-autocomplete)
(require 'go-flymake)

(add-hook 'go-mode-hook (lambda ()
                          (setq tab-width 4
                                c-basic-offset 4)))
