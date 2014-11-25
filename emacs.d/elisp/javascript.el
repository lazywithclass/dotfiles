(setq-default js2-global-externs '("process" "module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "__dirname" "console" "JSON" "describe" "it" "expect" "$" "Backbone" "Handlebars" "should" "sinon" "beforeEach" "afterEach" "_" "angular"))
(setq js2-allow-keywords-as-property-names nil)
(setq js2-basic-offset 2)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.?js\\'" . js2-mode))
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

;; credit for the initial idea goes to
;; https://github.com/dwwoelfel/.emacs.d/blob/master/site-lisp/setup-slime-js.el
(defun slime-js-run-swank ()
  "Runs the swank side of the equation. Needs swank-js to be there"
  (interactive)
  (apply #'make-comint "swank-js" "swank-js" nil '("4008")))

(defun slime-js-jack-in-node ()
  "Start a swank-js server and connect to it, opening a repl."
  (interactive)
  (slime-js-run-swank)
  (sleep-for 1)
  (setq slime-protocol-version 'ignore)
  (slime-connect "localhost" 4008))
 
(defun slime-js-jack-in-browser (target-url)
  "Start a swank-js server, connect to it, open a repl, open a browser, connect to that."
  (interactive "sTarget url: ")
  (slime-js-jack-in-node)
  (sleep-for 2)
  ;; this is the url we want to develop on
  (slime-js-set-target-url target-url)
  ;; while this is the url at which the proxy resides
  (shell-command (concat "google-chrome" " " "http://localhost:8009" "/"))
  (sleep-for 3)
  (setq slime-remote-history nil)
  (slime-js-sticky-select-remote (caadr (slime-eval '(js:list-remotes)))))

;; TODO continue with the other functions, there are a lot of good things at that url
;; https://github.com/dwwoelfel/.emacs.d/blob/master/site-lisp/setup-slime-js.el

(defun js2-eval-friendly-node-p (n)
  (or (and (js2-stmt-node-p n) (not (js2-block-node-p n)))
      (and (js2-function-node-p n) (js2-function-node-name n))))

(defun slime-js-eval-buffer ()
  (slime-js-eval-region (point-min) (point-max)))

(defun slime-js-eval-region (beg end &optional func)
  (lexical-let ((func (or func 'slime-js--echo-result))
                (beg beg)
                (end end))
    (slime-flash-region beg end)
    (slime-js-eval
     (buffer-substring-no-properties beg end)
     #'(lambda (s) (funcall func (cadr s) beg end)))))

(defun slime-js-eval-statement (&optional func)
  (let ((node (js2r--closest 'js2-eval-friendly-node-p)))
    (slime-js-eval-region (js2-node-abs-pos node)
                          (js2-node-abs-end node)
                          func)))

(defun slime-js-eval-current ()
  (interactive)
  (if (use-region-p)
      (slime-js-eval-region (point) (mark))
    (slime-js-eval-statement)))

;; just take what I need from https://github.com/magnars/js2-refactor.el
;; to make this work

(defun js2r--closest (p)
  (save-excursion
    (cond
     ((bolp) (back-to-indentation))
     ((looking-at ";") (forward-char -1))
     ((looking-back ";") (forward-char -2))
     ((looking-back "}") (forward-char -1)))
    (js2r--closest-node-where p (js2-node-at-point))))

(defun js2r--closest-node-where (p node)
  (if (or (null node)
          (apply p node nil))
      node
    (js2r--closest-node-where p (js2-node-parent node))))

(defun slime-js--echo-result (result &rest _)
  (message result))

;; not yet fully functional, understand why https://github.com/magnars/js2-refactor.el
(require 'js2-refactor)
