(use-package tide
  :ensure t
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode))
  :config
  (setq-default typescript-indent-level 2)
  (flycheck-mode t)
  (setq flycheck-checker 'typescript-tslint)
  (company-mode t))

