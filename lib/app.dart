import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_news_app/core/di.dart';
import 'package:test_task_news_app/domain/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:test_task_news_app/domain/bloc/headlines_bloc/headlines_bloc.dart';
import 'package:test_task_news_app/core/router/app_router.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
             BlocProvider<FavoritesBloc>(
              create: (_) => serviceLocator<FavoritesBloc>()..add(const FavoritesLoadRequested()),
            ),
            BlocProvider<HeadlinesBloc>(
              create: (_) => serviceLocator<HeadlinesBloc>()..add(const HeadlinesFetchRequested()),
            ),
          ],
          child: CupertinoApp.router(
            title: 'News App',
            routerConfig: appRouter,
            theme: const CupertinoThemeData(
              primaryColor: CupertinoColors.activeBlue,
              barBackgroundColor: CupertinoColors.systemGrey6,
              textTheme:CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: child ?? const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }
}


