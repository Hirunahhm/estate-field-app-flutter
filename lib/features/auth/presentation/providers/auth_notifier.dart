import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  const AuthState({
    this.estateId = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final String estateId;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    String? estateId,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      estateId: estateId ?? this.estateId,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  void updateEstateId(String value) {
    state = state.copyWith(estateId: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<void> login(void Function(String route) navigate) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(const Duration(seconds: 1));
    if (state.estateId.isEmpty || state.password.isEmpty) {
      state = state.copyWith(isLoading: false, errorMessage: 'Please enter estate ID and password');
      return;
    }
    state = state.copyWith(isLoading: false);
    navigate('/home');
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
