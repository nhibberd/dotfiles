(require 'browse-kill-ring)
(require 'browse-kill-ring+)
(require 'ido)
(ido-mode t)
(add-to-list 'auto-mode-alist  '("\\.org\\'" . org-mode))
;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cb" 'org-iswitchb)

