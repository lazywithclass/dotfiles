(load "packages.el")

(install-packages '(ivy swiper counsel flx))

(ivy-mode 1)
(setq ivy-count-format ""
      ivy-display-style nil
      ivy-minibuffer-faces nil)

; Let ivy use flx for fuzzy-matching
(require 'flx)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

; Use Enter on a directory to navigate into the directory, not open it with dired.
(define-key ivy-minibuffer-map (kbd "C-m") 'ivy-alt-done)
(global-set-key (kbd "C-x C-f") 'counsel-git)
