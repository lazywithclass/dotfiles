(add-to-list 'load-path "~/.emacs.d/elisp")
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
 '(ac-slime auto-complete dash fiplr flymake-easy grizzl multi-web-mode popup s slime slime-js slime-repl fastnav flycheck flymake clojure-mode))

(load "~/.emacs.d/elisp/generic.el")
(load "~/.emacs.d/elisp/keys-mappings.el")
(load "~/.emacs.d/elisp/editing.el")
(load "~/.emacs.d/elisp/javascript.el")
(load "~/.emacs.d/elisp/coffee.el")
(load "~/.emacs.d/elisp/html.el")
;; (load "~/.emacs.d/elisp/ruby.el")
(load "~/.emacs.d/elisp/web.el")
(load "~/.emacs.d/elisp/spotify.el")
(load "~/.emacs.d/elisp/go.el")
(load "~/.emacs.d/elisp/clojurescript.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(js2-instanceof-has-side-effects nil)
 '(js2-strict-inconsistent-return-warning nil)
 '(nav-filtered-p nil)
 '(nav-width 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
