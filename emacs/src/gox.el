(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/go/go-mode"))
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; (add-hook 'before-save-hook #'gofmt-before-save)

;; go-code - https://github.com/nsf/gocode
(add-to-list 'load-path (concat (getenv "EDOTDIR") "/lib/go/go-autocomplete"))
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(require 'golint)

(setq gofmt-command "goimports")
(setq gofmt-args '("-local=formation"))
(add-hook 'before-save-hook #'gofmt-before-save)


(setq-default tab-width 4)
