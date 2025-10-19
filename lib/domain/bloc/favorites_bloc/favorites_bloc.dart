import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/repositories/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._repository) : super(const FavoritesState()) {
    on<FavoritesLoadRequested>(_onLoadRequested);
    on<FavoritesToggleRequested>(_onToggleRequested);
    on<FavoritesCheckRequested>(_onCheckRequested);
  }

  final IFavoritesRepository _repository;

  Future<void> _onLoadRequested(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    try {
      final List<Article> favorites = _repository.getFavorites();
      emit(state.copyWith(status: FavoritesStatus.success, articles: favorites));
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onToggleRequested(
    FavoritesToggleRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final List<Article> favorites = await _repository.toggleFavorite(event.article);
      final bool isFavorite = _repository.isFavorite(event.article);
      emit(state.copyWith(
        status: FavoritesStatus.success, 
        articles: favorites,
        isFavorite: isFavorite,
      ));
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onCheckRequested(
    FavoritesCheckRequested event,
    Emitter<FavoritesState> emit,
  ) {
    final bool isFavorite = _repository.isFavorite(event.article);
    emit(state.copyWith(isFavorite: isFavorite));
  }
}
