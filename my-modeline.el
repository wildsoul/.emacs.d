;; Mode line setup
(setq nyan-wavy-trail t)
;; (nyan-mode)

(setq-default
 mode-line-format
 '(; Position, including warning for 80 columns
   ; dont need line numbers, cause i use linum
   ;; (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 75)
                          'mode-line-80col-face
                        'mode-line-position-face)))
   ; emacsclient [default -- keep?]
   mode-line-client
   " "
   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize "!RO" 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize "!**" 'face 'mode-line-modified-face))
          (t(propertize " λ " 'face 'mode-line-minor-mode-face))))
   " "
   ; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 10))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ; narrow [default -- keep?]
   " %n"
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   ;; (vc-mode vc-mode)
   " %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   "  "
   ; nyan-mode uses nyan cat as an alternative to %p
   (:eval (when nyan-mode (list (nyan-create))))
   ))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
    :foreground "gray80"
    :background "#0B5568"
    :inverse-video nil
    :box '(:color "#0B5568" :style nil))

(set-face-attribute 'mode-line-inactive nil
    :foreground "gray80" :background "#586e75"
    :inverse-video nil
    :box '(:color "#586e75" :style nil))

(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#6DB3E4"
    :box '(:color "#6DB3E4"))

(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#dc322f"
    :background "#fdf6e3"
    :box '(:color "#dc322f"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#d9a400"
    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo")
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "gray90")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray70")
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#B4CF00")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#b58900")

(provide 'my-modeline)
