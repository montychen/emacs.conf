(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(
			   ;;   ("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ;;   ("melpa" . "http://elpa.emacs-china.org/melpa/")
			   ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                           ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			   )))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
   		      company
		      counsel
		      exec-path-from-shell  ;;允许访问环境变量$PATH的设置。

		      swiper  ;;当前缓冲区搜索工具
		      rg ;;整个项目，多文件搜索工具
		      yasnippet  ;;代码块补全的插件, 没内置包含代码块
		      yasnippet-snippets  ;; 这里定义了yasnippet的补全代码块

		      ace-window  ;;在多窗口中快速跳转,自定义了M-o快捷键
		      avy
		      
		      js2-mode
		      web-mode
       		      json-mode
		      popwin
		      reveal-in-osx-finder   ;;直接在finder中高亮定位当前buffer的位置

		      expand-region  ;; 方便的选中莫个区域
		      iedit

		      ;; --- Themes ---
		      gruvbox-theme
		      zenburn-theme
		      ) "Default packages")

(setq package-selected-packages my/packages)



(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless ()
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))



;;先要M-x运行iedit-mode进入该模式后，才能使用 C-; 进行切换， 下面是修改iedit选中的高亮颜色;
(custom-set-faces
 '(iedit-occurrence ((t (:background "gray10" :foreground "orange2" :weight bold))))
 )




;;代码块补全的插件yasnippet, 没内置包含代码块。补全代码的定义在yasnippet-snippets
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)


;;  加载插件
(load-theme 'zenburn t)
;;(load-theme 'gruvbox-dark-soft t)


(global-company-mode 1)
(setq-default company-minimum-prefix-length 2)
(setq-default company-tooltip-idle-delay 0.08)

;; on OS X, 确保Emacs可以访问环境变量 $PATH 里的设置。
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; config for swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)



;;config for popwin
(require 'popwin)
(popwin-mode 1)



(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       '(("\\.htm\\'" . web-mode))
       auto-mode-alist))

;; 先按C-=,  然后 = 选更多， - 减少， 0 不选
(global-set-key (kbd "C-=") 'er/expand-region)


(provide 'init-packages)

