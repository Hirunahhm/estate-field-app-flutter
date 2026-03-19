import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/tapper_attendance_notifier.dart';
import '../widgets/tapper_card.dart';

class TapperAttendanceScreen extends ConsumerStatefulWidget {
  const TapperAttendanceScreen({super.key});

  @override
  ConsumerState<TapperAttendanceScreen> createState() => _TapperAttendanceScreenState();
}

class _TapperAttendanceScreenState extends ConsumerState<TapperAttendanceScreen> {
  final _searchController = TextEditingController();
  int _tabIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tapperAttendanceProvider);
    final notifier = ref.read(tapperAttendanceProvider.notifier);
    final tappers = state.filteredTappers;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Compound sticky header
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.go('/home'),
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
                              'Tapper Attendance',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${state.markedCount} marked',
                              style: GoogleFonts.inter(
                                color: AppColors.primary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Date selector
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: state.selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) => Theme(
                              data: ThemeData.dark(),
                              child: child!,
                            ),
                          );
                          if (picked != null) notifier.updateDate(picked);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.surfaceBorder),
                          ),
                          child: Row(
                            children: [
                              const Icon(Symbols.calendar_today, color: AppColors.textMuted, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                '${state.selectedDate.day}/${state.selectedDate.month}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  // Search bar
                  TextField(
                    controller: _searchController,
                    onChanged: notifier.updateSearch,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search tappers...',
                      hintStyle: GoogleFonts.inter(color: AppColors.textMuted),
                      prefixIcon: const Icon(Symbols.search, color: AppColors.textMuted, size: 20),
                      filled: true,
                      fillColor: AppColors.surface,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                itemCount: tappers.length,
                separatorBuilder: (_, __) => const Gap(8),
                itemBuilder: (context, index) => TapperCard(tapper: tappers[index]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/attendance/record-trees'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        icon: const Icon(Symbols.arrow_forward),
        label: Text(
          'Record Trees',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Symbols.home), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.groups), label: 'Field'),
          NavigationDestination(icon: Icon(Symbols.account_balance_wallet), label: 'Finance'),
        ],
      ),
    );
  }
}
