import 'package:test_task_news_app/data/models/news_models.dart';

abstract interface class IFavoritesRepository {
  List<Article> getFavorites();
  Future<void> saveFavorites(List<Article> articles);
  Future<List<Article>> toggleFavorite(Article article);
  bool isFavorite(Article article);
}
