(load "packages.el")

(install-packages '(evil evil-escape undo-tree goto-chg))

(require 'evil)
(evil-mode 1)

(evil-escape-mode)
(setq-default evil-escape-key-sequence "fd")
