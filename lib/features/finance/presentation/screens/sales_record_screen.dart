import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/sales_notifier.dart';

class SalesRecordScreen extends ConsumerStatefulWidget {
  const SalesRecordScreen({super.key});

  @override
  ConsumerState<SalesRecordScreen> createState() => _SalesRecordScreenState();
}

class _SalesRecordScreenState extends ConsumerState<SalesRecordScreen> {
  final _latexController = TextEditingController();
  final _massController = TextEditingController();
  final _metrolacController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _latexController.dispose();
    _massController.dispose();
    _metrolacController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estimatedTotal = ref.watch(salesProvider.select((s) => s.estimatedTotal));
    final notifier = ref.read(salesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Sales Record',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Symbols.more_vert, color: AppColors.textMuted),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceHighlight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Row(
                children: [
                  const Icon(Symbols.info, color: AppColors.primary, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Enter details for the current latex batch sale.',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            AppTextField(
              label: 'Total Latex Volume (L)',
              hint: '0.00',
              prefixIcon: Symbols.water_drop,
              controller: _latexController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: notifier.updateLatex,
            ),
            const Gap(16),
            AppTextField(
              label: 'Total Mass (kg)',
              hint: '0.00',
              prefixIcon: Symbols.scale,
              controller: _massController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: notifier.updateMass,
            ),
            const Gap(16),
            AppTextField(
              label: 'Final Metrolac (°)',
              hint: '0.0',
              prefixIcon: Symbols.device_thermostat,
              controller: _metrolacController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: notifier.updateMetrolac,
            ),
            const Gap(16),
            AppTextField(
              label: 'Unit Price (LKR/kg)',
              hint: '0.00',
              prefixIcon: Symbols.payments,
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: notifier.updateUnitPrice,
            ),
            const Gap(24),
            // Gradient result card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.surfaceDark, AppColors.surfaceActive],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Total',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'LKR ${estimatedTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'Based on mass × unit price',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
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
          label: 'Confirm Sale Record',
          icon: Symbols.check_circle,
          onPressed: () => notifier.confirmSale(() => context.go('/home')),
        ),
      ),
    );
  }
}
