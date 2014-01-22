
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories  (concat (getenv "EDOTDIR") "/lib/auto-complete/ac-dict"))
(ac-config-default)
(global-auto-complete-mode t)

; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

; snippets in autocomplete
(add-to-list 'ac-sources 'ac-source-yasnippet)

(defun javascript-mode-on-init ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(try-expand-abbrev
         try-expand-dabbrev))
  (define-key js-mode-map (kbd "<tab>") 'indent-and-complete))

(add-hook 'js-mode-hook 'javascript-mode-on-init)
(add-hook 'js-mode-hook 'fuzzit)

(define-abbrev-table 'js-mode-abbrev-table ())



(defun update-fixtag-js (&optional tag)
  (interactive)
  (snippet-with-abbrev-table 'js-mode-abbrev-table
    ("f"  .  (concat (concat "$>// FIX " (if (null tag) (read-from-minibuffer "Update fixtag:" ) tag)) " "))
    ("a"  .  "$>console.log('$${variable}', $${variable});")
    ("n"  .  "$>var $${name} = function () {
};")
    ("e"  .  "$>$${name}: $${name}")
    ("m"  .  "define(
  '$${name}',

  [
  ],

  function () {
  }
);
")
  )
  "hello, this is for updating js fix tag value")

(update-fixtag-js "CHESS")

(setq js-indent-level 2)

(require 'js-comint)

(setenv "NODE_DISABLE_COLORS" "1")
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
       ;; We like nice colors
;;        (ansi-color-for-comint-mode-off)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                     (replace-regexp-in-string ".*1G.*3G" "> " output))))))
