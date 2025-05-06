import 'package:flutter_application_1/providers/user.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferenceProvider = StateProvider((ref) => <dynamic, dynamic>{});

Map<dynamic, dynamic> getPreference() {
  final preference = globalContainer.read(preferenceProvider);
  return preference;
}

String getCalendarSystem() {
  return getPreference()['calendar-system'];
}

void updatePreference(Map<dynamic, dynamic> preferenceData) {
  final preference = globalContainer.read(preferenceProvider.notifier);
  preference.state = preferenceData;
}

bool isCalendarEthiopian() {
  return getCalendarSystem() == 'Ethiopian';
}
