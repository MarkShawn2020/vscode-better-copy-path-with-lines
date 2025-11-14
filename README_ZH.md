# 复制路径和行号

> **⚡ 增强版 Fork** - 专注速度与易用性 | [English Docs](./README.md)

一个精简的 VSCode 扩展，一键复制**带行号的文件路径**。非常适合在 issue、PR 和文档中分享代码引用。

## 🎯 为什么选择这个 Fork？

这是 [qishan233/copy-path-with-line-number](https://github.com/qishan233/copy-path-with-line-number) 的增强版 fork，包含重大改进：

### ✨ 核心改进

| 特性 | 原版 | 本 Fork |
|------|------|---------|
| **菜单速度** | 3次点击（子菜单） | **2次点击**（直接） |
| **菜单选项** | 4个选项 | **2个聚焦选项** |
| **行号区域** | ❌ 无法使用 | **✅ 正常工作** |
| **命令格式** | 冗长标签 | **简洁 `路径:行号` 格式** |
| **功能聚焦** | 混合功能 | **仅行号功能** |

### 🚀 主要区别

**速度与简洁**
- ⚡ **快 33%** - 移除子菜单，直接访问
- 🧠 **认知负担减少 50%** - 仅 2 个相关选项
- 🎯 **清晰聚焦** - 行号上下文是核心价值

**修复关键问题**
- ✅ **行号区域现在可用** - 修复 VSCode API 处理
- ✅ **更简洁的 UX** - 移除冗余的无行号命令（请使用 VSCode 原生"复制路径"）

**更好的设计**
- 📝 使用简洁格式的命令：`复制相对路径:行号` / `复制绝对路径:行号`
- 🎨 仅在相关上下文中显示（编辑器和行号区域）
- 🔧 保留强大的配置选项（分隔符、连接符等）

## 📥 安装

### 从 Release 安装（推荐）

1. 从 [Releases](https://github.com/MarkShawn2020/copy-path-with-line-number/releases) 下载最新的 `.vsix`
2. 在 VSCode 中：`扩展` → `...` → `从 VSIX 安装`

### 从源码安装

```bash
git clone https://github.com/MarkShawn2020/copy-path-with-line-number.git
cd copy-path-with-line-number
npm install
npm run compile
# 按 F5 启动扩展开发主机
```

## 🎬 使用方法

### 快速开始

**在行号区域或编辑器中右键：**

```
└─ 复制相对路径:行号     → src/app.ts:42
└─ 复制绝对路径:行号     → /Users/me/project/src/app.ts:42
```

**多行选择：**
```
选择 10-20 行 → 复制 → src/app.ts:10~20
多处选择 → 复制 → src/app.ts:5, 10, 15
```

### 配置

在 VSCode 设置中自定义分隔符和连接符：

```json
{
  "copyPathWithLineNumber.path.separator": "slash",      // "/" 或 "\" 或 "system"
  "copyPathWithLineNumber.range.connector": "tilde",     // "~" 或 "-"
  "copyPathWithLineNumber.selection.separator": "comma", // "," 或 ";" 或 " "
  "copyPathWithLineNumber.show.message": true            // 显示通知
}
```

**示例：**
```
默认格式：   src/components/Button.tsx:42~55
使用破折号： src/components/Button.tsx:42-55
使用空格：   src/components/Button.tsx:10 20 30
```

## 🔄 与原版对比

完整的原版功能列表，请参阅[原始仓库](https://github.com/qishan233/copy-path-with-line-number)。

**保留的功能：**
- ✅ 带范围的行号复制
- ✅ 自定义分隔符和连接符
- ✅ 多行选择支持
- ✅ 国际化（英文和中文）

**改动的内容：**
- 🎯 **移除**：无行号命令（资源管理器/标签上下文）- 请使用 VSCode 原生"复制路径"
- 🎯 **移除**：子菜单 - 直接命令访问
- 🎯 **修复**：行号区域右键菜单
- 🎯 **简化**：命令标签为 `路径:行号` 格式

## 📊 技术细节

### 架构亮点

- **设计模式**：装饰器 + 策略 + 命令模式
- **类型安全**：完整 TypeScript 严格模式
- **性能**：零依赖（除 VSCode API）
- **大小**：打包后约 194 KB

### 关键技术改进

**v0.1.2** - 修复 VSCode 行号上下文 API
```typescript
// VSCode 从行号区域传递 {lineNumber: number, uri: Uri}
// 添加了正确的检测和提取逻辑
```

**v0.1.1** - 聚焦重构
- 移除 2 个命令（仅保留带行号的）
- 扁平化菜单结构
- 简化所有代码路径

## 🐛 已知问题

目前无。报告问题请访问：https://github.com/MarkShawn2020/copy-path-with-line-number/issues

## 🤝 贡献

欢迎贡献！这是一个聚焦的 fork - 我们优先考虑：
1. 速度和简洁性
2. 行号上下文用例
3. 清晰、可维护的代码

## 📜 许可证

MIT License - 与原项目相同

## 🙏 致谢

- **原作者**：[qishan233](https://github.com/qishan233/copy-path-with-line-number)
- **Fork 维护者**：[MarkShawn2020](https://github.com/MarkShawn2020)
- **改进内容**：聚焦重构 + 关键 bug 修复

---

## 📝 版本说明

### 0.1.2（最新）

**🐛 关键 Bug 修复**
- 修复行号区域右键菜单（VSCode API `{lineNumber, uri}` 处理）
- 移除调试日志

### 0.1.1

**🚀 重大重构**
- 移除无行号命令（请使用 VSCode 原生"复制路径"）
- 扁平化菜单结构（2次点击 vs 3次）
- 简化标签为 `路径:行号` 格式
- 仅在编辑器和行号区域上下文中显示

### 0.1.0

- 添加行号区域支持

### 早期版本

0.0.1 - 0.0.7 版本请参阅[原始仓库](https://github.com/qishan233/copy-path-with-line-number)

---

**用 ❤️ 为经常分享代码引用的开发者打造**
