#!/usr/bin/env bash
# 在仓库根目录执行：bash scripts/bootstrap-github-pages.sh
# 前置：已安装 gh，且已执行 gh auth login

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! gh auth status >/dev/null 2>&1; then
  echo "请先运行: gh auth login -h github.com" >&2
  exit 1
fi

USER_LOGIN="$(gh api user -q .login)"
REPO_NAME="${GITHUB_REPO_NAME:-clawtvos.site}"
FULL_REPO="${USER_LOGIN}/${REPO_NAME}"

if git remote get-url origin >/dev/null 2>&1; then
  echo "已存在 origin，跳过 gh repo create。"
else
  gh repo create "${REPO_NAME}" --public --source=. --remote=origin --push
fi

git push -u origin main 2>/dev/null || {
  git branch -M main 2>/dev/null || true
  git push -u origin main
}

# 从分支根目录发布 GitHub Pages（legacy / 分支源）
if gh api "repos/${FULL_REPO}/pages" >/dev/null 2>&1; then
  echo "GitHub Pages 已存在，跳过创建。"
else
  gh api "repos/${FULL_REPO}/pages" -X POST --input - <<JSON
{"build_type":"legacy","source":{"branch":"main","path":"/"}}
JSON
fi

echo "默认站点（项目页）: https://${USER_LOGIN}.github.io/${REPO_NAME}/"
echo "下一步：在 GitHub 仓库 Settings → Pages 填写 Custom domain: clawtvos.com"
echo "或在 DNS 就绪后执行: bash scripts/set-custom-domain.sh"
