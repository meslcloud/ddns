# Cloudflare DDNS 自动更新脚本
- 脚本默认是优先获取ipv4地址
## 1.安装 JQ
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

## 2.创建 Cloudflare API Token
> 以下为创建单个域名DNS修改权限的api教程，建议不要使全局api
- 登录 Cloudflare 仪表盘。
- 进入 My Profile -> API Tokens。
- 点击 Create Token，选择 Edit zone DNS 模板。
- 在 Permissions 中，设置：
- Zone Resources：选择 Include -> Specific Zone -> 选择您的域名。
- Permissions：设置为 Zone - DNS - Edit。
- 创建 Token。

## 3.配置脚本
```shell
vim ddns.sh
```
```shell
#!/bin/bash
API_TOKEN="您的API令牌"
ZONE_NAME="example.com"           # 您的域名
RECORD_NAME="sub.example.com"     # 要更新的记录
TTL=120                           # 可选：TTL 值
PROXIED=false                     # 可选：是否开启 Cloudflare 代理
```

## 4.赋权执行
```shell
chmod +x ddns.sh
```
测试：
```shell
./ddns.sh
```
如果成功，终端会输出：
```shell
[日期 时间] DNS 记录更新成功：sub.example.com -> 您的公网 IP
```

## 5.设置定时任务
```shell
crontab -e
```
每分钟运行一次脚本：
```shell
* * * * * /root/ddns.sh
```
