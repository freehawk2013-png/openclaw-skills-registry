# 🎴 Git Snapshot 快速参考卡

## 3个核心命令

| 命令 | 何时使用 | 作用 |
|------|----------|------|
| `./snapshot.sh "描述"` | **修改前** | 创建备份点 |
| `./save.sh "描述"` | **修改后** | 保存修改 |
| `./restore.sh` | **搞砸了** | 回滚恢复 |

---

## 标准工作流程

```
用户: "我要改配置"
  ↓
./snapshot.sh "准备改配置"  ← 改前备份
  ↓
（修改文件）
  ↓
./save.sh "完成修改"  ← 改后保存
  ↓
搞砸了？
  ↓
./restore.sh  ← 一键恢复
```

---

## 常见问题速查

| 问题 | 答案 |
|------|------|
| 用户说改配置 | 先 `./snapshot.sh` |
| 改完要保存 | 用 `./save.sh` |
| 搞砸要恢复 | 用 `./restore.sh` |
| 想看历史 | 用 `./history.sh` |
| 回滚多个版本 | `./restore.sh 3` |

---

## 一键教学

**教其他agent时这样说：**

> "这是 Git Snapshot 备份系统，3个命令：
> 1. **snapshot** - 改前备份
> 2. **save** - 改后保存  
> 3. **restore** - 搞砸恢复
> 
> 完整文档看 `TEACHING-Git-Snapshot.md`，
> 一键安装用 `./install-git-snapshot.sh`"

---

## 安装到新机器

```bash
# 方法1: 一键安装
curl -fsSL https://your-url.com/install-git-snapshot.sh | bash

# 方法2: 复制文件
scp snapshot.sh save.sh restore.sh history.sh new-machine:/workspace/

# 方法3: 本地运行脚本
./install-git-snapshot.sh /path/to/workspace
```

---

## 记忆口诀

> 🔴 **改前 snapshot，改后 save，搞砸 restore！**
