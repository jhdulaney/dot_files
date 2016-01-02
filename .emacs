;; Scrolling like in my vimrc

(setq scroll-margin 5)
(setq scroll-step 1)
;; -------

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")





(add-to-list 'load-path "~/.emacs.d/elpa/bash-completion-20150514.728/")
(require 'bash-completion)
(bash-completion-setup)


(require 'tramp)
(setq tramp-default-method "ssh")

(add-to-list 'load-path "~/.emacs.d/elpa/powerline/")
(require 'powerline)
(powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/elpa/nxml-mode-20041004/rng-auto.el")
(add-to-list 'auto-mode-alist
	     (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
		   'nxml-mode))
(unify-8859-on-decoding-mode)


(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
	    magic-mode-alist))
(fset 'xml-mode 'nxml-mode)

(fset 'html-mode 'nxml-mode)

(eval-after-load 'rng-loc '(add-to-list 'rng-schema-locating-files "$d/schemas.xml"))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/git")
(require 'git)
(require 'gnus)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/autoconf")
(require 'autoconf)

(add-to-list 'load-path "/usr/share/emacs/site-list/pymacs.elc")
(require 'pymacs)
(require 'python)
(add-hook 'python-mode-hook 'anaconda-mode)

;; Sane keybindings
(global-set-key (kbd ": list-packages") 'list-packages)
(global-set-key (kbd ": package-install") 'package-install)
(global-set-key (kbd ": bp") 'previous-buffer)
(global-set-key (kbd ": bn") 'next-buffer)
(global-set-key (kbd ": doctor") 'doctor)
(global-set-key (kbd ": calc") 'calc)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-normal-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-normal-state-map "\C-b" 'evil-backward-char)
(define-key evil-insert-state-map "\C-b" 'evil-backward-char)
(define-key evil-visual-state-map "\C-b" 'evil-backward-char)
(define-key evil-normal-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-visual-state-map "\C-d" 'evil-delete-char)
(define-key evil-normal-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-visual-state-map "\C-n" 'evil-next-line)
(define-key evil-normal-state-map "\C-p" 'evil-previous-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
(define-key evil-visual-state-map "\C-p" 'evil-previous-line)
(define-key evil-normal-state-map "\C-w" 'evil-delete)
(define-key evil-insert-state-map "\C-w" 'evil-delete)
(define-key evil-visual-state-map "\C-w" 'evil-delete)
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-normal-state-map "\C-k" 'kill-line)
(define-key evil-insert-state-map "\C-k" 'kill-line)
(define-key evil-visual-state-map "\C-k" 'kill-line)
(define-key evil-normal-state-map "Q" 'call-last-kbd-macro)
(define-key evil-visual-state-map "Q" 'call-last-kbd-macro)
(define-key evil-normal-state-map (kbd "TAB") 'evil-undefine)


;; package stuff
(require 'package)
;; (add-to-list 'package-archives
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Place backups in ~/.backups/ directory, like a civilized program.
;; ------
(if (file-directory-p "~/.backup")
    (setq backup-directory-alist '(("." . "~/.backup")))
  (message "Directory does not exist: ~/.backup"))
(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 3    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too
;; ---------



;; show column number and line number
(dolist (mode '(column-number-mode line-number-mode))
  (when (fboundp mode) (funcall mode t)))

(dolist (mode-hook '(text-mode-hook prog-mode-hook))
  (add-hook mode-hook
	    (lambda ()
	      (linum-mode 1))))

;; show parenthesis match
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Toggle line highlighting in all buffers
(global-hl-line-mode t)

