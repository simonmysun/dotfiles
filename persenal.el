(defun disable-smartparens ()
  (smartparens-mode -1))

(add-hook 'smartparens-enabled-hook 'disable-smartparens t)

(setq prelude-flyspell nil)

(global-flycheck-mode -1)
(remove-hook 'prog-mode 'flycheck-mode)


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-langs)

(straight-use-package '(tsi :type git :host github :repo "orzechowskid/tsi.el"))

(straight-use-package '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el"))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))