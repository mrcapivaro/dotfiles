;;; ~/.config/emacs/early-init.el

;;; Disable 'package.el' since I will not use it.
(setq package-enable-at-startup nil)

;;; Disable GUI and other unnecessary things.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
(setq use-dialog-box nil
      inhibit-startup-message t
      ring-bell-function 'ignore)
