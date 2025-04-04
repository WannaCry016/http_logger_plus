# 🧾 http_logger_plus

A developer-friendly HTTP logger for Dart that wraps `http.Client` and logs all requests and responses with formatting, cURL command generation, color-coded CLI output, and more.

> 🔍 Perfect for debugging APIs, inspecting outgoing requests, and logging backend interactions in both CLI tools and Flutter apps.

---

[![pub version](https://img.shields.io/pub/v/http_logger_plus.svg)](https://pub.dev/packages/http_logger_plus)
[![Dart CI](https://github.com/WannaCry016/http_logger_plus/actions/workflows/dart.yml/badge.svg)](https://github.com/WannaCry016/http_logger_plus)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## ✨ Features

- ✅ Drop-in replacement for `http.Client`
- 🧾 Pretty-printed request & response logs
- 🎨 Color-coded terminal output
- 🌀 cURL command generation for any request
- 🧼 Truncated body logging for large payloads
- 🔐 Easy to extend with custom filters (coming soon)

---

## 🚀 Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  http_logger_plus: ^0.0.1
