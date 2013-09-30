(setq inhibit-splash-screen t)

(setq default-directory "~/workspace/" )

(color-theme-solarized-dark)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode."
  (interactive)
  (when (eq major-mode 'emacs-lisp-mode)
    (byte-compile-file buffer-file-name)))
(add-hook 'after-save-hook 'byte-compile-current-buffer)

;; use git as backup not ~ files
(setq make-backup-files nil)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(ido-everywhere 1)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

(desktop-save-mode 1)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes '(emacs-lisp-mode ruby-mode))

(setq twittering-icon-mode t)
(twittering-enable-unread-status-notifier)
;; display the remaining API calls
(setq twittering-display-remaining t)

(setq gc-cons-threshold 20000000)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)

(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup)

(require 'flymake-cursor)

(require 'fastnav)
