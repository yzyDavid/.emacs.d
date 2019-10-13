;; Author: David Yu

;; set http sources instead of https.

(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; copied from wiki, set charset to display utf8 chinese correctly with LANG=C.

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

;; misc configuration.

(setq make-backup-files nil)
(setq auto-save-default nil)

;; built-in modules.

(require 'ido)
(ido-mode t)

;; managed by emacs.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode gnu-elpa-keyring-update evil yasnippet magit go-mode lsp-ui use-package lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use-package 3rd-party modules.

(require 'use-package)

(setq lsp-enable-snippet nil)

(use-package lsp-mode
  :hook (c++-mode . lsp-mode)
  :commands lsp)

(use-package lsp-mode
  :hook (c-mode . lsp-mode)
  :commands lsp)

(use-package lsp-mode
  :hook (go-mode . lsp-mode)
  :commands lsp)

(use-package lsp-clients)
(use-package lsp-ui)

;; key bindings

(global-set-key (kbd "C-x g") 'magit-status)
