;; xxx dupe with ruby



(defun python-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key python-mode-map (kbd "<tab>") 'indent-and-complete))

(add-hook 'python-mode-hook 'python-mode-on-init)
(add-hook 'python-mode-hook 'fuzzit)

(require 'py-yapf)
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

(define-abbrev-table 'python-mode-abbrev-table ())

(defun py-unittest ()
  "run unittest on file in the current bufffer "
  (interactive)
  (compile
   (format "python \"%s\""
	   (buffer-file-name))))

(global-set-key "\C-xx" 'py-unittest)


;; xxx use this instead of relying on installation of libraries.
;;  (setq pymacs-load-path '("/path/to/rope"
;;                           "/path/to/ropemacs"))



;; xxx get this working
;;(add-to-list 'compilation-error-regexp-alist '(".*File \"\\(.+\\)\", line \\([0-9]+\\)" 1 2))

;; xxx complete this
(snippet-with-abbrev-table 'python-mode-abbrev-table
  ("f"  . "$># FIX")
  ("m"  . "$>def $${method}():
$>$.")
  ("i"  . "import $${module}")
  ("fi"  . "from $${module} import $${symbol}")
  ("tm"  . "from unittest import TestCase, main

$>class $${Subject}Test(TestCase):
$>def test_$${operation}(self):
$>$.

if __name__ == \"__main__\":
$>main()

")
  ("tc"  . "class $${Subject}Test(TestCase):
$>def test_$${operation}(self):
$>$.")
  ("t"  . "$>def test_$${operation}(self):
$>$.")
  ("main"  . "if __name__ == \"__main__\":
$>$.")

)


;; xxx install rope and reinstate
;;(require 'pymacs)
;;(pymacs-load "ropemacs" "rope-")
