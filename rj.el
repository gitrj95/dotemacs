;;;; rj .emacs

(setq notes-directory "~/notes"
      package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/")
	("melpa" . "https://melpa.org/packages/"))
      use-package-always-ensure t
      use-package-enable-imenu-support t
      custom-file (make-temp-file "emacs-sink"))
(eval-when-compile (require 'use-package))

(let ((expanded-f (expand-file-name notes-directory)))
  (unless (file-directory-p expanded-f)
    (make-directory expanded-f)))

(use-package doric-themes
  :init (doric-themes-load-random)
  :bind (("<f7>" . doric-themes-load-random)))

(use-package org
  :custom
  (org-agenda-files `(,notes-directory))
  (org-startup-indented +1)
  :config
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)))

(use-package denote
  :custom
  (denote-directory (expand-file-name notes-directory))
  (denote-infer-keywords t)
  (denote-sort-keywords t)
  :init
  (add-hook 'dired-mode-hook #'denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n l" . denote-link)
   ("C-c n i" . denote-find-link)
   ("C-c n b" . denote-find-backlink)))

(use-package wgrep)

(use-package windmove
  :bind
  (("C-M-<up>" . windmove-up)
   ("C-M-<down>" . windmove-down)
   ("C-M-<left>" . windmove-left)
   ("C-M-<right>" . windmove-right)))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer))

(use-package kkp
  :config (global-kkp-mode +1)
  (define-key key-translation-map (kbd "M-<backspace>") (kbd "M-DEL")) ; HACK
  (define-key key-translation-map (kbd "M-<return>") (kbd "M-RET")))   ; HACK

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :config (marginalia-mode +1))

(use-package ediff
  :defer t
  :custom
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package buffer-env
  :config
  (add-hook 'hack-local-variables-hook #'buffer-env-update)
  (add-hook 'comint-mode-hook #'buffer-env-update))

(use-package ansi-color
  :config
  (add-hook 'compilation-filter-hook #'ansi-color-compilation-filter))

(use-package breadcrumb
  :init (breadcrumb-mode +1))

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit))
