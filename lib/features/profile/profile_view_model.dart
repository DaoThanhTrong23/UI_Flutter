import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/data_repository.dart';
import '../../models/user_model.dart';

final profileViewModelProvider = FutureProvider.autoDispose<UserProfileModel>((ref) {
  final repo = ref.watch(dataRepositoryProvider);
  return repo.getProfile();
});
