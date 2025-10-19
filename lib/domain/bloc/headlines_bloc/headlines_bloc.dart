import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/repositories/news_repository.dart';

part 'headlines_event.dart';
part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  HeadlinesBloc(this._repository) : super(const HeadlinesState()) {
    on<HeadlinesFetchRequested>(_onFetchRequested);
    on<HeadlinesFetchMoreRequested>(_onFetchMoreRequested);
    on<HeadlinesRefreshRequested>(_onRefreshRequested);
    on<HeadlinesQueryChanged>(_onQueryChanged);
    on<HeadlinesCategoryChanged>(_onCategoryChanged);
    on<HeadlinesSearchRequested>(_onSearchRequested);
    on<HeadlinesResetRequested>(_onResetRequested);
  }

  int _currentPage = 1;
  bool _hasNextPage = true;
  final INewsRepository _repository;

  Future<void> _onFetchRequested(
    HeadlinesFetchRequested event,
    Emitter<HeadlinesState> emit,
  ) async {
    emit(state.copyWith(status: HeadlinesStatus.loading, errorMessage: null));

    try {
      final articles = await _repository.getTopHeadlines(
        category: state.category,
        sources: state.sources,
        query: state.query,
        page: _currentPage,
        pageSize: 20,
      );

      _currentPage++;
      _hasNextPage = articles.length == 20;

      emit(state.copyWith(
        status: HeadlinesStatus.success,
        articles: articles,
      ));
    } catch (e) {
      emit(state.copyWith(status: HeadlinesStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchMoreRequested(
    HeadlinesFetchMoreRequested event,
    Emitter<HeadlinesState> emit,
  ) async {
    if (!_hasNextPage || state.status == HeadlinesStatus.loadingMore) return;

    emit(state.copyWith(status: HeadlinesStatus.loadingMore));

    try {
      final moreArticles = await _repository.getTopHeadlines(
        category: state.category,
        sources: state.sources,
        query: state.query,
        page: _currentPage,
        pageSize: 20,
      );

      _currentPage++;
      _hasNextPage = moreArticles.length == 20;

      final updatedList = [...state.articles, ...moreArticles];

      emit(state.copyWith(
        status: HeadlinesStatus.success,
        articles: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(status: HeadlinesStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onRefreshRequested(
    HeadlinesRefreshRequested event,
    Emitter<HeadlinesState> emit,
  ) async {
    _currentPage = 1;
    _hasNextPage = true;
    add(const HeadlinesFetchRequested());
  }

  void _onQueryChanged(HeadlinesQueryChanged event, Emitter<HeadlinesState> emit) {
    emit(state.copyWith(query: event.query));
    add(const HeadlinesResetRequested());
  }

  void _onCategoryChanged(HeadlinesCategoryChanged event, Emitter<HeadlinesState> emit) {
    emit(state.copyWith(category: event.category, sources: null));
    add(const HeadlinesResetRequested());
  }

  Future<void> _onSearchRequested(HeadlinesSearchRequested event, Emitter<HeadlinesState> emit) async {
    _currentPage = 1;
    _hasNextPage = true;

    emit(state.copyWith(status: HeadlinesStatus.loading, errorMessage: null));
    try {
      final articles = await _repository.searchEverything(
        query: event.query,
        page: _currentPage,
        pageSize: 20,
      );
      _currentPage++;
      emit(state.copyWith(status: HeadlinesStatus.success, articles: articles, query: event.query));
    } catch (e) {
      emit(state.copyWith(status: HeadlinesStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onResetRequested(HeadlinesResetRequested event, Emitter<HeadlinesState> emit) async {
    _currentPage = 1;
    _hasNextPage = true;
    add(const HeadlinesFetchRequested());
  }
}
