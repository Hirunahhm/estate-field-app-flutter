import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatexCollectionState {
  const LatexCollectionState({
    this.selectedTapperId,
    this.volumeLiters,
    this.weightKg,
    this.ammoniaML = 50,
    this.notes = '',
  });

  final String? selectedTapperId;
  final String? volumeLiters;
  final String? weightKg;
  final int ammoniaML;
  final String notes;

  LatexCollectionState copyWith({
    String? selectedTapperId,
    String? volumeLiters,
    String? weightKg,
    int? ammoniaML,
    String? notes,
  }) {
    return LatexCollectionState(
      selectedTapperId: selectedTapperId ?? this.selectedTapperId,
      volumeLiters: volumeLiters ?? this.volumeLiters,
      weightKg: weightKg ?? this.weightKg,
      ammoniaML: ammoniaML ?? this.ammoniaML,
      notes: notes ?? this.notes,
    );
  }
}

class LatexCollectionNotifier extends Notifier<LatexCollectionState> {
  @override
  LatexCollectionState build() => const LatexCollectionState();

  void selectTapper(String id) {
    state = state.copyWith(selectedTapperId: id);
  }

  void updateVolume(String s) {
    state = state.copyWith(volumeLiters: s);
  }

  void updateWeight(String s) {
    state = state.copyWith(weightKg: s);
  }

  void incrementAmmonia() {
    state = state.copyWith(ammoniaML: state.ammoniaML + 1);
  }

  void decrementAmmonia() {
    if (state.ammoniaML <= 0) return;
    state = state.copyWith(ammoniaML: state.ammoniaML - 1);
  }

  void updateNotes(String s) {
    state = state.copyWith(notes: s);
  }

  Future<void> saveRecord(void Function() onDone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = const LatexCollectionState();
    onDone();
  }
}

final latexCollectionProvider =
    NotifierProvider<LatexCollectionNotifier, LatexCollectionState>(
        LatexCollectionNotifier.new);
