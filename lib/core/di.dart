import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_news_app/core/env.dart';
import 'package:test_task_news_app/data/api/news_api_client.dart';
import 'package:test_task_news_app/data/repositories/favorites_repository.dart';
import 'package:test_task_news_app/data/repositories/news_repository.dart';
import 'package:test_task_news_app/domain/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:test_task_news_app/domain/repositories/favorites_repository.dart';
import 'package:test_task_news_app/domain/repositories/news_repository.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {
  if (!serviceLocator.isRegistered<Dio>()) {
    serviceLocator.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl: EnvConfig.newsApiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      return dio;
    });
  }

  if (!serviceLocator.isRegistered<SharedPreferences>()) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    serviceLocator.registerSingleton<SharedPreferences>(prefs);
  }

  if (!serviceLocator.isRegistered<NewsApiClient>()) {
    serviceLocator.registerLazySingleton<NewsApiClient>(() => NewsApiClient(serviceLocator<Dio>()));
  }

  if (!serviceLocator.isRegistered<INewsRepository>()) {
    serviceLocator.registerLazySingleton<INewsRepository>(() => NewsRepositoryImpl(serviceLocator<NewsApiClient>()));
  }

  if (!serviceLocator.isRegistered<IFavoritesRepository>()) {
    serviceLocator.registerLazySingleton<IFavoritesRepository>(
      () => FavoritesRepositoryImpl(serviceLocator<SharedPreferences>()),
    );
  }

  if (!serviceLocator.isRegistered<FavoritesBloc>()) {
    serviceLocator.registerFactory<FavoritesBloc>(() => FavoritesBloc(serviceLocator<IFavoritesRepository>()));
  }
}
