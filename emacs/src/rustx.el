(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/rust-mode"))
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq rust-format-on-save nil)
;; (setq rust-rustfmt-bin "/home/nick/.rustup/toolchains/nightly-2019-08-09-x86_64-unknown-linux-gnu/bin/rustfmt")

(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

(defun nuke_traling ()
  (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))

(add-hook 'rust-mode-hook #'nuke_traling)
