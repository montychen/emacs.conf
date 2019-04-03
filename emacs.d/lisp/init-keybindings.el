

(global-set-key "\C-s" 'swiper)     
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)



;;将函数 open-init-file 绑定到 f2 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 显示最近打开文件列表
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;调整缩进、格式化所选中的区域，或当前激活的buffer
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;补充company补全的不足
(global-set-key (kbd "s-/") 'hippie-expand)

;; 在多窗口中快速跳转，定义了快捷键
(global-set-key (kbd "M-o") 'ace-window)


;;在Company-mode 中使用 C-p 与 C-n 来进行上一行、下一行
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;启用 dired-x 就可以使用新的快捷键 C-x C-j 可以进入当前文件所在的目录。
(require 'dired-x)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


(provide 'init-keybindings)
