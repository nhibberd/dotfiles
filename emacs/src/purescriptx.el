(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/purescript"))
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list (concat (getenv "EDOTDIR") "/lib/purescript/"))


(add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)

;; (add-hook 'purescript-mode-hook 'purescript-mode-on-init)

(define-abbrev-table 'haskell-mode-abbrev-table ())

(snippet-with-abbrev-table 'haskell-mode-abbrev-table
  ("f"  . "$>-- FIX ")
  ("iq"  . "import qualified $.")
  ("ii"  . "import           $.")
)
