(use-package web-mode
  :ensure t
  :config
  (require 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))
