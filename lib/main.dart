import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/app_navigation_bar.dart';
import 'package:task_list_app/common/constants.dart';
import 'package:task_list_app/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
//Added easy localizaton
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [AppConstants.enLocale, AppConstants.arLocale],
        fallbackLocale: AppConstants.enLocale,
        path: AppConstants.langPath,
        child: MyApp(),
      ),
    ),
  );
}

// Added router
final GoRouter _router = GoRouter(
  initialLocation: "/tasks",
  routes: <RouteBase>[
    ShellRoute(
        pageBuilder: (context, state, child) => NoTransitionPage(
              key: state.pageKey,
              child: HomePage(
                child: child,
              ),
            ),
        routes: [
          GoRoute(
            path: '/tasks',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: TasksPage());
            },
          ),
          GoRoute(
            path: '/projects',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: ProjectsPage());
            },
          ),
          GoRoute(
            path: '/teams',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: TeamsPage());
            },
          ),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Task list App',
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
