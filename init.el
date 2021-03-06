;;(set-frame-parameter nil 'fullscreen 'fullboth)
(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

(setq-default cursor-type 'bar) 
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
    (setq exec-path (append exec-path '("/usr/local/bin/")))

(if window-system
    (tool-bar-mode -1)
)


(setenv "PATH" (concat (getenv "PATH") ":~/node_modules/js-beautify/js/bin"))
    (setq exec-path (append exec-path '("~/node_modules/js-beautify/js/bin")))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;MATLAB module
(add-to-list 'load-path "~/.emacs.d/loadpath/")
    (load-library "matlab-load")
    ;; Enable CEDET feature support for MATLAB code. (Optional)
    (matlab-cedet-setup)
;;HTML 5 editor
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(autoload 'xah-css-mode "xah-css-mode" "css major mode." t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . xah-css-mode))

;;
(setq visible-bell t)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)



;;(require 'multi-web-mode)
;;(setq mweb-default-major-mode 'html-mode)
;;(setq mweb-tags 
;;  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;    (js-mode  "<script[^>]*>" "</script>")
;    (css-mode "<style[^>]*>" "</style>")))
;(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;(multi-web-global-mode 1)

;;Some customized function
(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))
(server-start)


(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))



(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
    (js-mode  "<script[^>]*>" "</script>")
    (xah-css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;(defun web-beautify-html-newline ()
 ; (interactive)
  ;(web-beautify-html)
  ;(newline))
(defun sgml-close-tag-back (&optional arg)  
  (interactive)
    (let ((p (point)))
      (sgml-close-tag)
      (goto-char p)))


(defun web-beautify-html-newline (&optional arg)
    (interactive)
    (web-beautify-html)
    (move-end-of-line nil)
    (newline)
    (indent-relative nil))

(defun web-beautify-css-newline (&optional arg)
    (interactive)
    (web-beautify-css)
    (move-end-of-line nil)
    (newline)
    (indent-relative nil))

(defun web-beautify-js-newline (&optional arg)
    (interactive)
    (web-beautify-js)
    (move-end-of-line nil)
    (newline)
    (indent-relative nil))
(defun newline-relative-indent ()
  (interactive)
  (newline)
  (indent-relative nil))





(add-hook 'sgml-mode-hook 'linum-mode)
(add-hook 'js2-mode-hook 'linum-mode)
(add-hook 'json-mode-hook 'linum-mode)
(add-hook 'xah-css-mode-hook 'linum-mode)

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "M-RET") 'web-beautify-html-newline))

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "RET") 'newline-relative-indent))

;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "M-RET") 'web-beautify-js-newline))

(eval-after-load 'js
  '(define-key js-mode-map (kbd "RET") 'newline-relative-indent))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "M-RET") 'web-beautify-js-newline))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "RET") 'newline-relative-indent))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "M-RET") 'web-beautify-html-newline))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "RET") 'newline-relative-indent))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c C-e") 'sgml-close-tag-back))

(eval-after-load 'sgml-mode
		 '(define-key html-mode-map (kbd "C-c C-s") (define-skeleton html-script
  "HTML level 1 headline tags."
  nil
  "<script type = "_">\n \n    </script>")))
  
  (eval-after-load 'sgml-mode
		 '(define-key html-mode-map (kbd "C-c C-t") (define-skeleton html-style
  "HTML level 1 headline tags."
  nil
  "<style type = "_">\n \n    </style>")))
  
(eval-after-load 'sgml-mode
		 '(define-key html-mode-map (kbd "C-c C-h") 'html-template))

		 
		 
		 
(define-skeleton html-template
  "html-template"
  nil
  "<!DOCTYPE html>\n"
  "<html>\n \n"
  "<head> \n"
  "    <meta charset=\"utf-8\"> \n"
  "    <title>"_"</title>\n \n"
  "</head> \n \n"
  "<body> \n \n"
  "</body>\n"
  "</html>")
		 
		 
(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "M-RET") 'web-beautify-css-newline))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "RET") 'newline-relative-indent))

(eval-after-load 'xah-css-mode
  '(define-key (current-global-map) (kbd "RET") 'newline-relative-indent))

(eval-after-load 'xah-css-mode
  '(define-key (current-global-map) (kbd "M-RET") 'web-beautify-html-newline))

(eval-after-load 'xah-css-mode
  '(define-key (current-global-map) (kbd "TAB") 'web-beautify-css))

(eval-after-load 'xah-css-mode
  '(define-key (current-global-map) (kbd "TAB") 'web-beautify-css))
  
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "TAB") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "TAB") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "TAB") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "TAB") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "TAB") 'web-beautify-css))







;;emmet-mode
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-move-cursor-between-quotes t) ;; default nil
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#000000"))
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#424242")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
