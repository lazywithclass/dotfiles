(use-package helm-gtags
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package yasnippet
  :ensure t)

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
  :hook (
         (enh-ruby-mode . lsp)
         ;; TODO this might be wrong
         (tide-mode . lsp))
  :ensure t
  :config

  ;; change nil to 't to enable logging of packets between emacs and the LS
  ;; this was invaluable for debugging communication with the MS Python Language Server
  ;; and comparing this with what vs.code is doing
  (setq lsp-print-io nil)

  ;; lsp-ui gives us the blue documentation boxes and the sidebar info
  ;; TODO commented out because it's making TS buffers lag
  ;; (use-package lsp-ui
  ;;   :ensure t
  ;;   :config
  ;;   (setq lsp-ui-sideline-ignore-duplicate t)
  ;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

  ;; (require 'lsp-imenu)
  ;; (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

  (use-package company-lsp
    :ensure t
    :config
    (push 'company-lsp company-backends)))

;; (use-package polymode
;;   :ensure t
;;   :mode
;;   ("\.ts$" . poly-ts-web-mode)
;;   ("\.js$" . js2-mode)
;;   :config
;;   (define-hostmode poly-ts-hostmode :mode 'typescript-mode))

;; (define-innermode poly-ts-web-innermode
;;   :mode 'html-mode
;;   :head-matcher " `\n"
;;   :tail-matcher "`"
;;   :head-mode 'host
;;   :tail-mode 'host)

;; (define-polymode poly-ts-web-mode
;;   :hostmode 'poly-ts-hostmode
;;   :innermodes '(poly-ts-web-innermode)
;;   (setq-default typescript-indent-level 2)
;;   (add-hook 'typescript-mode #'tide-setup)
;;   (add-hook 'typescript-mode #'tide-hl-identifier-mode)
;;   (web-mode-set-content-type "ts"))
