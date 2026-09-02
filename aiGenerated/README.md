# aiGenerated

這個資料夾是「陽光智慧黑板」共用的 AI 生成資料層。

## 核心流程

1. 教學程式依 taskType + requestId 查找 GitHub。
2. 若資料已存在，直接讀取，不再呼叫 AI。
3. 若資料不存在，產生標準 AI 任務需求。
4. ChatGPT 依任務需求生成標準 JSON。
5. 將結果寫回 aiGenerated。
6. 下次同一需求直接讀 GitHub 快取。

## 共用欄位

- taskType：功能類型，例如 listening_quiz
- requestId：同一份教材的唯一識別碼
- version：資料格式版本
- source：資料來源，固定可標記 chatgpt
- input：生成時使用的條件
- data：實際教材內容
- createdAt：建立時間（ISO 8601）
- updatedAt：更新時間（ISO 8601）

## 建議路徑

aiGenerated/{taskType}/{requestId}.json

例如：

aiGenerated/listening_quiz/nani_g6_s1_l03.json

## 目前初始 taskType

- listening_quiz：生字聽力闖關
- homophone_compare：造句比較／同音字探索
- fillblank_generate：造句填空測驗

未來新增功能時，只要註冊新的 taskType，沿用同一套讀取與快取流程即可。
