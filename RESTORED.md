# PCL 下载恢复修改版

本版本是第三方基于 PCL 独立进行二次创作的产物，由 arknights8037 维护。
原作者：龙腾猫跃。赞助原作者：https://meloong.com/afd/a/LTCat

- 修改版源码：https://github.com/arknights8037/PCL
- 上游源码：https://github.com/Meloong-Git/PCL
- 基础版本：2.99.0.1，提交 93ede5d。
- 保留原仓库 LICENCE、正版购买与赞助劝导、蓝色主题。

## 使用

解压整个文件夹到可写目录，然后运行 `PCL 下载恢复修改版.exe`。请保留同目录的 DLL 和配置文件。
需要 64 位 Windows 与 .NET Framework 4.8（Windows 10/11 通常已自带）。运行启动器无需安装 .NET 9 SDK。

进入“下载 → 自动安装”，选择 Minecraft 版本，可继续选择 Forge、NeoForge、Fabric 等组件，再开始安装。
同时恢复版本选择页的安装入口、版本组件修改、整合包安装入口及 Minecraft 更新提示中的下载入口。
下载仍使用上游 Mojang / BMCLAPI 下载与校验逻辑，网络连接情况会影响下载速度与可用性。

微软正版登录需要自行向微软申请 Client ID，在“启动 → 正版 → 登录应用设置”中填写；也兼容环境变量 `PCL_MS_CLIENT_ID`。申请条件与步骤见同目录 `微软登录配置.md`（仓库文档为 `MICROSOFT-LOGIN.md`）。
CurseForge 需要自行申请 API Key，并在启动程序前设置环境变量 `PCL_CURSEFORGE_API_KEY`。
没有这些密钥仍可使用 Minecraft 原版下载；官方更新、联网通知、主题切换与百宝箱仍保留源码版本原有的限制。
Minecraft 的账号登录、购买与游戏使用许可需要由使用者自行满足。

## 构建与打包

Windows 上安装 .NET 9 SDK（支持 C# 13），PowerShell 7 中执行：

```powershell
git clone --recurse-submodules https://github.com/arknights8037/PCL.git
cd PCL
./build.ps1
```

也可以指定 SDK 的完整路径：`./build.ps1 -Dotnet F:/PCL-SDK/dotnet.exe`。
首次构建需要联网还原 NuGet 包。旧式 VB WPF 工程已迁移为 SDK 格式，运行目标仍为 .NET Framework 4.8。
输出位于 `dist/PCL-Download-Restored-2.99.0.1-r2-win64.zip`，包含使用说明、原许可、构建提交与 SHA-256 校验清单。
重复打包前请先移动已有的同名产物文件夹和 ZIP。
