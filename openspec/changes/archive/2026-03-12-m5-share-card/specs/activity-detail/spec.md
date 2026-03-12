## ADDED Requirements

### Requirement: 活動詳情頁分享入口
活動詳情頁 SHALL 在 AppBar 提供分享按鈕，導航至 `ShareCardPage`。

#### Scenario: 點擊分享按鈕
- **WHEN** 用戶在活動詳情頁點擊 AppBar 分享 Icon（`Icons.ios_share`）
- **THEN** 導航至 `/activities/:id/share`（`ShareCardPage`）
