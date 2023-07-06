(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :config (progn
            (setq js2-basic-offset 2)
            (setq js2-strict-missing-semi-warning nil)
            (setq js2-mode-show-strict-warnings nil)))

;; don't add this as hook in the use-package declaration above
;; for some reason it does not work
(add-hook 'js2-mode-hook 'flycheck-mode)

(use-package json-mode
  :ensure t
  :mode (("\\.side\\'" . json-mode)
         "\\.json\\'"))
