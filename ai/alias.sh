alias claude='claude --dangerously-skip-permissions'

codex() {
  xattr -dr com.apple.quarantine /opt/homebrew/Caskroom/codex 2>/dev/null
  command codex --dangerously-bypass-approvals-and-sandbox "$@"
}
