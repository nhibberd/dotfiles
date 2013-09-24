;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; xxx ripped from ruby wiki, tidy it up

(autoload 'ruby-mode "ruby-mode" "Mode fossssr editing ruby source files")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
(autoload 'rubydb "rubydb3x" "Ruby debugger" t)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; xxx dupe with python.el pull out something

(defun ruby-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key ruby-mode-map (kbd "<tab>") 'indent-and-complete))

(add-hook 'ruby-mode-hook 'ruby-mode-on-init)

(add-hook 'ruby-mode-hook 'fuzzit)

(define-abbrev-table 'ruby-mode-abbrev-table ())

;; xxx complete this
(snippet-with-abbrev-table 'ruby-mode-abbrev-table
  ("f"  . "# FIX")
  ("ic"  . "include_class ''") 
)
