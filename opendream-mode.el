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
    '("list"
      "if"
      "else"
      "while"
      "for"
      "proc"
      "return"
      "continue"
      "break"
      "const"
      "global"
      "temp"
      "verb"
      "var"
      "usr" ;;pretend it's a keyword
      "switch"
      "case"
      "as"
      )))

(eval-and-compile
  (defconst opendream-classes
    '("area"
      "client"
      "atom"
      "movable"
      "world"
      "datum"
      "mob"
      "turf"
      "obj"
      "image"
      "icon"
      "sound"
      "mutable_appearance"
      "matrix"
      "regex"
      "savefile"
      "database"
      ;;pretend the following are actually types
      "num"
      "anything"
      "text"
      "message" ;;from byond docs about input() no fucking clue if anyone has ever used this..
      )))

(eval-and-compile
  (defconst opendream-constants
    '("null"
      ;;appearance flags
      "LONG_GLIDE"
      "RESET_COLOR"
      "RESET_ALPHA"
      "NO_CLIENT_COLOR"
      "KEEP_TOGETHER"
      "KEEP_APART"
      "PLANE_MASTER"
      "TILE_BOUND"
      "PIXEL_SCALE"
      "PASS_MOUSE"
      "TILE_MOVER"
      ;;blend modes
      "BLEND_DEFAULT"
      "BLEND_OVERLAY"
      "BLEND_ADD"
      "BLEND_SUBTRACT"
      "BLEND_MULTIPLY"
      "BLEND_INSET_OVERLAY"
      ;;directions
      "NORTH"
      "SOUTH"
      "EAST"
      "WEST"
      "NORTHEAST"
      "NORTHWEST"
      "SOUTHEAST"
      "SOUTHWEST"
      ;;layers
      "AREA_LAYER"
      "TURF_LAYER"
      "OBJ_LAYER"
      "MOB_LAYER"
      "FLOAT_LAYER"
      "TOPDOWN_LAYER"
      "EFFECTS_LAYER"
      "BACKGROUND_LAYER"
      ;;planes
      "FLOAT_PLANE"
      ;;vis flags
      "VIS_INHERIT_ICON"
      "VIS_INHERIT_ICON_STATE"
      "VIS_INHERIT_DIR"
      "VIS_INHERIT_LAYER"
      "VIS_INHERIT_PLANE"
      "VIS_INHERIT_ID"
      "VIS_UNDERLAY"
      "VIS_HIDE"
      )))

(eval-and-compile
  (defconst opendream-preprocessors
    '("#define"
      "#if"
      "#elif"
      "#ifdef"
      "#ifndef"
      "#else"
      "#endif"
      "#include"
      "#error"
      "#warn"
      )))

;;some common procs
(eval-and-compile
  (defconst opendream-inbuilt-procs
    '("sleep"
      "spawn"
      ".."
      "alert"
      "input"
      "prob"
      "pick"
      "rand"
      "range"
      "new"
      "del"
      "throw"
      "catch"
      "try" )))



(defconst opendream-highlights
  `(
    ;; TODO: figure out why preprocessors dont work!
    ;;(,(regexp-opt opendream-preprocessors	'symbols) . 	font-lock-preprocessor-face)
    (,(regexp-opt opendream-constants 		'symbols) . 	font-lock-constant-face)
    (,(regexp-opt opendream-keywords 		'symbols) . 	font-lock-keyword-face)
    (,(regexp-opt opendream-classes 		'symbols) . 	font-lock-type-face)
    (,(regexp-opt opendream-inbuilt-procs 	'symbols) . 	font-lock-builtin-face))
  )


;;;###autoload
(define-derived-mode opendream-mode prog-mode "opendream"
  (setq font-lock-defaults '(opendream-highlights))
  (set-syntax-table opendream-mode-syntax-table))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.dm\\'" . opendream-mode))

(provide 'opendream-mode)




;;; opendream-mode.el ends here
