;;; opendream-mode.el --- Mode for editing DM files
;;; Copyright © 2021
;;             Free Software Foundation, Inc

;; Author: Edge
;; Keywords: opendream

;; This file is not part of GNU Emacs.

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:
;; Special syntax highlighting for working with Opendream code. Supports .dm file extensions
;; based off of porth-mode by Tsoding https://gitlab.com/tsoding/porth/-/blob/master/editor/porth-mode.el thank you very much tsoding, love from poland!

;;; Code:

(defconst opendream-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    ;; C/C++ style comments
	(modify-syntax-entry ?/ ". 124b")
	(modify-syntax-entry ?* ". 23")
	(modify-syntax-entry ?\n "> b")
    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"")
    (syntax-table))
  "Syntax table for `opendream-mode'.")

(eval-and-compile
  (defconst opendream-keywords
    '("if" "else" "while" "for" "proc" "return" "continue" "break" "const" "global" "temp" "new" "verb" "var" )))

(defconst opendream-highlights
  `((,(regexp-opt opendream-keywords 'symbols) . 	font-lock-keyword-face))
  `((,(regexp-opt opendream-classes 'symbols) . 	font-lock-type-face))
  `((,(regexp-opt opendream-inbuilt-procs 'symbols) . 	font-lock-builtin-face))
  )


(eval-and-compile
  (defconst opendream-classes
    '("client" "atom" "atom/movable" "world" "datum" "mob" "turf" "obj" "image" "icon" )))

(eval-and-compile
  (defconst opendream-inbuilt-procs
    '("sleep" "spawn" "del" ".." )))

;;;###autoload
(define-derived-mode opendream-mode prog-mode "opendream"
  (setq font-lock-defaults '(opendream-highlights))
  (set-syntax-table opendream-mode-syntax-table))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.dm\\'" . opendream-mode))

(provide 'opendream-mode)




;;; opendream-mode.el ends here
