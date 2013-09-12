(global-set-key (kbd "C-x f") 'find-file-in-repository)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(global-set-key (kbd "C-S-w") 'duplicate-line)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c m") 'run-suite)
(global-set-key (kbd "C-c t") 'tern-get-type)
(global-set-key (kbd "C-c C-a") 'iedit-mode)

(global-set-key (kbd "C-c s p") 'spotify-previous)
(global-set-key (kbd "C-c s t") 'spotify-toggle)
(global-set-key (kbd "C-c s n") 'spotify-next)

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(global-set-key [f11] 'fullscreen)
