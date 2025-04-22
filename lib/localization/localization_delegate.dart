import 'package:flutter_translate/flutter_translate.dart';

Future<LocalizationDelegate> setupLocalization() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'am'],
    basePath: 'assets/i18n',
  );

  return delegate;
}
