# OpenClaw 自带 Skills

> 随 OpenClaw 安装时自带的 15 个基础技能

---

## 📊 技能列表

### 平台工具类

| 技能 | 功能 | 常用命令 | 风险等级 |
|------|------|----------|----------|
| **clawhub** | ClawHub CLI 管理工具 | `npx skills add <skill>` | 🟢 Low |
| **discord** | Discord 操作 | `message action=send` | 🟢 Low |
| **gemini** | Gemini CLI 问答生成 | `gemini` 或直接对话 | 🟢 Low |
| **github** | GitHub 操作 (PR/CI/审查) | `gh issue list` | 🟢 Low |
| **gh-issues** | GitHub Issues 自动化 | `gh issue create` | 🟢 Low |
| **xurl** | X (Twitter) API 工具 | `xurl` 命令 | 🟡 Medium |

### 文件处理类

| 技能 | 功能 | 常用命令 | 风险等级 |
|------|------|----------|----------|
| **nano-pdf** | PDF 自然语言编辑 | 直接对话编辑 PDF | 🟢 Low |
| **video-frames** | 视频帧提取 (ffmpeg) | `extract frames` | 🟢 Low |
| **openai-whisper** | 本地语音转文字 | `whisper` 命令 | 🟢 Low |

### 系统工具类

| 技能 | 功能 | 常用命令 | 风险等级 |
|------|------|----------|----------|
| **healthcheck** | 主机安全加固 | `healthcheck audit` | 🟢 Low |
| **himalaya** | 邮件管理 (IMAP/SMTP) | `himalaya` 命令 | 🟢 Low |
| **mcporter** | mcporter CLI 工具 | `mcporter` 命令 | 🟢 Low |
| **weather** | 天气查询 | `weather` 或对话查询 | 🟢 Low |

### 开发工具类

| 技能 | 功能 | 常用命令 | 风险等级 |
|------|------|----------|----------|
| **coding-agent** | 代码任务代理 | `spawn coding-agent` | 🟢 Low |
| **skill-creator** | 创建/更新 AgentSkills | 对话创建 | 🟢 Low |

---

## 🔧 使用示例

### Discord 发送消息
```bash
message action=send target="#频道" message="Hello"
```

### GitHub 操作
```bash
# 查看 issues
gh issue list --repo owner/repo

# 创建 PR
gh pr create --title "Fix bug" --body "Description"
```

### PDF 编辑
```
用户: 把 PDF 第一页的标题改成 "New Title"
AI: 使用 nano-pdf 编辑完成
```

### 天气查询
```
用户: 北京今天天气怎么样？
AI: 使用 weather 查询并回复
```

---

## ⚙️ 配置说明

大部分自带技能开箱即用，无需额外配置。

需要配置的技能：
- **himalaya**: 需要配置邮件账户 (IMAP/SMTP)
- **xurl**: 需要配置 X API Token
- **gh-issues/github**: 需要 `gh auth login`

---

*文档更新于: 2026-03-07*