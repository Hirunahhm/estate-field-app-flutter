import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/hr/presentation/screens/tapper_attendance_screen.dart';
import '../../features/production/presentation/screens/record_trees_screen.dart';
import '../../features/production/presentation/screens/latex_collection_wizard.dart';
import '../../features/lab/presentation/screens/metrolac_update_screen.dart';
import '../../features/finance/presentation/screens/expense_entry_screen.dart';
import '../../features/finance/presentation/screens/sales_record_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/attendance', builder: (context, state) => const TapperAttendanceScreen()),
    GoRoute(path: '/attendance/record-trees', builder: (context, state) => const RecordTreesScreen()),
    GoRoute(path: '/latex', builder: (context, state) => const LatexCollectionWizard()),
    GoRoute(path: '/metrolac', builder: (context, state) => const MetrolacUpdateScreen()),
    GoRoute(path: '/expense', builder: (context, state) => const ExpenseEntryScreen()),
    GoRoute(path: '/sales', builder: (context, state) => const SalesRecordScreen()),
  ],
);
