;;; turn on syntax highlighting
(global-font-lock-mode 1)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(defun my-c-mode-hook ()
   (setq indent-tabs-mode nil
         c-basic-offset 4))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(defun groovy-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key js-mode-map (kbd "<tab>") 'indent-and-complete))

(define-abbrev-table 'groovy-mode-abbrev-table ())

(add-hook 'groovy-mode-hook 'groovy-mode-on-init)
(add-hook 'groovy-mode-hook 'fuzzit)

(snippet-with-abbrev-table 'groovy-mode-abbrev-table
  ("f"  . "$>// FIX")
)

