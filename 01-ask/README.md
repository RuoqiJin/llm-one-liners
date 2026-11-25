# 01-ask: a question-and-answer function in one line

The line asks the model to write `ask3`, a zsh function that sends a question to the model and prints the answer.

## The line

It is in [`line.sh`](line.sh). Set the key first, then paste the line:

```sh
export DSKEY=...   # your DeepSeek API key
```

```sh
curl -s https://api.deepseek.com/chat/completions -H "Authorization: Bearer $DSKEY" -H "Content-Type: application/json" -d '{"model":"deepseek-flash","messages":[{"role":"user","content":"(need zsh-function ask3 (in (or args (stdin (if-tty (eprint \"粘贴完按 Ctrl-D\"))))) (curl deepseek deepseek-flash (key-in-env DSKEY)) (eprint \"已发出，等回复…\" (after \"用时 N 秒\")) (save ~/ds/last.json) (print .choices[0].message.content (or .error.message)) (style minimal no-checks) (deliver (paste-to-install ~/ds/ask3.zsh) (then source)))"}]}' | jq -r '.choices[0].message.content'
```

You need zsh, curl and jq.

## What comes back

After some tens of seconds the line prints one block of shell. The block creates `~/ds`, writes the function to `~/ds/ask3.zsh` and loads it. [`sample-reply.zsh`](sample-reply.zsh) is one reply, kept as it came. Yours will differ in detail.

Read the block, then paste it.

## Using `ask3`

```sh
ask3 "What does jq -r do?"      # the question as arguments (quote it: zsh treats ? and * specially)
echo "Explain this error: ..." | ask3   # the question from a pipe
ask3                             # no arguments: paste the question, then press Ctrl-D
```

It prints `已发出，等回复…` ("sent, waiting for the reply") when the request goes out and `用时 N 秒` ("took N seconds") when the reply arrives. The full reply is saved in `~/ds/last.json`. If the API returns an error, `ask3` prints the error message.

In a new terminal window, set `DSKEY` again and run `source ~/ds/ask3.zsh`.

## The prompt, clause by clause

[`prompt.lisp`](prompt.lisp) is the same prompt laid out one clause per line.

| Clause | What it asks for |
|---|---|
| `(need zsh-function ask3` | The thing to write: a zsh function named `ask3`. |
| `(in (or args (stdin (if-tty (eprint "粘贴完按 Ctrl-D")))))` | The question comes from the arguments, or else from standard input. When standard input is a terminal, first print the hint "paste, then press Ctrl-D". |
| `(curl deepseek deepseek-flash (key-in-env DSKEY))` | Call DeepSeek with curl, model `deepseek-flash`, with the key taken from the environment variable `DSKEY`. |
| `(eprint "已发出，等回复…" (after "用时 N 秒"))` | Print "sent, waiting" before the call and the time taken after it, both on standard error. |
| `(save ~/ds/last.json)` | Keep the full reply in this file. |
| `(print .choices[0].message.content (or .error.message))` | Print the answer, or the error message when there is no answer. |
| `(style minimal no-checks)` | Keep the code short and leave out defensive checks. |
| `(deliver (paste-to-install ~/ds/ask3.zsh) (then source)))` | Reply with one block that installs the function into this file when pasted, and loads it. |

## Checked

Checked on 2026-11-24 with `deepseek-flash`. The line was run with an empty home directory, the block it printed was installed, and `ask3` was tried three ways: with the question as arguments, with the question from a pipe, and with a wrong key. All three behaved as described above.

## Limits

- The key is passed to curl on its command line. While curl runs, other processes on the same machine can see it in the process list.
- The model writes the function anew on each run, so two runs of the line give two different functions.
- The answer is printed when it is complete. There is no streaming.

---

# 01-ask:一行命令,得到一个问答函数

这一行让模型写出 `ask3`:一个 zsh 函数,把问题发给模型,把回答打印出来。

## 命令

在 [`line.sh`](line.sh) 里(上面英文部分也有全文)。先设钥匙,再粘贴那一行:

```sh
export DSKEY=...   # 你的 DeepSeek API 钥匙
```

需要 zsh、curl、jq。

## 会得到什么

几十秒后,这一行会打印一段 shell。这段 shell 做三件事:建 `~/ds` 目录,把函数写进 `~/ds/ask3.zsh`,然后载入它。[`sample-reply.zsh`](sample-reply.zsh) 是其中一次的回复,原样保留。你得到的在细节上会不一样。

把这段读一遍,再粘贴。

## 怎么用 `ask3`

```sh
ask3 "jq -r 是做什么的?"      # 问题写在参数里(加上引号:zsh 会把 ? 和 * 当通配符)
echo "解释这个报错:……" | ask3   # 问题从管道进来
ask3                         # 不带参数:粘贴问题,然后按 Ctrl-D
```

请求发出时它会打印「已发出，等回复…」,回复到了打印「用时 N 秒」。完整的回复存在 `~/ds/last.json`。接口报错时,它打印报错的内容。

新开的终端窗口里,要重新设 `DSKEY`,再 `source ~/ds/ask3.zsh`。

## 提示词逐条读

[`prompt.lisp`](prompt.lisp) 是同一段提示词,一条一行。

| 这一条 | 要的是什么 |
|---|---|
| `(need zsh-function ask3` | 要写的东西:一个叫 `ask3` 的 zsh 函数。 |
| `(in (or args (stdin (if-tty (eprint "粘贴完按 Ctrl-D")))))` | 问题从参数来,没有参数就从标准输入来。标准输入是终端时,先提示「粘贴完按 Ctrl-D」。 |
| `(curl deepseek deepseek-flash (key-in-env DSKEY))` | 用 curl 调 DeepSeek,模型是 `deepseek-flash`,钥匙从环境变量 `DSKEY` 取。 |
| `(eprint "已发出，等回复…" (after "用时 N 秒"))` | 发出前提示一句,回来后报用时,都打在标准错误上。 |
| `(save ~/ds/last.json)` | 完整的回复存进这个文件。 |
| `(print .choices[0].message.content (or .error.message))` | 打印回答;没有回答时打印报错的内容。 |
| `(style minimal no-checks)` | 代码写短,不加防御性的检查。 |
| `(deliver (paste-to-install ~/ds/ask3.zsh) (then source)))` | 回复是一整段:粘贴就把函数装进这个文件,并载入。 |

## 验证

2026-11-24 用 `deepseek-flash` 验过。在一个空的主目录里跑这一行,把它打印的那段装上,然后用三种方式试了 `ask3`:问题写在参数里、问题从管道进来、钥匙是错的。三种的表现都和上面写的一样。

## 局限

- 钥匙是放在 curl 的命令行里传的。curl 运行期间,同一台机器上的其它进程能在进程列表里看到它。
- 函数每次都是模型重新写的,所以跑两次这一行会得到两个不同的函数。
- 回答是整段到了才打印,没有边出边显示。
