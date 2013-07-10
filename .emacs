;; global vars
(defconst temporary-file-directory "/tmp" "On OSX: the directory /tmp")

;; add directory tree under plugins to load path!
(let ((default-directory "~/.emacs.d/plugins/"))
      (normal-top-level-add-subdirs-to-load-path))

;; auto completion preferences
; start auto completion after 2 characters of word
(setq ac-auto-start 2)
; case sensitive matching
(setq ac-ignore-case nil)
; tab does not indent - use C-j when newline-ing instead
(setq-default indent-tabs-mode nil)


;; javascript console
(require 'js-comint)
;; use node
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
	;; colors
	(ansi-color-for-comint-mode-on)
	;; prompt stuff
	(add-to-list 'comint-preoutput-filter-functions
		     (lambda (output)
		       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
						 (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))

;; Auto completion!!
; default config
(require 'auto-complete-config)
; specify path for autocomplete dictionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/dict")
; use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)


;; snippets
; load it
(require 'yasnippet)
(yas-global-mode 1)

;; javascript linter (jshint)
(require 'flymake-node-jshint)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
;; flymake cursor
(load "flymake-cursor.el")


;; code folding

(add-hook 'js-mode-hook
	  (lambda ()
		 ;; scan for nested code blocks
		 (imenu-add-menubar-index)
		 ;; activate folding mode
		 (hs-minor-mode t)))

;; use js-mode for .json files too
(setq auto-mode-alist (cons '("\\.json\\'" . js-mode) auto-mode-alist))

;; meta key fixes

; turns off non-ascii insertion with alt key
(set-keyboard-coding-system nil)

;; autosaves && backups
;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)




;; assign source control mode to all files under obiechat dir
(load "source-control-mode.el")
(load "minor-mode-list.el")
(add-to-list 'auto-minor-mode-alist `(,(expand-file-name "~/obiechat/*") . source-control-mode))
;;;;;;
;; assign source control mode to all directories in source control (set in global vars at top of .emacs)
;;
;; ... TODO

