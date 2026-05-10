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
    required this.stories,
  });

  final List<ConversationEntity> conversations;
  final List<HomeUserEntity> searchResults;
  final List<HomeStoryEntity> stories;
}

final class HomeConversationCreatedState extends HomeState {
  HomeConversationCreatedState(this.conversation);

  final ConversationEntity conversation;
}

final class HomeStoryActionLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  HomeErrorState(this.message);

  final String message;
}
