# aiRequests

這個資料夾是「陽光智慧黑板」與 ChatGPT 之間的 AI 任務佇列。

## 流程

1. 教學網站需要 AI 資料時，先查 aiGenerated。
2. 若資料不存在，建立一筆 request JSON 到 aiRequests/pending。
3. 使用者在 ChatGPT 說「處理 AI 待辦」。
4. ChatGPT 讀取 pending 任務，依 taskType 生成內容。
5. ChatGPT 將結果寫入 aiGenerated/{taskType}/{requestId}.json。
6. 完成後，將任務狀態記錄到 aiRequests/done。
7. 教學網站下次載入時直接讀 aiGenerated，不再產生新任務。

## request 格式

{
  "taskType": "listening_quiz",
  "requestId": "nani_g6_s1_l03_listening_quiz",
  "version": "1.0",
  "status": "pending",
  "input": {
    "publisher": "南一",
    "grade": "六年級",
    "semester": "上學期",
    "lesson": "第三課",
    "characters": []
  }
}

## 注意

aiRequests 只負責傳遞需求，不儲存正式教材。
正式教材一律寫入 aiGenerated。
