import 'package:test_task_news_app/data/models/news_models.dart';

abstract interface class INewsRepository {
  Future<List<Article>> getTopHeadlines({
    String? category,
    String? sources,
    String? query,
    int page = 1,
    int pageSize = 20,
  });
  Future<List<Article>> searchEverything({
    required String query,
    String? from,
    String? to,
    String sortBy = 'popularity',
    int page = 1,
    int pageSize = 20,
  });
}
