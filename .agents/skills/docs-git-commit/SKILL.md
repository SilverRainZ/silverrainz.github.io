---
name: docs-git-commit
description: 在 SilverRainZ/silverrainz.github.io 和 SilverRainZ/bullet.in 项目中，当我要求提交文档修改时使用
---

# 文档项目专用的 Git 提交

## 概述

对 staging area 中的文档内容改动分析关联度，拆分或合并为独立 commit，每个 commit 附带中文描述。

## 触发条件

在 bullet 和 bullet.in 项目中，当我说「提交」「commit」时触发。**仅在 staging area 包含以下内容文件时才使用本 skill：**

- `*.rst` — reStructuredText 文档正文
- `*.md` — Markdown 文档
- `blobs/**` 下的图片/素材（若伴随内容文件改动）

以下文件属于配置/工程文件，**不计入内容改动**，不触发本 skill：

- `conf.py`、`confs/*`、`Makefile`、`requirements.txt`
- `templates/`、`.github/`、`utils/`、`blobs/`、`.agents`

若 staging area 仅含配置/工程文件，降级使用 `general-git-commit` skill。

## 核心流程

### 第一步：判断是否触发

```bash
git diff --cached --name-only
```

检查文件列表中是否有 `*.rst` 或 `*.md`。若无，退回到 `git-commit` 处理。

### 第二步：阅读改动内容

```bash
git diff --cached -- "*.rst" "*.md"
```

理解每处改动的主题：新增文章？修正错字？补充段落？结构调整？

### 第三步：分析关联度

在纯文档项目中，关联判断规则：

1. **同一文章**：对同一 `.rst`/`.md` 文件的改动属于同一主题
2. **文章 + 配图**：`src/foo.rst` 的改动引入新图片，同时 `static/images/foo.png` 新增，视为关联
3. **索引联动**：`src/index.rst` 新增了某篇文章的 toctree 条目，同时该文章文件新增，视为关联
4. **同一主题系列**：`src/blog/` 下多篇关于同一事件的文章改动，视为关联
5. **跨文件修正**：同一个错别字或格式问题在多个文件中被修正，视为关联

不满足以上任何条件 → 各自单独 commit。

### 第四步：展示方案

```
计划创建以下 commit：

Commit 1: [中文描述]
  - src/blog/post-a.rst
  - src/blog/post-b.rst

Commit 2: [中文描述]
  - src/index.rst
  - src/about/contact.rst
```

**必须等我确认后再执行。** 若我明确说「直接提交」或者你当前不被允许和用户交互，
跳过确认。

### 第五步：逐个提交

```bash
git commit -m "<中文描述>" -- <文件列表>
```

`git commit -- <files>` 只提交指定文件，staging area 中其他文件不变。

在 commit body 中附加 co-author 信息，参见 `model-co-authors` skill：

```bash
git commit -m "<中文描述>" -m "" -m "Co-authored-by: DeepSeek <service@deepseek.com>" -- <files>
```

完成后展示：

```
✅ 已创建 N 个 commit:
  abc1234 新增「2026 年度回顾」系列文章
  def5678 修正多处失效的外部链接
```

## commit message 规范

- 使用中文
- 描述改动目的，避免出现文件名
- 控制在 50 字符内

## 常见错误

| 错误 | 正确做法 |
|------|----------|
| 对纯配置改动触发本 skill | 检查无 `.rst`/`.md` 后降级到 git-commit |
| 把不同主题的文章混在一个 commit | 按主题拆分 |
| 文章和配图分两个 commit | 同一篇文章的图文合并提交 |
| 不展示方案直接提交 | 必须展示等我确认 |
| commit message 写「修改了 a.rst b.rst」 | 描述目的，如「修正导航栏失效链接」 |

## 示例

**Staging：**
- `src/blog/2026-review.rst` — 新文章：2026 年度回顾
- `static/images/2026-chart.png` — 该文章的配图
- `src/index.rst` — toctree 新增该文章条目
- `src/about/contact.rst` — 修正一个邮箱地址

**分析：**
- `2026-review.rst` + `2026-chart.png` + `index.rst` → 关联（新文章 + 配图 + 索引联动）
- `contact.rst` → 无关（独立修正）

**展示：**
```
Commit 1: 新增「2026 年度回顾」文章及配图
  - src/blog/2026-review.rst
  - static/images/2026-chart.png
  - src/index.rst

Commit 2: 修正联系页面邮箱地址
  - src/about/contact.rst
```
