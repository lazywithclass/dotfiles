; TODO https://github.com/syl20bnr/spacemacs/blob/master/layers/%2Blang/ruby/packages.el 

(use-package enh-ruby-mode
  :ensure t)

(use-package rubocop
  :ensure t)

(use-package rvm
  :ensure t
  :config (rvm-activate-corresponding-ruby))

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

