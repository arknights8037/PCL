# 微软正版登录配置

本修改版没有内置微软应用 ID。截图中的 AADSTS900144 / 缺少 client_id 是应用配置缺失，不是微软账号密码错误。r2 已新增配置入口，并在请求前拦截空白、全零或无效格式的 ID。

## 申请条件

微软当前应用注册指南列出：有有效订阅的 Azure 账号（文档提供免费账号入口）、一个 Microsoft Entra 租户，以及至少 Application Developer（应用程序开发人员）权限。如果组织关闭了普通用户的应用注册权限，需要联系租户管理员。

这是为启动器注册一个应用身份。应用 ID 不是 Minecraft 用户名、微软账号、租户 ID 或密码，也不会赋予 Minecraft 游戏所有权。

## 注册步骤

1. 访问 https://entra.microsoft.com/ ，登录具备应用注册权限的账号。
2. 进入 Entra ID → 应用注册 → 新注册。
3. 名称填写“PCL 下载恢复修改版”，支持的账号类型选择“仅个人 Microsoft 账号”，或包含个人 Microsoft 账号的选项。
4. 本修改版使用设备代码流，注册时可不填写重定向 URI。
5. 注册完成后，在“概述”复制“应用程序（客户端）ID”，这是 GUID 格式的公开应用标识。
6. 在“身份验证”中启用“允许公共客户端流”并保存。设备代码流不需要客户端密码（Client Secret）。
7. 回到启动器 → 启动 → 正版 → 登录应用设置，填入并保存 ID，再添加账号。

入口中保存的 ID 优先于环境变量 `PCL_MS_CLIENT_ID`，保存后无需重启。若没有界面配置，仍兼容原有环境变量。
更换 ID 后，需要选择“添加新账号”重新授权；旧应用签发的刷新令牌不能直接用于新应用。

## Minecraft 服务权限

拿到 Azure 应用 ID 只完成微软应用注册，并不保证 Minecraft 服务接受该应用。
Minecraft 官方支持目录列有 “Java Edition Game Service API Review or Application Process”。新应用如遇到 Minecraft 服务的 403 / Invalid app registration，应向 Minecraft 官方确认应用访问权限及审核要求。

官方 AppID Review 短链接：https://aka.ms/mce-reviewappid
该链接在本次核查中跳转到 Microsoft Forms；自动抓取未能读取表单内容，因此这里不承诺当前受理资格、所需字段、审批时限或审批结果。请核对表单标题和适用的游戏/API。
准备本项目的 Client ID、项目源码链接 https://github.com/arknights8037/PCL 与实际用途说明，可用于向官方咨询。仅在你确认表单适用时提交。

## 官方资料

- 注册条件与步骤：https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app
- 桌面应用与公共客户端配置：https://learn.microsoft.com/en-us/entra/identity-platform/scenario-desktop-app-configuration
- 设备代码流：https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-device-code
- Minecraft Java 支持目录：https://help.minecraft.net/hc/en-us/sections/44460521913485

本次未提供有效的自有应用 ID，因此只验证了配置 UI、格式校验与缺失参数拦截，未验证完整微软 → Xbox → Minecraft 登录。
