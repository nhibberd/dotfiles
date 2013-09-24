(require 'hippie-exp)
(require 'snippet)

(defun indent-and-complete ()
  "Indent line and complete"
  (interactive)
  (cond
   ((and (boundp 'snippet) snippet)
    (snippet-next-field))
   ((looking-at "\\_>")
    (hippie-expand nil))
   ((indent-for-tab-command))))


(defun fuzzit ()
  "fuzzit"
  (interactive)
  (local-set-key "\t" 'indent-and-complete))

(defun try-expand-abbrev (old)
  (expand-abbrev))
