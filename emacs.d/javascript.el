(setq-default js2-global-externs '("process" "module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "__dirname" "console" "JSON" "describe" "it" "expect" "$" "Backbone" "Handlebars" "should" "sinon" "beforeEach"))
(setq js2-allow-keywords-as-property-names nil)
(setq js2-basic-offset 2)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

(add-to-list 'load-path "/home/lazywithclass/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; credit http://stackoverflow.com/a/13784404/57095
(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'slime-repl-mode)
     (add-to-list 'ac-modes 'js2-mode)
     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)))
(eval-after-load 'slime
  '(progn
     (setq slime-protocol-version 'ignore
           slime-net-coding-system 'utf-8-unix
           slime-complete-symbol*-fancy t
           slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (slime-setup '(slime-repl slime-js))))

(defun run-suite()
  "Runs all the tests in the current buffer"
  (interactive)
  (let* (exit-value)
    (setq exit-value (call-process-shell-command "make" nil (get-buffer-create "*JavaScript test output*") nil "-C .." "test"))
    (color-modeline exit-value)))

(defun color-modeline(exit-value)
  "Colors the modeline, green success red failure"
  (interactive)
  (let (test-result-color)
    (if (= exit-value 0)
        (setq test-result-color "Green")
      (setq test-result-color "Red"))
    (set-face-foreground 'mode-line test-result-color)
    (run-at-time "1 sec" nil 'no-color-modeline)))

(defun no-color-modeline()
  "No color for the modeline"
  (interactive)
  (set-face-foreground 'mode-line nil))
