(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/rust-mode"))
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq rust-format-on-save t)
