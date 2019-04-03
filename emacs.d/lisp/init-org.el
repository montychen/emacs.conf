(require 'org)
(setq org-src-fontify-natively t)


;;config for org-agenda
(setq org-agenda-files '("~/STUDY/org"))
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'init-org)
 
