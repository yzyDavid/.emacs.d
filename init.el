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

;;; built-in modules.

(require 'ido)
(ido-mode t)

;;; managed by emacs.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-lsp web-mode gnu-elpa-keyring-update evil yasnippet magit go-mode lsp-ui use-package lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; use-package 3rd-party modules.

(require 'use-package)

(use-package company)

(use-package company-lsp
  :after (company lsp-mode)
  :config (push 'company-lsp company-backends))

(use-package yasnippet)

(use-package lsp-mode
  ;; we also have: `lsp-clients` `lsp-ui` packages.
  :hook ((c++-mode c-mode go-mode python-mode) . lsp)
  :after (yasnippet)
  :commands lsp)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package evil
  :ensure t
  :config (progn (evil-set-initial-state 'dired-mode 'emacs)
	       (evil-set-initial-state 'eshell-mode 'emacs)
	       (evil-set-initial-state 'scratch-mode 'emacs)
	       (evil-mode t)))

;;; key bindings

;; <f5> through <f9> can be used.
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'compile)
(global-set-key (kbd "<f7>") 'lsp)
(global-set-key (kbd "<f8>") 'lsp-workspace-folders-add)
