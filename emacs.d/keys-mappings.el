(global-set-key (kbd "C-x f") 'fiplr-find-file)
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

(global-set-key (kbd "C-c RET") 'switch-to-previous-buffer)

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
(global-set-key "\M-s" 'fastnav-jump-to-char-forward)
(global-set-key "\M-S" 'fastnav-jump-to-char-backward)
(global-set-key "\M-r" 'fastnav-replace-char-forward)
(global-set-key "\M-R" 'fastnav-replace-char-backward)
(global-set-key "\M-i" 'fastnav-insert-at-char-forward)
(global-set-key "\M-I" 'fastnav-insert-at-char-backward)
(global-set-key "\M-j" 'fastnav-execute-at-char-forward)
(global-set-key "\M-J" 'fastnav-execute-at-char-backward)
(global-set-key "\M-k" 'fastnav-delete-char-forward)
(global-set-key "\M-K" 'fastnav-delete-char-backward)
(global-set-key "\M-m" 'fastnav-mark-to-char-forward)
(global-set-key "\M-M" 'fastnav-mark-to-char-backward)
(global-set-key "\M-p" 'fastnav-sprint-forward)
(global-set-key "\M-P" 'fastnav-sprint-backward)
