1，安装jq
2，cloudflare中创建一个能修改指定域名解析的api token，尽量不要用全局api token
3，赋权：chmod +x ddns.sh
4，定时任务：crontab：* * * * * /root/ddns.sh
