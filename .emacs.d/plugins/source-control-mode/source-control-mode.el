;;;;;;
;;
;; source-control-mode: minor mode that turns off backups
;; (intended use for project directories managed under git/svn/etc
(define-minor-mode source-control-mode
"With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " source-control"
  ;; The minor mode bindings.
  nil
  (if (symbol-value source-control-mode)
      (progn
        ;; disable backups
        (set (make-local-variable 'backup-inhibited) t)

    ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited))))

