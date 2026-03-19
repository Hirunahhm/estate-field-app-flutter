# HTML to Flutter Migration Guide for Claude

This is the system prompt and instructional guide you should use when generating the Flutter code from the provided HTML mockups.

## Objective
Translate the Estate ERP Field App HTML mockups found in the `app in html` directory into production-ready Flutter Dart code, adhering strictly to the architecture defined in [coding_guide.md](file:///C:/Users/ASUS/.gemini/antigravity/brain/28f25ba6-a8cf-468e-b377-762c06a87d55/coding_guide.md).

---

## 🏗️ 1. Architecture Rules (Strict Enforcement)
- **Feature-First Structure**: Every UI screen MUST be placed in its respective feature folder.
  - [login.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/login.html) ➡️ `lib/features/auth/presentation/screens/login_screen.dart`
  - [erp_home.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/erp_home.html) ➡️ `lib/features/home/presentation/screens/home_screen.dart`
  - [tapper_selection_list.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/tapper_selection_list.html) ➡️ `lib/features/hr/presentation/screens/tapper_attendance_screen.dart`
  - [latex_collection.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/latex_collection.html) ➡️ `lib/features/production/presentation/screens/latex_collection_wizard.dart`
  - [record_tress.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/record_tress.html) ➡️ `lib/features/production/presentation/screens/record_trees_screen.dart`
  - [metrolacupdate.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/metrolacupdate.html) ➡️ `lib/features/lab/presentation/screens/metrolac_update_screen.dart`
  - [expenses.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/expenses.html) ➡️ `lib/features/finance/presentation/screens/expense_entry_screen.dart`
  - [sales.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/sales.html) ➡️ `lib/features/finance/presentation/screens/sales_record_screen.dart`

- do **NOT** put everything in `main.dart`. Use `main.dart` exclusively for initialization, theme setup, and root routing.

## 🎨 2. Theming & Design Translation
The HTML mockups use Tailwind CSS. Translate these specific concepts as follows:

- **Colors**: Rely purely on `Theme.of(context).colorScheme` or the predefined `AppColors` derived from [coding_guide.md](file:///C:/Users/ASUS/.gemini/antigravity/brain/28f25ba6-a8cf-468e-b377-762c06a87d55/coding_guide.md).
  - `primary` (`#37ec13`): `AppColors.primary`
  - `background-dark` (`#132210`): `AppColors.background`
  - `surface-dark` (`#1e3319`): `AppColors.surface`
- **Typography** (`font-display: Inter`): Ensure `GoogleFonts.inter()` is applied globally in `app_theme.dart`.
- **Icons** (`material-symbols-outlined`): Use the `material_symbols_icons` flutter package. Translate string names directly (e.g., `<span class="material-symbols-outlined">water_drop</span>` ➡️ `Icon(Symbols.water_drop)`). Default to Material Outlined and filled variants where applicable.
- **Scrollbars**: The UI removes scrollbars (`no-scrollbar`). Wrap list components with `ScrollConfiguration` to remove default OS scrollglow or scrollbars if translating 1:1, but standard mobile scrolling `ListView`/`SingleChildScrollView` behavior is acceptable.

## 🧩 3. Flutter Component Mapping (Tailwind to Dart)
- **Flexbox Layouts** (`flex flex-col`, `gap-3`): Translate directly to `Column(children: [...])` or `Row(children: [...])` leveraging `SizedBox(height: 12)` arrays or the `spacing` properties (if utilizing recent Flutter versions, or simple `Gap()` if leveraging the `gap` package).
- **Grids** (`grid grid-cols-2`): Use `GridView.builder` or `Wrap` depending on dynamic vs static content.
- **Cards/Containers** (`bg-surface-dark border rounded-xl`): `Container` or `Card` decorated with `BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceBorder))`.
- **Tailwind `group-hover` and `active:` classes**: These indicate interactive elements. Translate them using `InkWell` or `GestureDetector` wrapped around `Container`s.
- **Responsive Sizing** (`h-screen`, `pb-safe`): Use `SafeArea` widget and `MediaQuery.of(context).size`. 

## ⚙️ 4. State Management (Riverpod)
- All the UI must be wrapped using `ConsumerWidget` or `ConsumerStatefulWidget`.
- **Do not** use `setState()` mapping for complex logic (e.g. tracking Metrolac values or Tapper selections). Setup Riverpod `Notifier` or `StateProvider` files corresponding to the specific screens inside `lib/features/[feature]/presentation/providers/`.

## 📜 5. Execution Steps for Claude
When prompted to generate code for a specific HTML file:
1. Examine the HTML and extract all structural layout (Headers, Body segments, Navigation/Footers).
2. Before scaffolding the screen, identify reusable widgets (e.g. repeated Tapper Cards in [tapper_selection_list.html](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/app%20in%20html/tapper_selection_list.html)) and extract them into `lib/features/[feature]/presentation/widgets/`.
3. Output the fully typed Dart code, ensuring complete matching with the aesthetic of the HTML. Apply `Material 3` design principles wherever a standard component matches (e.g., `NavigationBar`).

--- 
**Start standard prompt for Claude with:** "Please read `[path_to_html_file]` and translate its UI to Flutter complying with the guidelines in `flutter_migration_guide_for_claude.md` and [coding_guide.md](file:///C:/Users/ASUS/.gemini/antigravity/brain/28f25ba6-a8cf-468e-b377-762c06a87d55/coding_guide.md)."
