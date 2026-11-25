# llm-one-liners

One pasted line asks a language model to write a small program and to tell you how to install it.

The starting point is a fresh machine with `curl` and an API key, and nothing else. If you can reach a model, you can have it build your tools, beginning with the tool you use to talk to it. This repository collects lines that do this. Each line carries a complete prompt, written as a short S-expression, and each has been run before it was added.

This is an experimental research project. More lines will be added as they are tested.

## The lines

| # | What you get | What you need |
|---|---|---|
| [01-ask](01-ask/) | `ask3`, a zsh function that sends a question to the model and prints the answer. It is the smallest workbench: with it you can ask for the next tool. | zsh, curl, jq, a DeepSeek API key |

## How to use a line

1. Put your key in the environment variable the line names, for example `export DSKEY=...`.
2. Paste the line into a terminal. It prints the model's reply: a block of shell that installs the program.
3. Read the block.
4. Paste the block to install.

## Read the reply before you run it

A model wrote the code in the reply, and the reply differs from run to run. Before you paste it, check two things: it calls only the API host you expect, and it deletes nothing.

## License

MIT. See [LICENSE](LICENSE).

---

# 一行命令版程序

粘贴一行命令,让大模型写出一个小程序,并告诉你怎么装。

出发点是一台新电脑:只有 `curl` 和一把 API 钥匙,别的什么都没有。只要连得上模型,就能让它把工具一样样做出来,第一样就是「和它说话」的那个工具。这个仓库收的就是这样的命令。每一行都带着一段完整的提示词,用很短的 S 表达式写成;每一行放进来之前都真跑过。

这是一个实验性的研究项目。以后会陆续放进更多测过的命令。

## 现有的命令

| 编号 | 得到什么 | 需要什么 |
|---|---|---|
| [01-ask](01-ask/) | `ask3`:一个 zsh 函数,把问题发给模型,把回答打印出来。它是最小的工作台:有了它,就能接着要下一样工具。 | zsh、curl、jq、一把 DeepSeek 的 API 钥匙 |

## 怎么用

1. 把钥匙放进命令里写的那个环境变量,比如 `export DSKEY=...`。
2. 把那一行粘贴进终端。它会打印模型的回复:一段用来安装的 shell。
3. 把这段读一遍。
4. 粘贴这段,装好。

## 先读再跑

回复里的代码是模型写的,每次都不一样。粘贴之前看两点:它只连你预期的那个接口地址;它不删任何东西。

## 许可

MIT,见 [LICENSE](LICENSE)。
