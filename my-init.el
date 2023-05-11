;;; my-init.el -*- lexical-binding: t; -*-

(require 'crafted-startup)
(require 'crafted-compile)     ; automatically compile some emacs lisp files
(require 'crafted-completion)  ; selection framework based on `vertico`
(require 'crafted-defaults)    ; Sensible default settings for Emacs
(require 'crafted-editing)     ; Whitspace trimming, auto parens etc.
(require 'crafted-ide)         ; A general configuration to make Emacs more like an IDE, uses eglot.
(require 'crafted-latex)       ; A configuration for creating documents using the LaTeX typesetting language
(require 'crafted-lisp)        ; A configuration for the Lisp family of languages (Clojure, Common Lisp, Scheme, Racket)
(require 'crafted-org)         ; org-appear, clickable hyperlinks etc.
(require 'crafted-osx)         ; Set up some conveniences to work in a Mac OS/OSX environment
(require 'crafted-pdf-reader)  ; Setup pdf-tools for reading PDF files in Emacs
(require 'crafted-project)     ; built-in alternative to projectile
(require 'crafted-python)      ; A configuration for programming in Python
(require 'crafted-screencast)  ; show current command and binding in modeline
(require 'crafted-speedbar)    ; built-in file-tree
(require 'crafted-ui)          ; Better UI experience (modeline etc.)
(require 'crafted-updates)     ; Tools to upgrade Crafted Emacs
(require 'crafted-windows)     ; Window management configuration

(require 'my-def)
;; Override local configuration for per host
(defvar local-config-file (expand-file-name "my-local-config.el"))
(when (file-exists-p local-config-file)
  (load local-config-file nil 'nomessage))

;; Load modules
(require 'my-org)
(require 'my-ui)


(provide 'my-init)
;;; my-org.el ends here
