(setq inhibit-startup-echo-area-message "lazywithclass")

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


