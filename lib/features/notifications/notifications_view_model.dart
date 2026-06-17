import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/data_repository.dart';
import '../../models/notification_model.dart';

class NotificationsViewModel extends AutoDisposeAsyncNotifier<List<NotificationModel>> {
  @override
  FutureOr<List<NotificationModel>> build() {
    return ref.watch(dataRepositoryProvider).getNotifications();
  }

  void removeNotificationLocally(String id) {
    final currentList = state.value;
    if (currentList != null) {
      state = AsyncData(currentList.where((n) => n.id != id).toList());
    }
  }
}

final notificationsViewModelProvider = AsyncNotifierProvider.autoDispose<NotificationsViewModel, List<NotificationModel>>(
  NotificationsViewModel.new,
);
