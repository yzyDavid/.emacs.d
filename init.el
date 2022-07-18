;;;; Author: David Yu

;;; emacs 28

(require 'package)
(setq package-archives '(("gnu" . "https://mirror.zju.edu.cn/elpa/gnu/")
			 ("melpa" . "https://mirror.zju.edu.cn/elpa/melpa/")))
(package-initialize)

(setq load-path (cons (expand-file-name "lisp") load-path))
(setq load-path (cons (expand-file-name ".emacs.d/lisp") load-path))

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
(menu-bar-mode -1)
(setq-default c-basic-offset 4)
(setq confirm-kill-emacs 'y-or-n-p)
(setenv "PAGER" "/bin/cat")
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(setq gdb-many-windows t)

;;; managed by emacs.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-file-watch-threshold 65536)
 '(package-selected-packages
   '(cmake-mode company exec-path-from-shell po-mode sbt-mode lsp-metals lsp-treemacs magit-popup markdown-mode treemacs evil go-mode lsp-mode lsp-ui rust-mode scala-mode tuareg use-package utop web-mode yaml-mode magit ccls bazel-mode ace-window dockerfile-mode flymake gnu-elpa-keyring-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages t)

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

(use-package exec-path-from-shell
  :ensure t
  :config (progn (setq exec-path-from-shell-variables '("PATH"))
            (exec-path-from-shell-initialize)))

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) . lsp))

(use-package lsp-mode
  ;; we also have: `lsp-clients` `lsp-ui` packages.
  :hook ((go-mode python-mode rust-mode web-mode tuareg-mode scala-mode) . lsp)
  :after (ccls)
  :commands lsp)

(use-package lsp-ui
  :after (lsp-mode)
  :config (progn (set-face-attribute 'lsp-ui-sideline-current-symbol
                                     nil
                                     :foreground "brightblue")
                 (set-face-attribute 'lsp-ui-sideline-symbol-info
                                     nil
                                     :foreground "brightblack")
                 (set-face-attribute 'lsp-ui-doc-background
                                     nil
                                     :background "brightblack")
                 (setq lsp-ui-sideline-enable nil)))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package evil
  :ensure t
  :config (progn (dolist (mode '(dired-mode
				 eshell-mode
				 scratch-mode
				 help-mode
                                 utop-mode))
		   (evil-set-initial-state mode 'emacs))
		 (evil-mode t)))

(use-package yaml-mode)
(use-package llvm-mode)
(use-package scala-mode)
(use-package sbt-mode)
(use-package lsp-metals)

(use-package ace-window
  :config (global-set-key (kbd "C-x o") 'ace-window))

(use-package web-mode
  :mode ("\\.html\\'"
	 "\\.js\\'"
	 "\\.ts\\'"
	 "\\.jsx\\'"
	 "\\.tsx\\'"
	 "\\.vue\\'"
	 "\\.php\\'"
	 "\\.css\\'"))

;;; key bindings

(setq grep-command "grep --exclude-dir=.git --exclude=*.pbtxt --exclude=*.pyc -nHFi -R . -e ")

;; <f5> through <f9> can be used.
(global-set-key (kbd "<f5>") (lambda ()
			       (interactive)
				 (revert-buffer t t)))
(global-set-key (kbd "<f6>") 'lsp-find-declaration)
(global-set-key (kbd "<f7>") 'lsp-execute-code-action)
(global-set-key (kbd "<f8>") 'lsp-format-buffer)
(global-set-key (kbd "<f9>") 'compile)
