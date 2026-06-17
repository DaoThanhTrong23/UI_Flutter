import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/data_repository.dart';
import '../../models/faculty_model.dart';

final facultyViewModelProvider = FutureProvider.autoDispose<List<FacultyModel>>((ref) {
  final repo = ref.watch(dataRepositoryProvider);
  return repo.getFaculties();
});
