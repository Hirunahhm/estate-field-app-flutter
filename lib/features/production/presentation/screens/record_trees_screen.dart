import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/numeric_keypad.dart';
import '../providers/record_trees_notifier.dart';

class RecordTreesScreen extends ConsumerWidget {
  const RecordTreesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordTreesProvider);
    final notifier = ref.read(recordTreesProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/attendance'),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.surfaceBorder),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          state.tapperName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          state.tapperId,
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Symbols.history, color: AppColors.textMuted),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.surfaceBorder),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Display area
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.inputBuffer.isEmpty ? '0' : state.inputBuffer,
                    style: GoogleFonts.inter(
                      color: state.inputBuffer.isEmpty ? AppColors.textMuted : Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Trees tapped today',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted,
                      fontSize: 16,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'Enter number of trees (max 9999)',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NumericKeypad(
                onDigit: notifier.appendDigit,
                onBackspace: notifier.backspace,
                onClear: notifier.clear,
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppPrimaryButton(
                label: 'Confirm Attendance',
                icon: Symbols.check_circle,
                onPressed: () => notifier.confirmAttendance(() => context.go('/attendance')),
              ),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
