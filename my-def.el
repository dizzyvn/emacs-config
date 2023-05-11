;;; my-def.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;; Commentary

;; Provides definition for local configuration.

;;; Code:

(defvar my/org-roam-directory "/Users/dizzy/Dropbox/organizer/roam")
(defvar my/org-agenda-files '("~/Dropbox/organizer/agenda"
                              "~/Dropbox/organizer/beorg"))
(defvar my/org-inbox-file "~/Dropbox/organizer/beorg/inbox.org")
(defvar my/org-slipbox-file "~/Dropbox/organizer/beorg/slipbox.org")
(defvar my/org-journal-file "~/Dropbox/organizer/beorg/journal.org")

(provide 'my-def)
;;; my-def.el ends here
