import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordTreesState {
  const RecordTreesState({
    this.inputBuffer = '',
    this.tapperId = 'T001',
    this.tapperName = 'Suresh Kumar',
  });

  final String inputBuffer;
  final String tapperId;
  final String tapperName;

  RecordTreesState copyWith({
    String? inputBuffer,
    String? tapperId,
    String? tapperName,
  }) {
    return RecordTreesState(
      inputBuffer: inputBuffer ?? this.inputBuffer,
      tapperId: tapperId ?? this.tapperId,
      tapperName: tapperName ?? this.tapperName,
    );
  }
}

class RecordTreesNotifier extends Notifier<RecordTreesState> {
  @override
  RecordTreesState build() => const RecordTreesState();

  void appendDigit(String digit) {
    if (state.inputBuffer.length >= 4) return;
    state = state.copyWith(inputBuffer: state.inputBuffer + digit);
  }

  void backspace() {
    if (state.inputBuffer.isEmpty) return;
    state = state.copyWith(
      inputBuffer: state.inputBuffer.substring(0, state.inputBuffer.length - 1),
    );
  }

  void clear() {
    state = state.copyWith(inputBuffer: '');
  }

  Future<void> confirmAttendance(void Function() onDone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    clear();
    onDone();
  }
}

final recordTreesProvider =
    NotifierProvider<RecordTreesNotifier, RecordTreesState>(RecordTreesNotifier.new);
