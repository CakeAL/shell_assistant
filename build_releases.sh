#!/bin/bash

# 定义函数：修改 Xcode 项目配置
function modify_xcode_arch {
  local arch=$1

  echo "Modifying Xcode project to build for $arch..."

  # 使用 sed 修改 Xcode 项目配置
  sed -i '' "s/ARCHS = .*/ARCHS = $arch;/" macos/Runner.xcodeproj/project.pbxproj
}

# 定义函数：恢复 Xcode 项目配置
function restore_xcode_arch {
  echo "Restoring Xcode project to default settings..."

  # 恢复 ARCHS 和 EXCLUDED_ARCHS 为默认值
  sed -i '' "s/ARCHS = .*/ARCHS = arm64;/" macos/Runner.xcodeproj/project.pbxproj
}

rm -rf release

mkdir -p release/arm
mkdir -p release/x86
mkdir -p release/dmgs

# 构建 x86_64 版本
modify_xcode_arch "x86_64"
flutter build macos --release
cp -R build/macos/Build/Products/Release/Shell\ Assistant.app release/x86/Shell\ Assistant.app

# 构建 arm64 版本
modify_xcode_arch "arm64"
flutter build macos --release
cp -R build/macos/Build/Products/Release/Shell\ Assistant.app release/arm/Shell\ Assistant.app

# 恢复 Xcode 项目配置
restore_xcode_arch

echo "Build completed. Apps are in the 'release' directory."