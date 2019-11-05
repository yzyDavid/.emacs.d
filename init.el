;;;; Author: David Yu

;;; set http sources instead of https.

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			 ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")))
(package-initialize)

;;; copied from wiki, set charset to display UTF-8 Chinese characters correctly with LANG=C.

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; misc configuration.

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;;; managed by emacs.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (highlight-parentheses yaml-mode flymake rust-mode company-lsp web-mode gnu-elpa-keyring-update evil yasnippet magit go-mode lsp-ui use-package lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; use-package modules.

(require 'use-package)

;;; built-in modules.

(use-package ido
  :ensure t
  :config (ido-mode t))

(use-package man
  :ensure t
  :config (progn (set-face-attribute 'Man-overstrike
                                     nil
                                     :inherit 'bold
                                     :foreground "blue")
                 (set-face-attribute 'Man-underline
                                     nil
                                     :inherit 'underline
                                     :foreground "magenta")))

;;; 3rd-party modules.

(use-package company)

(use-package company-lsp
  :after (company lsp-mode)
  :config (push 'company-lsp company-backends))

(use-package yasnippet)

(use-package lsp-mode
  ;; we also have: `lsp-clients` `lsp-ui` packages.
  :hook ((c++-mode c-mode go-mode python-mode rust-mode web-mode) . lsp)
  :after (yasnippet)
  :commands lsp)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package evil
  :ensure t
  :config (progn (dolist (mode '('dired-mode
				 'eshell-mode
				 'scratch-mode
				 'help-mode))
		   (evil-set-initial-state mode 'emacs))
		 (evil-mode t)))

(use-package yaml-mode)

(use-package web-mode
  :mode ("\\.html\\'"
	 "\\.js\\'"
	 "\\.ts\\'"
	 "\\.jsx\\'"
	 "\\.tsx\\'"
	 "\\.vue\\'"
	 "\\.css\\'"))

;;; key bindings

;; <f5> through <f9> can be used.
(global-set-key (kbd "<f5>") (lambda ()
			       (interactive)
				 (revert-buffer t t)))
(global-set-key (kbd "<f7>") 'lsp-execute-code-action)
(global-set-key (kbd "<f9>") 'compile)
