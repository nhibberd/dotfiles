(setq inhibit-startup-message t)

(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(setq diff-switches "-u")

;; emacs 24

;; this breaks pasting code
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;;pbcopy osx
(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

;(setq require-final-newline 'query)

(setq line-number-mode t)
(setq column-number-mode t)

(setq-default indent-tabs-mode nil)

(setq display-time-24hr-format t)
(display-time)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default ispell-program-name "aspell")

;;(set-default-font "DejaVu Sans Mono-16")
;;(set-default-font "DejaVu Sans Mono-13")
(set-frame-font "DejaVu Sans Mono-13")
;;(set-default-font "DejaVu Sans Mono-10")

;;(set-face-attribute 'default nil :height 115)

;; gui cruft

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

;; if not running with -nw
(when window-system
 (set-background-color "#121212")
 (set-face-background 'default "#121212")
 (set-face-background 'region "#16CC55")
; (set-face-foreground 'default "#34E249") was:
 (set-face-foreground 'default "#16CC55")
 (set-face-foreground 'region "#121212")
 (set-foreground-color "#16CC55")
 (set-cursor-color "#16CC55")
 (set-face-foreground 'vertical-border "grey30")
 )

(set-face-foreground 'font-lock-comment-face "grey60")
(set-face-foreground 'font-lock-comment-delimiter-face "grey60")

(set-face-foreground 'font-lock-doc-face "grey52")
(set-face-foreground 'font-lock-keyword-face "#86ABD9")
;;(set-face-foreground 'font-lock-keyword-face "#16CC55")
(set-face-foreground 'font-lock-string-face "#F5F5F5")
(set-face-foreground 'font-lock-constant-face "#16CC55")
(set-face-foreground 'font-lock-type-face "#16CC55")
(set-face-foreground 'minibuffer-prompt "#86ABD9")
(set-face-foreground 'ido-subdir "#16CC55")
(set-face-foreground 'ido-only-match "#16CC55")

(set-face-foreground 'font-lock-function-name-face "#16CC55")
(set-face-foreground 'font-lock-variable-name-face "#16CC55")
(set-face-foreground 'font-lock-builtin-face "#16CC55")
(set-face-foreground 'font-lock-preprocessor-face "#16CC55")
(set-face-foreground 'font-lock-negation-char-face "#16CC55")

(set-face-foreground 'font-lock-warning-face "#16CC55")
(set-face-background 'mode-line-inactive "#363636")
(set-face-foreground 'mode-line-inactive "grey75")
(set-face-background 'mode-line "grey30")
(set-face-foreground 'mode-line "grey80")




(set-face-bold-p 'minibuffer-prompt t)
(set-face-bold-p 'ido-subdir t)
(set-face-bold-p 'ido-first-match t)
(set-face-bold-p 'ido-only-match t)
(set-face-bold-p 'ido-indicator t)
(set-face-bold-p 'ido-incomplete-regexp t)
(set-face-bold-p 'font-lock-comment-face t)
(set-face-bold-p 'font-lock-comment-delimiter-face t)
(set-face-bold-p 'font-lock-keyword-face t)
(set-face-bold-p 'font-lock-string-face nil)

(set-face-bold-p 'font-lock-type-face t)
(set-face-bold-p 'font-lock-function-name-face nil)
(set-face-bold-p 'font-lock-variable-name-face nil)
(set-face-bold-p 'font-lock-builtin-face nil)
(set-face-bold-p 'font-lock-preprocessor-face nil)
(set-face-bold-p 'font-lock-negation-char-face nil)
(set-face-bold-p 'font-lock-warning-face nil)



(set-face-italic-p 'font-lock-comment-face nil)
(set-face-italic-p 'font-lock-comment-delimiter-face nil)
(set-face-italic-p 'font-lock-keyword-face nil)
(set-face-italic-p 'font-lock-string-face nil)
(set-face-italic-p 'font-lock-constant-face  nil)
(set-face-italic-p 'font-lock-type-face nil)
(set-face-italic-p 'font-lock-function-name-face nil)
(set-face-italic-p 'font-lock-variable-name-face nil)
(set-face-italic-p 'font-lock-builtin-face nil)
(set-face-italic-p 'font-lock-preprocessor-face nil)
(set-face-italic-p 'font-lock-negation-char-face nil)
(set-face-italic-p 'font-lock-warning-face nil)

(windmove-default-keybindings)

(blink-cursor-mode 0) ;; no blink


;; column highlighter

(require 'column-marker) ;; to use: C-u 81 column-marker-1


(menu-bar-mode 0)


(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

(setq require-final-newline t)                ; Always newline at end of file
(setq next-line-add-newlines nil)                ; Add newline when at buffer end
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun nuke_traling ()
  (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))

(add-hook 'prog-mode-hook #'nuke_traling)

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))


(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-do-window-select (before windmove-do-window-select activate)
  (when buffer-file-name (save-buffer)))

(ad-activate 'switch-to-buffer)


;;;;; find a better home for this

    (defvar ido-enable-replace-completing-read t
      "If t, use ido-completing-read instead of completing-read if possible.

    Set it to nil using let in around-advice for functions where the
    original completing-read is required.  For example, if a function
    foo absolutely must use the original completing-read, define some
    advice like this:

    (defadvice foo (around original-completing-read-only activate)
      (let (ido-enable-replace-completing-read) ad-do-it))")

    ;; Replace completing-read wherever possible, unless directed otherwise
    (defadvice completing-read
      (around use-ido-when-possible activate)
      (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
              (and (boundp 'ido-cur-list)
                   ido-cur-list)) ; Avoid infinite loop from ido calling this
          ad-do-it
        (let ((allcomp (all-completions "" collection predicate)))
          (if allcomp
              (setq ad-return-value
                    (ido-completing-read prompt
                                   allcomp
                                   nil require-match initial-input hist def))
            ad-do-it))))
