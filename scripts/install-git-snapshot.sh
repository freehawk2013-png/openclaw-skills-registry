#!/bin/bash
# Git Snapshot 备份系统 - 一键安装脚本
# 用途: 在新 workspace 快速部署备份系统

set -e

WORKSPACE="${1:-$HOME/.openclaw/workspace}"

echo "🚀 Git Snapshot 备份系统安装"
echo "=============================="
echo "目标目录: $WORKSPACE"
echo ""

# 创建目录
mkdir -p "$WORKSPACE"
cd "$WORKSPACE" || exit 1

# 初始化 Git（如果没有）
if [ ! -d .git ]; then
    echo "[1/5] 初始化 Git 仓库..."
    git init
    git add -A 2>/dev/null || true
    git commit -m "🛡️ 安全基线 - Git Snapshot 备份系统" 2>/dev/null || true
else
    echo "[1/5] Git 仓库已存在，跳过初始化"
fi

# 创建 snapshot.sh
echo "[2/5] 创建 snapshot.sh..."
cat > snapshot.sh <> 'EOF'
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
EOF

# 创建 save.sh
echo "[3/5] 创建 save.sh..."
cat > save.sh <> 'EOF'
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
EOF

# 创建 restore.sh
echo "[4/5] 创建 restore.sh..."
cat > restore.sh <> 'EOF'
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
EOF

# 创建 history.sh
echo "[5/5] 创建 history.sh..."
cat > history.sh <> 'EOF'
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
EOF

# 添加执行权限
chmod +x snapshot.sh save.sh restore.sh history.sh

echo ""
echo "🎉 安装完成！"
echo ""
echo "快速开始："
echo "  cd $WORKSPACE"
echo "  ./snapshot.sh '测试备份'"
echo "  ./save.sh '测试保存'"
echo "  ./restore.sh"
echo ""
echo "教学文档: TEACHING-Git-Snapshot.md"
