;;; my-ui.el -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;; Commentary

;; Use doom-themes
(crafted-package-install-package 'doom-themes)
(crafted-package-install-package 'vertico-posframe)

(require 'echo-bell)

;; Disable splash-buffer
(customize-set-variable 'crafted-startup-inhibit-splash t)

;; Custom theme
(consult-theme 'doom-one-light)
(customize-set-variable 'echo-bell-background nil)

;; Custom bell
(customize-set-variable 'visible-bell nil)
(customize-set-variable 'echo-bell-string "¯\\_(ツ)_/¯ ")
(echo-bell-mode t)

;; Custom font
(custom-set-variables
 '(crafted-ui-default-font
   '(:font "PlemolJP Console NF" :weight normal :height 140)))
(set-face-attribute 'default nil :font "PlemolJP Console NF")
(set-face-attribute 'fixed-pitch nil :font "PlemolJP Console NF")
(set-face-attribute 'variable-pitch nil :font "PlemolJP Console NF")

;; Disable truncation symbol-name
(setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))

;; Use posframe to show menu buffer on the top of the frame
(customize-set-variable 'vertico-count 15)
(customize-set-variable 'verticle-resize nil)
(vertico-posframe-mode 1)


(customize-set-variable 'vertico-posframe-poshandler #'my/posframe-poshandler-frame-top-center-with-offset)
(defun my/posframe-poshandler-frame-top-center-with-offset (info)
  "Posframe's position handler.
This poshandler function let top edge center of posframe align
to top edge center of frame.
The structure of INFO can be found in docstring of
`posframe-show'."
  (cons (/ (- (plist-get info :parent-frame-width)
              (plist-get info :posframe-width))
           2)
        0))

(provide 'my-ui)
;;; crafted-ui.el ends here
