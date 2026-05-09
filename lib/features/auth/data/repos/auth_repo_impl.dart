import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_codex/core/error/custom_exception.dart';
import 'package:test_codex/core/error/failure.dart';
import 'package:test_codex/features/auth/data/models/user_model.dart';
import 'package:test_codex/features/auth/data/services/firebase_auth_service.dart';
import 'package:test_codex/features/auth/domain/entities/user_entity.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.firebaseAuthService});

  final FirebaseAuthService firebaseAuthService;

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception AuthRepoImpl - loginWithEmailAndPassword: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception AuthRepoImpl - registerWithEmailAndPassword: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }
}
