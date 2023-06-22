;;; my-light-theme.el --- a light variant of Solarized -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Thien Q. Tran
;; Source: https://github.com/bbatsov/solarized-emacs
;; Source: https://ethanschoonover.com/solarized
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup my-light-theme nil
  "Options for the `doom-solarized-light' theme."
  :group 'doom-themes)

(defcustom doom-solarized-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-solarized-light-theme
  :type 'boolean)

(defcustom doom-solarized-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-solarized-light-theme
  :type 'boolean)

(defcustom doom-solarized-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-solarized-light-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme my-light
  "A light theme inspired by Solarized light"

  ;; name        default   256       16
  ((bg         '("#ffffff" "white"   "white"        ))
   (fg         '("#383a42" "#424242" "black"        ))


   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#f0f0f0" "white"   "white"        ))
   (fg-alt     '("#c6c7c7" "#c7c7c7" "brightblack"  ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#FFFBF0" "#FFFBF0" "white"        ))
   (base1      '("#FCF8ED" "#FCF8ED" "brightblack"  ))
   (base2      '("#FCF7E8" "#FCF7E8" "brightblack"  ))
   (base3      '("#F2E6CE" "#F2E6CE" "brightblack"  ))
   (base4      '("#D6D6D6" "#D6D6D6" "brightblack"  ))
   (base5      '("#96A7A9" "#96A7A9" "brightblack"  ))
   (base6      '("#788484" "#788484" "brightblack"  ))
   (base7      '("#626C6C" "#626C6C" "black"        ))
   (base8      '("#1b2229" "black"   "black"        ))

   (grey       base4)
   (red        '("#dc322f" "#dc322f" "red"          ))
   (orange     '("#cb4b16" "#cb4b16" "brightred"    ))
   (green      '("#859900" "#859900" "green"        ))
   (teal       '("#35a69c" "#35a69c" "brightgreen"  ))
   (yellow     '("#b58900" "#b58900" "yellow"       ))
   (blue       '("#268bd2" "#268bd2" "brightblue"   ))
   (dark-blue  '("#3F88AD" "#3F88AD" "blue"         ))
   (magenta    '("#d33682" "#d33682" "magenta"      ))
   (violet     '("#6c71c4" "#6c71c4" "brightmagenta"))
   (cyan       '("#2aa198" "#2aa198" "brightcyan"   ))
   (dark-cyan  '("#204052" "#204052" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   base4)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-solarized-light-brighter-comments
                       (doom-lighten teal 0.25)
                     base6))
   (doc-comments   teal)
   (constants      violet)
   (functions      magenta)
   (keywords       green)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        cyan)
   (variables      blue)
   (numbers        violet)
   (region         `(,(doom-darken (car bg-alt) 0.1) ,@(doom-darken (cdr base0) 0.1)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-bright doom-solarized-light-brighter-modeline)
   (-modeline-pad
    (when doom-solarized-light-padded-modeline
      (if (integerp doom-solarized-light-padded-modeline) doom-solarized-light-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-lighten bg 0.7)
      (doom-darken bg 0.05)))
   (modeline-bg-alt
    (if -modeline-bright
        (doom-lighten bg 0.7)
      (doom-lighten base3 0.2)))
   (modeline-bg-inactive     (doom-darken bg 0.025))
   (modeline-bg-inactive-alt (doom-darken bg 0.02)))


  ;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :slant 'italic
    :background (if doom-solarized-light-brighter-comments
                    (doom-blend teal base0 0.07)))
   ((font-lock-type-face &override) :slant 'italic)
   ((font-lock-builtin-face &override) :slant 'italic)
   ((font-lock-function-name-face &override) :foreground type)
   ((font-lock-keyword-face &override) :weight 'bold)
   ((font-lock-constant-face &override) :weight 'bold)
   (hl-line :background base3)
   ((line-number &override) :foreground base6)
   ((line-number-current-line &override) :foreground fg :background region :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-evil-emacs-state  :foreground magenta)
   (doom-modeline-evil-insert-state :foreground blue)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; lsp-ui
   (lsp-ui-sideline-code-action :foreground blue)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; ivy
   (ivy-current-match :background (doom-lighten yellow 0.65) :distant-foreground fg)
   (ivy-minibuffer-match-face-1 :foreground blue :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-2 :foreground magenta :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-3 :foreground green   :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-4 :foreground yellow  :background base3 :weight 'bold)
   (ivy-minibuffer-match-highlight :foreground violet :weight 'bold)
   ;;;; ivy-posframe
   (ivy-posframe :background modeline-bg-alt)
   ;;;; swiper
   (swiper-match-face-1 :inherit 'ivy-minibuffer-match-face-1)
   (swiper-match-face-2 :inherit 'ivy-minibuffer-match-face-2)
   (swiper-match-face-3 :inherit 'ivy-minibuffer-match-face-3)
   (swiper-match-face-4 :inherit 'ivy-minibuffer-match-face-4)
   ;;;; helm
   (helm-selection :foreground base0 :weight 'bold :background blue)
   ;;;; company
   (company-tooltip-selection :background blue :foreground base3)

   ;;;; org block
   (org-block :background (doom-blend yellow bg 0.04) :extend t)
   (org-block-background :background (doom-blend yellow bg 0.04))
   (org-block-begin-line :foreground teal :background (doom-blend yellow bg 0.08) :extend t)
   (org-block-end-line :foreground teal :background (doom-blend yellow bg 0.08) :extend t)

   ((org-quote &override) :background base1)
   ((org-table &override) :foreground fg)
   ;;;; widget

   ;;;; outline <built-in>
   ;; ((outline-1 &override) :foreground violet)
   ;; ((outline-2 &override) :foreground green)
   ((outline-1 &override) :foreground fg :height 1.0)
   ((outline-2 &override) :foreground fg :height 1.0)
   ((outline-3 &override) :foreground fg)
   ((outline-4 &override) :foreground fg)
   ((outline-5 &override) :foreground fg)
   ((outline-6 &override) :foreground fg)
   ((outline-7 &override) :foreground fg)
   ((outline-8 &override) :foreground fg)

   ;;;; org <built-in>
   ;; Make unfinished cookie & todo keywords bright to grab attention
   ((org-todo &override) :foreground red)
   ((org-date &override) :background base2)
   ((org-archived &override) :foreground base5)
   ;; (org-ellipsis :underline nil :box nil :foreground fg-alt :background bg)
   (org-ellipsis :underline nil :box nil :background bg)
   ((org-latex-and-related &override) :foreground "#268bd2" :weight 'normal)

   (widget-field :foreground fg :background base3)
   (widget-single-line-field :foreground fg :background base3)
   ;;;; latex
   (font-latex-sedate-face :foreground base6)
   ;;;; notmuch
   (notmuch-message-summary-face :foreground teal)
   (notmuch-wash-cited-text :foreground base6))

  ;;;; Base theme variable overrides-
  ;; ()
  )

;;; my-light-theme.el ends here
