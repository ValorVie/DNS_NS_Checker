#!/bin/bash

echo "腳本開始執行。"

# 檢查是否提供了 Name Server
if [ -z "$1" ]; then
    echo "請提供 Name Server 作為參數。"
    exit 1
fi

nameserver=$1
result_file="result.csv"

# 創建或附加到 result.csv 文件的表頭
if [ ! -f $result_file ]; then
    echo "time,domain,record type,result" > $result_file
fi

# 檢查 domain_list.txt 是否存在
if [ ! -f domain_list.txt ]; then
    echo "domain_list.txt 文件不存在。"
    exit 1
fi

# # 顯示 domain_list.txt 的內容
# echo "以下是 domain_list.txt 的內容："
# cat domain_list.txt

# 設定 IFS
IFS=","

# 讀取 domain_list.txt 並執行 dig 查詢
while read -r domain record_type; do
    # 跳過空行或不完整的行
    if [ -z "$domain" ] || [ -z "$record_type" ]; then
        continue
    fi

    # 獲取當前時間
    current_time=$(date '+%Y/%m/%d %H:%M:%S')

    echo "正在查詢 $domain 的 $record_type 記錄..."

    # 執行 dig 命令，並只取得 ANSWER SECTION 下一行的信息
    dig_answer=$(dig @$nameserver $domain $record_type +noquestion +noadditional +nocomments +nocmd +noauthority +nostats)

    # 將結果寫入 result.csv
    echo "$current_time,$domain,$record_type,\"$dig_answer\"" >> $result_file
done < <(cat domain_list.txt; echo)
