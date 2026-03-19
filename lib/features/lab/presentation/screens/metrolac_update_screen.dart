import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_screen_header.dart';
import '../providers/metrolac_notifier.dart';

class MetrolacUpdateScreen extends ConsumerStatefulWidget {
  const MetrolacUpdateScreen({super.key});

  @override
  ConsumerState<MetrolacUpdateScreen> createState() => _MetrolacUpdateScreenState();
}

class _MetrolacUpdateScreenState extends ConsumerState<MetrolacUpdateScreen> {
  final _readingController = TextEditingController();
  int _tabIndex = 2; // Quality tab

  @override
  void dispose() {
    _readingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(metrolacProvider);
    final notifier = ref.read(metrolacProvider.notifier);

    final loadIds = ['L-0042', 'L-0041', 'L-0040', 'L-0039'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppScreenHeader(
              title: 'Metrolac Update',
              onBack: () => context.go('/home'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Load',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.surfaceBorder),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: state.selectedLoadId,
                          hint: Text(
                            'Select a load ID',
                            style: GoogleFonts.inter(color: AppColors.textMuted),
                          ),
                          dropdownColor: AppColors.surface,
                          style: GoogleFonts.inter(color: Colors.white),
                          items: loadIds.map((id) => DropdownMenuItem(
                            value: id,
                            child: Text(id),
                          )).toList(),
                          onChanged: (id) {
                            if (id != null) notifier.selectLoad(id);
                          },
                        ),
                      ),
                    ),
                    const Gap(32),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'DRC Reading',
                            style: GoogleFonts.inter(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                          const Gap(8),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _readingController,
                              onChanged: notifier.updateReading,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: InputDecoration(
                                hintText: '0.0',
                                hintStyle: GoogleFonts.inter(
                                  color: AppColors.textMuted.withValues(alpha: 0.5),
                                  fontSize: 56,
                                  fontWeight: FontWeight.w700,
                                ),
                                suffixText: 'deg',
                                suffixStyle: GoogleFonts.inter(
                                  color: AppColors.textMuted,
                                  fontSize: 20,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceHighlight,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.surfaceBorder),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Symbols.info, color: AppColors.textMuted, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  'Valid range: 0.0 – 45.0 °',
                                  style: GoogleFonts.inter(
                                    color: AppColors.textMuted,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (state.readingInput.isNotEmpty && !state.isValid) ...[
                            const Gap(8),
                            Text(
                              'Reading out of range',
                              style: GoogleFonts.inter(
                                color: AppColors.actionRed,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Gap(100),
                  ],
                ),
              ),
            ),
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
          label: 'Save Reading',
          icon: Symbols.save,
          onPressed: state.isValid
              ? () => notifier.saveReading(() => context.go('/home'))
              : null,
        ),
      ),
      bottomNavigationBar: _MetrolacBottomNav(
        selectedIndex: _tabIndex,
        onTap: (i) {
          setState(() => _tabIndex = i);
          if (i == 0) context.go('/home');
          if (i == 1) context.go('/attendance');
          if (i == 3) context.go('/expense');
        },
      ),
    );
  }
}

class _MetrolacBottomNav extends StatelessWidget {
  const _MetrolacBottomNav({
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Symbols.home, 'Home'),
      (Symbols.groups, 'Field'),
      (Symbols.science, 'Quality'),
      (Symbols.account_balance_wallet, 'Finance'),
    ];

    return Container(
      height: 64,
      color: AppColors.surfaceDark,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: List.generate(items.length, (i) {
              final (icon, label) = items[i];
              final isSelected = i == selectedIndex;
              if (isSelected) return Expanded(child: const SizedBox());
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: AppColors.textMuted, size: 22),
                      const SizedBox(height: 2),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Floating active pill
          Positioned(
            top: -24,
            left: 0,
            right: 0,
            child: Row(
              children: List.generate(items.length, (i) {
                if (i != selectedIndex) return const Expanded(child: SizedBox());
                final (icon, label) = items[i];
                return Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () => onTap(i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, color: AppColors.background, size: 22),
                            Text(
                              label,
                              style: GoogleFonts.inter(
                                color: AppColors.background,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
