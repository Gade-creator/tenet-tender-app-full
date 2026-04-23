import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/contractor/dashboard_screen.dart';
import '../screens/contractor/tender_list_screen.dart';
import '../screens/contractor/tender_detail_screen.dart';
import '../screens/contractor/project_workspace_screen.dart';
import '../screens/contractor/chat_screen.dart';
import '../screens/contractor/payment_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_screens.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    // ── AUTH ──
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

    // ── CONTRACTOR ──
    GoRoute(path: '/contractor/dashboard', builder: (_, __) => const ContractorDashboard()),
    GoRoute(path: '/contractor/tenders', builder: (_, __) => const TenderListScreen()),
    GoRoute(path: '/contractor/tender-detail', builder: (_, __) => const TenderDetailScreen()),
    GoRoute(path: '/contractor/bid-form', builder: (_, __) => const BidFormScreen()),
    GoRoute(path: '/contractor/projects', builder: (_, __) => const ProjectWorkspaceScreen()),
    GoRoute(path: '/contractor/chat', builder: (_, __) => const ChatScreen()),
    GoRoute(path: '/contractor/payments', builder: (_, __) => const PaymentScreen()),
    GoRoute(path: '/contractor/invoice', builder: (_, __) => const InvoiceScreen()),
    GoRoute(path: '/contractor/workshops', builder: (_, __) => const WorkshopsScreen()),

    // ── ADMIN ──
    GoRoute(path: '/admin/dashboard', builder: (_, __) => const AdminDashboard()),
    GoRoute(path: '/admin/kyc', builder: (_, __) => const KycReviewScreen()),
    GoRoute(path: '/admin/post-tender', builder: (_, __) => const PostTenderScreen()),
  ],
);
