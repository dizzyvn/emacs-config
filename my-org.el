;;; my-org.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;; Commentary

;; Provides basic configuration for Org Mode.

;;; Code:

(crafted-package-install-package 'org-modern)
(crafted-package-install-package 'org-roam)
(crafted-package-install-package 'visual-fill-column)

(let ((default-directory (expand-file-name "~/.crafted-emacs/custom-modules")))
  (normal-top-level-add-subdirs-to-load-path))
(require 'org-download)

;; Setup agenda files
(customize-set-variable 'org-agenda-files my/org-agenda-files)

;; Agenda commands
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c SPC") #'my/org-agenda)
(global-set-key (kbd "C-c 0") #'my/org-capture-inbox)
(global-set-key (kbd "C-c 9") #'my/org-capture-journal)
(global-set-key (kbd "C-c 8") #'my/org-capture-slip)
(global-set-key (kbd "C-c 7") #'my/org-capture-interrupt)

(defun my/org-agenda ()
  (interactive)
  (org-agenda nil "a"))

(defun my/org-capture-inbox ()
  (interactive)
  (org-capture nil "t"))

(defun my/org-capture-interrupt ()
  (interactive)
  (org-capture nil "i"))

(defun my/org-capture-slip ()
  (interactive)
  (org-capture nil "s"))

(defun my/org-capture-journal ()
  (interactive)
  (org-capture nil "j"))

;; Set org-todo-keywords
(customize-set-variable 'org-todo-keywords
                        '((sequence "NEXT(n)" "TODO(t)" "|" "DONE(x!)")
                          (sequence "WAITING(w@/!)" "HOLD(h)" "Delegated(e!)" "|" "Cancelled(c@/!)")))

;; Set capture template
(customize-set-variable 'org-capture-templates
                        `(("t" "Inbox" entry  (file ,my/org-inbox-file)
                           ,(concat "* TODO %?\n"
                                    "/Entered on/ %U"))
                          ("r" "Read" entry  (file ,my/org-inbox-file)
                           ,(concat "* TODO Read %a\n"
                                    "/Entered on/ %U\n"))
                          ("i" "interupt" entry (file ,my/org-inbox-file)
                           ,(concat "* TODO %?\n"
                                    "/Entered on/ %U\n")
                           :clock-in :clock-resume)
                          ("f" "Follow" entry  (file ,my/org-inbox-file)
                           ,(concat "* TODO %?\n"
                                    "/Entered on/ %U\n/From/ %a"))
                          ("s" "Slipbox" entry  (file ,my/org-slipbox-file)
                           "* %?\n")
                          ("j" "Journal" entry  (file+datetree ,my/org-journal-file)
                           "** /%<%H:%M>/ %?\n%K %a\n")))

;; Ask for effort when clock in
(add-hook 'org-clock-in-prepare-hook 'my/Org-mode-ask-effort)
(defun my/org-mode-ask-effort ()
  "Ask for an effort estimate when clocking in."
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))

;; Set indentation to 4 and turn on auto indent
(customize-set-variable 'org-indent-indentation-per-level 2)
(customize-set-variable 'org-startup-indented t)
(customize-set-variable 'org-startup-truncated nil)

;; Highlight latex and related
(customize-set-variable 'org-highlight-latex-and-related '(latex script entities))

;; Customize emphasis alist
(customize-set-variable 'org-emphasis-alist
                        '(("*" (bold :background "#fdff46"))
                          ("/" (italic :background "#bdffe8"))
                          ("_" (underline :background "#ffddbd"))
                          ("=" (:background "#d6ccf9"))
                          ("~" (bold :background "#ffbdce"))
                          ("+" (:strike-through t))))


;; Use org speed command
(customize-set-variable 'org-use-speed-commands t)
(with-eval-after-load 'org
  (let ((listvar (if (boundp 'org-speed-commands) 'org-speed-commands
                   'org-speed-commands-user)))
    (add-to-list listvar '("A" org-archive-subtree-default))
    (add-to-list listvar '("T" org-todo))
    (add-to-list listvar '("t" org-todo "TODO"))
    (add-to-list listvar '("x" org-todo "DONE"))
    (add-to-list listvar '("z" org-todo "Cancelled"))
    (add-to-list listvar '("y" org-todo-yesterday "DONE"))
    (add-to-list listvar '("s" call-interactively 'org-schedule))
    (add-to-list listvar '("d" call-interactively 'org-deadline))
    (add-to-list listvar '("i" call-interactively 'org-clock-in))
    (add-to-list listvar '("o" call-interactively 'org-clock-out))
    (add-to-list listvar '("$" call-interactively 'org-archive-subtree))
    (add-to-list listvar '("N" org-narrow-to-subtree))
    (add-to-list listvar '("W" widen))))

;; Customize template for org-tempo
(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("e"  . "example"))
  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("kt" . "src kotlin"))
  (add-to-list 'org-structure-template-alist '("x"  . "src xml"))
  (add-to-list 'org-structure-template-alist '("y"  . "src yaml"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("md" . "src markdown")))

;; User org-modern for beautiful org
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'org-modern-mode)
(add-hook 'org-agenda-finalize 'org-modern-agenda)
(customize-set-variable 'org-modern-star '("⧉" "◉" "⁖" "❖"))
(customize-set-variable 'org-modern-table nil)
(customize-set-variable 'org-modern-list nil)
(customize-set-variable 'org-modern-todo nil)
(customize-set-variable 'org-modern-timestamp nil)
(customize-set-variable 'org-modern-keyword nil)
(customize-set-variable 'org-modern-block-fringe nil)
(customize-set-variable 'org-modern-statistics nil)
(customize-set-variable 'org-modern-progress nil)
(customize-set-variable 'org-modern-priority nil)


;; Also hide markers and use pretty entities
(customize-set-variable 'org-hide-emphasis-markers t)
(customize-set-variable 'org-pretty-entities t)
(customize-set-variable 'org-ellipsis "…")
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Custom agenda
(customize-set-variable 'org-agenda-inhibit-startup t)
(customize-set-variable 'org-agenda-use-tag-inheritance t)
(customize-set-variable 'org-enforce-todo-dependencies t)
(customize-set-variable 'org-agenda-dim-blocked-tasks t)
(customize-set-variable 'org-agenda-start-with-log-mode nil)
(customize-set-variable 'org-agenda-skip-scheduled-if-done t)
(customize-set-variable 'org-agenda-skip-deadline-if-done t)
(customize-set-variable 'org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
(customize-set-variable 'org-agenda-clockreport-parameter-plist '(:stepskip0 t :link t :maxlevel 2 :fileskip0 t))
(customize-set-variable 'org-habit-completed-glyph 43)
(customize-set-variable 'org-habit-today-glyph 45)
(customize-set-variable 'org-habit-show-done-always-green t)
(customize-set-variable 'org-habit-preceding-days 19)
(customize-set-variable 'org-habit-graph-column 75)
(customize-set-variable 'org-habit-show-all-today t)
(customize-set-variable 'org-agenda-prefix-format '((agenda . " %-2i %-10c| %5e | %-12t %s")
                                                    (timeline . "%s")
                                                    (todo . " %-2i %-10c| %5e | ")
                                                    (tags . " %-2i %-10c")
                                                    (search . " %-2i %-10c")))
(customize-set-variable 'org-agenda-time-grid
                        '((daily remove-match)
                          (800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000)
                          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
(customize-set-variable 'org-agenda-sorting-strategy
                        '((agenda time-up deadline-up priority-down category-keep habit-down)
                          (todo   priority-down category-keep)
                          (tags   priority-down category-keep)
                          (search category-keep)))

;; Setup org-roam
(with-eval-after-load 'org-roam
  (customize-set-variable 'org-roam-v2-ack t)
  (customize-set-variable 'org-roam-db-update-method 'immediate)
  (customize-set-variable 'org-roam-directory my/org-roam-directory)
  (customize-set-variable 'org-roam-capture-templates
                          '(("m" "main" plain
                             "%?"
                             :if-new (file+head "main/${slug}.org"
                                                "#+title: ${title}\n")
                             :immediate-finish t
                             :unnarrowed t)
                            ("r" "reference" plain "%?"
                             :if-new
                             (file+head "reference/${slug}.org" "#+title: ${title}\n")
                             :immediate-finish t
                             :unnarrowed t)
                            ("a" "article" plain "%?"
                             :if-new
                             (file+head "articles/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n")
                             :immediate-finish t
                             :unnarrowed t)
                            ("d" "default" plain
                             "%?"
                             :if-new (file+head "${slug}.org"
                                                "#+title: ${title}\n")
                             :immediate-finish t
                             :unnarrowed t)))
  (org-roam-db-autosync-enable)
  (define-key org-roam-mode-map (kbd "C-c n t") #'org-roam-tag-add)
  (define-key org-roam-mode-map (kbd "C-c n r") #'org-roam-ref-add)
  (define-key org-roam-mode-map (kbd "C-c n a") #'org-roam-alias-add)
  (define-key org-roam-mode-map (kbd "C-c n b") #'org-roam-buffer-toggle)
  (define-key org-roam-mode-map (kbd "C-c n u") #'org-roam-ui-open)
  (define-key org-roam-mode-map (kbd "C-c n .") #'orb-edit-citation-note))

(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n v") #'org-roam-node-visit)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)


;; First define a function to query global org property
(defun org-global-props (&optional property buffer)
  "Get the plists of global org properties of current buffer."
  (unless property (setq property "PROPERTY"))
  (with-current-buffer (or buffer (current-buffer))
    (org-element-map (org-element-parse-buffer) 'keyword (lambda (el) (when (string-match property (org-element-property :key el)) el)))))

(defun org-global-prop-value (key)
  "Get global org property KEY of current buffer."
  (org-element-property :value (car (org-global-props key))))

;; Limit the size of inline image
;; https://stackoverflow.com/questions/36465878/how-to-make-inline-images-responsive-in-org-mode
;; We additionally add
(defun org-image-resize (frame)
  (condition-case nil
    (when (derived-mode-p 'org-mode)
      (let* ((inline-width-string (org-global-prop-value "INLINE_WIDTH")))
        (when inline-width-string
          (let* ((inline-width (string-to-number inline-width-string)))
            (if (< (window-total-width) inline-width)
                (setq org-image-actual-width (- (window-pixel-width) 20))
              (setq org-image-actual-width (* inline-width (window-font-width))))
            (org-redisplay-inline-images)))))
    (error (c)
           (format t "We caught a condition.~&")
           (values 0 c))))

(add-hook 'window-size-change-functions 'org-image-resize)

;; org-download
(customize-set-variable 'org-download-image-dir "~/Dropbox/screenshot")
(customize-set-variable 'org-download-heading-lvl nil)
(customize-set-variable 'org-download-screenshot-method "screencapture -i %s")
(org-download-enable)
(define-key org-mode-map (kbd "C-M-y") #'org-download-clipboard)

;; Visual fill column for margin
(customize-set-variable 'visual-fill-column-width 100)
(customize-set-variable 'visual-fill-column-center-text t)
(add-hook 'org-mode-hook 'visual-fill-column-mode)

(provide 'my-org)
;;; my-org.el ends here
