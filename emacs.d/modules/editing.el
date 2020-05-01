(use-package multiple-cursors
  :ensure t
  :init (require 'multiple-cursors))

(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package helm-swoop
  :ensure t)

(use-package browse-kill-ring
  :ensure t)

(use-package avy
  :ensure t)

(use-package ws-butler
  :hook (prog-mode-hook . ws-butler-mode)
  :init (require 'ws-butler)
  :ensure t)

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode)

;; TODO should I also use this?
;; https://stackoverflow.com/questions/823745/how-do-i-make-emacs-auto-indent-my-c-code
(use-package aggressive-indent
  :ensure t
  :config (global-aggressive-indent-mode 1))

(save-place-mode 1) 
(show-paren-mode 1)
