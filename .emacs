;; Initialize package system
(require 'package)
;; Add MELPA repository
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Initialize package system
(package-initialize)
;; Refresh package contents on first load
(unless package-archive-contents
  (package-refresh-contents))
;; Install and configure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Set custom file
(setq custom-file "~/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Add local directory to load path
(add-to-list 'load-path "~/.emacs.local/")

;; Disable backup/autosave/lock files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Basic UI improvements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-hl-line-mode 1)
(electric-pair-mode 1)
(save-place-mode 1)
(savehist-mode 1)

;; Default settings
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Set default font
(add-to-list 'default-frame-alist '(font . "Iosevka-20"))

;; IDO Configuration
(use-package ido
  :init
  (ido-mode 1)
  (ido-everywhere 1))

(use-package smex
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

;; Dash - Modern list library for Emacs Lisp
(use-package dash)

;; Guru mode - Disable arrow keys for better Emacs habits
(use-package guru-mode
  :config
  (guru-global-mode 1))

;; Magit - Git interface
(use-package magit
  :bind
  (("C-x g" . magit-status)))

;; Project management
(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; Code completion
(use-package company
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2))

;; Syntax checking
(use-package flycheck
  :init
  (global-flycheck-mode))

;; Snippets
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all))

(use-package yasnippet-snippets)

;; Ensure yasnippet integrates with company-mode
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-yasnippet))

;; Load simpc-mode from local directory
(load "~/.emacs.local/simpc-mode.el")
;; C/C++ Configuration with simpc-mode
(use-package simpc-mode
  :ensure nil ;; Tell use-package not to try to install this package
  :mode ("\\.c\\'" "\\.h\\'" "\\.cpp\\'" "\\.hpp\\'")
  :init
  (setq simpc-indent-offset 4))

;; Optional: GNU Global for source code navigation
(use-package ggtags
  :hook
  ((simpc-mode . ggtags-mode))
  :bind
  (:map ggtags-mode-map
        ("C-c g s" . ggtags-find-other-symbol)
        ("C-c g h" . ggtags-view-tag-history)
        ("C-c g r" . ggtags-find-reference)
        ("C-c g d" . ggtags-find-definition)
        ("C-c g f" . ggtags-find-file)))

;; Tree-based file explorer
(use-package treemacs
  :bind
  ("C-c t" . treemacs))

;; Show available key bindings
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5))

;; Move between windows easily
(use-package ace-window
  :bind
  ("M-o" . ace-window))

;; Highlight color codes
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

;; Highlight matching parentheses distinctly
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
