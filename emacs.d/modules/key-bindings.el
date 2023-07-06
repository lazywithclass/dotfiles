(use-package general
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (require 'which-key)
  (which-key-mode)
  (setq which-key-idle-delay 1))

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
(general-evil-setup)

(general-imap "="
  (general-key-dispatch 'self-insert-command
    :timeout 0.25
    "=" 'evil-indent-line))

;; remember C-p is how you cycle though the kill ring, don't override that
(general-define-key :states '(normal)               :keymaps 'override             "/"              'evil-search-forward)
(general-define-key :states '(normal)               :keymaps 'override             "f"              'avy-goto-char)
(general-define-key :states '(normal)               :keymaps 'override             "n"              'evil-search-next)
(general-define-key :states '(normal)               :keymaps 'override             "N"              'evil-search-previous)
(general-define-key :states '(normal visual)        :keymaps 'override             "u"              'undo-only)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-a"            'fzf-git)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-b"            'projectile-project-buffers-other-buffer)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-d"            'dash-at-point)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-e"            'evil-end-of-line)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-j j"          'dumb-jump-go)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-j b"          'dumb-jump-back)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-j o"          'dumb-jump-go-other-window)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-k"            'kill-this-buffer)
(general-define-key :states '(normal visual)        :keymaps 'override             "C-m"            'mc/mark-next-like-this)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-o"            'open-file-at-point)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-q"            'beginning-of-line-text)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-s"            'helm-swoop)
(general-define-key :states '(normal insert)        :keymaps '(override term-mode) "C-y"            'term-paste)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-w"            'evil-window-next)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-;"            'comment-line)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c f r"        'recentf-open-files)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c g g"        'magit)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c g h"        'magit-log-buffer-file)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c h ."        'highlight-symbol-at-point)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c h r"        'unhighlight-regexp)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c k b"        'browse-kill-ring)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p p"        'eyebrowse-last-window-config)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p \""       'eyebrowse-close-window-config)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p ,"        'eyebrowse-rename-window-config)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p b"        'projectile-switch-to-buffer)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p l"        'eyebrowse-switch-to-window-config)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c p c"        'eyebrowse-create-window-config)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c r"          'rg)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c u"          'undo-tree)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c w <left>"   'buf-move-left)
(general-define-key :states '(normal insert)        :keymaps 'override             "C-c w <right>"  'buf-move-right)

;; TODO if there are no bookmarks just cycle buffer history
(general-define-key :states '(normal insert)        :keymaps 'override "C-t"     'bm-toggle)   ; bookmark
(general-define-key :states '(normal insert)        :keymaps 'override "<tab>"   'bm-next)     ; bookmark
(general-define-key :states '(normal insert)        :keymaps 'override "C-<tab>" 'bm-previous) ; bookmark

(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "E") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "m") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)


