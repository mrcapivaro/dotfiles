;;;+ Basic Stuff

;; Disable the startup message.
(setq inhibit-startup-message t)

;; Set default directory to home
(setq default-directory "~/")

;; Make sure files end with a newline
(setq require-final-newline t)

;; Enable recent files
;; (recentf-mode 1)
;; (setq recentf-max-saved-items 25)

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

;; VIM Emulation
;; TODO: vim-sneak -> avy/ace-jump <;>
;;       C-x and C-c -> <leader>??
;;       <leader> = <space> and <localleader> = <,>
;;       general.el for keybinds?
(use-package general)

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

;; Statusline for emacs that integrates nicely with (Neo)Vim emulation, like
;; evil mode(doom-modeline).
;; It would be nice to be able to change the cwd in emacs with some sort of
;; command and then show the cwd + the relative path of the current file.
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Theme
(use-package catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

;; Which Key
(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.3))

;; Mini Buffer Completion(Ivy), it's integration with emacs builtin
;; functionality(Counsel) and a Replacement for the builtin emacs package
;; called I-Search(Swiper).
(use-package ivy
  :diminish
  :bind (("C-s" . save-buffer)
         ("C-x C-f" . counsel-find-file)
         ("C-x C-b" . counsel-buffer-or-recentf)
         :map ivy-minibuffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("<tab>" . ivy-next-line)
         ("S-<iso-lefttab>" . ivy-previous-line)
         ("RET" . ivy-alt-done)
         :map ivy-switch-buffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("<tab>" . ivy-next-line)
         ("S-<iso-lefttab>" . ivy-previous-line)
         ("RET" . ivy-alt-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("S-<iso-lefttab>" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel)
(use-package swiper)

;; Buffer Autocompletion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 2))

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

;; GIT Integration
(use-package magit
  :bind (("C-x g" . magit-status)))
