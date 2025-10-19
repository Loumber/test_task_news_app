part of 'favorites_bloc.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.articles = const <Article>[],
    this.isFavorite = false,
    this.errorMessage,
  });

  final FavoritesStatus status;
  final List<Article> articles;
  final bool isFavorite;
  final String? errorMessage;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Article>? articles,
    bool? isFavorite,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      isFavorite: isFavorite ?? this.isFavorite,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, articles, isFavorite, errorMessage];
}
