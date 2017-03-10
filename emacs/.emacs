;; disable welcome message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; indentation for C
(setq c-default-style "linux"
      c-basic-offset 4)
(custom-set-faces)

;; aesthetics
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "skyblue")

(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "skyblue"))

;; remove toolbar
(tool-bar-mode -1)

;; remove menu bar
(menu-bar-mode -1)

;; create directory upon save if necessary
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; delete any trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; never insert tabs
(setq-default indent-tabs-mode nil)

;; always show column numbers
(setq column-number-mode t)

;; always show which function the cursor is in
(which-function-mode t)

;; disable scroll bar
(scroll-bar-mode -1)
