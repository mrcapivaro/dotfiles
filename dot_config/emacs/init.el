;; Inspired from:
;; https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org

;;; Base Configuration

(setq ;; Disable unneeded prompts.
      inhibit-startup-message t
      use-dialog-box nil

      ;; Disable the cursor blinking.
      blink-cursor-mode nil

      ;; Do not create backup files of the type: #file#.
      auto-save-default nil
      make-backup-files nil

      ;; Do not warn on large files.
      large-file-warning-threshold nil

      ;; Follow symlinks on version controlled(vc) files without
      ;; warning.
      vc-follow-symlinks t

      ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      native-comp-async-report-warnings-erros nil)

;; Tabs
(defvar mrc/default-tab-width 4)
(setq-default tab-width mrc/default-tab-width
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
   `(whitespace-newline ((t (:foreground ,ws-color))))
   `(whitespace-missing-newline-at-eof ((t (:foreground ,ws-color))))
   `(whitespace-space-after-tab ((t (:foreground ,ws-color))))
   `(whitespace-space-before-tab ((t (:foreground ,ws-color))))
   `(whitespace-trailing ((t (:foreground ,ws-color))))
   `(whitespace-tab ((t (:foreground ,ws-color))))
   `(whitespace-space ((t (:foreground ,ws-color))))))

(global-whitespace-mode 1)

;; https://www.youtube.com/watch?v=51eSeqcaikM
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq history-lenght 25)
(savehist-mode 1)

;;; Fonts

;; Variables
(defvar mrc/default-font "Iosevka Nerd Font")
(defvar mrc/default-font-size 130)
(defvar mrc/default-variable-font-size 140)
(defvar mrc/default-frame-font
  (concat mrc/default-font
          " "
          (number-to-string (/ mrc/default-font-size 10))))

;; Main font setup procedure.
(defun mrc/font-setup ()
  (set-face-attribute 'default nil
                      :font mrc/default-font
                      :height mrc/default-font-size)

  (set-face-attribute 'fixed-pitch nil
                      :font mrc/default-font
                      :height mrc/default-font-size)

  (set-face-attribute 'variable-pitch nil
                      :font mrc/default-font
                      :height mrc/default-font-size))

;; Setup fonts for regular Emacs.
(mrc/font-setup)

;; Setup fonts for Emacs Clients.
(add-hook 'after-make-frame-functions
          (lambda (frame) (with-selected-frame frame (mrc/font-setup))))

;;; Line numbering

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;; Scratch Buffer
;; TODO change it to the refile.org
;;      expect to get the ~/Sync/org/refile.org but have a replacement
;;      for it in the case of non availability of the ~/Sync folder.

(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "#+title: Scratch Buffer

")

;;; User commands for configuration files management

(defun mrc/open-config ()
  "Open the init.el file."
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun mrc/open-org-config ()
  "Open the emacs.org file."
  (interactive)
  (find-file (expand-file-name "emacs.org" user-emacs-directory)))

(defun mrc/reload-config ()
  "Reload the init.el file."
  (interactive)
  (load user-init-file))

;;; Package Manager

;; Bootstrap straight.el
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

;; Options
(setq straight-vc-git-default-clone-depth '(1 single-branch))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;; Clean the config folder

(setq cache-emacs-directory (expand-file-name "~/.local/share/emacs"))
(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "etc/" cache-emacs-directory)
        no-littering-var-directory
        (expand-file-name "var/" cache-emacs-directory)))

;;; Keybinds

;; Buffer cycling config
;; https://emacs.stackexchange.com/questions/17687/make-previous-buffer-and-next-buffer-to-ignore-some-buffers
;; TODO understand emacs regexp
(defcustom mrc/buffer-skip-regexp
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

(defun mrc/buffer-skip-p (window buffer bury-or-kill)
  "Return t if BUFFER name matches `mrc/buffer-skip-regexp'."
  (string-match-p mrc/buffer-skip-regexp (buffer-name buffer)))

(setq switch-to-prev-buffer-skip 'mrc/buffer-skip-p)

;; Make 'ESC' quit prompts
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

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; comment command
(defun mrc/toggle-comment-region-or-line ()
    "Toggle the comment state of the current line or region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

;; general.el
(use-package general
  :after evil
  :config

  ;; Create wrappers for leader keybinds
  (general-create-definer mrc/leader-def
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer mrc/local-leader-def
    :keymaps '(normal visual emacs)
    :prefix ",")

  ;; Commands to be used in binds
  (defun mrc/evil-shift-left-keep-selected ()
    (interactive)
    (evil-shift-left (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))

  (defun mrc/evil-shift-right-keep-selected ()
    (interactive)
    (evil-shift-right (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))

  (general-def :keymaps 'override
    ;; Use the standard C-S-{c,v} for copy and paste.
    "C-S-c" 'kill-ring-save
    "C-S-v" 'yank)

  ;; Non-leader binds
  (general-def '(normal emacs)
    "x"  nil
    "xc" 'mrc/toggle-comment-region-or-line
    "x:" 'eval-expression
    "xi" 'evil-fill-and-move
    "L"  'next-buffer
    "H"  'previous-buffer)

  (general-def '(visual)
    ">" 'mrc/evil-shift-right-keep-selected
    "<" 'mrc/evil-shift-left-keep-selected)

  ;; Leader binds
  (mrc/leader-def
    "s"  'save-buffer
    "e"  'dired-jump

    "."  'counsel-find-file
    "f"   '(:ignore t :which-key "find")
    "fc"  'mrc/open-config
    "ff"  'counsel-fzf
    "fw"  'counsel-rg
    "fr"  'counsel-recentf

    "j"   '(:ignore t :which-key "buffer")
    "jd"  '(lambda () (interactive)
             (kill-buffer (current-buffer)))
    "jf"  'counsel-switch-buffer
    "js"  'scratch-buffer

    "r"   '(:ignore t :which-key "run/restart")
    "re"  'restart-emacs
    "ri"  'mrc/reload-config

    "h"   '(:ignore t :which-key "help")
    "hv"  'counsel-describe-variable
    "hf"  'counsel-describe-function
    "ho"  'counsel-describe-symbol
    "hm"  'describe-mode
    "hk"  'describe-key
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

(use-package avy
  :general-config
  ('(normal emacs visual operator) "s" 'avy-goto-char-2))

;;; Appearance

;; Colorscheme, Statusline & Icons

(use-package all-the-icons)
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init (setq doom-modeline-support-imenu t)
        (setq doom-modeline-height 25)
        (setq doom-modeline-bar-width 4)
        (setq doom-modeline-hud nil)
        (setq doom-modeline-window-width-limit 85)
        (setq doom-modeline-spc-face-overrides nil)
        (setq doom-modeline-project-detection 'auto)
        (setq doom-modeline-buffer-file-name-style 'auto)
        (setq doom-modeline-icon t)
        (setq doom-modeline-major-mode-icon t)
        (setq doom-modeline-major-mode-color-icon t)
        (setq doom-modeline-buffer-state-icon t)
        (setq doom-modeline-buffer-modification-icon t)
        (setq doom-modeline-lsp-icon t)
        (setq doom-modeline-time-icon t)
        (setq doom-modeline-time-live-icon t)
        (setq doom-modeline-time-analogue-clock t)
        (setq doom-modeline-time-clock-size 0.7)
        (setq doom-modeline-unicode-fallback nil)
        (setq doom-modeline-buffer-name t)
        (setq doom-modeline-highlight-modified-buffer-name t)
        (setq doom-modeline-column-zero-based t)
        (setq doom-modeline-percent-position '(-3 "%p"))
        (setq doom-modeline-position-line-format '("L%l"))
        (setq doom-modeline-position-column-format '("C%c"))
        (setq doom-modeline-position-column-line-format '("%l:%c"))
        (setq doom-modeline-minor-modes nil)
        (setq doom-modeline-enable-word-count nil)
        (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
        (setq doom-modeline-buffer-encoding t)
        (setq doom-modeline-indent-info nil)
        (setq doom-modeline-total-line-number nil)
        (setq doom-modeline-vcs-icon t)
        (setq doom-modeline-vcs-max-length 15)
        (setq doom-modeline-vcs-display-function #'doom-modeline-vcs-name)
        (setq doom-modeline-vcs-state-faces-alist
            '((needs-update . (doom-modeline-warning bold))
                (removed . (doom-modeline-urgent bold))
                (conflict . (doom-modeline-urgent bold))
                (unregistered . (doom-modeline-urgent bold))))
        (setq doom-modeline-check-icon t)
        (setq doom-modeline-check-simple-format nil)
        (setq doom-modeline-number-limit 99)
        (setq doom-modeline-project-name t)
        (setq doom-modeline-workspace-name t)
        (setq doom-modeline-persp-name t)
        (setq doom-modeline-display-default-persp-name nil)
        (setq doom-modeline-persp-icon t)
        (setq doom-modeline-lsp t)
        (setq doom-modeline-github nil)
        (setq doom-modeline-github-interval (* 30 60))
        (setq doom-modeline-modal t)
        (setq doom-modeline-modal-icon t)
        (setq doom-modeline-modal-modern-icon nil)
        (setq doom-modeline-always-show-macro-register nil)
        (setq doom-modeline-gnus t)
        (setq doom-modeline-gnus-timer 2)
        (setq doom-modeline-gnus-excluded-groups '("dummy.group"))
        (setq doom-modeline-irc t)
        (setq doom-modeline-irc-stylize 'identity)
        (setq doom-modeline-battery t)
        (setq doom-modeline-time t)
        (setq doom-modeline-display-misc-in-all-mode-lines t)
        (setq doom-modeline-buffer-file-name-function #'identity)
        (setq doom-modeline-buffer-file-truename-function #'identity)
        (setq doom-modeline-env-version t)
        (setq doom-modeline-env-enable-python t)
        (setq doom-modeline-env-enable-ruby t)
        (setq doom-modeline-env-enable-perl t)
        (setq doom-modeline-env-enable-go t)
        (setq doom-modeline-env-enable-elixir t)
        (setq doom-modeline-env-enable-rust t)
        (setq doom-modeline-env-python-executable "python")
        (setq doom-modeline-env-ruby-executable "ruby")
        (setq doom-modeline-env-perl-executable "perl")
        (setq doom-modeline-env-go-executable "go")
        (setq doom-modeline-env-elixir-executable "iex")
        (setq doom-modeline-env-rust-executable "rustc")
        (setq doom-modeline-env-load-string "...")
        (setq doom-modeline-always-visible-segments '(irc))
        (setq doom-modeline-before-update-env-hook nil)
        (setq doom-modeline-after-update-env-hook nil))

;;; Minibuffer Completion
;; TODO: set up some keybinds with general and evil here, for files and buffers

(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
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
  ;; :bind (("C-M-j" . 'counsel-switch-buffer)
  ;;       :map minibuffer-local-map
  ;;       ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (general-def '(normal visual motion) "xx" 'counsel-M-x)
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

;;; {E}shell, Emulate a {Term}inal (Eat) & *Compilation*

(use-package term
  :straight (:type built-in)
  :config
  (setq explicit-shell-file-name "zsh")
  (setq shell-file-name explicit-shell-file-name)
  (mrc/leader-def
    "t" 'term))

;;; Org Mode

(setq user-org-directory (expand-file-name "~/Sync/org")
      org-indent-indentation-per-level 1)

;; File bookmarks

(defun mrc/org-refile ()
  "Open refile.org."
  (interactive)
  (find-file (expand-file-name "refile.org" user-org-directory)))

(defun mrc/org-agenda ()
  "Open agenda.org."
  (interactive)
  (find-file (expand-file-name "agenda.org" user-org-directory)))

;; Dynamic font sizes and family & Change list item hyphen for an utf-8 dot
(with-eval-after-load 'org-faces
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region
                                           (match-beginning 1)
                                           (match-end 1) "•"))))))

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
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
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

;; Org mode initial setup
(defun mrc/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :straight (:type built-in)
  :commands (org-capture org-agenda)
  :hook (org-mode . mrc/org-mode-setup)
  :config

  (general-def 'normal 'org-mode-map
    "<tab>" 'evil-toggle-fold)
  
  (general-def 'insert 'org-mode-map
    "C-<return>" 'org-meta-return
    "M-<return>" 'org-insert-heading-respect-content)

  (mrc/leader-def
    "o"  '(:ignore t :which-key "org")
    "or" 'mrc/org-refile
    "oc" 'mrc/open-org-config
    "oa" 'mrc/org-agenda))

;; Heading Bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "◆" "◇" "✸" "✿")))

;;; Center Buffers
(use-package visual-fill-column
  :config
    (setq visual-fill-column-width 80
          visual-fill-column-center-text t)
    (global-visual-fill-column-mode 1)
    (mrc/leader-def "z" 'visual-fill-column-toggle-center-text))

;;; Org Mode Babel

;; reference for languages support:
;; https://orgmode.org/worg/org-contrib/babel/languages/index.html
(with-eval-after-load 'org
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
        (js . t))))

;;; IDE stuff

;; Autocompletion
(use-package company
  :hook (prog-mode latex-mode))

;; Latex
(use-package auctex
  :config
  (setq TeX-view-program-selection
   '(((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "xdg-open")
     (output-html "xdg-open"))))

;; LSP
(defun mrc/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . mrc/lsp-mode-setup)
  :config
  (mrc/leader-def
    "l" 'lsp-command-map)

  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; DAP: ...

;; Shell: bash, zsh, fish, cmd & powershell

;; Scripting: Python, Lua & {Emacs|Common}Lisp
(use-package slime
  :commands (slime)
  :config
  (setq inferior-lisp-program "clisp"))

(use-package lua-mode
  :commands (lua-mode)
  :config
  (setq lua-indent-close-paren-align nil)
  (setq lua-indent-level mrc/default-tab-width))

;; Systems: Go, C & C++
;; Web: HTML, CSS, JS/TS & Frameworks
;; Functional: Haskell
