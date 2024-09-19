# Cloudflare DDNS 自动更新脚本
- 脚本默认优先获取ipv4地址，要ipv6可以自己改下
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
- 进入 **我的个人资料** -> **API令牌**。
- 在 **API令牌模板**中，选择 **编辑区域 DNS** 模板。
- **权限** 中：选择 **区域** -> **DNS** -> **编辑**。
- **区域资源** 中：选择 **包括** -> **特定区域** -> **选择您的域名**。

- 创建 Token。

## 3.配置脚本
下载脚本：
```shell
wget https://raw.githubusercontent.com/meslcloud/ddns/main/ddns.sh
```
编辑ddns.sh：
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
