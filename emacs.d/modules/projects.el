(use-package projectile
  :ensure t
  :config (projectile-mode +1))

(use-package dash-at-point
  :ensure t)

(use-package bm
  :ensure t
  :init
  (setq bm-cycle-all-buffers t))

(use-package neotree
  :ensure t
  :init
  (setq neo-smart-open t))

(use-package rg
  :ensure t)

(use-package fzf
  :ensure t)

(use-package eyebrowse
  :ensure t
  :init (eyebrowse-mode t))

(defun open-file-at-point ()
  (interactive)
  (find-file (current-word)))

(desktop-save-mode 1)
