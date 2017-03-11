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

(defvar sublimity-scroll-weight 3
  "scroll is maybe divided into N small scrolls.")
(defvar sublimity-scroll-drift-length 2
  "scroll last N lines especially slowly.")
;; (defvar sp-delin-bindings '(("C-M-f" . sp-forward-sexp)
;;                             ("C-M-b" . sp-backward-sexp)
;;                             ("C-M-d" . sp-down-sexp)
;;                             ("C-M-u" . sp-backward-up-sexp)
;;                             ("C-M-a" . sp-beginning-of-sexp)
;;                             ("C-M-e" . sp-end-of-sexp)
;;                             ("C-M-n" . sp-next-sexp)
;;                             ("C-M-p" . sp-previous-sexp)
;;                             ("C-M-k" . sp-kill-sexp)
;;                             ("C-M-w" . sp-copy-sexp)
;;                             ("s-<right>" . sp-forward-slurp-sexp)
;;                             ("s-<left>" . sp-forward-barf-sexp)
;;                             ("S-s-<left>" . sp-backward-slurp-sexp)
;;                             ("S-s-<right>" . sp-backward-barf-sexp)
;;                             ("M-D" . sp-splice-sexp)
;;                             ("M-F" . sp-forward-symbol)
;;                             ("M-B" . sp-backward-symbol)))

(defvar delin-layer-directory (file-name-directory load-file-name)
  "Directory of layer \"DELIN\".")
