import 'package:test_task_news_app/data/api/news_api_client.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements INewsRepository{
  NewsRepositoryImpl(this._apiClient);

  final NewsApiClient _apiClient;

  @override
  Future<List<Article>> getTopHeadlines({
    String? category,
    String? sources,
    String? query,
    int page = 1,
    int pageSize = 20,
  }) async {
    final NewsResponse response = await _apiClient.fetchTopHeadlines(
      category: category,
      sources: sources,
      query: query,
      page: page,
      pageSize: pageSize,
    );
    return response.articles;
  }

  @override
  Future<List<Article>> searchEverything({
    required String query,
    String? from,
    String? to,
    String sortBy = 'popularity',
    int page = 1,
    int pageSize = 20,
  }) async {
    final NewsResponse response = await _apiClient.searchEverything(
      query: query,
      from: from,
      to: to,
      sortBy: sortBy,
      page: page,
      pageSize: pageSize,
    );
    return response.articles;
  }
}