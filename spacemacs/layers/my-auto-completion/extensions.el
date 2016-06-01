(setq
 auto-completion-private-snippets-directory "~/workspace/dotfiles/spacemacs/yasnippets"
 auto-completion-enable-help-tooltip t
 auto-completion-enable-sort-by-usage t)

(defun autocomplete-show-snippets ()
  "Show snippets in autocomplete popup."
  (let ((backend (car company-backends)))
    (unless (listp backend)
      (setcar company-backends `(,backend :with company-yasnippet company-files)))))
(add-hook 'after-change-major-mode-hook 'autocomplete-show-snippets)
