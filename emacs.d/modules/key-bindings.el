(setq mac-command-modifier 'meta)

(define-key ivy-minibuffer-map (kbd "C-m") 'ivy-alt-done) ;; Use Enter on a directory to navigate into the directory, not open it with dired.

(global-set-key (kbd "C-x C-m") 'execute-extended-command) 
(global-set-key (kbd "C-c f") 'counsel-git)
(global-set-key (kbd "C-c g") 'counsel-rg)
(global-set-key (kbd "C-M-s") 'swiper)
(global-set-key (kbd "C-s") 'avy-goto-char-timer)

(global-set-key (kbd "<C-tab>") 'evil-switch-to-windows-last-buffer)
(global-set-key (kbd "<C-M-tab>") 'ido-switch-buffer)

