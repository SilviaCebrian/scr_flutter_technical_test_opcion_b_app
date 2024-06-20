import 'package:go_router/go_router.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/views.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: Splash.name,
    builder: (context, state) => const Splash(),
  ),
  GoRoute(
    path: '/home',
    name: HomeView.name,
    builder: (context, state) => const HomeView(),
  ),
]);
