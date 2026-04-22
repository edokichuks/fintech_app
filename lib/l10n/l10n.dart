// Flutter imports:
import 'package:clean_flutter/l10n/arb/app_localizations.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:flutter/widgets.dart';

// Project imports:

// export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('es'),
    const Locale('ig'),
    const Locale('ha'),
    const Locale('yo'),
  ];

  static String getLangCode(AppLanguages lang) {
    switch (lang) {
      case AppLanguages.Spanish:
        return 'es';
      case AppLanguages.French:
        return 'fr';
      case AppLanguages.English:
        return 'en';
      case AppLanguages.Hausa:
        return 'ha';
      case AppLanguages.Igbo:
        return 'ig';
      case AppLanguages.Yoruba:
        return 'yo';
    }
  }
}
