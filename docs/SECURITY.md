# 🔒 安全策略配置

> 基于慢雾安全团队《OpenClaw 极简安全实践指南 v2.7》
> > 核心原则：日常零摩擦，高危必确认，每晚有巡检，拥抱零信任

---

## 📋 目录

1. [bb-browser Skill 使用规则](#bb-browser-skill-使用规则)
2. [核心文件保护](#核心文件保护)
3. [每晚自动巡检](#每晚自动巡检)
4. [大脑灾备备份](#大脑灾备备份)

---

## bb-browser Skill 使用规则

### 需要确认的情况

**以下类型的网站使用前必须找用户确认：**

- ⚠️ 银行、金融机构网站
- ⚠️ 支付、钱包类网站（支付宝、微信支付等）
- ⚠️ 任何涉及资金操作的页面

### 可以直接操作的情况

**以下类型的网站可以直接使用 bb-browser：**

- ✅ 普通新闻、博客网站
- ✅ 社交媒体（Twitter/X、小红书、知乎等，包括登录后页面）
- ✅ 内部文档系统
- ✅ 电商网站（只读浏览，不涉及支付）
- ✅ 技术文档、GitHub 等开发相关网站
- ✅ 任意网页、信息提取、表单填写等常规操作

### 使用流程

```
1. 用户请求使用 bb-browser
   ↓
2. ELF 检查网址是否属于银行/支付类
   ↓
3. 如属于 → 请求用户确认："涉及银行/支付网站，确认访问 xxx 吗？"
   如不属于 → 直接执行操作
```

### 触发确认的关键词

涉及以下关键词时必须请求确认：
- "银行"
- "支付"
- "转账"
- "付款"
- "余额查询"
- "理财产品"

### 禁止访问

以下类型**绝对禁止**，即使请求确认也不能执行：
- ❌ 政府敏感系统（非公开政务系统）
- ❌ 需要特殊权限的内部网络

### 紧急停止

如用户随时说"停止"、"不要访问"、"取消"，立即终止操作。

---

## 核心文件保护

### 权限收窄

```bash
# 核心配置文件权限设置为 600（仅所有者可读写）
chmod 600 ~/.openclaw/openclaw.json
chmod 600 ~/.openclaw/devices/paired.json
```

### 配置文件哈希基线

```bash
# 生成基线（首次部署或确认安全后执行）
sha256sum ~/.openclaw/openclaw.json > ~/.openclaw/.config-baseline.sha256

# 注：paired.json 被 gateway 运行时频繁写入，不纳入哈希基线（避免误报）

# 巡检时对比
sha256sum -c ~/.openclaw/.config-baseline.sha256
```

---

## 每晚自动巡检

### Cron Job 配置

```bash
# 注册每晚安全巡检任务
openclaw cron add \
  --name "nightly-security-audit" \
  --description "每晚安全巡检" \
  --cron "0 3 * * *" \
  --tz "Asia/Shanghai" \
  --session "isolated" \
  --message "Execute this command and output the result as-is: bash ~/.openclaw/workspace/scripts/nightly-security-audit.sh" \
  --announce \
  --channel discord \
  --to "YOUR_CHAT_ID" \
  --timeout-seconds 300 \
  --thinking off
```

**注意事项：**
- `timeout` 必须 ≥ 300s（isolated session 需要冷启动）
- `--to` 必须用 chatId，不能用用户名
- 推送依赖外部 API，偶发故障但报告始终保存在本地

### 巡检覆盖核心指标（13项）

1. **OpenClaw 安全审计** - `openclaw security audit --deep`
2. **进程与网络审计** - 监听端口及关联进程、异常出站连接
3. **敏感目录变更** - 最近 24h `$OC/`、`/etc/`、`~/.ssh/` 等文件变更
4. **系统定时任务** - crontab + `/etc/cron.d/` + systemd timers
5. **OpenClaw Cron Jobs** - `openclaw cron list` 对比预期清单
6. **登录与 SSH** - 最近登录记录 + SSH 失败尝试
7. **关键文件完整性** - 哈希基线对比 + 权限检查
8. **黄线操作交叉验证** - `auth.log` sudo 记录 vs `memory/` 日志
9. **磁盘使用** - 整体使用率 + 新增大文件
10. **Gateway 环境变量** - 检查含 KEY/TOKEN/SECRET 的变量（值脱敏）
11. **明文私钥/凭证泄露扫描 (DLP)** - 扫描 workspace/memory 目录
12. **Skill/MCP 完整性** - 文件目录哈希清单与基线 diff
13. **大脑灾备自动同步** - Git commit + push

### 巡检脚本保护

```bash
# 锁定巡检脚本（不影响 gateway 运行）
sudo chattr +i ~/.openclaw/workspace/scripts/nightly-security-audit.sh

# 维护时解锁 → 修改 → 测试 → 复锁
sudo chattr -i ~/.openclaw/workspace/scripts/nightly-security-audit.sh
# 修改脚本...
bash ~/.openclaw/workspace/scripts/nightly-security-audit.sh  # 测试
sudo chattr +i ~/.openclaw/workspace/scripts/nightly-security-audit.sh  # 复锁
```

**注**：解锁/复锁属于黄线操作，需记录到当日 memory。

---

## 大脑灾备备份

### 备份内容

| 类别 | 路径 | 说明 |
|------|------|------|
| ✅ 备份 | `openclaw.json` | 核心配置（含 API keys、token 等） |
| ✅ 备份 | `workspace/` | 大脑（SOUL/MEMORY/AGENTS 等） |
| ✅ 备份 | `agents/` | Agent 配置与 session 历史 |
| ✅ 备份 | `cron/` | 定时任务配置 |
| ✅ 备份 | `credentials/` | 认证信息 |
| ✅ 备份 | `identity/` | 设备身份 |
| ✅ 备份 | `devices/paired.json` | 配对信息 |
| ✅ 备份 | `.config-baseline.sha256` | 哈希校验基线 |
| ❌ 排除 | `devices/*.tmp` | 临时文件 |
| ❌ 排除 | `media/` | 收发媒体文件（体积大） |
| ❌ 排除 | `logs/` | 运行日志（可重建） |
| ❌ 排除 | `completions/` | shell 补全脚本（可重建） |
| ❌ 排除 | `canvas/` | 静态资源（可重建） |

### 备份频率

- **自动**：通过 git commit + push，在巡检脚本末尾执行，每日一次
- **手动**：重大配置变更后立即备份

### Git 备份配置

```bash
# 本地仓库已在 ~/.openclaw/workspace/ 初始化
cd ~/.openclaw/workspace

# 添加远程仓库（GitHub 私有仓库）
git remote add origin https://github.com/freehawk2013-png/openclaw-backup.git

# 每日自动备份（已在巡检脚本中集成）
git add -A
git commit -m "nightly backup: $(date '+%Y-%m-%d %H:%M')"
git push origin master
```

---

## 🛡️ 防御矩阵速查

| 攻击场景 | 事前 | 事中 | 事后 |
|---------|------|------|------|
| 高危命令直调 | ⚡ 红线拦截 + 人工确认 | — | ✅ 自动化巡检 |
| 隐性指令投毒 | ⚡ 全文本正则审计 | ⚠️ 同 UID 风险 | ✅ 进程/网络监测 |
| 凭证/私钥窃取 | ⚡ 严禁外发红规则 | ⚠️ 提示词注入风险 | ✅ 环境变量 & DLP 扫描 |
| 核心配置篡改 | — | ✅ 权限收窄 (600) | ✅ SHA256 指纹校验 |
| 巡检系统破坏 | — | ✅ 内核级只读锁定 (+i) | ✅ 脚本哈希一致性检查 |

---

## ⚠️ 已知局限性

1. **Agent 认知层脆弱性**：可被复杂文档绕过，Human-in-the-loop 是最后防线
2. **同 UID 读取**：`chmod 600` 无法阻止同用户读取，需独立用户 + 容器化
3. **哈希基线非实时**：约 24h 延迟，可引入 inotify/auditd/HIDS 实时监控
4. **巡检推送依赖外部 API**：偶发故障，报告始终保存在本地

---

## 📚 参考资源

- [慢雾安全指南](https://github.com/slowmist/openclaw-security-practice-guide)
- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [Git Snapshot 备份系统](./README.md)

---

*配置更新于: 2026-03-07*