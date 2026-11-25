(need zsh-function ask3
  (in (or args (stdin (if-tty (eprint "粘贴完按 Ctrl-D")))))
  (curl deepseek deepseek-flash (key-in-env DSKEY))
  (eprint "已发出，等回复…" (after "用时 N 秒"))
  (save ~/ds/last.json)
  (print .choices[0].message.content (or .error.message))
  (style minimal no-checks)
  (deliver (paste-to-install ~/ds/ask3.zsh) (then source)))
