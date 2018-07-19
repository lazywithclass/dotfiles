(load "packages.el")

(use-package tide
  :ensure t
  :mode(("\\.ts\\'" . typescript-mode))
  :config
  (tide-setup)
  (flycheck-mode +1))
