import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetrolacState {
  const MetrolacState({
    this.selectedLoadId,
    this.readingInput = '',
  });

  final String? selectedLoadId;
  final String readingInput;

  bool get isValid {
    final v = double.tryParse(readingInput);
    return v != null && v >= 0.0 && v <= 45.0;
  }

  MetrolacState copyWith({
    String? selectedLoadId,
    String? readingInput,
  }) {
    return MetrolacState(
      selectedLoadId: selectedLoadId ?? this.selectedLoadId,
      readingInput: readingInput ?? this.readingInput,
    );
  }
}

class MetrolacNotifier extends Notifier<MetrolacState> {
  @override
  MetrolacState build() => const MetrolacState();

  void selectLoad(String id) {
    state = state.copyWith(selectedLoadId: id);
  }

  void updateReading(String s) {
    state = state.copyWith(readingInput: s);
  }

  Future<void> saveReading(void Function() onDone) async {
    if (!state.isValid) return;
    await Future.delayed(const Duration(milliseconds: 500));
    state = const MetrolacState();
    onDone();
  }
}

final metrolacProvider =
    NotifierProvider<MetrolacNotifier, MetrolacState>(MetrolacNotifier.new);
