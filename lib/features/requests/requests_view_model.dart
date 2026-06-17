import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/data_repository.dart';

final requestsViewModelProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) {
  final repo = ref.watch(dataRepositoryProvider);
  return repo.getRequests();
});

final requestTypesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final repo = ref.watch(dataRepositoryProvider);
  return repo.getRequestTypes();
});
