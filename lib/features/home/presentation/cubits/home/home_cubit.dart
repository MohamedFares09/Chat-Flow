
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/domain/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitialState());

  final HomeRepo homeRepo;

  List<ConversationEntity> conversations = [];
  List<HomeUserEntity> searchResults = [];

  Future<void> getConversations() async {
    emit(HomeLoadingState());
    final result = await homeRepo.getConversations();
    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (items) {
        conversations = items;
        emit(
          HomeSuccessState(
            conversations: conversations,
            searchResults: searchResults,
          ),
        );
      },
    );
  }

  Future<void> searchUsersByEmail(String email) async {
    emit(HomeSearchLoadingState(conversations: conversations));
    final result = await homeRepo.searchUsersByEmail(email);
    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (users) {
        searchResults = users;
        emit(
          HomeSuccessState(
            conversations: conversations,
            searchResults: searchResults,
          ),
        );
      },
    );
  }

  Future<void> createConversationWithUser(HomeUserEntity user) async {
    emit(HomeActionLoadingState(conversations: conversations));
    final result = await homeRepo.createConversationWithUser(user);
    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (conversation) async {
        searchResults = [];
        emit(HomeConversationCreatedState(conversation));
        await getConversations();
      },
    );
  }

  void clearSearch() {
    searchResults = [];
    emit(
      HomeSuccessState(
        conversations: conversations,
        searchResults: searchResults,
      ),
    );
  }
}
