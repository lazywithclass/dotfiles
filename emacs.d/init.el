(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modules")

(load "autocomplete.el")
(load "buffers.el")

(load "avy-config.el")
(load "backup-config.el")
(load "ivy-config.el")
(load "c++-config.el")
(load "evil-config.el")
(load "ui.el")

;; after all modes have been configured
(load "key-bindings.el")

;; TODOs
;; https://unix.stackexchange.com/questions/19874/prevent-unwanted-buffers-from-opening
;; https://nathantypanski.com/blog/2014-08-03-a-vim-like-emacs-config.html

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (slime tide markdown-mode use-package irony evil)))
 '(ring-bell-function (quote ignore)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
