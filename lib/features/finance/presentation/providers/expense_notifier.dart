import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ExpenseCategory { fuel, repairs, wages, chemicals }

enum PaymentMethod { cash, bank }

class ExpenseState {
  const ExpenseState({
    this.amount = '',
    this.selectedCategory,
    required this.date,
    this.paymentMethod = PaymentMethod.cash,
  });

  final String amount;
  final ExpenseCategory? selectedCategory;
  final DateTime date;
  final PaymentMethod paymentMethod;

  ExpenseState copyWith({
    String? amount,
    ExpenseCategory? selectedCategory,
    DateTime? date,
    PaymentMethod? paymentMethod,
  }) {
    return ExpenseState(
      amount: amount ?? this.amount,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class ExpenseNotifier extends Notifier<ExpenseState> {
  @override
  ExpenseState build() => ExpenseState(date: DateTime.now());

  void updateAmount(String s) => state = state.copyWith(amount: s);
  void selectCategory(ExpenseCategory c) => state = state.copyWith(selectedCategory: c);
  void updateDate(DateTime dt) => state = state.copyWith(date: dt);
  void togglePaymentMethod(PaymentMethod m) => state = state.copyWith(paymentMethod: m);

  Future<void> logExpense(void Function() onDone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = ExpenseState(date: DateTime.now());
    onDone();
  }
}

final expenseProvider =
    NotifierProvider<ExpenseNotifier, ExpenseState>(ExpenseNotifier.new);
