part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class FavoritesLoadRequested extends FavoritesEvent {
  const FavoritesLoadRequested();
}

class FavoritesToggleRequested extends FavoritesEvent {
  const FavoritesToggleRequested(this.article);
  final Article article;

  @override
  List<Object?> get props => <Object?>[article];
}

class FavoritesCheckRequested extends FavoritesEvent {
  const FavoritesCheckRequested(this.article);
  final Article article;

  @override
  List<Object?> get props => <Object?>[article];
}
