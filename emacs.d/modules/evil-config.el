(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-key-sequence "jk")
  (setq
   evil-want-fine-undo t
   evil-emacs-state-cursor '("red" box)
   evil-normal-state-cursor '("green" box)
   evil-visual-state-cursor '("orange" box)
   evil-insert-state-cursor '("red" bar)
   evil-replace-state-cursor '("red" bar)
   evil-operator-state-cursor '("red" hollow)))

(use-package evil-terminal-cursor-changer
  :ensure t)

;; TODO could I also have the same colors as the GUI one?
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate))

