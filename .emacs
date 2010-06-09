(add-to-list 'load-path "~/.elisp")
(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(require 'goto-last-change)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq auto-save-default nil) 
(setq ipython-command "/usr/bin/ipython")
(require 'ipython)
; (require 'pymacs)
; (pymacs-load "ropemacs" "rope-")
;; (desktop-save-mode 1)
(setq-default indent-tabs-mode nil)


(setq-default indent-tabs-mode nil)
(setq make-backup-files t)
;;(setq version-control t)

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

(require 'git)
;(line-number-mode 1)
(defun my-haskell-mode-hook () 
 (local-set-key "\C-cl" 'hs-lint))

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
(org-remember-insinuate)
 

 (setq org-directory "~/.orgfiles/")
 (setq org-default-notes-file "~/.journal/mine.org")
 (setq remember-annotation-functions '(org-remember-annotation))
 (setq remember-handler-functions '(org-remember-handler))
 (add-hook 'remember-mode-hook 'org-remember-apply-template)
 (define-key global-map "\C-cr" 'org-remember)

 (setq org-remember-templates
    '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/.journal/newgtd.org" "Tasks")
      ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "~/.journal/journal.org")
      ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "~/.journal/journal.org")
      ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "~/.journal/finances.org")
      ("Someday"   ?s "** %^{Someday Heading} %U\n%?\n"  "~/.journal/someday.org")
      ("Vocab"   ?v "** %^{Word?}\n%?\n"  "~/.journal/vocab.org")
     )
   )

;; (defun toggle-selective-display (column)
;;    (interactive "P")
;;       (set-selective-display
;;        (or column
;;            (unless selective-display
;;              (1+ (current-column))))))

;;     (defun toggle-hiding (column)
;;       (interactive "P")
;;       (if hs-minor-mode
;;           (if (condition-case nil
;;                   (hs-toggle-hiding)
;;                 (error t))
;;               (hs-show-all))
;;         (toggle-selective-display column)))

;; (global-set-key (kbd "C-\\") 'toggle-hiding)
;; (add-hook 'c-mode-common-hook   'hs-minor-mode)
;; (add-hook 'sh-mode-hook         'hs-minor-mode)
;; (setq org-remember-templates
;;       '(("Journal"
;;          ?j
;;          "* %U %? %^g\n\n   %x"
;;          "~/.journal/journal.org"
;;          'top)))
;; (global-set-key (kbd "C-c j") 'org-remember)
