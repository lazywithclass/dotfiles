(setq inhibit-splash-screen t)

(setenv "PATH" "$HOME/usr/bin:$PATH" t)

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
(add-to-list 'ac-modes '(emacs-lisp-mode purescript-mode))

(setq gc-cons-threshold 20000000)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)

(require 'flymake-cursor)

(require 'fastnav)

(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(defun reload-init ()
  (interactive)
  (load-file "~/workspace/dotfiles/emacs.d/init.el"))

(show-paren-mode 1)

(require 'evil)
(evil-mode 1)
(add-to-list 'evil-emacs-state-modes 'nav-mode)

(savehist-mode 1)

(defun arrow () 
  (interactive)
  (insert "→")) 

(add-to-list 'load-path "~/workspace/emacs-nav")
(require 'nav)

(require 'move-text)
(move-text-default-bindings)

(defun sync-nav-with-current-buffer ()
  (interactive)
  (setq current-buffer-folder (el-get-replace-string (buffer-name) "" (buffer-file-name)))
  (windmove-left)
  (nav-jump-to-dir current-buffer-folder)
  (windmove-right))
