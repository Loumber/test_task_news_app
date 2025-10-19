import 'package:go_router/go_router.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/presentation/screens/details_screen.dart';

import 'package:test_task_news_app/presentation/screens/favorites_screen.dart';
import 'package:test_task_news_app/presentation/screens/home_page.dart';
import 'package:test_task_news_app/presentation/screens/list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/news',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/news',
         routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) {
                    final article = state.extra as Article;
                    return DetailsScreen(article: article);
                  },
                ),
              ],
        builder: (context, state) => const ListScreen())]),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) {
                    final article = state.extra as Article;
                    return DetailsScreen(article: article);
                  },
                ),
              ],
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
