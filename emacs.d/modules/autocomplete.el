(load "packages.el")

(use-package ycmd
  :ensure t)
(use-package company
  :ensure t)
(use-package company-ycmd
  :ensure t)
(use-package flycheck
  :ensure t)

;; TODO commented until this becomes more stable, makes emacs lag as of now
;; (use-package company-tabnine
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends #'company-tabnine)
;;   (setq company-idle-delay 0
;;         company-show-numbers t))

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(set-variable 'ycmd-server-command '("python" "/Users/lazywithclass/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd"))
;(set-variable 'ycmd-extra-conf-whitelist "/Users/lazywithclass/Documents/.ycm_extra_conf.py")
(set-variable 'ycmd-global-config "/Users/lazywithclass/Documents/.ycm_extra_conf.py")
(setq ycmd-force-semantic-completion t)

(require 'ycmd)

(add-hook 'after-init-hook 'global-company-mode)

(require 'company-ycmd)
(company-ycmd-setup)

(require 'ycmd-eldoc)
(add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)

(setq company-backends (delete 'company-semantic company-backends))
(setq company-backends (delete 'company-eclim company-backends))
(setq company-backends (delete 'company-xcode company-backends))
(setq company-backends (delete 'company-clang company-backends))
(setq company-backends (delete 'company-bbdb company-backends))
(setq company-backends (delete 'company-oddmuse company-backends))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

