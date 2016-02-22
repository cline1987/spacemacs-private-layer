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

(defun sanityinc/open-line-with-reindent (n)
  "A version of `open-line' which reindents the start and end positions.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive "*p")
  (let* ((do-fill-prefix (and fill-prefix (bolp)))
	 (do-left-margin (and (bolp) (> (current-left-margin) 0)))
	 (loc (point-marker))
	 ;; Don't expand an abbrev before point.
	 (abbrev-mode nil))
    (delete-horizontal-space t)
    (newline n)
    (indent-according-to-mode)
    (when (eolp)
      (delete-horizontal-space t))
    (goto-char loc)
    (while (> n 0)
      (cond ((bolp)
	     (if do-left-margin (indent-to (current-left-margin)))
	     (if do-fill-prefix (insert-and-inherit fill-prefix))))
      (forward-line 1)
      (setq n (1- n)))
    (goto-char loc)
    (end-of-line)
    (indent-according-to-mode)))

(defun delin//open-line-with-reindent-anywhere (n)
  "Move the point at beginning of current line and insert newline
with indentation below it."
  (interactive "*p")
  (move-beginning-of-line 1)
  (sanityinc/open-line-with-reindent n))

(defun delin//newline-and-indent-anywhere ()
  "Move the point at end of current line and insert a new line with indentation."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(defun delin//open-line-anywhere (n)
  "Move the point at beginning of current line and insert newline
without indentation below it."
  (interactive "*p")
  (move-beginning-of-line 1)
  (open-line n))

(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(defun mark-line ()
  "Marks the current line."
  (interactive)
  (move-beginning-of-line 1)
  (push-mark (point) nil t)
  (move-end-of-line 1))

(defun sublimity-scroll--gen-speeds (amount)
  "10 => '(2 2 2 1 1 1)"
  (cl-labels ((fix-list (lst &optional eax)
                        (if (null lst) nil
                          (let* ((rem (car lst))
                                 (val (floor rem))
                                 (rem (+ (- rem val) (or eax 0)))
                                 (val (if (>= rem 1) (1+ val) val))
                                 (rem (if (>= rem 1) (1- rem) rem)))
                            (cons val (fix-list (cdr lst) rem))))))
    (let (a lst)
      (cond ((integerp sublimity-scroll-weight)
             (setq sublimity-scroll-weight (float sublimity-scroll-weight))
             (sublimity-scroll--gen-speeds amount))
            ((< amount 0)
             (mapcar '- (sublimity-scroll--gen-speeds (- amount))))
            ((< amount sublimity-scroll-drift-length)
             (make-list amount 1))
            (t
             (setq amount (- amount sublimity-scroll-drift-length))
             ;; x = a t (t+1) / 2 <=> a = 2 x / (t^2 + t)
             (setq a (/ (* 2 amount)
                        (+ (expt (float sublimity-scroll-weight) 2)
                           sublimity-scroll-weight)))
             (dotimes (n sublimity-scroll-weight)
               (setq lst (cons (* a (1+ n)) lst)))
             (append (cl-remove-if 'zerop (sort (fix-list lst) '>))
                     (make-list sublimity-scroll-drift-length 1)))))))

(defun sublimity-scroll--vscroll-effect (lins)
  (let ((speeds (sublimity-scroll--gen-speeds lins)))
    (dolist (speed speeds)
      (scroll-down-command speed)
      (force-window-update (selected-window))
      (redisplay))))

(defun sublimity-scroll-other--vscroll-effect (lins)
  (let ((speeds (sublimity-scroll--gen-speeds lins)))
    (dolist (speed speeds)
      (scroll-other-window-down speed)
      (force-window-update (selected-window))
      (redisplay))))
