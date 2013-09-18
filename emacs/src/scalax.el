;; xxx dupe with python



(defun scala-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key scala-mode-map (kbd "<tab>") 'indent-and-complete))

(add-hook 'scala-mode-hook 'scala-mode-on-init)
(add-hook 'scala-mode-hook 'fuzzit)

(define-abbrev-table 'scala-mode-abbrev-table ())

;; xxx complete this

(defun update-fixtag-scala (&optional tag)
  (interactive)
  (snippet-with-abbrev-table 'scala-mode-abbrev-table
    ("f"  . (concat "$>// FIX " (if (null tag) (read-from-minibuffer "Update fixtag:" ) tag)))
  )
  "hello")

(update-fixtag-scala "CHESS")

(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/ensime/elisp"))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'java-mode-hook 'ensime-scala-mode-hook)
