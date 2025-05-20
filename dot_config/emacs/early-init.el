;; ~/.config/emacs/early-init.el

;;; Disabling UI elements

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)


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
