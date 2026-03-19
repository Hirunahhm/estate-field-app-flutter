import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/latex_collection_notifier.dart';
import '../../data/models/tapper_mini_model.dart';

class TapperMiniCard extends ConsumerWidget {
  const TapperMiniCard({super.key, required this.tapper});

  final TapperMiniModel tapper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(latexCollectionProvider).selectedTapperId;
    final isSelected = selectedId == tapper.id;
    final notifier = ref.read(latexCollectionProvider.notifier);

    return GestureDetector(
      onTap: () => notifier.selectTapper(tapper.id),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.surfaceBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(tapper.avatarUrl),
              backgroundColor: AppColors.surfaceActive,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tapper.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    tapper.id,
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Symbols.check_circle, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}
