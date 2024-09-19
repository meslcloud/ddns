#!/bin/bash

API_TOKEN=""
ZONE_NAME=""     
RECORD_NAME=""
TTL=120                           
PROXIED=false                      

# 获取 Zone ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$ZONE_NAME" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取 DNS Record ID
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$RECORD_NAME" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取当前的公网IP
IP=$(curl -4 -s https://ipinfo.io/ip)

# 更新DNS记录
UPDATE_RESULT=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$IP\",\"ttl\":$TTL,\"proxied\":$PROXIED}")

# 检查更新结果
if echo "$UPDATE_RESULT" | grep -q "\"success\":true"; then
    echo "[$(date)] DNS 记录更新成功：$RECORD_NAME -> $IP"
else
    echo "[$(date)] DNS 记录更新失败：$UPDATE_RESULT"
fi
