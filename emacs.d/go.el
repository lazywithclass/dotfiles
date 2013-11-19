(add-to-list 'load-path "/home/lazywithclass/go-1.1.2/misc/emacs")
(require 'go-mode-load)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-to-list 'load-path "/home/lazywithclass/gocode/src/github.com/dougm/goflymake")
(require 'go-flymake)
(require 'go-flycheck)

(add-to-list 'load-path "/home/lazywithclass/gocode/src/github.com/nsf/gocode/emacs")
(require 'go-autocomplete)
(require 'auto-complete-config) ; shouldn't be needed
