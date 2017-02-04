(require 'init-elpa)

(require-package 'racer)
(require-package 'rust-mode)
;;(require-package 'flycheck)
(require-package 'flycheck-rust)

(require 'racer)
(require 'rust-mode)
;;(require 'flycheck)
(require 'flycheck-rust)

(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
(setq racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/") ;; Rust

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rust-mode-map (kbd "\C-c TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
