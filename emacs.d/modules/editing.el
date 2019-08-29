(use-package multiple-cursors
  :ensure t
  :init (require 'multiple-cursors))

(use-package undo-tree
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package dumb-jump
  :ensure t
  :config (setq dumb-jump-selector 'ivy))

(use-package helm-swoop
  :ensure t)

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode)

