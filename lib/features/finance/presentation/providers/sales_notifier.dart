import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesState {
  const SalesState({
    this.totalLatexL = '',
    this.totalMassKg = '',
    this.finalMetrolac = '',
    this.unitPriceLKR = '',
  });

  final String totalLatexL;
  final String totalMassKg;
  final String finalMetrolac;
  final String unitPriceLKR;

  double get estimatedTotal {
    final mass = double.tryParse(totalMassKg) ?? 0;
    final price = double.tryParse(unitPriceLKR) ?? 0;
    return mass * price;
  }

  SalesState copyWith({
    String? totalLatexL,
    String? totalMassKg,
    String? finalMetrolac,
    String? unitPriceLKR,
  }) {
    return SalesState(
      totalLatexL: totalLatexL ?? this.totalLatexL,
      totalMassKg: totalMassKg ?? this.totalMassKg,
      finalMetrolac: finalMetrolac ?? this.finalMetrolac,
      unitPriceLKR: unitPriceLKR ?? this.unitPriceLKR,
    );
  }
}

class SalesNotifier extends Notifier<SalesState> {
  @override
  SalesState build() => const SalesState();

  void updateLatex(String s) => state = state.copyWith(totalLatexL: s);
  void updateMass(String s) => state = state.copyWith(totalMassKg: s);
  void updateMetrolac(String s) => state = state.copyWith(finalMetrolac: s);
  void updateUnitPrice(String s) => state = state.copyWith(unitPriceLKR: s);

  Future<void> confirmSale(void Function() onDone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = const SalesState();
    onDone();
  }
}

final salesProvider =
    NotifierProvider<SalesNotifier, SalesState>(SalesNotifier.new);
