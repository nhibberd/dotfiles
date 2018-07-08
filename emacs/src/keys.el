(global-set-key "\C-x\C-b" 'electric-buffer-list)

(global-set-key "\C-x\C-r" 'revert-buffer)

(global-set-key "\C-x\C-g" 'goto-line)

(global-set-key "\M-?" 'help-command)

(global-set-key "\C-c\C-k" 'browse-kill-ring)

(define-key global-map (kbd "\C-c SPC") 'ace-jump-mode)

(global-set-key [f12] 'compile)
(global-set-key [f11] 'ensime-builder-build)
(global-set-key [f10] 'ensime-typecheck-all)

(global-set-key [f9] 'ensime-typecheck-current-file)

(global-set-key [f2] 'ensime-import-type-at-point)
(global-set-key [f5] 'ensime-inspect-type-at-point)

(global-set-key [f6] 'update-fixtag)

(global-set-key [f7] 'linum-mode)

;; what was this for???
 (keyboard-translate ?\C-h ?\C-?)

(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
