;; remember to follow these steps
;; https://github.com/Sarcasm/irony-mode/issues/167#issuecomment-71817840

(load "packages.el")

(install-packages '(irony modern-cpp-font-lock))

(modern-c++-font-lock-global-mode t)

;; TODO this tries to index anything it finds, find a way to scope
;; it, the generated files contains EVERYTHING and is gigantic
;; (load "counsel-etags.el")
;; (require 'counsel-etags)
;; Ignore files above 800kb
(setq counsel-etags-max-file-size 800)
;; Don't ask before rereading the TAGS files if they have changed
(setq tags-revert-without-query t)
(setq large-file-warning-threshold nil)
;; How many seconds to wait before rerunning tags for auto-update
(setq counsel-etags-update-interval 180)

(add-hook
 'prog-mode-hook
 (lambda () (add-hook 'after-save-hook
                      (lambda ()
                        (counsel-etags-virtual-update-tags)))))

 (add-hook 'c++-mode-hook 'irony-mode)
 (add-hook 'c-mode-hook 'irony-mode)

 (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
