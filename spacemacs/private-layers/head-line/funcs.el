(defun buffer-path()
  (defconst file-path (buffer-file-name (window-buffer (minibuffer-selected-window))))
  (defconst project-path (projectile-locate-dominating-file file-path ".git"))
  (s-replace project-path "" file-path))

(defun project-name()
  (defconst project-path (projectile-locate-dominating-file file-path ".git"))
  (car (last (s-split-words project-path))))

(set-face-attribute 'header-line nil
                    :inherit nil
                    :foreground "#B2B2B2"
                    :background "#292B2E"
                    :underline "#5D4D7A")

(setq-default
 header-line-format '(:eval (concat (project-name) " | " (buffer-path))))
