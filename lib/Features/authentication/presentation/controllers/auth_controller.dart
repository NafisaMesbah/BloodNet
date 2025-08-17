import 'package:bloodnet/Features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // ✅ Needed for @riverpod

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<void> build() async {}

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = AsyncError(
        'Ensure all fields are filled',
        StackTrace.current,
      );
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(email: email, password: password));
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String bloodGroup,
    required String type,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        bloodGroup.trim().isEmpty) {
      // ✅ changed check from `bloodGroup == null` since it's non-nullable
      state = AsyncError(
        'Ensure all fields are filled',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      bloodGroup: bloodGroup,
      type: type,
    ));
  }
}
