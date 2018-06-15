(load "packages.el")

(install-packages '(ivy swiper counsel flx))

(ivy-mode 1)
(setq ivy-count-format ""
      ivy-display-style nil
      ivy-minibuffer-faces nil)

; Let ivy use flx for fuzzy-matching
(require 'flx)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

(defvar counsel-git-cmd "git ls-files --others --full-name --" "Command for `counsel-git'.")
