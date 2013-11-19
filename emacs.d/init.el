(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/yasnippets")
(add-to-list 'load-path "~/.emacs.d/slime")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(el-get 'sync)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package)) 
           (package-install package))))
 '(ac-slime auto-complete dash fiplr flymake-easy grizzl multi-web-mode popup s slime slime-js slime-repl fastnav flycheck flymake))

(load "~/.emacs.d/generic.el")
(load "~/.emacs.d/keys-mappings.el")
(load "~/.emacs.d/editing.el")
(load "~/.emacs.d/javascript.el")
(load "~/.emacs.d/coffee.el")
(load "~/.emacs.d/html.el")
;; (load "~/.emacs.d/ruby.el")
(load "~/.emacs.d/web.el")
(load "~/.emacs.d/spotify.el")
(load "~/.emacs.d/go.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(nav-filtered-p nil)
 '(nav-width 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
