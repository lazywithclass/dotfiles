(load "packages.el")

(install-packages '(ycmd company company-ycmd flycheck))

(set-variable 'ycmd-server-command '("python" "/Users/lazywithclass/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd"))
;(set-variable 'ycmd-extra-conf-whitelist "/Users/lazywithclass/Documents/.ycm_extra_conf.py")
(set-variable 'ycmd-global-config "/Users/lazywithclass/Documents/.ycm_extra_conf.py")
(setq ycmd-force-semantic-completion t)

(require 'ycmd)
(add-hook 'c++-mode-hook 'ycmd-mode)

(add-hook 'after-init-hook 'global-company-mode)

(require 'company-ycmd)
(company-ycmd-setup)

(require 'ycmd-eldoc)
(add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)

(setq company-backends (delete 'company-semantic company-backends))
(setq company-backends (delete 'company-eclim company-backends))
(setq company-backends (delete 'company-xcode company-backends))
(setq company-backends (delete 'company-clang company-backends))
(setq company-backends (delete 'company-bbdb company-backends))
(setq company-backends (delete 'company-oddmuse company-backends))
