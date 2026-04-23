#!/usr/bin/env bash
# DNS 指向 GitHub Pages 后，将仓库 Pages 绑定 clawtvos.com 并尽量开启 HTTPS。
# 前置：gh auth login；仓库已推送；仓库根目录已有 CNAME 文件（本仓库已包含）。

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

USER_LOGIN="$(gh api user -q .login)"
REPO_NAME="${GITHUB_REPO_NAME:-cto.site}"
FULL_REPO="${USER_LOGIN}/${REPO_NAME}"

if ! gh api "repos/${FULL_REPO}/pages" -X PUT --input - <<JSON
{"cname":"clawtvos.com","https_enforced":true,"source":{"branch":"main","path":"/"}}
JSON
then
  echo "若提示证书尚未就绪：先在 Spaceship 配好 DNS，等待后再执行本脚本或在网页勾选 Enforce HTTPS。" >&2
  exit 1
fi

echo "已请求将 Pages 自定义域名设为 clawtvos.com（HTTPS 在证书就绪后可于网页确认）。"
