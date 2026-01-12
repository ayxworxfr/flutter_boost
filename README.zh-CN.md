# Flutter Boost

[English](./README.md) | [简体中文](./README.zh-CN.md)

开箱即用的 Flutter 企业级应用脚手架。

[![Flutter](https://img.shields.io/badge/Flutter-3.19+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ 特性

- 💡 **Dart 3.3+**: 使用最新 Dart 语言特性，严格类型检查
- 📦 **模块化**: 基于功能的模块化架构
- 🎨 **主题系统**: 内置亮色/暗色主题支持
- 🌐 **国际化**: 使用 GetX 实现中英文切换
- 🔧 **最佳实践**: 清晰的代码规范和 lint 规则
- 🧪 **Mock 数据**: 开发友好的模拟数据系统
- 📱 **跨平台**: 支持 Android、iOS、Web、macOS、Windows、Linux

## 📐 架构设计

```
lib/
├── app/                    # 应用配置
│   ├── bindings/           # 依赖绑定
│   ├── middlewares/        # 路由中间件
│   └── routes/             # 路由定义
├── core/                   # 核心模块
│   ├── config/             # 配置管理
│   ├── mock/               # Mock 数据
│   ├── network/            # HTTP 客户端和拦截器
│   ├── storage/            # 本地存储（Hive + SharedPreferences）
│   ├── theme/              # 主题配置
│   ├── utils/              # 工具类
│   └── widgets/            # 通用组件
├── features/               # 功能模块
│   └── [feature]/
│       ├── bindings/       # 模块绑定
│       ├── controllers/    # GetX 控制器
│       ├── models/         # 数据模型
│       ├── services/       # API 服务
│       └── views/          # 页面视图
└── shared/                 # 共享资源
    ├── constants/          # 常量定义
    ├── translations/       # 国际化文件
    └── types/              # 类型定义
```

## 🛠️ 技术栈

| 分类 | 技术 |
|------|------|
| 状态管理 | GetX 4.6.6 |
| 网络请求 | Dio 5.4.0 |
| 本地存储 | Hive + SharedPreferences |
| UI 增强 | ScreenUtil、CachedNetworkImage、Shimmer |
| 日志 | Logger |

## 🚀 快速开始

### 环境要求

- Flutter >= 3.19.0
- Dart >= 3.3.0

### 安装

```bash
# 克隆仓库
git clone https://github.com/your-org/flutter_boost.git
cd flutter_boost

# 安装依赖
make install

# 运行项目
make run
```

### 开发账户

| 字段 | 值 |
|------|-----|
| 用户名 | `admin` |
| 密码 | `123456` |

> 注意：开发环境默认启用 Mock 模式，使用任意账户密码都可登录成功。

## 📝 常用命令

```bash
make help          # 显示所有命令
make install       # 安装依赖
make run           # 在 Chrome 上运行
make run-web       # 在 Web 上运行（端口 8080）
make build-web     # 构建 Web 版本
make analyze       # 代码分析
make format        # 格式化代码
make test          # 运行测试
make clean         # 清理构建
make stop          # 停止运行中的应用
```

## 🌍 国际化

支持中英文切换，采用结构化 key 命名：

```dart
// Key 格式：分类.页面.元素
'pages.login.title'.tr           // "登录"
'common.confirm'.tr              // "确认"
'validation.email.invalid'.tr   // "邮箱格式不正确"
```

## 🔧 配置说明

### 环境配置

位于 `lib/core/config/env_config.dart`：

```dart
EnvConfig.apiBaseUrl    // API 基础地址
EnvConfig.enableMock    // 启用 Mock 数据
EnvConfig.enableLog     // 启用日志
```

### 应用配置

位于 `lib/core/config/app_config.dart`：

```dart
AppConfig.defaultPadding       // 16.0
AppConfig.defaultAnimationDuration   // 300ms
AppConfig.defaultPageSize      // 20
```

## 📚 文档

- [架构设计文档](docs/Flutter架构设计文档.md)
- [贡献指南](CONTRIBUTING.md)

## 🤝 参与贡献

欢迎贡献！请先阅读 [贡献指南](CONTRIBUTING.md)。

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'feat: 添加新功能'`)
4. 推送分支 (`git push origin feature/amazing-feature`)
5. 提交 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

---

**Made with ❤️ by Flutter Boost Team**

