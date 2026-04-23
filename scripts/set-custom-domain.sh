#!/usr/bin/env bash
# DNS 指向 GitHub Pages 后，将仓库 Pages 绑定 clawtvos.com 并尽量开启 HTTPS。
# 前置：gh auth login；仓库已推送；仓库根目录已有 CNAME 文件（本仓库已包含）。

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

USER_LOGIN="$(gh api user -q .login)"
REPO_NAME="${GITHUB_REPO_NAME:-clawtvos.site}"
FULL_REPO="${USER_LOGIN}/${REPO_NAME}"

gh api "repos/${FULL_REPO}/pages" -X PATCH \
  -f cname='clawtvos.com' \
  -F https_enforced=true 2>/dev/null || {
  echo "若报错，请先在网页 Settings → Pages 保存一次 Custom domain，再重试。" >&2
  exit 1
}

echo "已请求将 Pages 自定义域名设为 clawtvos.com（HTTPS 在证书就绪后可于网页确认）。"
