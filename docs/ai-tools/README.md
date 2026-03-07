# AI 工具 Skills

> 提升 AI Agent 自主能力的工具

---

## 📊 技能列表

| 技能 | 功能 | 风险等级 | 状态 |
|------|------|----------|------|
| **self-improvement** | 自动学习总结反省 | 🟢 Low | ✅ 已安装 |
| **proactive-agent** | 主动提醒任务 | 🟢 Low | ✅ 已安装 |

---

## 🧠 self-improvement

### 功能
- 自动捕捉对话中的学习和错误
- 总结经验教训
- 避免重复犯错
- 持续自我优化

### 工作原理
1. 监控对话中的纠正和错误
2. 提取学习点
3. 保存到记忆系统
4. 未来对话中应用

### 触发场景
- 用户说 "不对"、"错了"、"应该..."
- 发现更好的解决方案
- 外部 API 调用失败

### 使用示例
```
用户: 你刚才说的不对，应该是...
AI: 记录学习点，下次改进

[系统自动]
self-improvement: 记录本次纠正，更新行为模式
```

### 配置
无需配置，自动运行

---

## 🎯 proactive-agent

### 功能
- 从被动响应转为主动提醒
- 根据日程主动推送任务
- 连续改进
- WAL 协议支持
- Working Buffer 上下文保持

### 工作原理
1. 分析用户习惯和日程
2. 预测需要提醒的事项
3. 主动发送提醒
4. 根据反馈调整

### 使用场景
- 每日任务提醒
- 定期报告生成
- 习惯养成监督
- 项目进度跟踪

### 使用示例
```
用户: 请每天提醒我查看 ResearchWang 的推文

[系统自动]
proactive-agent: 设置每日提醒任务

每天 9:00:
AI: 提醒：今天需要查看 ResearchWang 的推文更新
```

### 配置
通过对话配置：
```
帮我设置 proactive-agent，每天提醒我...
```

---

## 🔧 系统技能

### Git Snapshot 备份系统
- **snapshot.sh**: 创建备份点
- **save.sh**: 保存修改
- **restore.sh**: 回滚恢复
- **history.sh**: 查看历史

使用流程：
```bash
./snapshot.sh "准备修改"
# 修改文件...
./save.sh "完成修改"
# 搞砸了？
./restore.sh
```

---

## 📦 安装

```bash
# self-improvement
npx skills add peterskoett/self-improving-agent

# proactive-agent
npx skills add halthelobster/proactive-agent
```

---

*文档更新于: 2026-03-07*