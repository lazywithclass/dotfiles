;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alberto Zaccagni"
      user-mail-address "lazywithclass@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Monaco" :size 14 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq evil-want-fine-undo t)
(after! undo-fu
  (setq undo-fu-allow-undo-in-region t))
(map! :v "u" #'undo) ;; avoid evil-downcase

(setq-default evil-escape-delay 0.2)
(setq-default evil-escape-key-sequence "jk")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! projectile
  (setq projectile-enable-caching nil))

(setq c-basic-offset 2)

(global-visual-line-mode t)
(setq-default word-wrap t)

(setq twelf-root "/home/lazywithclass/workspace/twelf/")
(load (concat twelf-root "emacs/twelf-init.el"))

;; https://emacs.stackexchange.com/a/28746
(setq auto-window-vscroll nil)
(setq doom-modeline-enable-word-count nil)

(map! :leader :desc "Eval JS expression" :n "e" #'nodejs-repl-send-region)

(setq display-line-numbers-type 'relative)

(setq lsp-ui-doc-enable nil)
; (setq lsp-ui-doc-show-with-cursor nil)
; (setq lsp-ui-doc-show-with-mouse nil)

(after! lsp-mode
  (setq lsp-diagnostics-provider :flycheck))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(after! treemacs
  (treemacs-follow-mode 1))

(setq projectile-enable-caching nil)
(setq projectile-indexing-method 'alien)

;; (remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(after! lsp-java
  ;; (setq lsp-java-java-path "/usr/lib/jvm/java-17-openjdk/bin/java")

  ;; Enable signature help (shows method parameters)
  (setq lsp-signature-auto-activate t)

  ;; Download sources for library documentation
  (setq lsp-java-content-provider-preferred "fernflower"))

(add-hook! 'prog-mode-hook #'rainbow-mode)
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)

(setq clojure-indent-style 'always-align)

(after! clojure-mode
  (setq clojure-align-forms-automatically t))

(after! lsp-mode
  (setq lsp-eldoc-enable-hover nil))

(defun lazy/clj-reload ()
  (interactive)
  (cider-interactive-eval "(clj-reload.core/reload)"))

(setenv "CLJ_CONFIG" "/home/lazywithclass/.clojure")
(setenv "LD_LIBRARY_PATH" "/run/current-system/sw/share/nix-ld/lib")

(after! cider
  (setq cider-use-xref nil)

  ;; reload namespaces when testing
  (defun +my/cider-refresh (&rest _) (cider-ns-refresh))
  (advice-add 'cider-test-run-test     :before #'+my/cider-refresh)
  (advice-add 'cider-test-run-ns-tests :before #'+my/cider-refresh)

  ;; no docs in modeline on mouse over 
  (add-hook! 'cider-mode-hook
    (defun lazy/cider-prefer-lsp-completion ()
      (remove-hook 'completion-at-point-functions
                   #'cider-complete-at-point t))))

;; ignore projectile-git-command "unsafeness" in .dir-locals.el
(put 'projectile-git-command 'safe-local-variable #'stringp)

;; use difftastic as the default magit diff/show backend
(after! magit
  (require 'difftastic)
  (advice-add 'magit-diff-dwim   :override #'difftastic-magit-diff)
  (advice-add 'magit-show-commit :override #'difftastic-magit-show)

  ;; always pop the difftastic buffer below, full width, large height
  (setq difftastic-display-buffer-function
        (lambda (buffer-or-name _requested-width)
          (pop-to-buffer buffer-or-name
                         '((display-buffer-at-bottom)
                           (window-height . 0.8)))))

  (defun lazy/difftastic-magit-file-diff ()
    "Show difftastic diff for the file at point in magit-status."
    (interactive)
    (let ((file (magit-file-at-point t)))
      (difftastic-magit-diff (car (magit-diff-arguments)) (list file))))

  (keymap-set magit-file-section-map "D" #'lazy/difftastic-magit-file-diff))
