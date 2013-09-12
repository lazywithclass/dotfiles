(add-to-list 'load-path "~/.emacs.d/el-get/coffee-mode")
(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\.erb$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(add-hook 'coffee-mode-hook '(lambda () 
                               (auto-complete-mode)))
