# 🎓 Git Snapshot 备份系统教学指南

> 教其他 Agent 使用 Git 备份系统保护配置文件

---

## 📚 系统介绍

**Git Snapshot** 是一个基于 Git 的配置文件备份系统，用于：
- ✅ 修改前创建备份点
- ✅ 修改后保存版本
- ✅ 搞砸了快速回滚
- ✅ 完整历史记录

**核心文件：**
- `snapshot.sh` - 创建备份点（修改前）
- `save.sh` - 保存修改（修改后）
- `restore.sh` - 回滚恢复（搞砸了）
- `history.sh` - 查看历史

---

## 🚀 快速上手（3步）

### Step 1: 创建备份点（修改前）
```bash
./snapshot.sh "准备修改XXX配置"
```
**作用**：保存当前所有文件状态

### Step 2: 保存修改（修改后）
```bash
./save.sh "完成XXX修改"
```
**作用**：提交你的修改为新版本

### Step 3: 回滚（搞砸了）
```bash
./restore.sh
```
**作用**：回到上一个备份点

---

## 📝 完整工作流程示例

```
用户: "我要修改 USER.md"
  ↓
Agent: ./snapshot.sh "准备修改 USER.md"
  ↓
Agent: （修改文件）
  ↓
Agent: ./save.sh "改名 hawk→hawk2008"
  ↓
用户: "搞砸了，恢复！"
  ↓
Agent: ./restore.sh
  ↓
完成！文件恢复
```

---

## 🛠️ 安装到新的 Workspace

### 方法1: 复制脚本（推荐）
```bash
# 从已有系统复制
SOURCE="/Users/lz/.openclaw/workspace"
TARGET="/Users/OTHER/.openclaw/workspace"

cp $SOURCE/snapshot.sh $TARGET/
cp $SOURCE/save.sh $TARGET/
cp $SOURCE/restore.sh $TARGET/
cp $SOURCE/history.sh $TARGET/

chmod +x $TARGET/*.sh
```

### 方法2: 重新创建
```bash
cd /Users/OTHER/.openclaw/workspace

# 1. 初始化 Git（如果没有）
git init
git add -A && git commit -m "初始备份"

# 2. 创建脚本（见下方完整代码）
# ... 粘贴 snapshot.sh / save.sh / restore.sh / history.sh 代码 ...

chmod +x *.sh
```

---

## 📋 脚本完整代码

### snapshot.sh
```bash
#!/bin/bash
# 创建备份点 - 修改前调用

MSG="${1:-备份点}"
cd "$(dirname "$0")" || exit 1

git add -A
git commit -m "$(date '+%m-%d %H:%M') - $MSG" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ 已创建备份点: $MSG"
    echo "   版本: $(git rev-parse --short HEAD)"
else
    echo "ℹ️  当前无变更"
fi
```

### save.sh
```bash
#!/bin/bash
# 保存修改 - 修改后调用

MSG="${1:-修改}"
cd "$(dirname "$0")" || exit 1

if [[ -z $(git status --porcelain) ]]; then
    echo "ℹ️  没有需要保存的修改"
    exit 0
fi

git add -A
git commit -m "$(date '+%m-%d %H:%M') - $MSG"

if [ $? -eq 0 ]; then
    echo "✅ 修改已保存: $MSG"
    echo "   版本: $(git rev-parse --short HEAD)"
else
    echo "❌ 保存失败"
fi
```

### restore.sh
```bash
#!/bin/bash
# 回滚恢复 - 搞砸了调用

cd "$(dirname "$0")" || exit 1

STEPS="${1:-1}"

echo "📋 最近的备份记录："
git log --oneline -5
echo ""

if [[ -n $(git status --porcelain) ]]; then
    echo "⚠️  当前有未提交的修改，按回车丢弃并回滚，Ctrl+C 取消"
    read
    git checkout -- .
fi

echo "⚠️  即将回滚 $STEPS 个版本，按回车确认，Ctrl+C 取消"
read

git reset --hard HEAD~$STEPS

echo ""
echo "✅ 已回滚到："
git log --oneline -1
```

### history.sh
```bash
#!/bin/bash
# 查看历史

cd "$(dirname "$0")" || exit 1

echo "📋 备份历史（最近的在前）："
git log --oneline -20
echo ""
echo "💡 常用命令："
echo "   ./snapshot.sh '描述'  - 创建备份点"
echo "   ./save.sh '描述'      - 保存当前修改"
echo "   ./restore.sh          - 回滚1个版本"
echo "   ./restore.sh 3        - 回滚3个版本"
```

---

## 🎓 教学要点

### 给用户说明时强调：
1. **修改前必备份** - 养成 `./snapshot.sh` 的习惯
2. **修改后必保存** - 用 `./save.sh` 提交
3. **搞砸能恢复** - `./restore.sh` 一键回滚
4. **历史可追溯** - `./history.sh` 查看所有版本

### 常见场景处理：

| 场景 | 命令 |
|------|------|
| 准备改配置 | `./snapshot.sh "准备改配置"` |
| 改完保存 | `./save.sh "完成修改"` |
| 用户说"搞砸了" | `./restore.sh` |
| 查看历史 | `./history.sh` |
| 回滚3个版本 | `./restore.sh 3` |

---

## 🔧 高级技巧

### 1. 集成到 Shell 别名
```bash
# 添加到 .zshrc
alias snap='cd ~/.openclaw/workspace && ./snapshot.sh'
alias save='cd ~/.openclaw/workspace && ./save.sh'
alias restore='cd ~/.openclaw/workspace && ./restore.sh'
```

### 2. 自动备份（修改前）
```bash
# 安全编辑函数
safe-edit() {
    cd ~/.openclaw/workspace
    ./snapshot.sh "edit: $(basename "$1")"
    ${EDITOR:-nano} "$1"
}
```

### 3. 每天自动备份
```bash
# 添加到 cron
0 3 * * * cd ~/.openclaw/workspace && ./snapshot.sh "每日自动备份"
```

---

## ⚠️ 注意事项

1. **只在 workspace 目录使用** - 其他目录无效
2. **Git 必须初始化** - 首次使用需 `git init`
3. **定期推送到远程** - 防止本地丢失
4. **大文件不要提交** - 用 .gitignore 排除

---

## 📞 故障排除

**问题**: "git 不是命令"
**解决**: `brew install git`

**问题**: "没有变更要提交"
**解决**: 先修改文件再运行 save.sh

**问题**: "无法回滚"
**解决**: 检查是否有未提交的修改，先运行 `git status`

---

## ✅ 检查清单

教完其他 agent 后确认：
- [ ] 4个脚本已复制到 workspace
- [ ] 脚本有执行权限 (`chmod +x`)
- [ ] Git 已初始化 (`git init`)
- [ ] 测试过完整流程（备份→修改→保存→回滚）
- [ ] 用户理解每个命令的作用

---

**记住核心口诀：改前 snapshot，改后 save，搞砸 restore！**