# 宝玉内容创作 Skills 合集

> 由宝玉老师 (@dotey) 开发的 18 个内容创作技能
> > 涵盖 AI 生成、社交媒体发布、内容处理全流程

---

## 📊 技能分类

### 1. AI 生成类 (2个)

#### baoyu-image-gen
- **功能**: AI 图片生成 (支持 OpenAI/Google/DashScope)
- **使用**: `生成一张...的图片`
- **输出**: 图片文件

#### baoyu-danger-gemini-web
- **功能**: Gemini 反向工程图片生成
- **使用**: 直接对话描述图片需求
- **注意**: Medium 风险，需审核

---

### 2. 内容创作类 (10个)

#### baoyu-article-illustrator
- **功能**: 文章插图生成
- **使用**: `为这篇文章生成插图`
- **特点**: 自动分析文章结构，识别需要插图的位置

#### baoyu-comic
- **功能**: 知识漫画创作
- **使用**: `把这篇文章变成漫画`
- **特点**: 支持多种艺术风格

#### baoyu-cover-image
- **功能**: 封面图生成 (5维度设计系统)
- **使用**: `生成文章封面图`
- **参数**: 类型、配色、渲染、纹理、排版

#### baoyu-infographic
- **功能**: 信息图生成 (21种布局)
- **使用**: `把数据变成信息图`
- **输出**: 专业信息图图片

#### baoyu-slide-deck
- **功能**: 幻灯片生成
- **使用**: `生成PPT幻灯片`
- **特点**: 14+ 风格预设

#### baoyu-xhs-images
- **功能**: 小红书信息图系列
- **使用**: `生成小红书风格图片`
- **特点**: 适配小红书格式

#### 社交媒体发布

| 技能 | 平台 | 功能 | 风险 |
|------|------|------|------|
| baoyu-post-to-wechat | 微信公众号 | 文章发布 | 🟡 Medium (需API) |
| baoyu-post-to-weibo | 微博 | 内容发布 | 🟡 Medium (需API) |
| baoyu-post-to-x | X/Twitter | 推文/文章发布 | 🟡 Medium (需API) |

---

### 3. 实用工具类 (6个)

#### baoyu-compress-image
- **功能**: 图片压缩 (WebP/PNG)
- **使用**: `压缩这张图片`
- **特点**: 自动选择最佳格式

#### baoyu-danger-x-to-markdown
- **功能**: X 推文转 Markdown
- **使用**: `把这条推文转成 Markdown`
- **输出**: Markdown 格式文本

#### baoyu-format-markdown
- **功能**: Markdown 格式化
- **使用**: `格式化这篇 Markdown`
- **特点**: 添加 frontmatter，标准化格式

#### baoyu-markdown-to-html
- **功能**: Markdown 转 HTML
- **使用**: `转成 HTML`
- **特点**: 微信公众号兼容样式

#### baoyu-translate
- **功能**: DeepL 翻译
- **使用**: `翻译成英文`
- **支持**: 多语言互译

#### baoyu-url-to-markdown
- **功能**: URL 转 Markdown (Chrome CDP)
- **使用**: `提取这个网页内容`
- **技术**: 使用 Chrome CDP 抓取

#### release-skills
- **功能**: Skill 发布工作流
- **使用**: 自动检测版本文件，发布到仓库

---

## 🔧 快速使用

### 生成小红书图片
```
用户: 帮我生成小红书风格的读书笔记图片
AI: 使用 baoyu-xhs-images 生成
```

### 发布到公众号
```
用户: 把这篇文章发到我的公众号
AI: 使用 baoyu-post-to-wechat 发布
(需先配置微信公众号 API)
```

### 翻译文档
```
用户: 把这篇文档翻译成英文
AI: 使用 baoyu-translate 翻译
```

---

## ⚙️ 配置要求

### 无需配置 (开箱即用)
- baoyu-image-gen
- baoyu-article-illustrator
- baoyu-comic
- baoyu-cover-image
- baoyu-infographic
- baoyu-slide-deck
- baoyu-xhs-images
- baoyu-compress-image
- baoyu-format-markdown
- baoyu-markdown-to-html

### 需要 API Key
- baoyu-post-to-wechat → 微信公众号 API
- baoyu-post-to-weibo → 微博 API
- baoyu-post-to-x → X API
- baoyu-translate → DeepL API (可选)

---

## 📚 资源

- 作者: 宝玉老师 (@dotey)
- 安装: `npx skills add jimliu/baoyu-skills`
- GitHub: https://github.com/jimliu/baoyu-skills

---

*文档更新于: 2026-03-07*