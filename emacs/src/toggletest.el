(defun toggle-test ( )
  "Toggle test"
  (interactive)
  (if buffer-file-name
    (message buffer-file-name)
    (error "Not visiting a file")))

(global-set-key "\C-xt" 'toggle-test)
