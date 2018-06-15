(load "packages.el")

(install-packages '(color-theme-solarized))

(load-theme 'solarized t)

(setq inhibit-startup-echo-area-message "lazywithclass")
(setq inhibit-startup-screen t)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)

(set-frame-font "Monaco-13")
(set-default 'truncate-lines t)

;; use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)
;; cua goodness without remapping C-v and the likes
(cua-selection-mode t)

;; no point and click
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq-default left-margin-width 4 right-margin-width 4)

(blink-cursor-mode 0)
