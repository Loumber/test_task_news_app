part of 'headlines_bloc.dart';

enum HeadlinesStatus { initial, loading,loadingMore ,success, failure }

class HeadlinesState extends Equatable {
  const HeadlinesState({
    this.status = HeadlinesStatus.initial,
    this.articles = const <Article>[],
    this.query,
    this.category,
    this.sources,
    this.errorMessage,
  });

  final HeadlinesStatus status;
  final List<Article> articles;
  final String? query;
  final String? category;
  final String? sources;
  final String? errorMessage;

  HeadlinesState copyWith({
    HeadlinesStatus? status,
    List<Article>? articles,
    String? query,
    String? category,
    String? sources,
    String? errorMessage,
  }) {
    return HeadlinesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      query: query ?? this.query,
      category: category ?? this.category,
      sources: sources ?? this.sources,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, articles, query, category, sources, errorMessage];
}


