import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../providers/expense_notifier.dart';
import '../widgets/expense_category_tile.dart';
import '../widgets/payment_method_toggle.dart';

class ExpenseEntryScreen extends ConsumerStatefulWidget {
  const ExpenseEntryScreen({super.key});

  @override
  ConsumerState<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends ConsumerState<ExpenseEntryScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseProvider);
    final notifier = ref.read(expenseProvider.notifier);

    final categories = [
      (ExpenseCategory.fuel, Symbols.local_gas_station, 'Fuel'),
      (ExpenseCategory.repairs, Symbols.build, 'Repairs'),
      (ExpenseCategory.wages, Symbols.payments, 'Wages'),
      (ExpenseCategory.chemicals, Symbols.science, 'Chemicals'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'New Expense',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.go('/sales'),
            child: Text(
              'Sale',
              style: GoogleFonts.inter(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large amount field
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'LKR',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _amountController,
                      onChanged: notifier.updateAmount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: GoogleFonts.inter(
                          color: AppColors.textMuted.withValues(alpha: 0.5),
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(28),
            Text(
              'Category',
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.8,
              children: categories.map((c) {
                final (cat, icon, label) = c;
                return ExpenseCategoryTile(
                  category: cat,
                  icon: icon,
                  label: label,
                  isSelected: state.selectedCategory == cat,
                  onTap: () => notifier.selectCategory(cat),
                );
              }).toList(),
            ),
            const Gap(24),
            Text(
              'Date',
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(8),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: state.date,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (ctx, child) =>
                      Theme(data: ThemeData.dark(), child: child!),
                );
                if (picked != null) notifier.updateDate(picked);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Symbols.calendar_today,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${state.date.day}/${state.date.month}/${state.date.year}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            Text(
              'Payment Method',
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(8),
            PaymentMethodToggle(
              selected: state.paymentMethod,
              onChanged: notifier.togglePaymentMethod,
            ),
            const Gap(100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          12 + MediaQuery.of(context).padding.bottom,
        ),
        color: AppColors.surfaceDark,
        child: AppPrimaryButton(
          label: 'Log Expense',
          icon: Symbols.add_circle,
          color: AppColors.actionRed,
          onPressed: () => notifier.logExpense(() => context.go('/home')),
        ),
      ),
    );
  }
}
