import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/latex_collection_notifier.dart';

class AmmoniaCounter extends ConsumerWidget {
  const AmmoniaCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ammoniaML = ref.watch(latexCollectionProvider).ammoniaML;
    final notifier = ref.read(latexCollectionProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CircleButton(
          icon: Icons.remove,
          onTap: notifier.decrementAmmonia,
        ),
        const SizedBox(width: 24),
        Column(
          children: [
            Text(
              '$ammoniaML',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'mL',
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        _CircleButton(
          icon: Icons.add,
          onTap: notifier.incrementAmmonia,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.surfaceBorder),
            ),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
      ),
    );
  }
}
