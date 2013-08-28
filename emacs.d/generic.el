(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode."
  (interactive)
  (when (eq major-mode 'emacs-lisp-mode)
    (byte-compile-file buffer-file-name)))
(add-hook 'after-save-hook 'byte-compile-current-buffer)

(setq default-directory "~/workspace/" )

;; use git as backup not ~ files
(setq make-backup-files nil)

(set-default-font "Monaco-13")

(setq-default truncate-lines 1)

(setq inhibit-splash-screen t)
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)
;; cua goodness without remapping C-v and the likes
(cua-selection-mode t)

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
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(color-theme-solarized-dark)

(desktop-save-mode 1)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes '(coffee-mode emacs-lisp-mode ruby-mode))

(setq make-backup-files nil)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/yasnippets"))
(yas-global-mode 1)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

(setq twittering-icon-mode t)
(twittering-enable-unread-status-notifier)
;; display the remaining API calls
(setq twittering-display-remaining t)

(projectile-global-mode)
(setq projectile-require-project-root nil)

(setq gc-cons-threshold 20000000)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup)

(require 'flymake-cursor)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(whitespace-mode 1)
