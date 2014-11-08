(global-set-key (kbd "C-f") 'fiplr-find-file)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-x C-k") 'ido-kill-buffer)

(global-set-key (kbd "C-S-w") 'duplicate-line)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c m") 'run-suite)
(global-set-key (kbd "C-c t") 'tern-get-type)
(global-set-key (kbd "C-c v") 'tern-highlight-refs)
(global-set-key (kbd "C-c C-a") 'iedit-mode)
(global-set-key (kbd "C-c s p") 'spotify-previous)
(global-set-key (kbd "C-c s t") 'spotify-toggle)
(global-set-key (kbd "C-c s n") 'spotify-next)
(global-set-key (kbd "C-c RET") 'switch-to-previous-buffer)
(global-set-key (kbd "C-j") 'ace-jump-char-mode)
(global-set-key (kbd "C-c l") 'ace-jump-line-mode)

(global-set-key (kbd "C-S-<up>") 'move-text-up)
(global-set-key (kbd "C-S-<down>") 'move-text-down)

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-m") 'back-to-indentation)

;; I'm not entirely sure why I had to specify this
(global-set-key [dead-grave] "`")
