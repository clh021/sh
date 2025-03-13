#!/bin/bash

# 设置 GEMINI_API_KEY 环境变量，如果未设置则报错
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY environment variable not set. Please set it before running this test."
    exit 1
fi

# 测试用例 1: 检查是否输出了结果
echo "Running test case 1: Check if output is produced"
output=$(./gemini.sh "Hello, world!")
if [ -z "$output" ]; then
    echo "Test case 1 failed: No output produced"
    exit 1
else
    echo "Test case 1 passed: Output produced"
fi

# 测试用例 2: 检查是否能正确处理参数
echo "Running test case 2: Check if the script handles the prompt correctly"
output=$(./gemini.sh "What is the capital of France?")
if [[ "$output" == *"Paris"* ]]; then
    echo "Test case 2 passed: Correctly handled the prompt"
else
    echo "Test case 2 failed: Incorrect output"
    exit 1
fi

# 测试用例 3: 检查是否能处理空参数
echo "Running test case 3: Check if the script handles empty prompt correctly"
output=$(./gemini.sh "")
if [[ "$output" == *"Please provide a prompt"* ]]; then
    echo "Test case 3 passed: Correctly handles empty prompt"
else
    echo "Test case 3 failed: Incorrect output"
    exit 1
fi

echo "All test cases passed!"
exit 0