(require 'cl)

(labels ((add-path (p)
        (add-to-list 'load-path
                     (concat (getenv "EDOTDIR") (concat "/" p)))))

(add-path "lib")
(add-path "lib/python")
(add-path "lib/scala-mode2")
(add-path "lib/yas")
(add-path "lib/killring")
(add-path "lib/git")
(add-path "lib/ruby")
(add-path "lib/haskell")
(add-path "lib/groovy")
(add-path "lib/auto-complete")
(add-path "lib/js-comint")
(add-path "lib/bbdb")
(add-path "lib/norang-org")
(add-path "lib/dash.el")
(add-path "lib/ace-jump-mode.el")
(add-path "lib/projectile")
(add-path "src")
)

(labels ((add-exec-path (p)
        (add-to-list 'exec-path
                     (concat (getenv "EDOTDIR") (concat "/" p)))))

(add-exec-path "bin/haskell")
)



(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat (getenv "EDOTDIR") "/bin/haskell"))))
(setq exec-path (append exec-path ' (concat (getenv "EDOTDIR") "/bin/haskell")))
