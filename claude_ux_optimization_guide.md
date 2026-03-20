# UX Optimization Guide for Claude

Please execute the following UI/UX optimizations across the `estate-field-app-flutter` codebase to optimize it for rapid data entry by Estate Managers in the field.

## 1. Remove Bottom Navigation Bars from Data Entry Screens
Data entry screens must act as modal tasks to maximize vertical screen real estate for the keyboard and inputs.
- **Tapper Attendance Screen ([lib/features/hr/presentation/screens/tapper_attendance_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/hr/presentation/screens/tapper_attendance_screen.dart))**:
  - Remove the `bottomNavigationBar` property entirely from the `Scaffold`.
  - Remove any local variables related to tabs (like `_tabIndex`).
- **Metrolac Update Screen ([lib/features/lab/presentation/screens/metrolac_update_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/lab/presentation/screens/metrolac_update_screen.dart))**:
  - Remove the `bottomNavigationBar` property entirely from the `Scaffold`.
  - Remove the unused [AppBottomNav](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/core/widgets/app_bottom_nav.dart#13-84) import if present.
- **Rule Enforcement**: Ensure that *no screen* other than [HomeScreen](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/home/presentation/screens/home_screen.dart#12-225) ([lib/features/home/presentation/screens/home_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/home/presentation/screens/home_screen.dart)) has a `bottomNavigationBar`. If [expense_entry_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/finance/presentation/screens/expense_entry_screen.dart), [sales_record_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/finance/presentation/screens/sales_record_screen.dart), or [latex_collection_wizard.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/production/presentation/screens/latex_collection_wizard.dart) have one, remove them as well.

## 2. Update Home Screen Action Grid
Make the Home Hub a true command center by replacing secondary tasks with top-level modules.
- **File**: [lib/features/home/presentation/screens/home_screen.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/home/presentation/screens/home_screen.dart)
- **Action**: Locate the `GridView.count` children.
- Replace the [FeatureGridCard](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/home/presentation/widgets/feature_grid_card.dart#5-68) for **"Record Trees"** with a new **"Stats Dashboard"** card.
  - Icon: `Symbols.analytics` (or `insights` / `bar_chart`)
  - Category: `'Overview'`
  - Title: `'Stats Dashboard'`
  - OnTap Route: `context.go('/stats')`

## 3. Create 'Stats Dashboard' (Coming Soon) Screen
- **Create File**: `lib/features/home/presentation/screens/stats_dashboard_screen.dart`
- Implement a simple `StatelessWidget` returning a `Scaffold`.
- The AppBar should have a back button returning to `/home`.
- The Body should be centrally aligned text: "Stats Dashboard \n Coming Soon", styled nicely using `GoogleFonts.inter` and `AppColors.textMuted`.

## 4. Register the New Route
- **File**: [lib/core/router/app_router.dart](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/core/router/app_router.dart)
- Add a new `GoRoute` for `path: '/stats'` that points to the new `StatsDashboardScreen`.

## 5. Keyboard & Input Polish (Data Entry Constraints)
Review all `TextField` inputs across data entry screens (`expenses`, `sales`, `metrolac`, `latex`) to ensure they are fully optimized for rapid entry:
- Ensure numeric fields use `keyboardType: const TextInputType.numberWithOptions(decimal: true)` (which is mostly done, just verify).
- Ensure the primary Call-To-Action (Save/Log) button is accessible without excessive scrolling (e.g., using a `bottomSheet` in the `Scaffold` above the safe area, as currently done in [ExpenseEntryScreen](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/lib/features/finance/presentation/screens/expense_entry_screen.dart#13-19)), so it remains pinned above the keyboard.

---
**Claude, please process these instructions sequentially and ensure `flutter analyze` passes perfectly after all edits.**
