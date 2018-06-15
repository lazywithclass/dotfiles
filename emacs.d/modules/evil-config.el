(load "packages.el")

(install-packages '(evil evil-escape evil-terminal-cursor-changer undo-tree goto-chg))

(require 'evil)
(evil-mode 1)

(evil-escape-mode)
(setq-default evil-escape-key-sequence "jk")

;; TODO could I also have the same colors as the GUI one?
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate))

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
