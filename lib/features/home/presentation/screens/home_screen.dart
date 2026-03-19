import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../widgets/feature_grid_card.dart';
import '../widgets/recent_upload_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(
                  bottom: BorderSide(color: AppColors.surfaceBorder),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.surfaceBorder,
                    child: const Icon(
                      Symbols.person,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Madukotawatte Estate',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Div B · Sungkai',
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(
                      Symbols.logout,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    tooltip: 'Logout',
                  ),
                ],
              ),
            ),
            // ── Scrollable content ───────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,\nForeman',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        const Icon(
                          Symbols.wb_cloudy,
                          color: AppColors.textMuted,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '28 °C · Partly Cloudy',
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    // ── Action Grid ──────────────────────────────────────
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.15,
                      children: [
                        FeatureGridCard(
                          icon: Symbols.assignment_ind,
                          category: 'HR',
                          title: 'Tapper Attendance',
                          onTap: () => context.go('/attendance'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.propane_tank,
                          category: 'Production',
                          title: 'Latex Collection',
                          onTap: () => context.go('/latex'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.biotech,
                          category: 'Lab',
                          title: 'Metrolac Update',
                          onTap: () => context.go('/metrolac'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.receipt_long,
                          category: 'Finance',
                          title: 'Log Expense',
                          onTap: () => context.go('/expense'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.local_shipping,
                          category: 'Finance',
                          title: 'Record Sale',
                          onTap: () => context.go('/sales'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.forest,
                          category: 'Production',
                          title: 'Record Trees',
                          onTap: () => context.go('/attendance/record-trees'),
                        ),
                      ],
                    ),
                    const Gap(28),
                    // ── Recent Uploads ────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Uploads',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Symbols.sync,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          label: Text(
                            'Sync Now',
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    const RecentUploadItem(
                      title: 'Tapper Attendance',
                      subtitle: 'Today, 07:45 AM · 34 tappers',
                      status: UploadStatus.synced,
                      icon: Symbols.assignment_ind,
                    ),
                    const RecentUploadItem(
                      title: 'Latex Collection',
                      subtitle: 'Today, 08:30 AM · 120 L',
                      status: UploadStatus.pending,
                      icon: Symbols.propane_tank,
                    ),
                    const RecentUploadItem(
                      title: 'Metrolac Reading',
                      subtitle: 'Yesterday, 04:15 PM',
                      status: UploadStatus.synced,
                      icon: Symbols.biotech,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) context.go('/attendance');
          if (i == 2) context.go('/latex');
          if (i == 3) context.go('/expense');
        },
      ),
    );
  }
}
