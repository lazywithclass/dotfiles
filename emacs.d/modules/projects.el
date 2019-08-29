(use-package projectile
  :ensure t
  :config (projectile-mode +1))

(use-package ripgrep
  :ensure t)

(use-package dash-at-point
  :ensure t)

(use-package bm
  :ensure t
  :init
  (setq bm-cycle-all-buffers t))
