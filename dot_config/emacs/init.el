;;; ~/.config/emacs/init.el

;; A folder to store emacs data outside the '~/.config/emacs' directory.
(setq cache-emacs-directory (expand-file-name "~/.local/share/emacs"))

;; Who does not prefer 'utf-8'?
(prefer-coding-system 'utf-8)

(setq ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      native-comp-async-report-warnings-erros nil

      ;; Prefer newer emacs lisp files when possible.
      load-prefer-newer t

      ;; Increase the max amount allowed to be read from a process into emacs.
      read-process-output-max (* 1024 1024)

      ;; Disable unneeded prompts.
      inhibit-startup-message t
      use-dialog-box nil

      ;; Disable the cursor blinking.
      blink-cursor-mode nil

      ;; Do not create backup files of the type: #file#.
      auto-save-default nil
      make-backup-files nil

      ;; Do not warn on large files.
      large-file-warning-threshold nil

      ;; Execute local eval's from file variables without querying.
      enable-local-eval t

      ;; Follow symlinks on version controlled(vc) files without warning.
      vc-follow-symlinks t

      ;; Automatically remove compiled files not needed by the curret Emacs version.
      native-compile-prune-cache t)

;; https://www.youtube.com/watch?v=51eSeqcaikM
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq history-lenght 25)
(savehist-mode 1)

;; 'custom.el'
(setq custom-file (concat cache-emacs-directory "custom.el"))

;; Tabs
(defvar my-default-tab-width 4)
(setq-default tab-width my-default-tab-width
              indent-tabs-mode nil)

  ;; Whitespace mode
  (setq-default whitespace-global-modes '(not shell-mode
                                              help-mode
                                              term-mode
                                              org-mode
                                              magit-mode
                                              magit-diff-mode
                                              ibuffer-mode
                                              dired-mode
                                              occur-mode))

  (setq whitespace-style '(face spaces tabs space-mark tab-mark))

  (let* ((ws-color "#3c3836"))
      (custom-set-faces
      `(whitespace-empty ((t (:foreground ,ws-color))))
      `(whitespace-hspace ((t (:foreground ,ws-color))))
      `(whitespace-indent ((t (:foreground ,ws-color))))
      `(whitespace-newline ((t (:foreground ,ws-color))))
      `(whitespace-missing-newline-at-eof ((t (:foreground ,ws-color))))
      `(whitespace-space-after-tab ((t (:foreground ,ws-color))))
      `(whitespace-space-before-tab ((t (:foreground ,ws-color))))
      `(whitespace-trailing ((t (:foreground ,ws-color))))
      `(whitespace-tab ((t (:foreground ,ws-color))))
      `(whitespace-space ((t (:foreground ,ws-color))))))

  (global-whitespace-mode 1)

  ;; Line numbering
  (global-display-line-numbers-mode 1)

;;; Fonts

;; Variables
(defvar my-default-font "JetBrainsMono Nerd Font")
(defvar my-default-font-size 120)
(defvar my-default-variable-font-size 120)

;; Main font setup procedure.
(defun my-font-setup ()
  (set-face-attribute 'default nil
                      :font my-default-font
                      :weight 'semibold
                      :height my-default-font-size)

  (set-face-attribute 'fixed-pitch nil
                      :font my-default-font
                      :weight 'semibold
                      :height my-default-font-size)

  (set-face-attribute 'variable-pitch nil
                      :font my-default-font
                      :weight 'semibold
                      :height my-default-font-size)

  (set-face-attribute 'bold nil
                      :font my-default-font
                      :weight 'extrabold
                      :height my-default-font-size))

;; Setup fonts for regular Emacs.
(my-font-setup)

;; Setup fonts for Emacs Clients.
(add-hook 'after-make-frame-functions
          (lambda (frame) (with-selected-frame frame (my-font-setup))))

;;; Scratch Buffer
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "#+TITLE: Scratch Buffer\n\n")

;;; Bootstrap package manager (straight.el)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
  (with-current-buffer
      (url-retrieve-synchronously
      "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
      'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; Package manager options
(setq straight-vc-git-default-clone-depth '(1 single-branch))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;; Clean the config folder
(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "etc/" cache-emacs-directory)
        no-littering-var-directory
        (expand-file-name "var/" cache-emacs-directory)))

;;; Commands for keybinds

(defun my-open-config ()
  "Open the init.el file."
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun my-open-org-config ()
  "Open the emacs.org file."
  (interactive)
  (find-file (expand-file-name "emacs.org" user-emacs-directory)))

(defun my-reload-config ()
  "Reload the init.el file."
  (interactive)
  (load user-init-file))

;; To make keybinds that cycle through open buffers actually useful, I need
;; skip any buffers that are not text edition buffers, like any buffer that
;; has '*' characters in it's name or buffers from magit, dired, term etc.

;; Regex used to identify unwanted buffers for buffer cycling:
;; https://emacs.stackexchange.com/questions/17687/ make-previous-buffer-and-next-buffer-to-ignore-some-buffers
;; TODO understand emacs regexp
(defcustom my-buffer-skip-regexp
  (rx bos (or (or "*Backtrace*" "*Compile-Log*" "*Completions*"
                  "*Messages*" "*package*" "*Warnings*" "*scratch*"
                  "*Async-native-compile-log*" "*straight-process*")
              (seq "magit-diff" (zero-or-more anything))
              (seq "magit-process" (zero-or-more anything))
              (seq "magit-revision" (zero-or-more anything))
              (seq "magit-stash" (zero-or-more anything)))
              eos)
  "Regular expression matching buffers that should be ignored
by `next-buffer' or `previous-buffer'."
  :type 'regexp)

(defun my-buffer-skip-p (window buffer bury-or-kill)
  "Return t if BUFFER name matches `my-buffer-skip-regexp'."
  (string-match-p my-buffer-skip-regexp (buffer-name buffer)))
(setq switch-to-prev-buffer-skip 'my-buffer-skip-p)

;; comment command
(defun my-toggle-comment-region-or-line ()
  "Toggle the comment state of the current line or region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

;; TODO Use the fact that the '(other-buffer)' function accepts a
;; filter to filter out some unnecessary buffers.
(defun my-last-buffer ()
  "Switch to last buffer."
  (interactive)
  (switch-to-buffer (other-buffer)))

;; With a vim emulator, it makes more sense to use 'ESC' to quit prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;;; Keybinds

;; general.el
(use-package general
  :after evil
  :config

  ;; Create wrappers for leader keybinds
  (general-create-definer my-leader-def
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer my-lleader-def
    :states '(normal visual emacs insert)
    :keymaps 'override
    :prefix ","
    :global-prefix "C-,")

  ;; Commands to be used in binds
  (defun my-evil-shift-left-keep-selected ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

  (defun my-evil-shift-right-keep-selected ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

  ;; Use the standard C-S-{c,v} for copy and paste.
  (general-def :keymaps 'override
  "C-S-c" 'kill-ring-save
  "C-S-v" 'yank)

  ;; Non-leader binds
  (general-def '(normal emacs)
  "x"  nil
  "x:" 'eval-expression
  "xc" 'my-toggle-comment-region-or-line
  "xv" 'evil-visual-restore
  "xi" 'evil-fill-and-move
  "C-." 'completion-at-point
  "L"  'next-buffer
  "H"  'previous-buffer)

  (general-def '(visual)
  ">" 'my-evil-shift-right-keep-selected
  "<" 'my-evil-shift-left-keep-selected)

  ;; Leader binds
  (my-leader-def

  "m" '(:ignore t :which-key "local")

  ;;; Windows (replaces C-w)
  ;; TODO: add hydras.
  "w"  '(:ignore t :which-key "window")
  "wn" 'evil-window-new
  ;; close
  "q" 'evil-quit
  "wd" 'evil-window-delete
  "w." 'delete-other-windows
  ;; splits
  "ws" 'evil-window-split
  "wv" 'evil-window-vsplit
  ;; directional movement
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  ;; cardinal and frequency movement
  "wp" 'evil-window-prev
  "wP" 'evil-window-next
  "wo" 'evil-window-mru
  ;; rotation
  "wx" 'evil-window-exchange
  "wr" 'evil-window-rotate-downwards
  "wR" 'evil-window-rotate-upwards
  ;; resize
  "w+" 'evil-window-increase-height
  "w-" 'evil-window-decrease-height
  "w>" 'evil-window-increase-width
  "w<" 'evil-window-decrease-width
  "w|" 'evil-window-set-width
  "w_" 'evil-window-set-height
  "wm" 'evil-window-middle

  ;;; Find
  "."  'dired-jump
  "e"  'counsel-find-file
  "f"   '(:ignore t :which-key "find")
  "fc"  'my-open-config
  "ff"  'counsel-fzf
  "fw"  'counsel-rg
  "fr"  'counsel-recentf

  ;;; Buffers
  "s"  'save-buffer
  "j"   '(:ignore t :which-key "buffer")
  "jd"  '(lambda () (interactive) (kill-buffer (current-buffer)))
  "jf"  'counsel-switch-buffer
  "js"  'scratch-buffer

  ;;; Run/Reload
  "r"   '(:ignore t :which-key "run/reload")
  "re"  'restart-emacs
  "ri"  'my-reload-config

  ;;; Help (replaces C-h)
  "h"   '(:ignore t :which-key "help")
  "h C-c" 'describe-copying
  "hv"  'counsel-describe-variable
  "hf"  'counsel-describe-function
  "ho"  'counsel-describe-symbol
  "hm"  'describe-mode
  "hk"  'describe-key
  "hs"  'describe-syntax
  "hL"  'describe-language-environment
  "hO"  'describe-distribution
  "hp"  'finder-by-keyword
  "hP"  'describe-package
  "hc"  'describe-command))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ace-jump-mode
  :general-config
  ('(normal emacs visual operator)
   "s" 'ace-jump-word-mode
   "S" 'ace-jump-char-mode
   "C-s" 'ace-jump-line-mode))

;;; Appearance
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ivy-rich
  :config (nerd-icons-ivy-rich-mode 1))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-icon t)
  (doom-modeline-modal-modern-icon nil)
  (doom-modeline-indent-info t)
  (doom-modeline-total-line-number t)
  (doom-modeline-bar-width 4))

;;; Minibuffer Completion
(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
              ("TAB" . ivy-alt-done)
              ("C-l" . ivy-alt-done)
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              :map ivy-switch-buffer-map
              ("TAB" . ivy-alt-done)
              ("C-l" . ivy-alt-done)
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              ("C-h" . ivy-switch-buffer-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after (ivy nerd-icons-ivy-rich counsel)
  :init
  (ivy-rich-mode 1))

;; Better sorting algorithm for ivy
(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package counsel
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (general-def '(normal visual)
  "xx" 'counsel-M-x)
  (counsel-mode 1))

;;; Dired
(use-package dired
  :straight (:type built-in)
  :hook (dired-mode . dired-hide-details-mode)
  :config
  (setq dired-dwin-target t)
  (setq dired-recursive-copies 'always)
  (setq dired-create-destination-dirs 'ask)
  (setq dired-clean-confirm-killing-deleted-buffers nil)
  (setq dired-make-directory-clickable t)
  (setq dired-mouse-drag-files t)
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-listing-switches "-Fla1 --group-directories-first")
  (general-def 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

;;; Dirvish
;; (use-package dirvish
;;   :init (dirvish-override-dired-mode))

;;; Terminal

;; Commands for keybinds.
(defun my-toggle-vterm ()
  "Toggles between the current/last buffer and a vterm buffer. Creates
a new vterm buffer if needed."
  (interactive)
  (if (string= "*vterm*" (buffer-name))
      (my-last-buffer)
      (vterm)))

;; akermu/emacs-libvterm
(use-package vterm
  :general
  (general-def
    :keymaps 'override
    "C-t" #'my-toggle-vterm))

;;;; Org Mode

;;; Preamble

;; Commands

(defun my-org-refile ()
  "Open refile.org."
  (interactive)
  (find-file (expand-file-name "20250525231452-refile.org" user-org-directory)))

(defun my-org-agenda ()
  "Open agenda.org."
  (interactive)
  (find-file (expand-file-name "20250525231549-agenda.org" user-org-directory)))

(defun my-org-paste-screenshot ()
  "Put the contents of the clipboard into an image named after the current time in a '.png' file under a 'imgs' folder in the user org directory and then link this new file at point."
  (interactive)
  (unless (boundp 'user-org-directory)
    (error "Variable `user-org-directory` must be set."))
  (let* ((folder (expand-file-name "imgs" user-org-directory))
         (filename (concat (format-time-string "%Y%m%d_%H%M%S") ".png"))
         (file (expand-file-name filename folder))
         (session-type (getenv "XDG_SESSION_TYPE"))
         (copy-command
          (cond
           ((and (eq system-type 'gnu/linux)
                 (string= session-type "x11"))
            "xclip")
           ((and (eq system-type 'gnu/linux)
                 (string= session-type "wayland"))
            "wl-paste")
           (t (error "Unsupported OS (MacOS or Windows) or session-type: %s"
                     session-type)))))
    (unless (file-exists-p folder) (make-directory folder t))
    (shell-command (concat copy-command (shell-quote-argument file)))
    (when (file-exists-p file)
      (insert (concat "[[file:" file "]]"))
      (org-display-inline-images))))

;; Fonts

(with-eval-after-load 'org-faces
  ;; Set faces for heading levels
  (dolist (face '((org-document-title . 1.5)
                  (org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :inherit 'fixed-pitch :background "#1d2021")
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

;; Setup Function

(defun my-org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

;; Org Mode Setup

(use-package org
  :straight (:type built-in)
  :commands (org-capture org-agenda)
  :hook (org-mode . my-org-mode-setup)
  :init
  (setq user-org-directory (expand-file-name "~/Sync/org")
      org-indent-indentation-per-level 1)
  :config
  (setq org-startup-with-latex-preview t
      org-startup-with-inline-images t
      org-format-latex-options (plist-put
                          org-format-latex-options
                          :scale 1.5))

  ;; Org Tempo
  (add-to-list 'org-modules 'org-tempo t)
  (add-to-list 'org-structure-template-alist '("t" . "src txt"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("cl" . "src common-lisp"))
  (add-to-list 'org-structure-template-alist '("cc" . "src c"))
  (add-to-list 'org-structure-template-alist '("cp" . "src cpp"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("cs" . "src css"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))

  ;; Org Mode Keybinds
  (general-def 'insert 'org-mode-map
    "C-<return>" 'org-meta-return
    "M-<return>" 'org-insert-heading-respect-content)

  (my-lleader-def 'org-mode-map
    "c"   'org-ctrl-c-ctrl-c
    "l"   'org-insert-link
    "o"   'org-open-at-point
    "s"   'org-insert-structure-template
    "p"   '(:ignore t :which-key "preview")
    "pl"  'org-latex-preview
    "pi"  'org-display-inline-images)

  (my-leader-def
    "o"  '(:ignore t :which-key "org")
    "or" 'my-org-refile
    "oc" 'my-open-org-config
    "oa" 'my-org-agenda)

  ;; Prettier heading bullets
  (use-package org-superstar
      :hook (org-mode . org-superstar-mode)
      :config
      (setq org-superstar-headline-bullets-list '("◉" "○" "◆" "◇" "✸" "✿")
            org-superstar-leading-bullet ?\s
            org-superstar-item-bullet-alist
            '((?- ?•))))

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode))

;;; Org babel
;; reference for languages support:
;; https://orgmode.org/worg/org-contrib/babel/languages/index.html
(with-eval-after-load 'org
  (setq org-confirm-babel-evaluate nil
        org-src-preserve-indentation t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (lua . t)
     (shell . t)
     (C . t)
     (haskell . t)
     ;(sql . t)
     ;(sqlite . t)
     (css . t)
     (js . t)))))

;;; Org babel
(use-package org-roam
  :general
  (my-leader-def
  "of" 'org-roam-node-find
  "on" 'org-roam-capture)
  :config
  (setq org-roam-directory (expand-file-name "~/Sync/org"))
  (org-roam-db-autosync-enable))

;;; Latex
(use-package auctex
  :config
  (setq TeX-view-program-selection
  '(((output-dvi has-no-display-manager) "dvi2tty")
  ((output-dvi style-pstricks) "dvips and gv")
  (output-dvi "xdvi")
  (output-pdf "xdg-open")
  (output-html "xdg-open"))))

;; Autocompletion
(use-package corfu
  :init
  (global-corfu-mode)
  ;; Auto Completion is disabled by default.
  (setq corfu-auto t))

;; 'corfu' needs providers for completions.
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;;; Treesitter

(use-package treesit
  :when (treesit-available-p)
  :straight (:type built-in)
  :init
  ;; Use "~/.local/share/emacs/treesitter" instead of
  ;; "~/.config/emacs/treesitter".
  (setq treesit-extra-load-path
        `(,(expand-file-name
            (concat
             cache-emacs-directory
             "/tree-sitter"))))
  (setq major-mode-remap-alist
        '((html-mode . html-ts-mode)
          (js-mode . js-ts-mode)
          (python-mode . python-ts-mode)
          (c-mode . c-ts-mode)
          (css-mode . css-ts-mode))))

(defun my-lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . my-lsp-mode-setup)
  :config
  (my-leader-def
  "l" 'lsp-command-map)
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package magit)

(use-package slime
  :commands (slime)
  :config
  (setq inferior-lisp-program "clisp"))

(use-package lua-mode
  :commands (lua-mode)
  :config
  (setq lua-indent-close-paren-align nil)
  (setq lua-indent-level my-default-tab-width))
