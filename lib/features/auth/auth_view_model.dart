import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/auth_repository.dart';
import '../../models/user_model.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<UserModel?>>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthViewModel(repo);
});

class AuthViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repo;

  AuthViewModel(this._repo) : super(const AsyncValue.data(null));

  Future<bool> login(String mssv, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repo.login(mssv, password);
      state = AsyncValue.data(user);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncValue.data(null);
  }
}
