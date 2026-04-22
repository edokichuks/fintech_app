// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:intl/intl.dart' as intl;

// Package imports:

class IOSLocalizationsDelegate extends CupertinoLocalizations {
  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get clearButtonLabel => 'Clear';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get cutButtonLabel => 'Cut';

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) {
    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) {
    return hour.toString().padLeft(2, '0');
  }

  @override
  String? datePickerHourSemanticsLabel(int hour) {
    return '$hour o\'clock';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return intl.DateFormat.yMMMd().format(date);
  }

  @override
  String datePickerMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  @override
  String? datePickerMinuteSemanticsLabel(int minute) {
    return '$minute minute${minute == 1 ? '' : 's'}';
  }

  @override
  String datePickerMonth(int monthIndex) {
    return intl.DateFormat.MMM().format(DateTime(2021, monthIndex));
  }

  @override
  String datePickerStandaloneMonth(int monthIndex) {
    return intl.DateFormat.MMMM().format(DateTime(2021, monthIndex));
  }

  @override
  String datePickerYear(int yearIndex) {
    return yearIndex.toString();
  }

  @override
  String get lookUpButtonLabel => 'Look Up';

  @override
  String get menuDismissLabel => 'Dismiss menu';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get noSpellCheckReplacementsLabel => 'No Replacements Found';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get searchTextFieldPlaceholderLabel => 'Search';

  @override
  String get searchWebButtonLabel => 'Search Web';

  @override
  String get selectAllButtonLabel => 'Select All';

  @override
  String get shareButtonLabel => 'Share...';

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String timerPickerHour(int hour) {
    return hour.toString().padLeft(2, '0');
  }

  @override
  String? timerPickerHourLabel(int hour) {
    return hour == 1 ? 'hour' : 'hours';
  }

  @override
  List<String> get timerPickerHourLabels => ['hour', 'hours'];

  @override
  String timerPickerMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  @override
  String? timerPickerMinuteLabel(int minute) {
    return 'min.';
  }

  @override
  List<String> get timerPickerMinuteLabels => ['min.'];

  @override
  String timerPickerSecond(int second) {
    return second.toString().padLeft(2, '0');
  }

  @override
  String? timerPickerSecondLabel(int second) {
    return 'sec.';
  }

  @override
  List<String> get timerPickerSecondLabels => ['sec.'];

  @override
  String get todayLabel => 'Today';
  
  @override
  String get backButtonLabel => '';
  
  @override
  String get cancelButtonLabel => '';
}

class AppIOSLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const AppIOSLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ig', 'ha', 'yo', 'en', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<IOSLocalizationsDelegate> load(Locale locale) async {
    return SynchronousFuture<IOSLocalizationsDelegate>(
        IOSLocalizationsDelegate());
  }

  @override
  bool shouldReload(AppIOSLocalizationDelegate old) => false;
}
