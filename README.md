# 🦞 OpenClaw Skills Registry

> 个人 OpenClaw Skills 分类注册表
> 
> 更新时间: 2026-03-07

---

## 📊 Skills 统计

| 类别 | 数量 |
|------|------|
| OpenClaw 自带 | 15 |
| 宝玉内容创作合集 | 18 |
| 信息抓取 | 2 |
| AI 工具 | 2 |
| **总计** | **37** |

---

## 📦 OpenClaw 自带 Skills (15个)

[📖 查看详细文档 →](./docs/builtin/README.md)

| Skill | 功能描述 | 风险 |
|-------|---------|------|
| clawhub | ClawHub CLI 管理工具 | 🟢 Low |
| coding-agent | 代码任务代理 (Codex/Claude Code/Pi) | 🟢 Low |
| discord | Discord 操作 | 🟢 Low |
| gemini | Gemini CLI 问答生成 | 🟢 Low |
| gh-issues | GitHub Issues 自动化 | 🟢 Low |
| github | GitHub 操作 (PR/CI/代码审查) | 🟢 Low |
| healthcheck | 主机安全加固 | 🟢 Low |
| himalaya | 邮件管理 (IMAP/SMTP) | 🟢 Low |
| mcporter | mcporter CLI 工具 | 🟢 Low |
| nano-pdf | PDF 自然语言编辑 | 🟢 Low |
| openai-whisper | 本地语音转文字 | 🟢 Low |
| skill-creator | 创建/更新 AgentSkills | 🟢 Low |
| video-frames | 视频帧提取 (ffmpeg) | 🟢 Low |
| weather | 天气查询 | 🟢 Low |
| xurl | X (Twitter) API 工具 | 🟡 Medium |

---

## 🎨 宝玉内容创作合集 (18个)

[📖 查看详细文档 →](./docs/baoyu/README.md)

### AI 生成
| Skill | 功能描述 |
|-------|---------|
| baoyu-image-gen | AI 图片生成 (OpenAI/Google/DashScope) |
| baoyu-danger-gemini-web | Gemini 反向工程图片生成 |

### 内容创作
| Skill | 功能描述 |
|-------|---------|
| baoyu-article-illustrator | 文章插图生成 |
| baoyu-comic | 知识漫画创作 |
| baoyu-cover-image | 封面图生成 (5维度设计) |
| baoyu-infographic | 信息图生成 (21种布局) |
| baoyu-post-to-wechat | 微信公众号发布 |
| baoyu-post-to-weibo | 微博发布 |
| baoyu-post-to-x | X (Twitter) 发布 |
| baoyu-slide-deck | 幻灯片生成 |
| baoyu-xhs-images | 小红书信息图系列 |

### 实用工具
| Skill | 功能描述 |
|-------|---------|
| baoyu-compress-image | 图片压缩 (WebP/PNG) |
| baoyu-danger-x-to-markdown | X 推文转 Markdown |
| baoyu-format-markdown | Markdown 格式化 |
| baoyu-markdown-to-html | Markdown 转 HTML |
| baoyu-translate | DeepL 翻译 |
| baoyu-url-to-markdown | URL 转 Markdown (Chrome CDP) |
| release-skills | Skill 发布工作流 |

---

## 🔍 信息抓取 (2个)

[📖 查看详细文档 →](./docs/web-scraping/README.md)

| Skill | 功能描述 | 风险 | 安全策略 |
|-------|---------|------|----------|
| defuddle | 网页正文提取 | 🟢 Low | - |
| bb-browser | 浏览器自动化 (登录态访问) | 🟡 Medium | 银行/支付网站需确认 |

### bb-browser 安全策略
- ✅ **可直接访问**: 普通网页、社交媒体、内部文档、电商浏览
- ⚠️ **需确认**: 银行、支付、金融机构、资金操作页面
- ❌ **禁止**: 政府敏感系统

---

## 🤖 AI 工具 (2个)

[📖 查看详细文档 →](./docs/ai-tools/README.md)

| Skill | 功能描述 | 风险 |
|-------|---------|------|
| self-improvement | 自动学习总结反省 | 🟢 Low |
| proactive-agent | 主动提醒任务 | 🟢 Low |

---

## 🔧 系统配置

### Git Snapshot 备份系统
- `snapshot.sh` - 创建备份点
- `save.sh` - 保存修改
- `restore.sh` - 回滚恢复
- `history.sh` - 查看历史

### 安全策略（慢雾安全指南 v2.7）
- [AGENTS.md](./docs/AGENTS.md) - Agent 行为规范（红线/黄线命令）
- [SECURITY.md](./docs/SECURITY.md) - 完整安全策略（文件保护/巡检/灾备）
- `scripts/nightly-security-audit.sh` - 每晚自动巡检脚本

**已实施的安全措施：**
- ✅ 核心文件权限收窄 (chmod 600)
- ✅ 配置文件哈希基线
- ✅ 红线/黄线行为规范写入 AGENTS.md
- ✅ 自动巡检脚本（覆盖11项核心指标）
- ✅ Git 增量灾备备份
- ✅ Cron Job 注册（ID: bab87619-7a87-4be9-819b-311dcc8bf51e，每天 03:00 运行）
- ⏳ 巡检脚本锁定（需 sudo 密码手动执行）

### 慢雾安全指南落地清单

- [x] 更新规则：红线/黄线协议写入 AGENTS.md
- [x] 权限收窄：chmod 600 保护核心配置文件
- [x] 哈希基线：生成配置文件 SHA256 基线
- [x] 部署巡检：编写并注册 nightly-security-audit Cron
- [x] 验证巡检：手动触发一次，确认执行 + 推送 + 报告
- [ ] 锁定巡检脚本：`chattr +i` 保护巡检脚本自身（需 sudo）
- [x] 配置灾备：建立 GitHub 私有仓库，完成 Git 自动备份部署
- [x] 端到端验证：针对事前/事中/事后安全策略各执行一轮验证

---

## 📚 推荐资源

- [ClawHub](https://clawhub.ai/) - Skills 注册中心
- [Skills.sh](https://skills.sh/) - Vercel 官方目录
- [Awesome OpenClaw Skills](https://github.com/VoltAgent/awesome-openclaw-skills)

---

*由 OpenClaw 自动生成*