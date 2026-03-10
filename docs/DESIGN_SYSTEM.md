# MountUp Design System

> Flutter 實作參考文件。所有 token 對應 `ThemeData` / `ColorScheme` / `TextTheme`。
> 主題跟隨系統自動切換（`ThemeMode.system`）。

---

## 1. 色彩系統

使用 Semantic Color Token 命名，避免直接使用 hex 值於元件層。

### Dark Theme

| Token | Hex | 用途 |
|-------|-----|------|
| `colorBackground` | `#0F1923` | 頁面底色 |
| `colorSurface` | `#1C2A35` | 卡片、Bottom Sheet |
| `colorSurfaceVariant` | `#243340` | 輸入框、Chip bg |
| `colorPrimary` | `#4CAF82` | 主要動作、CTA |
| `colorPrimaryContainer` | `#1B4332` | 低調強調背景 |
| `colorSecondary` | `#78909C` | 次要元素 |
| `colorAccent` | `#F5A623` | 數據高亮（距離、爬升）|
| `colorError` | `#EF5350` | 錯誤狀態 |
| `colorSuccess` | `#66BB6A` | 成功狀態 |
| `colorWarning` | `#FFA726` | 警告狀態 |
| `colorInfo` | `#42A5F5` | 資訊提示 |
| `colorTextPrimary` | `#FFFFFF` | 主要文字 |
| `colorTextSecondary` | `#B0BEC5` | 次要文字、label |
| `colorTextDisabled` | `#546E7A` | 停用狀態文字 |
| `colorDivider` | `#2E3F4D` | 分隔線 |

### Light Theme

| Token | Hex | 用途 |
|-------|-----|------|
| `colorBackground` | `#F7F8FA` | 頁面底色 |
| `colorSurface` | `#FFFFFF` | 卡片 |
| `colorSurfaceVariant` | `#EFF1F5` | 輸入框 bg |
| `colorPrimary` | `#2E7D52` | 主要動作 |
| `colorPrimaryContainer` | `#E8F5E9` | 低調強調 |
| `colorSecondary` | `#546E7A` | 次要元素 |
| `colorAccent` | `#E8711A` | 數據高亮 |
| `colorError` | `#D32F2F` | 錯誤 |
| `colorSuccess` | `#388E3C` | 成功 |
| `colorWarning` | `#F57C00` | 警告 |
| `colorInfo` | `#1976D2` | 資訊 |
| `colorTextPrimary` | `#1A1A1A` | 主要文字 |
| `colorTextSecondary` | `#6B7280` | 次要文字 |
| `colorTextDisabled` | `#9E9E9E` | 停用 |
| `colorDivider` | `#E5E7EB` | 分隔線 |

### Flutter 實作

```dart
// core/theme/app_colors.dart
class AppColors {
  // Dark
  static const darkBackground      = Color(0xFF0F1923);
  static const darkSurface         = Color(0xFF1C2A35);
  static const darkSurfaceVariant  = Color(0xFF243340);
  static const darkPrimary         = Color(0xFF4CAF82);
  static const darkPrimaryContainer= Color(0xFF1B4332);
  static const darkSecondary       = Color(0xFF78909C);
  static const darkAccent          = Color(0xFFF5A623);
  static const darkError           = Color(0xFFEF5350);
  static const darkSuccess         = Color(0xFF66BB6A);
  static const darkWarning         = Color(0xFFFFA726);
  static const darkInfo            = Color(0xFF42A5F5);
  static const darkTextPrimary     = Color(0xFFFFFFFF);
  static const darkTextSecondary   = Color(0xFFB0BEC5);
  static const darkTextDisabled    = Color(0xFF546E7A);
  static const darkDivider         = Color(0xFF2E3F4D);

  // Light
  static const lightBackground      = Color(0xFFF7F8FA);
  static const lightSurface         = Color(0xFFFFFFFF);
  static const lightSurfaceVariant  = Color(0xFFEFF1F5);
  static const lightPrimary         = Color(0xFF2E7D52);
  static const lightPrimaryContainer= Color(0xFFE8F5E9);
  static const lightSecondary       = Color(0xFF546E7A);
  static const lightAccent          = Color(0xFFE8711A);
  static const lightError           = Color(0xFFD32F2F);
  static const lightSuccess         = Color(0xFF388E3C);
  static const lightWarning         = Color(0xFFF57C00);
  static const lightInfo            = Color(0xFF1976D2);
  static const lightTextPrimary     = Color(0xFF1A1A1A);
  static const lightTextSecondary   = Color(0xFF6B7280);
  static const lightTextDisabled    = Color(0xFF9E9E9E);
  static const lightDivider         = Color(0xFFE5E7EB);
}
```

> **無障礙驗證**：`colorPrimary` (#4CAF82) on `colorBackground` (#0F1923) 對比度約 5.2:1，符合 WCAG AA（≥ 4.5:1）。

---

## 2. 字型規範

使用系統字型，無需額外套件：
- iOS：SF Pro（`-apple-system`）
- Android：Roboto（Material 預設）

基準：Material 3 `TextTheme` 命名。

| Token | Size | Weight | Line Height | 用途 |
|-------|------|--------|-------------|------|
| `displayLarge` | 32sp | 700 | 40 | 路線名 Hero、大數字 |
| `headlineLarge` | 24sp | 600 | 32 | 頁面主標題 |
| `headlineMedium` | 20sp | 600 | 28 | Section 標題 |
| `titleLarge` | 18sp | 600 | 26 | 卡片主標題 |
| `titleMedium` | 16sp | 500 | 24 | 卡片副標題 |
| `bodyLarge` | 16sp | 400 | 24 | 主要內文 |
| `bodyMedium` | 14sp | 400 | 20 | 次要內文 |
| `bodySmall` | 12sp | 400 | 16 | Caption、說明 |
| `labelLarge` | 14sp | 600 | 20 | 按鈕文字 |
| `labelMedium` | 12sp | 500 | 16 | Chip、Tag |
| `labelSmall` | 11sp | 500 | 14 | Badge、單位標示 |

> **數據等寬**：距離、爬升、時間等數字欄位使用 `FontFeature.tabularFigures()` 確保對齊。

### Flutter 實作

```dart
// core/theme/app_text_theme.dart
TextTheme buildTextTheme() => const TextTheme(
  displayLarge:  TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 40/32),
  headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 32/24),
  headlineMedium:TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 28/20),
  titleLarge:    TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 26/18),
  titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 24/16),
  bodyLarge:     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 24/16),
  bodyMedium:    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 20/14),
  bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 16/12),
  labelLarge:    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 20/14),
  labelMedium:   TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 16/12),
  labelSmall:    TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 14/11),
);

// 數據欄位用法
Text(
  '12.4',
  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
    fontFeatures: [const FontFeature.tabularFigures()],
  ),
)
```

---

## 3. 間距系統

基準單位 8px，以固定倍數衍生。

| Token | Value | 常見用途 |
|-------|-------|----------|
| `spacing2` | 2px | 細線、最小間隙 |
| `spacing4` | 4px | Icon 內邊距、徽章 |
| `spacing8` | 8px | 元件內間距、列表 item gap |
| `spacing12` | 12px | 小型容器 padding |
| `spacing16` | 16px | 標準內容 padding、頁面水平邊距 |
| `spacing20` | 20px | 中型間距 |
| `spacing24` | 24px | Section 間隔、卡片間距 |
| `spacing32` | 32px | 大型 section 間隔 |
| `spacing48` | 48px | 頁面 top padding |
| `spacing64` | 64px | Hero 區塊留白 |

> 頁面水平 padding 統一 `spacing16`（16px）。

### Flutter 實作

```dart
// core/theme/app_spacing.dart
class AppSpacing {
  static const double s2  = 2;
  static const double s4  = 4;
  static const double s8  = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s48 = 48;
  static const double s64 = 64;

  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: s16);
}
```

---

## 4. 圓角系統

風格定調：圓潤（非方正，非全圓）。

| Token | Value | 用途 |
|-------|-------|------|
| `radiusXS` | 4px | Chip、Tag、Badge |
| `radiusSM` | 8px | 輸入框、小型容器、SnackBar |
| `radiusMD` | 12px | 主要按鈕、次要按鈕 |
| `radiusLG` | 16px | Activity 卡片、Photo 卡片 |
| `radiusXL` | 24px | Bottom Sheet、Modal、Dialog |
| `radiusFull` | 9999px | FAB、圓形按鈕、Avatar、Pill |

### Flutter 實作

```dart
// core/theme/app_radius.dart
class AppRadius {
  static const double xs   = 4;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 24;
  static const double full = 9999;

  static BorderRadius get xsBorder   => BorderRadius.circular(xs);
  static BorderRadius get smBorder   => BorderRadius.circular(sm);
  static BorderRadius get mdBorder   => BorderRadius.circular(md);
  static BorderRadius get lgBorder   => BorderRadius.circular(lg);
  static BorderRadius get xlBorder   => BorderRadius.circular(xl);
  static BorderRadius get fullBorder => BorderRadius.circular(full);
}
```

---

## 5. 元件規範

### FilledButton（主要按鈕）

| 屬性 | 值 |
|------|----|
| 高度 | 48px |
| 水平 padding | 24px |
| 圓角 | `radiusMD` (12px) |
| 背景 | `colorPrimary` |
| 文字樣式 | `labelLarge`，白色 |
| pressed | opacity 0.85 |
| disabled | opacity 0.38 |

### OutlinedButton（次要按鈕）

| 屬性 | 值 |
|------|----|
| 高度 | 48px |
| Border | 1.5px `colorPrimary` |
| 圓角 | `radiusMD` (12px) |
| 文字樣式 | `labelLarge`，`colorPrimary` |
| 背景 | 無 |

### TextButton（文字按鈕）

- 文字 `colorPrimary` `labelLarge`，無背景無邊框
- 常用於「略過」、「取消」等低強調操作

### 尺寸變體

| 變體 | 高度 | 適用場景 |
|------|------|----------|
| standard | 48px | 主要操作 |
| compact | 36px | 列表內操作 |
| full-width | 48px，寬度撐滿 | 追蹤中大按鈕 |

### Flutter 實作（按鈕）

```dart
// 主要按鈕
FilledButton(
  onPressed: onPressed,
  style: FilledButton.styleFrom(
    minimumSize: const Size.fromHeight(48),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
  ),
  child: Text('開始追蹤', style: Theme.of(context).textTheme.labelLarge),
)

// 次要按鈕
OutlinedButton(
  onPressed: onPressed,
  style: OutlinedButton.styleFrom(
    minimumSize: const Size.fromHeight(48),
    side: BorderSide(color: colorPrimary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
  ),
  child: Text('查看路線'),
)
```

---

### TextFormField（輸入框）

| 屬性 | 值 |
|------|----|
| 高度 | 56px |
| 圓角 | `radiusSM` (8px) |
| Border 寬度 | 1.5px |
| idle border | `colorDivider` |
| focus border | `colorPrimary` |
| error border | `colorError` |
| 背景 | `colorSurfaceVariant` |
| Label 行為 | FloatingLabel（Material 預設） |

---

### ActivityCard（活動卡片）

| 屬性 | 值 |
|------|----|
| 背景 | `colorSurface` |
| 圓角 | `radiusLG` (16px) |
| padding | `spacing16` |
| elevation | 無（靠 Surface vs Background 色差區分層次）|
| pressed | InkWell splash + opacity 0.85 |

**內容結構**：
1. 路線名 — `titleLarge`
2. 日期 — `bodySmall` `colorTextSecondary`
3. StatBadge 列（距離 / 爬升 / 時間）

```dart
Card(
  color: colorSurface,
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: AppRadius.lgBorder),
  child: InkWell(
    borderRadius: AppRadius.lgBorder,
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(routeName, style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.s4),
          Text(date, style: textTheme.bodySmall?.copyWith(color: colorTextSecondary)),
          const SizedBox(height: AppSpacing.s12),
          const StatBadgeRow(),
        ],
      ),
    ),
  ),
)
```

---

### StatBadge（數據展示）

三欄水平排列：距離 / 爬升 / 時間。

| 元素 | 規格 |
|------|------|
| Icon | 24px，`colorPrimary` |
| 數字 | `headlineLarge`，`colorTextPrimary`，tabular figures |
| 單位 | `labelSmall`，`colorTextSecondary` |

---

### BottomNavigationBar

| 屬性 | 值 |
|------|----|
| 背景 | `colorSurface` |
| active item | `colorPrimary` + label 顯示 |
| inactive item | `colorTextSecondary`，無 label |

---

## 6. Elevation / Shadow

### Dark Theme — Tonal Elevation（Material 3）

色調提升，不使用實體陰影。

| Level | 色值 | 說明 |
|-------|------|------|
| level0 | `#1C2A35`（colorSurface） | 基礎表面 |
| level1 | `#20303C` | 輕微提升（Dropdown、Menu）|
| level2 | `#253540` | 中等提升（Dialog）|

### Light Theme — Box Shadow

| Level | Shadow | 說明 |
|-------|--------|------|
| level0 | 無陰影 | 基礎表面 |
| level1 | `rgba(0,0,0,0.08)` blur 4, offset (0,1) | 卡片 |
| level2 | `rgba(0,0,0,0.08)` blur 8, offset (0,2) | 浮動元件 |

```dart
// Light theme card shadow
BoxDecoration(
  borderRadius: AppRadius.lgBorder,
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ],
)
```

---

## 7. 分享卡片尺寸（Canvas 規格）

| 格式 | 畫布尺寸 | 說明 |
|------|----------|------|
| 1:1 貼文卡 | 1080 × 1080px | 軌跡縮圖 + 數據 + 路線名 |
| 9:16 限動卡 | 1080 × 1920px | 全版底圖 + 數據疊加 + Logo |

**視覺規格**：

| 元素 | 規格 |
|------|------|
| 背景 | 深色漸層：`colorBackground` → `colorSurface` |
| 軌跡線 | `colorPrimary`，strokeWidth 3px |
| 數據文字 | 白色，半透明圓角底板（`rgba(0,0,0,0.45)`，`radiusSM`）|
| Logo | 右下角，白色，建議高度 40px |

---

## 附錄：ThemeData 整合建議

```dart
// core/theme/app_theme.dart
ThemeData buildDarkTheme() => ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background:      AppColors.darkBackground,
    surface:         AppColors.darkSurface,
    surfaceVariant:  AppColors.darkSurfaceVariant,
    primary:         AppColors.darkPrimary,
    primaryContainer:AppColors.darkPrimaryContainer,
    secondary:       AppColors.darkSecondary,
    error:           AppColors.darkError,
    onPrimary:       Colors.white,
    onBackground:    AppColors.darkTextPrimary,
    onSurface:       AppColors.darkTextPrimary,
  ),
  textTheme: buildTextTheme().apply(
    bodyColor: AppColors.darkTextPrimary,
    displayColor: AppColors.darkTextPrimary,
  ),
  dividerColor: AppColors.darkDivider,
  useMaterial3: true,
);

ThemeData buildLightTheme() => ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background:      AppColors.lightBackground,
    surface:         AppColors.lightSurface,
    surfaceVariant:  AppColors.lightSurfaceVariant,
    primary:         AppColors.lightPrimary,
    primaryContainer:AppColors.lightPrimaryContainer,
    secondary:       AppColors.lightSecondary,
    error:           AppColors.lightError,
    onPrimary:       Colors.white,
    onBackground:    AppColors.lightTextPrimary,
    onSurface:       AppColors.lightTextPrimary,
  ),
  textTheme: buildTextTheme().apply(
    bodyColor: AppColors.lightTextPrimary,
    displayColor: AppColors.lightTextPrimary,
  ),
  dividerColor: AppColors.lightDivider,
  useMaterial3: true,
);

// main.dart
MaterialApp.router(
  theme:      buildLightTheme(),
  darkTheme:  buildDarkTheme(),
  themeMode:  ThemeMode.system,   // 跟隨系統
  ...
)
```
