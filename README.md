# Cloudflare DDNS 自动更新脚本
## 安装 jq
Debian/Ubuntu：
```shell
apt update
apt install jq
```
CentOS/RHEL：
```shell
yum install -y epel-release
yum install -y jq
```
## 创建 Cloudflare API Token
- 登录 Cloudflare 仪表盘。
- 进入 My Profile -> API Tokens。
- 点击 Create Token，选择 Edit zone DNS 模板。
- 在 Permissions 中，设置：
- Zone Resources：选择 Include -> Specific Zone -> 选择您的域名。
- Permissions：设置为 Zone - DNS - Edit。
- 创建 Token。
