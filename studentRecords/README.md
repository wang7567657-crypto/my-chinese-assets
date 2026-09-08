# studentRecords

雲端學生讀音補救紀錄。

每位學生一個 JSON 檔案，檔名使用 studentId，例如：

- `student_abc123.json`

資料範例：

```json
{
  "studentId": "student_abc123",
  "name": "學生A",
  "createdAt": "2026-09-08T00:00:00.000Z",
  "updatedAt": "2026-09-08T00:00:00.000Z",
  "characters": {},
  "history": []
}
```

此資料由 Cloudflare Worker 讀寫，前端不直接持有 GitHub Token。
