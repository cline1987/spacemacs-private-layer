;;; funcs.el --- delin layer functions file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Delin Wang <dlwang@dlwang-OptiPlex-9010>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; open lines
(global-set-key (kbd "C-o") 'sanityinc/open-line-with-reindent)
(global-set-key (kbd "C-S-o") 'open-line)

;; unfill
(global-set-key (kbd "M-S-q") 'xah-unfill-region)

;; kill back to indentation
(global-set-key (kbd "S-M-<backspace>") 'kill-back-to-indentation)

;; avy goto word
(spacemacs/set-leader-keys "SPC" 'avy-goto-word-1)

;; mark/join lines
(spacemacs/set-leader-keys "xlm" 'mark-line)
(spacemacs/set-leader-keys "xlj" 'join-line)

;; isearch
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

;; misc
;; (global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; scrolling
(global-set-key (kbd "M-n")
                (lambda ()
                  (interactive)
                  (sublimity-scroll--vscroll-effect -20)))

(global-set-key (kbd "M-p")
                (lambda ()
                  (interactive)
                  (sublimity-scroll--vscroll-effect 20)))

(global-set-key (kbd "M-N")
                (lambda ()
                  (interactive)
                  (sublimity-scroll-other--vscroll-effect -20)))

(global-set-key (kbd "M-P")
                (lambda ()
                  (interactive)
                  (sublimity-scroll-other--vscroll-effect 20)))

(global-set-key (kbd "s-=") 'spacemacs/scale-up-font)
(global-set-key (kbd "s--") 'spacemacs/scale-down-font)
(global-set-key (kbd "s-<backspace>") 'spacemacs/reset-font-size)
