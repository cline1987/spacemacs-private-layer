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

;; (global-set-key (kbd "S-<return>") 'delin//newline-and-indent-anywhere)

(global-set-key (kbd "C-o") 'sanityinc/open-line-with-reindent)
(global-set-key (kbd "C-S-o") 'open-line)
;; (global-set-key (kbd "s-O") 'delin//open-line-with-reindent-anywhere)
;; (global-set-key (kbd "C-S-o") 'delin//open-line-anywhere)

(global-set-key (kbd "S-M-<backspace>") 'kill-back-to-indentation)

(spacemacs/set-leader-keys "xlm" 'mark-line)
(spacemacs/set-leader-keys "xlj" 'join-line)

(global-set-key (kbd "C-x C-m") 'execute-extended-command)

(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

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

;; (global-set-key (kbd "s-j") 'join-line)
