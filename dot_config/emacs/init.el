;;;+ Basic Stuff

;; Disable the startup message.
(setq inhibit-startup-message t)

;; Set default directory to home
(setq default-directory "~/")

;; Make sure files end with a newline
(setq require-final-newline t)

;; Enable recent files
(recentf-mode 1)
(setq recentf-max-saved-items 25)

;; Enable minibuffer history
(savehist-mode 1)

;; Enable auto-save and backup file handling
(setq make-backup-files nil)   ;; Disable backup files (e.g., ~)
(setq auto-save-default nil)   ;; Disable auto-save files

;; Enable better scrolling behavior
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-margin 3)

;; Ensure that all trailing whitespace is deleted on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Set default indent style
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Automatically reload buffers that change on disk
(global-auto-revert-mode 1)

;; Enable line wrapping for long lines
(setq-default word-wrap nil)

;; Enable windmove for easy window switching
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Make ESC quit prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Allow M-x to autocomplete commands
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Store custom configs in separate files.
(setq custom-file (locate-user-emacs-file "custom-vars.el"))

;;;+ UI Basic Stuff

;; Unclutter screen
(menu-bar-mode -1)            ; Disable the menu bar
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips

;; Disable dialog boxes.
(setopt use-dialog-box nil)

;; Give some breathing room
(set-fringe-mode 10)

(setq visible-bell t)

(set-face-attribute 'default nil :font "IosevkaCapy Nerd Font" :height 110)

;; Relative line numbers.
(display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; Show whitespaces
(require 'whitespace)

;;;+ Package Manager Setup

;; Disable 'package.el'
(setq package-enable-at-startup nil)

;; Change 'straight.el' directory to something outside `.config`.
(setq straight-base-dir "~/.local/share/emacs")

;; 'straight.el' bootstrap
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

;; Install 'use-package.el'
(straight-use-package 'use-package)

;; Require use-package and set to always :ensure t.
(setq straight-use-package-by-default t)

;;;+ Packages

;;;+ VIM Emulation
;; TODO: vim-sneak -> avy/ace-jump <;>
;;       C-x and C-c -> <leader>??
;;       <leader> = <space> and <localleader> = <,>
;;       general.el for keybinds?

;; Functions to use in bindings
(defun switch-to-scratch ()
  "Switch to the scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

;; (defun switch-to-scratch ()
;;   "Switch to the scratch buffer."
;;   (interactive)
;;   (switch-to-buffer "*scratch*"))

;; Helper package for binding keys
(use-package general
  :config
  (general-evil-setup t)
  (general-define-key
   :states 'normal
   "s" 'avy-goto-char-2)
  (general-define-key
   :states 'normal
   :keymaps 'override
   :prefix "SPC"
   "ff" 'dired
   "fb" 'consult-buffer
   "bd" 'evil-delete-buffer
   "bs" #'switch-to-scratch)
  (general-create-definer mrc/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer mrc/local-leader-deF
    :prefix ","))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  ;; needed for evil-collection to work
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;; enable C-r
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

;; vim-leap emacs equivalent
;; evil-snipe: almost like vim-leap
(use-package avy
  :after evil
  :config
  (global-set-key (kbd "C-c C-s") 'avy-goto-char-2))

;; Statusline for emacs that integrates nicely with (Neo)Vim emulation, like
;; evil mode(doom-modeline).
;; It would be nice to be able to change the cwd in emacs with some sort of
;; command and then show the cwd + the relative path of the current file.
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;;;+ Theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;;;+ Which Key
(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.3))

;;;+ Mini Buffer
;; source: https://protesilaos.com/codelog/2024-02-17-emacs-modern-minibuffer-packages/
(use-package vertico
    :config
    (setq vertico-cycle t)
    (setq vertico-resize nil)
    (vertico-mode 1))

(use-package consult)

(use-package marginalia
    :config
    (marginalia-mode 1))

;;;+ Buffer Autocompletion

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :init
  (global-corfu-mode))

;; Add extensions
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative keys: M-p, M-+, ...
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)

;; Tab/Bufferline and change buffers with Tab and S-Tab.
;; Show only the name of the current file in the buffers tab and it's
;; relative path only when two files have the same name.

;; FZF stuff?
;; <leader>ff - find file in cwd
;; <leader>fw - fzf grep file in cwd

;; Integrated Terminal that can work with my custom fish/bash/zsh config.
;; Evil mode keybinds obviously.
;; Start in the terminal mode could be nice.

;; Org Mode
;;     - TODO(Agenda & Calendar?) & REFILE;
;;     - Roam/Zettelkasten;
;;     - Templates;
;;     - Daily Journal;
;;     - Evil mode keybinds for new zettels/nodes, notes, daily journal, etc;
;;     - Embedded Latex and Images;
;;     - Private Git Repo integration(Magit?);
(use-package org
  :custom
  (org-directory "~/Notes"))

(use-package org-bullets
  :hook (( org-mode ) . org-bullets-mode))

;; Package to enable LSP integration in emacs(LSP Mode).
;; LSP's and packages for programming languages:
;;
;; Standard:
;;     - C & C++;
;;     - Lua;
;;
;; Scripting:
;;     - Python;
;;     - Shell(Bash, Fish and Powershell/CMD);
;;     - Lisp & Elisp;
;;
;; WebDev:
;;     - HTML;
;;     - CSS;
;;     - Javascript and Typescript;
;;     - JS Frameworks and Runtimes;
;;     - Go;
;;
;; Interested:
;;     - Rust;
;;     - Haskell;
;;     - Nix;
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;; (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)

;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
(add-to-list 'load-path "~/.local/share/emacs/straight/repos/lsp-mode")
(add-to-list 'load-path "~/.local/share/emacs/straight/repos/lsp-mode/clients")

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;;;+ GIT Integration
(use-package magit
  :bind (("C-x g" . magit-status)))

;;;+ Scratch Buffer
;; Start with org mode
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "#+Title: Scratch Buffer\n\n")

;;;+ Better Dired
(use-package dirvish
  :config
  (dirvish-override-dired-mode))
