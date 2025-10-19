import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements IFavoritesRepository {
  FavoritesRepositoryImpl(this._prefs);

  static const String _favoritesKey = 'favorites_articles';
  final SharedPreferences _prefs;

  @override
  List<Article> getFavorites() {
    final String? raw = _prefs.getString(_favoritesKey);
    if (raw == null || raw.isEmpty) return <Article>[];
    final List<dynamic> list = json.decode(raw) as List<dynamic>;
    return list.map((dynamic e) => Article.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> saveFavorites(List<Article> articles) async {
    final String raw = json.encode(articles.map((Article a) => a.toJson()).toList());
    await _prefs.setString(_favoritesKey, raw);
  }

  @override
  Future<List<Article>> toggleFavorite(Article article) async {
    final List<Article> current = getFavorites();
    final int idx = current.indexWhere((Article a) => a.url == article.url);
    
    if (idx >= 0) {
      current.removeAt(idx);
    } else {
      current.add(article);
    }
    
    await saveFavorites(current);
    return current;
  }

  @override
  bool isFavorite(Article article) {
    return getFavorites().any((Article a) => a.url == article.url);
  }
}