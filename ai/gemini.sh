#!/bin/bash

# 确保安装了 curl
if ! command -v curl &> /dev/null
then
    echo "curl is not installed. Please install it."
    exit 1
fi

# 从环境变量中获取 API 密钥
API_KEY=${GEMINI_API_KEY}

# 如果没有提供 API 密钥，则退出
if [ -z "$API_KEY" ]; then
    echo "Error: GEMINI_API_KEY environment variable not set."
    exit 1
fi

# API 端点
API_ENDPOINT="https://generative-ai-openai.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${API_KEY}"

# 获取用户的问题，如果参数为空则提示
if [ -z "$1" ]; then
  echo "Please provide a prompt as an argument."
  exit 1
fi

PROMPT="$1"

# 构建 JSON 数据
DATA=$(cat <<EOF
{
  "contents": [{
    "parts":[{
      "text": "${PROMPT}"
    }]
  }]
}
EOF
)

# 发送 POST 请求
RESPONSE=$(curl -s -X POST \
     -H "Content-Type: application/json" \
     -d "$DATA" \
     "$API_ENDPOINT")

# 提取并打印回复内容
RESULT=$(echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

echo "$RESULT"
