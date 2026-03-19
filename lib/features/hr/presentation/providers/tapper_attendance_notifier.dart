import 'package:flutter_riverpod/flutter_riverpod.dart';

class TapperModel {
  const TapperModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.area,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String area;
}

class TapperAttendanceState {
  const TapperAttendanceState({
    this.tappers = const [],
    this.selectedIds = const {},
    this.absentIds = const {},
    this.searchQuery = '',
    required this.selectedDate,
  });

  final List<TapperModel> tappers;
  final Set<String> selectedIds;
  final Set<String> absentIds;
  final String searchQuery;
  final DateTime selectedDate;

  TapperAttendanceState copyWith({
    List<TapperModel>? tappers,
    Set<String>? selectedIds,
    Set<String>? absentIds,
    String? searchQuery,
    DateTime? selectedDate,
  }) {
    return TapperAttendanceState(
      tappers: tappers ?? this.tappers,
      selectedIds: selectedIds ?? this.selectedIds,
      absentIds: absentIds ?? this.absentIds,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  List<TapperModel> get filteredTappers {
    if (searchQuery.isEmpty) return tappers;
    return tappers.where((t) =>
      t.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
      t.id.toLowerCase().contains(searchQuery.toLowerCase()),
    ).toList();
  }

  int get markedCount => selectedIds.length;
}

class TapperAttendanceNotifier extends Notifier<TapperAttendanceState> {
  @override
  TapperAttendanceState build() {
    return TapperAttendanceState(
      selectedDate: DateTime.now(),
      tappers: _mockTappers,
    );
  }

  static final _mockTappers = List.generate(
    12,
    (i) => TapperModel(
      id: 'T${(i + 1).toString().padLeft(3, '0')}',
      name: ['Suresh Kumar', 'Rajan Perera', 'Nimal Silva', 'Arjun Raj',
             'Priya Sena', 'Kamal Wijeratne', 'Saman Fernando', 'Ruwan Jayawardena',
             'Chaminda Bandara', 'Kasun Perera', 'Thilak Dissanayake', 'Mahesh Jayasena'][i],
      avatarUrl: 'https://i.pravatar.cc/150?img=${i + 10}',
      area: ['Block A', 'Block B', 'Block C', 'Block A', 'Block B', 'Block C',
             'Block A', 'Block B', 'Block C', 'Block A', 'Block B', 'Block C'][i],
    ),
  );

  void toggleSelected(String id) {
    if (state.absentIds.contains(id)) return;
    final newSelected = Set<String>.from(state.selectedIds);
    if (newSelected.contains(id)) {
      newSelected.remove(id);
    } else {
      newSelected.add(id);
    }
    state = state.copyWith(selectedIds: newSelected);
  }

  void markAbsent(String id) {
    final newAbsent = Set<String>.from(state.absentIds);
    final newSelected = Set<String>.from(state.selectedIds);
    if (newAbsent.contains(id)) {
      newAbsent.remove(id);
    } else {
      newAbsent.add(id);
      newSelected.remove(id);
    }
    state = state.copyWith(absentIds: newAbsent, selectedIds: newSelected);
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateDate(DateTime dt) {
    state = state.copyWith(selectedDate: dt);
  }
}

final tapperAttendanceProvider =
    NotifierProvider<TapperAttendanceNotifier, TapperAttendanceState>(
        TapperAttendanceNotifier.new);
