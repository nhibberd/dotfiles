(if (equal nil (getenv "ZDOTDIR"))
    (setenv "EDOTDIR" "~/dotfiles/emacs")
        (setenv "EDOTDIR" (concat (getenv "ZDOTDIR") "/dotfiles/emacs")))

(load-file (concat (getenv "EDOTDIR") "/src/paths.el"))
(load-library "eperiodic")
(load-library "requirex")
(load-library "scala-mode-auto")
(load-library "viewx")
(load-library "keys")
(load-library "hippies")
(load-library "ruby")
(load-library "gitx")
(load-library "pythonx")
(load-library "toggletest")
(load-library "scalax")
(load-library "javascriptx")
(load-library "haskellx")
(load-library "groovyx")
(load-library "bbdbx")
(load-library "dash")
(load-library "s")
(load-library "projectile")
;;(load-library "orgmodex")
(load-library "flycheck")
(load-library "rust")

(projectile-global-mode)
