;;; packages.el --- delin layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Delin Wang <dlwang@dlwang-OptiPlex-9010>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `delin-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `delin/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `delin/pre-init-PACKAGE' and/or
;;   `delin/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst delin-packages
  '(
    avy
    browse-kill-ring
    god-mode
    key-chord
    latex-preview-pane
    multiple-cursors
    move-dup
    sequential-command
    smartparens
    ))

(defun delin/post-init-avy ()
  (with-eval-after-load 'avy
    (setq avy-keys (number-sequence ?a ?z)
          avy-background t
          avy-all-windows t
          avy-style 'at)
    ))

(defun delin/init-browse-kill-ring ()
  (use-package browse-kill-ring
    :bind ("s-y" . browse-kill-ring)
    :config
    (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
    (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous)
    ;; integrate `popwin' with `browse-kill-ring'
    (with-eval-after-load 'popwin
      (defun popwin-bkr:update-window-reference ()
        (popwin:update-window-reference 'browse-kill-ring-original-window :safe t))
      (add-hook 'popwin:after-popup-hook 'popwin-bkr:update-window-reference)
      (push "*Kill Ring*" popwin:special-display-config))
    ))

(defun delin/init-god-mode ()
  (use-package god-mode
    :commands (god-local-mode god-mode-all)
    :init
    (global-set-key (kbd "<f9>") 'god-local-mode)
    (with-eval-after-load 'key-chord
      (key-chord-define-global ",." 'god-local-mode))
    ))

(defun delin/init-latex-preview-pane ()
  (use-package latex-preview-pane
    :defer t
    :init
    (spacemacs/set-leader-keys "xp" 'latex-preview-pane-mode)
    ))

(defun delin/init-move-dup ()
  (use-package move-dup
    :bind (("M-<up>" . md/move-lines-up)
           ("M-<down>" . md/move-lines-down))
    :config
    (spacemacs/set-leader-keys "xln" 'md/duplicate-down)
    (spacemacs/set-leader-keys "xlp" 'md/duplicate-up)
    ))

(defun delin/init-sequential-command ()
  (use-package sequential-command
    :bind (("M-u" . upcase-backward-word)
           ("s-u" . capitalize-backward-word)
           ("M-U" . upcase-word))
    :config
    (defun upcase-backward-word ()
      (interactive)
      (upcase-word (- (1+ (seq-count*)))))
    (defun capitalize-backward-word ()
      (interactive)
      (capitalize-word (- (1+ (seq-count*)))))
    ))

(defun delin/init-multiple-cursors ()
  (use-package multiple-cursors
    :init
    (which-key-declare-prefixes "C-c c" "multiple-cursors")
    (setq mc/list-file (expand-file-name ".mc-lists.el" delin-layer-directory))
    :bind (("<S-mouse-3>" . mc/add-cursor-on-click)
           ("C-<" . mc/mark-previous-like-this)
           ("C->" . mc/mark-next-like-this)
           ("C-+" . mc/mark-all-like-this)
           ("C-c c r" . set-rectangular-region-anchor)
           ("C-c c c" . mc/edit-lines)
           ("C-c c a" . mc/edit-beginnings-of-lines)
           ("C-c c e" . mc/edit-en))
    ))

(defun delin/init-key-chord ()
  (use-package key-chord
    :defer t
    :init
    (setq key-chord-one-key-delay '0.2
          key-chord-two-keys-delay '0.1)
    (spacemacs/set-leader-keys "tk" 'key-chord-mode)
    :config
    (key-chord-define-global (kbd ",,") 'avy-goto-word-or-subword-1)
    ))

(defun delin/post-init-smartparens ()
  (setq sp-autoskip-closing-pair 'always)
  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  ;; (sp--populate-keymap sp-delin-bindings)
  (if (configuration-layer/package-usedp 'latex)
      (add-hook 'LaTeX-mode-hook (lambda ()
                                   (require 'smartparens-latex)))
    (add-hook 'latex-mode-hook (lambda ()
                                 (require 'smartparens-latex))))
  )
;;; packages.el ends here
