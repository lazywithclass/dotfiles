(use-package general
  :ensure t)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(setq mac-command-modifier 'meta)

(define-key evil-normal-state-map           [escape] 'keyboard-quit)
(define-key evil-visual-state-map           [escape] 'keyboard-quit)
(define-key minibuffer-local-map            [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map         [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map    [escape] 'minibuffer-keyboard-quit)

(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(global-set-key (kbd "C-x C-m")   'execute-extended-command)
(global-set-key (kbd "M-s")       'save-buffer)

(general-auto-unbind-keys)

(general-define-key :states '(normal)        :keymaps 'override "/"       'helm-swoop)
(general-define-key :states '(normal insert) :keymaps 'override "C-a"     'projectile-find-file)
(general-define-key :states '(normal insert) :keymaps 'override "C-b"     'evil-switch-to-windows-last-buffer)
(general-define-key :states '(normal insert) :keymaps 'override "C-d"     'dash-at-point)
(general-define-key :states '(normal insert) :keymaps 'override "C-j"     'dumb-jump-go)
(general-define-key :states '(normal insert) :keymaps 'override "C-k"     'kill-this-buffer)
(general-define-key :states '(normal insert) :keymaps 'override "C-q"     'dired-sidebar-toggle-with-current-directory)
(general-define-key :states '(normal insert) :keymaps 'override "C-s"     'helm-swoop)
(general-define-key :states '(normal insert) :keymaps 'override "C-w C-w" 'evil-window-next)
(general-define-key :states '(normal insert) :keymaps 'override "C-;"     'comment-line)
(general-define-key :states '(normal insert) :keymaps 'override "C-c p p" 'projectile-switch-project)
(general-define-key :states '(normal insert) :keymaps 'override "C-c p b" 'projectile-switch-to-buffer)
(general-define-key :states '(normal insert) :keymaps 'override "C-c g"   'projectile-ripgrep)
(general-define-key :states '(normal insert) :keymaps 'override "C-t"     'bm-toggle)
(general-define-key :states '(normal insert) :keymaps 'override "<tab>"   'bm-next)
(general-define-key :states '(normal insert) :keymaps 'override "C-<tab>" 'bm-previous)
