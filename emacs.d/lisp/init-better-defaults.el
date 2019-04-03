
;; 高亮匹配的括号
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;光标在括号内时就高亮包含内容的两个括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;; 隐藏工具条
(tool-bar-mode -1)


;; 更改字体
(set-face-attribute 'default nil :height 150)

;; 默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 高亮显示当前行
;;(global-hl-line-mode 1)

;; 去掉滚动到顶部或底部发出的"咚咚声"
(setq ring-bell-function 'ignore)

;; 显示行号
(global-linum-mode 1)
;;显示列的位置
(column-number-mode t)

;;显示时间
(display-time-mode t)

;; 禁止自动生成备份文件
(setq-default  make-backup-files nil)

;;禁止自动保存
(setq-default auto-save-default nil)

;; 选中内容，此时如果输入，则选中的内容会被替换掉。
(delete-selection-mode t)

;;简化yes or no 的输入
(fset 'yes-or-no-p 'y-or-n-p)

;;调整缩进、格式化所选中的区域，或当前激活的buffer
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))
(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

;;Dired 模式下总是递归删除、拷贝
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;;限制只有一个Dired的Buffer窗口，避免打开多个
(put 'dired-find-alternate-file 'disabled nil)



;;用hippie-expand来补充company补全的不足
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))


;;occur窗口在右边显示，宽度是55
;;(setq popwin:popup-window-position 'right)
;;(setq popwin:popup-window-width 60)

;;配置 Occur Mode 使其默认搜索当前被选中的或者在光标下的字符串
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


(provide 'init-better-defaults)
