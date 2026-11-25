mkdir -p ~/ds
cat > ~/ds/ask3.zsh <<'EOF'
ask3() {
  emulate -L zsh
  local prompt
  if (( $# )); then
    prompt="$*"
  else
    if [[ -t 0 ]]; then
      print -u2 '粘贴完按 Ctrl-D'
    fi
    prompt="$(cat)"
  fi

  local start=$SECONDS
  print -u2 '已发出，等回复…'

  local payload resp
  payload=$(jq -n --arg p "$prompt" --arg m "deepseek-flash" '{
    model: $m,
    messages: [{role:"user", content:$p}],
    stream: false
  }')

  resp=$(curl -sS https://api.deepseek.com/chat/completions \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $DSKEY" \
    -d "$payload")

  print -r -- "$resp" > ~/ds/last.json
  print -u2 "用时 $((SECONDS - start)) 秒"
  jq -r '.choices[0].message.content // .error.message // empty' ~/ds/last.json
}
EOF
source ~/ds/ask3.zsh
