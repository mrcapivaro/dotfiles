;; ~/.config/emacs/early-init.el

;;; Disable 'package.el' early to favor other package managers.
(setq package-enable-at-startup nil)

;;; Disable unnecessary UI elements.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
