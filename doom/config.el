;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular)
      doom-symbol-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular)
      doom-serif-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular)
      doom-big-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; (setq catppuccin-flavor 'frappe)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

                                        ; (use-package! multi-vterm
                                        ;   :config
                                        ;   (add-hook 'vterm-mode-hook
                                        ; 	    (lambda ()
                                        ; 	      (setq-local evil-insert-state-cursor 'box)
                                        ; 	      (evil-insert-state)))
                                        ;   (define-key vterm-mode-map [return]                      #'vterm-send-return)
                                        ;
                                        ;   (setq vterm-keymap-exceptions nil)
                                        ;   (evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
                                        ;   (evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
                                        ;   (evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
                                        ;   (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
                                        ;   (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))

;; ---------------------------- Prettier ----------------------------
;; TODO: Check if (require) is necessary to load this plugin
(add-hook 'web-mode-hook 'prettier-js-mode)

(setq select-active-regions t)
(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; (setq select-enable-primary t)
;; (setq select-enable-clipboard t)

;; (map! "S-C-c" #'clipboard-kill-ring-save)
;; (map! "S-C-v" #'clipboard-yank)

;; (straight-use-package 'xclip)
;; (xclip-mode 1)


;; -------------------------------- Org --------------------------------------------
;; Move heading up and down.
(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup))

;; -------------------------------- Custom --------------------------------------------
;; Insert Mode
;; Delete next char
(map! :ie "M-<backspace>"
      (cmd! (kill-forward-chars 1)))

;; Alt '['/']' to move to begin/end of line
(map! :ie "M-]"
      (cmd! (end-of-line)))

(map! :ie "M-["
      (cmd! (evil-first-non-blank)))


;; -------------------------------- Blamer --------------------------------------------
(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t)))
  :config
  (global-blamer-mode 1))


(set-frame-parameter (selected-frame) 'alpha '(90 . 90)) (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(add-to-list 'default-frame-alist '(undecorated . t))


;; -------------------------------- Golang --------------------------------------------
;; 1. Ensure goimports is available and set as the default formatting command
(after! go-mode
  (setq gofmt-command "goimports")
  (setenv "PATH" (concat (expand-file-name "~/go/bin") path-separator (getenv "PATH"))))

;; 2. Optional: Explicitly hook gofmt (which is now goimports) to before-save
;;    This is often used for non-LSP setups but can act as a reliable fallback.
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'gofmt-before-save nil 'local)))


;; -------------------------------- Debugger --------------------------------------------
;; Add Go bin directory to Emacs PATH
(add-to-list 'exec-path "~/go/bin")
(setenv "PATH" (concat (expand-file-name "~/go/bin") path-separator (getenv "PATH")))


;; -------------------------------- Editor Setting --------------------------------------------
;; enable word-wrap (almost) everywhere
(+global-word-wrap-mode +1)


;; --------------------------------- Neotree ---------------------------------
(after! neotree
  (setq neo-smart-open t)
  (add-hook 'window-selection-change-functions
            (lambda (_)
              (when (and (neo-global--window-exists-p)
                         (buffer-file-name))
                (neotree-find (buffer-file-name))))))

;; ------------------------ Emacs Application Framework ------------------------
(use-package! eaf
  :load-path "~/.config/emacs/.local/straight/repos/emacs-application-framework"
  :custom
  (eaf-browser-continue-where-left-off t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
  ;; (require 'eaf-browser)
  ;; (require 'eaf-pdf-viewer)
  ;; Add other apps as needed
  )

;; ------------------------ Custom Macro ------------------------

(defun convert-brackets-to-braces (start end)
  "Convert square brackets to curly braces instantly in the selection."
  (interactive "r")
  (subst-char-in-region start end ?\[ ?\{)
  (subst-char-in-region start end ?\] ?\}))

(map! :desc "Convert brackets to braces"
      :v "SPC z r b" #'convert-brackets-to-braces)


;; Choose elements:
;; - Full list: ns-alpha-default (default face/background)
;;              ns-alpha-fringe (fringes + internal border clears)
;;              ns-alpha-box (boxed face outlines)
;;              ns-alpha-stipple (stipple mask background clears)
;;              ns-alpha-relief (3D relief/shadow lines)
;;              ns-alpha-glyphs (glyph background fills like hl-line/region)
;; (set-frame-parameter nil 'ns-alpha-elements
;;                      '(ns-alpha-default ns-alpha-fringe ns-alpha-glyphs))

;; ------------------------ Rounded Corners ------------------------
;; Force the frame style mask to maintain native macOS rounded corners
(modify-all-frames-parameters
 '((ns-transparent-titlebar . t)
   (ns-appearance . dark) ;; or 'light depending on your theme
   (undecorated . nil)))  ;; Keep native window decorations active for rounding

;; If you prefer hiding the title bar text while keeping rounded macOS edges, configure default-frame-alist like this:
(add-to-list 'default-frame-alist '(titlebar-fields . nil))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))


;; ------------------------ Doom-Optimized Transparency & Blur ------------------------
;; 
(defun my/apply-mac-blur-and-transparency (&optional frame)
  "Apply native macOS blur and background opacity to FRAME."
  (when (display-graphic-p frame)
    ;; 1. Set background opacity (e.g., 85% opaque, 15% transparent)
    (set-frame-parameter frame 'alpha-background 50)
    
    ;; 2. Apply emacs-plus native blur and alpha element patches safely
    (ignore-errors
      (set-frame-parameter frame 'ns-background-blur 20)
      (set-frame-parameter frame 'ns-alpha-elements 'ns-alpha-all))))

;; Ensure new frames (like emacsclient) inherit these parameters automatically
(add-to-list 'default-frame-alist '(alpha-background . 50))
(add-to-list 'default-frame-alist '(ns-background-blur . 20))

;; Hook into Doom's UI initialization lifecycle
(add-hook 'doom-init-ui-hook #'my/apply-mac-blur-and-transparency)
(add-hook 'after-make-frame-functions #'my/apply-mac-blur-and-transparency)

;; Also re-apply whenever Doom loads or reloads a theme (prevents themes from wiping blur)
(add-hook 'doom-load-theme-hook
          (lambda ()
            (my/apply-mac-blur-and-transparency (selected-frame))))
