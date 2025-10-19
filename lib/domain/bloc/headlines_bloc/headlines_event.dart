part of 'headlines_bloc.dart';

abstract class HeadlinesEvent extends Equatable {
  const HeadlinesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class HeadlinesFetchRequested extends HeadlinesEvent {
  const HeadlinesFetchRequested();
}

class HeadlinesQueryChanged extends HeadlinesEvent {
  const HeadlinesQueryChanged(this.query);
  final String? query;

  @override
  List<Object?> get props => <Object?>[query];
}

class HeadlinesCategoryChanged extends HeadlinesEvent {
  const HeadlinesCategoryChanged(this.category);
  final String? category;

  @override
  List<Object?> get props => <Object?>[category];
}

class HeadlinesRefreshRequested extends HeadlinesEvent {
  const HeadlinesRefreshRequested();
}

class HeadlinesSearchRequested extends HeadlinesEvent {
  const HeadlinesSearchRequested(this.query);
  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}

class HeadlinesFetchMoreRequested extends HeadlinesEvent {
  const HeadlinesFetchMoreRequested();
}

class HeadlinesResetRequested extends HeadlinesEvent {
  const HeadlinesResetRequested();
}



