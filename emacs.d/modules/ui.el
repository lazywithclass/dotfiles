(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-buffer-file-name-style 'buffer-name
        doom-modeline-vcs-max-length 999999))

(use-package doom-themes
  :ensure t)

(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-dark t))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package flx
  :ensure t
  :config (require 'flx))

(use-package ivy
  :ensure t
  :requires flx
  :config (progn
            (ivy-mode 1)
            (setq ivy-count-format ""
                  ivy-display-style nil
                  ivy-minibuffer-faces nil
                  ivy-use-virtual-buffers t
                  ivy-re-builders-alist '((t . ivy--regex-fuzzy)))))

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(setq enable-recursive-minibuffers t
      inhibit-startup-echo-area-message "lazywithclass"
      inhibit-startup-screen t
      tab-width 4
      scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(setq-default indent-tabs-mode nil)

(global-hl-line-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)

(set-frame-font "Monaco-14")
(set-default 'truncate-lines t)

;; use the clipboard, pretty please, so that copy/paste "works"
(setq select-enable-clipboard t)
;; cua goodness without remapping C-v and the likes
(cua-selection-mode t)

;; no point and click
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq-default left-margin-width 4 right-margin-width 4)

(setq-default frame-title-format "%f")

(blink-cursor-mode 0)

;; prefer horizontal split
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window-Options.html
(setq split-width-threshold 999)


(setq header-line-format
      (concat (propertize " " 'display '((space :align-to 0))) ""))

(setq header-line-format
      '(:eval
        (concat (and (display-graphic-p)
                     (concat " "  ;; fringe
                             (and (eq 'left (frame-parameter nil 'vertical-scroll-bars))
                                  "  ")))  ;; left scrollbar
                "")))

(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))

(defun sl/make-header ()
  ""
  (let* ((sl/full-header (abbreviate-file-name buffer-file-name))
         (sl/header (file-name-directory sl/full-header))
         (sl/drop-str "[...]"))
    (if (> (length sl/full-header)
           (window-body-width))
        (if (> (length sl/header)
               (window-body-width))
            (progn
              (concat (with-face sl/drop-str
                                 :background "blue"
                                 :weight 'bold)
                      (with-face (substring sl/header
                                            (+ (- (length sl/header)
                                                  (window-body-width))
                                               (length sl/drop-str))
                                            (length sl/header))
                                 ;; :background "red"
                                 :weight 'bold)))
          (concat (with-face sl/header
                             ;; :background "red"
                             :foreground "#8fb28f"
                             :weight 'bold
                             )))
      (concat (with-face sl/header
                         ;; :background "green"
                         ;; :foreground "black"
                         :weight 'bold
                         :foreground "#8fb28f"
                         )
              (with-face (file-name-nondirectory buffer-file-name)
                         :weight 'bold
                         ;; :background "red"
                         )))))

(defun sl/display-header ()
  (setq header-line-format
        '("" ;; invocation-name
          (:eval (if (buffer-file-name)
                     (sl/make-header)
                   "%b")))))

(sl/display-header)

(add-hook 'buffer-list-update-hook
          'sl/display-header)
