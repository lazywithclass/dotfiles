(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(defun install-package (package)
  (unless (package-installed-p package)
    (package-install package)))

(defun install-packages (packages)
  (package-refresh-contents)
  (mapc #'install-package packages))

