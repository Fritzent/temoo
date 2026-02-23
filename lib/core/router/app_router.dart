
import 'package:go_router/go_router.dart';
import 'package:tere_mood/core/constant/route.dart';
import 'package:tere_mood/features/starter/page/starter_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/starter_page',
  routes: [
    GoRoute(
      path: Routes.starterPage,
      builder: (context, state) => const StarterPage(),
    ),
    // GoRoute(
    //   path: Routes.starterPage,
    //   builder: (context, state) => const HomePage(),
    // ),
  ],
);
