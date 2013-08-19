(setq-default js2-global-externs '("process" "module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "__dirname" "console" "JSON"))
(setq js2-allow-keywords-as-property-names nil)
(setq js2-basic-offset 2)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

(add-to-list 'load-path "/home/lazywithclass/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

;; credit http://stackoverflow.com/a/13784404/57095
(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'slime-repl-mode)
     (add-to-list 'ac-modes 'js2-mode)
     (add-to-list 'ac-modes 'js-mode)
     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)))
(eval-after-load 'slime
  '(progn
     (setq slime-protocol-version 'ignore
           slime-net-coding-system 'utf-8-unix
           slime-complete-symbol*-fancy t
           slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (slime-setup '(slime-repl slime-js))))
