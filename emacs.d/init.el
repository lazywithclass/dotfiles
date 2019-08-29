(add-to-list 'load-path "~/.emacs.d/modules")
(load "packages")

(load "generic")

(load "autocomplete")
(load "backup-config")
(load "buffers")
(load "commands")
;; (load "debug")
(load "editing")
(load "evil-config")
(load "git")
(load "projects")
(load "ui")

(load "language-agnostic")

(load "antlr")
(load "clojure")
(load "javascript")
(load "lisp")
(load "python")
(load "ruby")
(load "typescript")

;; after all modes have been configured
(load "key-bindings")

;; TODOs
;; https://unix.stackexchange.com/questions/19874/prevent-unwanted-buffers-from-opening
;; https://nathantypanski.com/blog/2014-08-03-a-vim-like-emacs-config.html

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" default)))
 '(doom-modeline-mode t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (helm-swoop smart-mode-line bm dash-at-point helm-dash spray dumb-jump rainbow-delimiters lsp-treemacs helm-lsp company-lsp lsp-ui dap-javascript dap-mode helm-gtags projectile-ripgrep rg skewer-mode anaconda-mode rvm exec-path-from-shell dired-sidebar git-gutter doom-themes doom-modeline magit ripgrep helm-rg amx helm geiser json-mode js2-mode ggtags rake ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv enh-ruby-mode chruby bundler multiple-cursors projectile general markdown-mode window-numbering use-package tide solarized-theme slime ivy highlight-parentheses flx evil-terminal-cursor-changer evil-escape company-ycmd beacon avy)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(ring-bell-function (quote ignore))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background-mode nil)
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
