// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:

class AWidgetLocalizationsDelegate extends WidgetsLocalizations {
  @override
  String get reorderItemDown => 'Move down';

  @override
  String get reorderItemLeft => 'Move left';

  @override
  String get reorderItemRight => 'Move right';

  @override
  String get reorderItemToEnd => 'Move to the end';

  @override
  String get reorderItemToStart => 'Move to the start';

  @override
  String get reorderItemUp => 'Move up';

  @override
  TextDirection get textDirection => TextDirection.ltr;
  
  @override
  String get copyButtonLabel => '';
  
  @override
  String get cutButtonLabel => '';
  
  @override
  String get lookUpButtonLabel => '';
  
  @override
  String get pasteButtonLabel => '';
  
  @override
  String get searchWebButtonLabel => '';
  
  @override
  String get selectAllButtonLabel => '';
  
  @override
  String get shareButtonLabel => '';
}

class AppWidgetLocalizationDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const AppWidgetLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ig', 'ha', 'yo', 'en', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AWidgetLocalizationsDelegate> load(Locale locale) async {
    return SynchronousFuture<AWidgetLocalizationsDelegate>(
        AWidgetLocalizationsDelegate());
  }

  @override
  bool shouldReload(AppWidgetLocalizationDelegate old) => false;
}
