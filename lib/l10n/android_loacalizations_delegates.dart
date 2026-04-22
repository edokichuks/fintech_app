// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart' as intl;

class AndroidLoacalizationsDelegates extends MaterialLocalizations {
  @override
  String aboutListTileTitle(String applicationName) {
    return 'About $applicationName';
  }

  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get backButtonTooltip => 'Back';

  @override
  String get bottomSheetLabel => 'Bottom Sheet';

  @override
  String get calendarModeButtonLabel => 'Switch to calendar';

  @override
  String get cancelButtonLabel => 'CANCEL';

  @override
  String get clearButtonTooltip => 'Clear';

  @override
  String get closeButtonLabel => 'CLOSE';

  @override
  String get closeButtonTooltip => 'Close';

  @override
  String get continueButtonLabel => 'CONTINUE';

  @override
  String get copyButtonLabel => 'COPY';

  @override
  String get currentDateLabel => 'Today';

  @override
  String get cutButtonLabel => 'CUT';

  @override
  String get dateHelpText => 'mm/dd/yyyy';

  @override
  String get dateInputLabel => 'Enter Date';

  @override
  String get dateOutOfRangeLabel => 'Out of range.';

  @override
  String get datePickerHelpText => 'SELECT DATE';

  @override
  String dateRangeEndDateSemanticLabel(String formattedDate) {
    return 'End date $formattedDate';
  }

  @override
  String get dateRangeEndLabel => 'End Date';

  @override
  String get dateRangePickerHelpText => 'SELECT RANGE';

  @override
  String dateRangeStartDateSemanticLabel(String formattedDate) {
    return 'Start date $formattedDate';
  }

  @override
  String get dateRangeStartLabel => 'Start Date';

  @override
  String get dateSeparator => '/';

  @override
  String get deleteButtonTooltip => 'Delete';

  @override
  String get dialModeButtonLabel => 'Switch to dial picker mode';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get drawerLabel => 'Navigation menu';

  @override
  int get firstDayOfWeekIndex => 0; // Sunday

  @override
  String get firstPageTooltip => 'First page';

  @override
  String formatCompactDate(DateTime date) {
    return intl.DateFormat.yMd().format(date);
  }

  @override
  String formatDecimal(int number) {
    return number.toString();
  }

  @override
  String formatFullDate(DateTime date) {
    return intl.DateFormat.yMMMMEEEEd().format(date);
  }

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    final hour = timeOfDay.hourOfPeriod;
    return hour.toString().padLeft(2, '0');
  }

  @override
  String formatMediumDate(DateTime date) {
    return intl.DateFormat.MMMEd().format(date);
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    return timeOfDay.minute.toString().padLeft(2, '0');
  }

  @override
  String formatMonthYear(DateTime date) {
    return intl.DateFormat.yMMMM().format(date);
  }

  @override
  String formatShortDate(DateTime date) {
    return intl.DateFormat.yMMMd().format(date);
  }

  @override
  String formatShortMonthDay(DateTime date) {
    return intl.DateFormat.MMMd().format(date);
  }

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay,
      {bool alwaysUse24HourFormat = false}) {
    return intl.DateFormat(alwaysUse24HourFormat ? 'HH:mm' : 'h:mm a')
        .format(DateTime(2021, 1, 1, timeOfDay.hour, timeOfDay.minute));
  }

  @override
  String formatYear(DateTime date) {
    return date.year.toString();
  }

  @override
  String get hideAccountsLabel => 'Hide accounts';

  @override
  String get inputDateModeButtonLabel => 'Switch to input';

  @override
  String get inputTimeModeButtonLabel => 'Switch to text input mode';

  @override
  String get invalidDateFormatLabel => 'Invalid format.';

  @override
  String get invalidDateRangeLabel => 'Invalid range.';

  @override
  String get invalidTimeLabel => 'Enter a valid time';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'Channel Down';

  @override
  String get keyboardKeyChannelUp => 'Channel Up';

  @override
  String get keyboardKeyControl => 'Ctrl';

  @override
  String get keyboardKeyDelete => 'Del';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Esc';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

  @override
  String get keyboardKeyNumpad0 => 'Num 0';

  @override
  String get keyboardKeyNumpad1 => 'Num 1';

  @override
  String get keyboardKeyNumpad2 => 'Num 2';

  @override
  String get keyboardKeyNumpad3 => 'Num 3';

  @override
  String get keyboardKeyNumpad4 => 'Num 4';

  @override
  String get keyboardKeyNumpad5 => 'Num 5';

  @override
  String get keyboardKeyNumpad6 => 'Num 6';

  @override
  String get keyboardKeyNumpad7 => 'Num 7';

  @override
  String get keyboardKeyNumpad8 => 'Num 8';

  @override
  String get keyboardKeyNumpad9 => 'Num 9';

  @override
  String get keyboardKeyNumpadAdd => 'Num +';

  @override
  String get keyboardKeyNumpadComma => 'Num ,';

  @override
  String get keyboardKeyNumpadDecimal => 'Num .';

  @override
  String get keyboardKeyNumpadDivide => 'Num /';

  @override
  String get keyboardKeyNumpadEnter => 'Num Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Num =';

  @override
  String get keyboardKeyNumpadMultiply => 'Num *';

  @override
  String get keyboardKeyNumpadParenLeft => 'Num (';

  @override
  String get keyboardKeyNumpadParenRight => 'Num )';

  @override
  String get keyboardKeyNumpadSubtract => 'Num -';

  @override
  String get keyboardKeyPageDown => 'PgDown';

  @override
  String get keyboardKeyPageUp => 'PgUp';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get lastPageTooltip => 'Last page';

  @override
  String licensesPackageDetailText(int licenseCount) {
    return '$licenseCount license${licenseCount == 1 ? '' : 's'}';
  }

  @override
  String get licensesPageTitle => 'Licenses';

  @override
  String get lookUpButtonLabel => 'Look Up';

  @override
  String get menuBarMenuLabel => 'Menu Bar Menu';

  @override
  String get menuDismissLabel => 'Dismiss menu';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get moreButtonTooltip => 'More';

  @override
  List<String> get narrowWeekdays =>
      const <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  String get nextMonthTooltip => 'Next month';

  @override
  String get nextPageTooltip => 'Next page';

  @override
  String get okButtonLabel => 'OK';

  @override
  String get openAppDrawerTooltip => 'Open navigation menu';

  @override
  String pageRowsInfoTitle(
      int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    return '$firstRow–$lastRow of ${rowCountIsApproximate ? 'about ' : ''}$rowCount';
  }

  @override
  DateTime? parseCompactDate(String? inputString) {
    return inputString != null ? DateTime.tryParse(inputString) : null;
  }

  @override
  String get pasteButtonLabel => 'PASTE';

  @override
  String get popupMenuLabel => 'Popup menu';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get previousMonthTooltip => 'Previous month';

  @override
  String get previousPageTooltip => 'Previous page';

  @override
  String get refreshIndicatorSemanticLabel => 'Refresh';

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    return '$remaining character${remaining == 1 ? '' : 's'} remaining';
  }

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
  String get rowsPerPageTitle => 'Rows per page:';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get scanTextButtonLabel => 'Scan text';

  @override
  String get scrimLabel => 'Scrim';

  @override
  String scrimOnTapHint(String modalRouteContentName) {
    return 'Close $modalRouteContentName';
  }

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => 'Search';

  @override
  String get searchWebButtonLabel => 'Search Web';

  @override
  String get selectAllButtonLabel => 'SELECT ALL';

  @override
  String get selectYearSemanticsLabel => 'Select year';

  @override
  String get selectedDateLabel => 'Selected date';

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    return '$selectedRowCount item${selectedRowCount == 1 ? '' : 's'} selected';
  }

  @override
  String get shareButtonLabel => 'Share';

  @override
  String get showAccountsLabel => 'Show accounts';

  @override
  String get showMenuTooltip => 'Show menu';

  @override
  String get signedInLabel => 'Signed in';

  @override
  String tabLabel({required int tabIndex, required int tabCount}) {
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  String get timePickerDialHelpText => 'SELECT TIME';

  @override
  String get timePickerHourLabel => 'Hour';

  @override
  String get timePickerHourModeAnnouncement => 'Select hours';

  @override
  String get timePickerInputHelpText => 'ENTER TIME';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get timePickerMinuteModeAnnouncement => 'Select minutes';

  @override
  String get unspecifiedDate => 'Date';

  @override
  String get unspecifiedDateRange => 'Date Range';

  @override
  String get viewLicensesButtonLabel => 'VIEW LICENSES';
}

class AppAndLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const AppAndLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ig', 'ha', 'yo', 'en', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AndroidLoacalizationsDelegates> load(Locale locale) async {
    return SynchronousFuture<AndroidLoacalizationsDelegates>(
        AndroidLoacalizationsDelegates());
  }

  @override
  bool shouldReload(AppAndLocalizationDelegate old) => false;
}
