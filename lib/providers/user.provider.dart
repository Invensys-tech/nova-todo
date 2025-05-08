import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalContainer = ProviderContainer();
final userProvider = StateProvider((ref) => <dynamic, dynamic>{});
final transactionProvider = StateProvider((ref) => '');

Map<dynamic, dynamic> getUser() {
  final user = globalContainer.read(userProvider);
  return user;
}

int getUserId() {
  return getUser()['id'];
}

void updateUser(Map<dynamic, dynamic> userData) {
  final user = globalContainer.read(userProvider.notifier);
  user.state = userData;
}

String getTxRef() {
  final txRef = globalContainer.read(transactionProvider);
  return txRef;
}

void updateTxRef(String newTxRef) {
  final txRef = globalContainer.read(transactionProvider.notifier);
  txRef.state = newTxRef;
}
