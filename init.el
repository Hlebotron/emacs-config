(set-foreground-color "#FFFFFF")
(set-background-color "#080810")

(setq default-frame-alist '((font . "iosevka 12")
                            (background-color . "#080810")
                            (foreground-color . "#FFFFFF")
                            (vertical-scroll-bars)))
;; (set-frame-font "-ukwn-iosevka-regular-normal-expanded-*-13-*-*-*-d-0-iso10646-11")

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :init
;;   ; to get lsp-mode going with xtensa
;;   (setq lsp-clients-clangd-executable "clangd")
;;   (setq lsp-clients-clangd-args '("--query-driver=/**/bin/xtensa-esp32-elf-*" "--background-index" "--header-insertion=iwyu" "-j=4" ))
;;   :hook
;;   (c-mode . lsp)
;;   (lsp-mode . lsp-enable-which-key-integration))

;; (use-package lsp-ui
;;   :commands lsp-ui-mode)

(require 'package)
(require 'use-package-ensure)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
;; (add-to-list 'package-archives '("nextcloud" . "https://codeberg.org/martianh/nc.el.git") t)
;; (package-initialize)
(setq use-package-always-ensure t)

(use-package multiple-cursors)
(use-package magit)
(use-package org)
(use-package org-bullets)
(use-package pretty-symbols)
(use-package ivy)
(use-package undo-tree)
(use-package nix-mode)
(use-package yaml-mode)
(use-package caddyfile-mode)
(use-package markdown-mode)
(use-package scad-mode)
;; (use-package evil)
;; (use-package diff-hl-mode)
(use-package emms
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (require 'emms-volume)
  (emms-all)
  (emms-default-players)
  (add-to-list 'emms-player-list 'emms-player-mpd)
  ;; (setq emms-player-list `(emms-player-mpd))
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (setq emms-player-mpd-server-name "/home/sasha/.mpd/socket"
        emms-player-mpd-music-directory "/home/sasha/Music"
	emms-player-mpd-server-port nil
	emms-source-file-default-directory "~/Music/"
	emms-volume-change-function 'emms-volume-mpd-change)
  (emms-player-mpd-connect)
  (emms-player-mpd-update-all))

(require 'iso-transl)
;; (add-hook 'emms-playlist-cleared-hook 'emms-player-mpd-clear))

;; (set-face-attribute 'default nil :family "iosevka")
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(ido-mode 1)
(multiple-cursors-mode 1)
(ivy-mode 1)
(auto-revert-mode 1)
(global-display-line-numbers-mode 1)
(global-undo-tree-mode 1)
(electric-pair-mode 1)

(set-mouse-color "white")

(setq global-display-line-numbers 'relative
      inhibit-startup-message 1
      backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      lpr-command "lp"
      lpr-add-switches nil
      mpc-browser-tags `(Playlist)
      kill-buffer-delete-auto-save-files t
      create-lockfiles nil
      user-mail-address "stabasov@gmail.com"
      doc-view-resolution 100)

;; (defun select-mpd-file ()
;;    (string-remove-prefix "/" (string-remove-prefix emms-player-mpd-music-directory (read-file-name "Please enter a file: " emms-player-mpd-music-directory))))

;; (defun mpd-insert ()
;;   "Interactively ask for a filename to insert into the MPD playlist."
;;   (interactive)
;;   (let ((file (select-mpd-file)))
;;     (shell-command (concat "mpc insert " file))
;;     (message (concat "Added " file))))
;;   ;; (emms-player-mpd-send
;; ;;  (concat "insert " (read-file-name "Please enter a file: " emms-player-mpd-music-directory))))
;; (message )

;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(keymap-global-set "C-." 'mc/mark-next-like-this)
(keymap-global-set "C-," 'mc/mark-previous-like-this)
(keymap-global-set "C->" 'mc/skip-to-next-like-this)
(keymap-global-set "C-<" 'mc/skip-to-previous-like-this)
(keymap-global-set "C-c C-<" 'mc/mark-all-like-this)
(keymap-global-set "C-c C-r" 'recompile)
(keymap-global-set "C-c C-s" 'emms-player-mpd-show)
(keymap-global-set "C-c C-c" 'shell)
(keymap-global-set "C-c C-l" 'mpc-list)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
;; (evil-mode 1)
(defun org-setup () "configure org mode"
       (setq org-hide-emphasis-markers t
             org-ellipsis " ⏷"
             visual-line-mode 0
             auto-fill-mode 1)
       (font-lock-mode 1)
       (org-bullets-mode 1)
       (prettify-symbols-mode 1)
       (font-lock-add-keywords 'org-mode
                               '(("^ *\\([-]\\) "
                                  (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
       (custom-theme-set-faces
        'user
        '(variable-pitch ((t (:family "noto serif" :height 180 :weight regular))))
        '(fixed-pitch ((t ( :family "iosevka" :height 160)))))
       (dolist (face '(
                       (org-level-1 . 1.2)
                       (org-level-2 . 1.1)
                       (org-level-3 . 1.05)
                       (org-level-4 . 1.0)
                       (org-level-5 . 0.95)
                       (org-level-6 . 0.9)
                       (org-level-7 . 0.85)
                       (org-level-8 . 0.8)))
         (set-face-attribute (car face) nil :family "noto serif" :weight 'bold :height (cdr face)))
       (set-face-attribute 'org-block nil :foreground nil :height 1.0 :inherit 'fixed-pitch)
       (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
       ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
       (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
       (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
       (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
       (set-face-attribute 'org-checkbox nil :height 1.0 :inherit 'fixed-pitch)
       (set-face-attribute 'org-default nil :height 0.8 :inherit 'variable-pitch)
       (put 'downcase-region 'disabled nil)

       ;; (add-hook 'org-mode-hook (lambda ()
       ;;                            "beautify org checkbox symbol"
       ;;                            (setq prettify-symbols-alist
       ;;                                  (prettify-utils-generate
       ;;                                   ("[ ]" "☐")
       ;;                                   ("[x]" "☑")
       ;;                                   ("[-]" "❍")))
       ;; 				  (prettify-symbols-mode)))
       (interactive)
       (buffer-face-mode t))

(defun info-setup () "configure Info mode"
       (custom-theme-set-faces
        'user
        '(variable-pitch ((t (:family "noto serif" :weight regular))))
        '(fixed-pitch ((t (:family "iosevka"))))
	'(Info-quoted ((t (:family "iosevka" :slant italic :foreground "#FF0")))))
       (interactive)
       (buffer-face-mode t))

(defun mpc-list () "Spawn a window with the list of songs currently playing"
       (interactive)
       (require 'mpc)
       (let* ((buf (mpc-songs-buf))
	      (win (split-window-right)))
	 (set-window-buffer win buf)
	 (set-frame-selected-window nil win))
       (mpc-songs-refresh)
       (mpc-status-refresh))

(defun emms-setup () "Configure EMMS mode"
       (emms-player-mpd-connect)
       ;; (keymap-global-set "n" 'emms-player-mpd-next)
       ;; (keymap-global-set "p" 'emms-player-mpd-previous)
       (message "Loaded EMMS hook"))

(add-hook 'org-mode-hook 'org-setup)
(add-hook 'Info-mode-hook 'info-setup)
(add-hook 'emms-playlist-mode-hook 'emms-setup)
;; (add-hook 'emms-browser-show-display-mode-hook 'emms-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(caddyfile-mode evil ivy key-chord magit markdown-mode
		    multiple-cursors nix-mode org-bullets
		    pretty-symbols scad-mode undo-tree yaml-mode))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-quoted ((t (:family "iosevka" :slant italic :foreground "#FF0"))))
 '(fixed-pitch ((t (:family "iosevka" :height 160))))
 '(variable-pitch ((t (:family "noto serif" :height 180 :weight thin)))))
