(defun disable-smartparens ()
  (smartparens-mode -1))

(add-hook 'smartparens-enabled-hook 'disable-smartparens t)

(setq prelude-flyspell nil)

(global-flycheck-mode -1)
(remove-hook 'prog-mode 'flycheck-mode)
