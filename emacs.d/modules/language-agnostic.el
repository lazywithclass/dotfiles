(use-package helm-gtags
  :ensure t)

;; TODO could this be delegated to dap?
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; TODO write a wrapper for lsp that falls back on dumb-jump if the first fails
(use-package dumb-jump
  :ensure t
  :config (setq dumb-jump-selector 'ivy))

(use-package dap-mode
  :ensure t
  :config
  (dap-mode +1)
  (dap-ui-mode)
  (require 'dap-chrome)
  (require 'dap-node))

(use-package lsp-mode
  :ensure t
  :commands lsp)

(use-package lsp-mode
  :hook (
         (emacs-lisp-mode . lsp)
         (js2-mode . lsp)
         (ruby-mode . lsp)
         (typescript-mode . lsp))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
