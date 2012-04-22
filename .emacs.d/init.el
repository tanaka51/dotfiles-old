;;;;
;;;; Setting at first
;;;;

;; local settings
(setq user-full-name "Koichi Tanaka")

;; ロードパス設定
(setq load-path(cons (expand-file-name "~/.emacs.d/") load-path))
(setq load-path(cons (expand-file-name "~/.emacs.d/elisp") load-path))

;; エラー時になにもしない
(setq ring-bell-function 'ignore)
;; 起動時のスプラッシュ画面を非表示
(setq inhibit-startup-message t)
;; バックアップファイルの作成をしない
(setq-default make-backup-files nil)

(if window-system
    (progn
      (set-frame-parameter nil 'alpha 90) ; 透明度
      (setq line-spacing 0.2) ; 行間
      (setq ns-pop-up-frames nil)))

;; 文字コード
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; フォント設定方法2 by igaiga
;; フレームのフォントを設定
(let* ((size 13) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
       (asciifont "Ricty") ; ASCIIフォント
       (jpfont "Ricty") ; 日本語フォント
       (h (* size 12))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

;; フォントサイズの動的変更
(global-set-key [(meta ?+)] (lambda () (interactive) (text-scale-increase 1)))
(global-set-key [(meta ?-)] (lambda () (interactive) (text-scale-decrease 1)))

;; インデント文字をタブではなく空白に設定
(setq-default indent-tabs-mode nil)
;; 最近、タブも良いかなって、思えてきたんだ…

;; tab幅
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;; 対応する括弧をハイライト
(show-paren-mode t)
;; emacsclient
(server-start)
;; 編集が終了したらアイコン化 ただし、フルスクリーン時には非アクティブになるだけ
;; うざいからやめた
;; (add-hook 'server-done-hook
;;           (lambda ()
;;             (unless server-clients (iconify-frame))))
;; (global-set-key (kbd "C-x C-c") 'server-edit)

;; カラーテーマ
(setq load-path(cons (expand-file-name "~/.emacs.d/color-theme-6.6.0") load-path))
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-robin-hood)
(color-theme-dark-laptop)

;; バックスペースをC-hに割り当て
(global-set-key "\C-h" 'backward-delete-char)

;; リロードをF5に設定
(global-set-key [C-f5] 'revert-buffer)

;; auto install
(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
;; 自動で更新にはいかせない…！
;; (auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; for mac  command key -> Meta key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; MacOS X Dict
(require 'thingatpt)
(defun macdict-lookup (word)
  "Lookup word with Dictionary.app"
  (call-process "open" nil 0 nil (concat "dict://" word)))

(defun macdict-lookup-word ()
  "Lookup the word at point with Dictionary.app."
  (interactive)
  (macdict-lookup (word-at-point)))
(global-set-key (kbd "C-^") 'macdict-lookup-word)

(global-set-key (kbd "C-M-_") 'indent-region)

(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "purple4")

;;;;
;;;; enable dafault settings
;;;;

;; 現在位置のファイル・urlを開く 83
(ffap-bindings)

;; ファイル名がかぶった場合にバッファ名をわかりやすくする 84
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[~*]+")

;; バッファ切り替えを強化する 85
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)

;; ディレクトリ内のファイル名を自由自在に編集する 102
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; hippie-expand 136
(global-set-key (kbd "C-:") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name))

;; which-func-mode 259
(which-func-mode 1)
(setq which-func-modes t)


;;;;
;;;; settings from auto-install
;;;;

;; recentf-ext.el
(setq recentf-max-saved-items 500)
(setq recentf-exclude '("/TAGS$"))
(require 'recentf-ext)
(global-set-key (kbd "C-x :") 'recentf-open-files)
(global-set-key (kbd "C-x C-:") 'recentf-open-files)

;; redo+ 123
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; color-moccur 155
(require 'color-moccur)
(setq moccur-split-word t)

;; moccur-edit 157
(require 'moccur-edit)

;; grep-edit 163
(require 'grep-edit)

;; ruby-block.el
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)

;; crosshairs 168
;; これを設定するとスムーズにスクロールしなくなるから却下
;; (require 'crosshairs)
;; (crosshairs-mode 1)

;; open-junk-file.el 247
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y/%m-%d-%H%M%S.")
(global-set-key (kbd "C-x j") 'open-junk-file)

;; summarye.el
(require 'summarye)
(global-set-key (kbd "C-x /") 'se/make-summary-buffer)

;; auto-complete
(require 'auto-complete-config)
(global-auto-complete-mode 1)

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; php-mode
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

;; rinari
(setq load-path(cons (expand-file-name "~/.emacs.d/elisp/rinari") load-path))
(require 'rinari)

;; rhtml-mode
(setq load-path(cons (expand-file-name "~/.emacs.d/elisp/rhtml") load-path))
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; org-remember
(global-set-key (kbd "C-.") 'org-remember)
(require 'org)
(org-remember-insinuate)
(setq org-directory "~/memo/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
(setq org-remember-templates
      '(("Note" ?n "** %?\n   %i\n   %t" nil "Inbox")
        ("Todo" ?t "** TODO %?\n   %i\n   %t" nil "Inbox")))

;; Clozure CL
;; Clozure CLをでフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "ccl")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/slime")) ;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
(setq slime-net-coding-system 'utf-8-unix)


;;; popwin 設定

;; Apropos
(push '("*slime-apropos*") popwin:special-display-config)
;; Macroexpand
(push '("*slime-macroexpansion*") popwin:special-display-config)
;; Help
(push '("*slime-description*") popwin:special-display-config)
;; Compilation
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
;; Cross-reference
(push '("*slime-xref*") popwin:special-display-config)
;; Debugger
(push '(sldb-mode :stick t) popwin:special-display-config)
;;REPL
(push '(slime-repl-mode) popwin:special-display-config)
;; Connections
(push '(slime-connection-list-mode) popwin:special-display-config)

;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(when (require 'cl-indent-patches nil t) ;; emacs-lispのインデントと混同しないように
  (setq lisp-indent-function
        (lambda (&rest args)
          (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                     'lisp-indent-function
                   'common-lisp-indent-function)
                 args))))


;; goshインタプリタのパスに合わる
(setq scheme-program-name "/usr/local/bin/gosh -i")
;; schemeモードとrun-shchemeモードにcmuscheme.elを使用する
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;;
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(global-set-key (kbd "C-c s") 'scheme-other-window)


;; Migemo
(setq load-path (cons "~/.emacs.d/elisp/" load-path))
(require 'migemo)
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)


;; anything
(require 'anything-startup)
(require 'anything-migemo)
(global-set-key (kbd "C-@") 'anything)  ; もっと良い場所があったら変えたい


;; rst.el
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))
;; 背景が黒い場合はこうしないと見出しが見づらい
(setq frame-background-mode 'dark)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rst-level-1-face ((t (:foreground "LightSkyBlue"))) t)
 '(rst-level-2-face ((t (:foreground "LightGoldenrod"))) t)
 '(rst-level-3-face ((t (:foreground "Cyan1"))) t)
 '(rst-level-4-face ((t (:foreground "chocolate1"))) t)
 '(rst-level-5-face ((t (:foreground "PaleGreen"))) t)
 '(rst-level-6-face ((t (:foreground "Aquamarine"))) t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rst-level-face-base-light 50))


;; ;; scss-mode
;; ;; https://github.com/antonj/scss-mode
(autoload 'scss-mode "scss-mode")
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.\\(scss\\|css\\|scss.erb\\|css.erb\\)\\'" . scss-mode))
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(add-hook 'scss-mode-hook
          (lambda ()
            (setq css-indent-offset 2)
            (setq scss-compile-at-save nil)))
(add-to-list 'ac-modes 'scss-mode)

;;
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ; 折り返し表示ON/OFF
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; ruby-electric
(when (locate-library "ruby-electric")
  (defun ruby-insert-end ()
    (interactive)
    (insert "end")
    (ruby-indent-line t)
    (end-of-line))
  (require 'ruby-electric)
  (ruby-electric-mode t))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
 (cons '("\\.text" . markdown-mode) auto-mode-alist))
