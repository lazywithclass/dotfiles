(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)

(set-frame-font "Monaco-13")
(set-default 'truncate-lines t)

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)
;; cua goodness without remapping C-v and the likes
(cua-selection-mode t)

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/yasnippets"))
(yas-global-mode 1)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
