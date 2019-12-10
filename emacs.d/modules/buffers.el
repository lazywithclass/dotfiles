(use-package beacon
  :ensure t
  :config (beacon-mode t))

(use-package ido
  :ensure t
  :config
  (ido-mode 1)
  (setq ido-enable-flex-matching t
        ido-everywhere t
        ido-ignore-buffers '("^ "
                             "*Completions*"
                             "*Shell Command Output*"
                             "*Messages*"
                             )))

(use-package window-numbering
  :ensure t
  :config (progn
            (global-auto-revert-mode t)
            (window-numbering-mode t))) 

(use-package buffer-move
  :ensure t)

;; https://unix.stackexchange.com/questions/19874/prevent-unwanted-buffers-from-opening

;; Makes *scratch* empty.
(setq initial-scratch-message "oh hai")

(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
