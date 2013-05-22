(add-to-list 'load-path "/home/lazywithclass/.emacs.d/el-get/scala-mode")
(require 'scala-mode-auto)
  
(add-to-list 'load-path "~/.emacs.d/outside-el-get/ensime_2.10.0-RC3-0.9.8.2/elisp")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

