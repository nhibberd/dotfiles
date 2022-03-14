(if (equal nil (getenv "ZDOTDIR"))
    (setenv "EDOTDIR" "~/dotfiles/emacs")
        (setenv "EDOTDIR" (concat (getenv "ZDOTDIR") "/dotfiles/emacs")))

(load-file (concat (getenv "EDOTDIR") "/src/paths.el"))
(load-library "eperiodic")
(load-library "requirex")
(load-library "scala-mode2")
(load-library "viewx")
(load-library "keys")
(load-library "hippies")
(load-library "ruby")
;;(load-library "gitx")
(load-library "pythonx")
(load-library "toggletest")
(load-library "javascriptx")
(load-library "typescriptx")
(load-library "haskellx")
(load-library "groovyx")
(load-library "bbdbx")
(load-library "dash")
(load-library "s")
(load-library "wgrep")
(load-library "projectile")
;;(load-library "functions")
;;(load-library "orgmodex")
;;(load-library "purescriptx")
(load-library "rustx")
(load-library "gox")
(load-library "shellx")


;;(projectile-global-mode)

(projectile-mode +1)
;; Recommended keymap prefix on macOS
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-indexing-method 'native)

(add-to-list 'auto-mode-alist '("\\.bzl\\'" . python-mode))
