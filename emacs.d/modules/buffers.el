(load "packages.el")

(install-packages '(beacon ido window-numbering))

(beacon-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(window-numbering-mode t)

(setq ido-ignore-buffers '("^ "
                           "*Completions*"
                           "*Shell Command Output*"
                           "*Messages*"
                           ))

