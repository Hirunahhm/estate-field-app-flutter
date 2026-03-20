import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_screen_header.dart';
import '../providers/latex_collection_notifier.dart';
import '../widgets/tapper_mini_card.dart';
import '../widgets/ammonia_counter.dart';
import '../../data/models/tapper_mini_model.dart';

final _mockTappers = List.generate(
  6,
  (i) => TapperMiniModel(
    id: 'T${(i + 1).toString().padLeft(3, '0')}',
    name: ['Suresh Kumar', 'Rajan Perera', 'Nimal Silva', 'Arjun Raj', 'Priya Sena', 'Kamal Wijeratne'][i],
    avatarUrl: 'https://i.pravatar.cc/150?img=${i + 10}',
  ),
);

class LatexCollectionWizard extends ConsumerStatefulWidget {
  const LatexCollectionWizard({super.key});

  @override
  ConsumerState<LatexCollectionWizard> createState() => _LatexCollectionWizardState();
}

class _LatexCollectionWizardState extends ConsumerState<LatexCollectionWizard> {
  final _volumeController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _volumeController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(latexCollectionProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppScreenHeader(
              title: 'Latex Collection',
              onBack: () => context.go('/home'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: Text(
                  'Load ID: L-0042',
                  style: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 12),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(number: '01', title: 'Select Tapper'),
                    const Gap(12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5,
                      children: _mockTappers
                          .map((t) => TapperMiniCard(tapper: t))
                          .toList(),
                    ),
                    const Gap(24),
                    _SectionHeader(number: '02', title: 'Measurements'),
                    const Gap(12),
                    Row(
                      children: [
                        Expanded(
                          child: _MeasurementField(
                            label: 'Volume (L)',
                            hint: '0.00',
                            controller: _volumeController,
                            onChanged: notifier.updateVolume,
                            suffix: 'L',
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: _MeasurementField(
                            label: 'Weight (kg)',
                            hint: '0.00',
                            controller: _weightController,
                            onChanged: notifier.updateWeight,
                            suffix: 'kg',
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    _SectionHeader(number: '03', title: 'Ammonia (mL)'),
                    const Gap(16),
                    const AmmoniaCounter(),
                    const Gap(24),
                    _SectionHeader(number: '04', title: 'Notes'),
                    const Gap(12),
                    TextField(
                      controller: _notesController,
                      onChanged: notifier.updateNotes,
                      maxLines: 3,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add any notes...',
                        hintStyle: GoogleFonts.inter(color: AppColors.textMuted.withValues(alpha: 0.6)),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.surfaceBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.surfaceBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
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
          label: 'Save Record',
          icon: Symbols.save,
          onPressed: () => notifier.saveRecord(() => context.go('/home')),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MeasurementField extends StatelessWidget {
  const _MeasurementField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    required this.suffix,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.textMuted.withValues(alpha: 0.6), fontSize: 20),
            suffixText: suffix,
            suffixStyle: GoogleFonts.inter(color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.surfaceBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.surfaceBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
