(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/haskell"))
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list (concat (getenv "EDOTDIR") "/lib/haskell"))

;;(load-library "haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(defun haskell-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key haskell-mode-map (kbd "<tab>") 'indent-and-complete))

(add-hook 'haskell-mode-hook 'haskell-mode-on-init)
(add-hook 'haskell-mode-hook 'fuzzit)

(define-abbrev-table 'haskell-mode-abbrev-table ())

(snippet-with-abbrev-table 'haskell-mode-abbrev-table
  ("f"  . "$>-- FIX ")
  ("iq"  . "import qualified $.")
  ("ii"  . "import           $.")
)
