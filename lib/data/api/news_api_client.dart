import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_task_news_app/core/env.dart';
import 'package:test_task_news_app/data/models/news_models.dart';


part 'news_api_client.g.dart';

@RestApi(baseUrl: EnvConfig.newsApiBaseUrl)
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio, {String baseUrl}) = _NewsApiClient;

  @GET('/top-headlines')
  Future<NewsResponse> fetchTopHeadlines({
    @Query('country') String country = 'us',
    @Query('category') String? category,
    @Query('sources') String? sources,
    @Query('q') String? query,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
    @Query('apiKey') String apiKey = EnvConfig.newsApiKey,
  });

  @GET('/everything')
  Future<NewsResponse> searchEverything({
    @Query('q') required String query,
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('sortBy') String sortBy = 'popularity',
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
    @Query('apiKey') String apiKey = EnvConfig.newsApiKey,
  });
}
