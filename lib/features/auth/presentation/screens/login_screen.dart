import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _estateIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _estateIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.surfaceDark, AppColors.background],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(32),
                  // Brand logo
                  Image.asset(
                    'assets/Madukotewatte_estate_logo.png',
                    width: 96,
                    height: 96,
                  ),
                  const Gap(24),
                  Text(
                    'Estate Field\nManagement',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Sign in to your estate account',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted,
                      fontSize: 16,
                    ),
                  ),
                  const Gap(40),
                  AppTextField(
                    label: 'Estate ID',
                    hint: 'e.g. EST-001',
                    prefixIcon: Symbols.domain,
                    controller: _estateIdController,
                    onChanged: notifier.updateEstateId,
                  ),
                  const Gap(16),
                  AppTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Symbols.lock,
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: notifier.updatePassword,
                  ),
                  if (authState.errorMessage != null) ...[
                    const Gap(12),
                    Text(
                      authState.errorMessage!,
                      style: GoogleFonts.inter(
                        color: AppColors.actionRed,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const Gap(24),
                  AppPrimaryButton(
                    label: 'Secure Login',
                    icon: Symbols.login,
                    isLoading: authState.isLoading,
                    onPressed: () => notifier.login(context.go),
                  ),
                  const Gap(12),
                  AppOutlinedButton(
                    label: 'Use Biometrics',
                    icon: Symbols.fingerprint,
                    onPressed: () {},
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
