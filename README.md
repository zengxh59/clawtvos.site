# ClawTVOS · clawtvos.site

面向大屏（电视 / 媒体中心）的 ClawTVOS 项目静态官网入口，托管在 **GitHub Pages**，自定义域名为 **clawtvos.com**。

## 在线访问

- 站点：<https://clawtvos.com>（与 `www` 由 GitHub Pages 自动处理跳转，以当前仓库设置为准）
- 默认 Pages 地址：<https://zengxh59.github.io/clawtvos.site/>

## 仓库结构

| 路径 | 说明 |
|------|------|
| `index.html` | 落地页 |
| `assets/clawtvos-hero.png` | 首屏主视觉 |
| `CNAME` | 自定义域名 `clawtvos.com`（GitHub Pages 使用） |
| `spaceship-dns-records.txt` | 域名注册商（Spaceship）侧 DNS 记录备忘 |

## 发布方式

- 使用 **GitHub Pages** 从分支 **`main`** 的根目录发布（无构建步骤）。
- 推送至 `main` 后，站点会在短时间内更新。

## 域名与 HTTPS

1. 在域名 DNS 中为 apex 配置指向 GitHub Pages 的 **A / AAAA** 记录，为 `www` 配置 **CNAME** 至 `zengxh59.github.io`（详见 `spaceship-dns-records.txt`）。
2. 在 GitHub 仓库 **Settings → Pages** 中确认 **Custom domain** 为 `clawtvos.com`，并在证书就绪后勾选 **Enforce HTTPS**。

若浏览器提示证书与域名不匹配（例如仍显示 `*.github.io`），多为 **Pages 未正常发布** 或 **自定义域名证书尚未签发**，请确认 DNS 已生效并等待一段时间后再试。

## 关于「私有仓库」与访问

在 **GitHub Free** 个人账户下：**无法**从**私有（Private）**仓库为**面向公网**的 GitHub Pages 站点提供托管。将仓库改为 Private 后，公开站点通常会**不可用**，且容易出现 HTTPS / 证书异常。

可选做法：

- **保持本仓库为 Public**（推荐用于当前这种公开官网源码与页面同仓的简单方案）；或
- 订阅 **GitHub Pro / Team / Enterprise Cloud** 等支持「私有仓库 + Pages」的方案；或
- 使用**两个仓库**：私有仓库存源码，通过 Actions 将构建结果推送到**仅含静态文件的公开仓库**发布 Pages。

## 本地开发

直接编辑 `index.html` 与 `assets/` 后提交推送即可，无需安装依赖。

## 许可

若未另行声明，以仓库内许可证文件为准；暂无许可证文件时，默认保留所有权利。
