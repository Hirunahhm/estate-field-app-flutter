import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/feature_grid_card.dart';
import '../widgets/recent_upload_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(homeTabIndexProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Sticky header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: AppColors.background,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.surfaceActive,
                    child: const Icon(Symbols.person, color: AppColors.textMuted, size: 22),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Field Operations',
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Symbols.logout, color: AppColors.textMuted, size: 20),
                    tooltip: 'Logout',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,\nSupervisor',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'What would you like to record today?',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 15,
                      ),
                    ),
                    const Gap(24),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.0,
                      children: [
                        FeatureGridCard(
                          icon: Symbols.groups,
                          category: 'HR',
                          title: 'Tapper Attendance',
                          iconBgColor: const Color(0xFF2563EB),
                          onTap: () => context.go('/attendance'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.water_drop,
                          category: 'Production',
                          title: 'Latex Collection',
                          iconBgColor: const Color(0xFF16A34A),
                          onTap: () => context.go('/latex'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.science,
                          category: 'Lab',
                          title: 'Metrolac Update',
                          iconBgColor: const Color(0xFF7C3AED),
                          onTap: () => context.go('/metrolac'),
                        ),
                        FeatureGridCard(
                          icon: Symbols.receipt_long,
                          category: 'Finance',
                          title: 'Expense Entry',
                          iconBgColor: const Color(0xFFD97706),
                          onTap: () => context.go('/expense'),
                        ),
                      ],
                    ),
                    const Gap(28),
                    Text(
                      'Recent Uploads',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(12),
                    const RecentUploadItem(
                      title: 'Tapper Attendance',
                      subtitle: 'Today, 07:45 AM • 34 tappers',
                      status: UploadStatus.synced,
                      icon: Symbols.groups,
                    ),
                    const RecentUploadItem(
                      title: 'Latex Collection',
                      subtitle: 'Today, 08:30 AM • 120L',
                      status: UploadStatus.pending,
                      icon: Symbols.water_drop,
                    ),
                    const RecentUploadItem(
                      title: 'Metrolac Reading',
                      subtitle: 'Yesterday, 04:15 PM',
                      status: UploadStatus.synced,
                      icon: Symbols.science,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        onDestinationSelected: (index) {
          ref.read(homeTabIndexProvider.notifier).state = index;
          if (index == 1) context.go('/attendance');
          if (index == 2) context.go('/expense');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Symbols.home), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.groups), label: 'Field'),
          NavigationDestination(icon: Icon(Symbols.account_balance_wallet), label: 'Finance'),
        ],
      ),
    );
  }
}
