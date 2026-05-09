part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSearchLoadingState extends HomeState {
  HomeSearchLoadingState({required this.conversations});

  final List<ConversationEntity> conversations;
}

final class HomeActionLoadingState extends HomeState {
  HomeActionLoadingState({required this.conversations});

  final List<ConversationEntity> conversations;
}

final class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required this.conversations,
    required this.searchResults,
  });

  final List<ConversationEntity> conversations;
  final List<HomeUserEntity> searchResults;
}

final class HomeErrorState extends HomeState {
  HomeErrorState(this.message);

  final String message;
}
