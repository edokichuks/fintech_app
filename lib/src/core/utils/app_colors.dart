// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  //SnappyPay Colors

  //Body
  static Color defaultBG = _fromHex('#111111');
  //WHITE
  static Color white = _fromHex('#FFFFFF');
  static Color white100 = _fromHex('#F3F2F5');

  //GREY
  static Color greyDesktop = _fromHex('#F8F8F9');
  static Color greyMobile = _fromHex('#FAFAFA');
  static Color darkgreyMobile = _fromHex('#1A1A1A');
  static Color stroke = _fromHex('#F2F2F2');

  //LIGHT MODE
  static Color defaultBackgroundLight = _fromHex('#F8F8FB');
  static Color defaultOverlayLight = _fromHex('#FFFFFF');
  //DARK MODE
  static Color defaultBackgroundDark = _fromHex('#111111');
  static Color defaultOverlaydDark = _fromHex('#171B20');

  //NEUTRAL
  static Color neutral50 = _fromHex('#E7E7E7');
  static Color neutral100 = _fromHex('#B5B5B5');
  static Color neutral200 = _fromHex('#929292');
  static Color neutral300 = _fromHex('#606060');
  static Color neutral400 = _fromHex('#414141');
  static Color neutral500 = _fromHex('#111111');
  static Color neutral600 = _fromHex('#0F0F0F');
  static Color neutral700 = _fromHex('#0C0C0C');
  static Color neutral800 = _fromHex('#090909');
  static Color neutral900 = _fromHex('#070707');

  //PRIMARY
  static Color primary50 = _fromHex('#E6F1FA');
  static Color primary75 = _fromHex('#B4D6F1');
  static Color primary100 = _fromHex('#68ADE3');
  static Color primary200 = _fromHex('#3691D9');
  static Color primary300 = _fromHex('#0476D0');
  static Color primary400 = _fromHex('#035EA6');
  static Color primary500 = _fromHex('#02477D');

  //PRIMARY DARK
  static Color primaryDark50 = _fromHex('#01233E');
  static Color primaryDark75 = _fromHex('#023B68');
  static Color primaryDark100 = _fromHex('#035392');
  static Color primaryDark200 = _fromHex('#0476D0');
  static Color primaryDark300 = _fromHex('#3691D9');
  static Color primaryDark400 = _fromHex('#82BBE8');
  static Color primaryDark500 = _fromHex('#B4D6F1');

  //SECONDARY
  static Color secondary50 = _fromHex('#E6E6F2');
  static Color secondary75 = _fromHex('#B3B3D9');
  static Color secondary100 = _fromHex('#6666B3');
  static Color secondary200 = _fromHex('#333399');
  static Color secondary300 = _fromHex('#000080');
  static Color secondary400 = _fromHex('#000066');
  static Color secondary500 = _fromHex('#00004D');

  //SECONDARY DARK
  static Color secondaryDark50 = _fromHex('#000033');
  static Color secondaryDark75 = _fromHex('#00004D');
  static Color secondaryDark100 = _fromHex('#000066');
  static Color secondaryDark200 = _fromHex('#000080');
  static Color secondaryDark300 = _fromHex('#6666B3');
  static Color secondaryDark400 = _fromHex('#8080C0');
  static Color secondaryDark500 = _fromHex('#B3B3D9');

  //SUCCESS
  static Color success50 = _fromHex('#E9F8EE');
  static Color success75 = _fromHex('#A4E2BB');
  static Color success100 = _fromHex('#7ED69E');
  static Color success200 = _fromHex('#4DC679');
  static Color success300 = _fromHex('#20B858');
  static Color success400 = _fromHex('#1A9346');
  static Color success500 = _fromHex('#147036');

  //SUCCESS DARK
  static Color successDark50 = _fromHex('#0A371A');
  static Color successDark75 = _fromHex('#105C2C');
  static Color successDark100 = _fromHex('#7ED69E');
  static Color successDark200 = _fromHex('#20B858');
  static Color successDark300 = _fromHex('#63CD8A');
  static Color successDark400 = _fromHex('#90DCAC');
  static Color successDark500 = _fromHex('#BCEACD');

  //DANGER
  static Color danger50 = _fromHex('#FDE7E7');
  static Color danger75 = _fromHex('#F89E9E');
  static Color danger100 = _fromHex('#F67676');
  static Color danger200 = _fromHex('#F24141');
  static Color danger300 = _fromHex('#EF1212');
  static Color danger400 = _fromHex('#BF0E0E');
  static Color danger500 = _fromHex('#920B0B');

  //DANGER DARK
  static Color dangerDark50 = _fromHex('#491111');
  static Color dangerDark75 = _fromHex('#791D1D');
  static Color dangerDark100 = _fromHex('#A92929');
  static Color dangerDark200 = _fromHex('#EF1212');
  static Color dangerDark300 = _fromHex('#F67575');
  static Color dangerDark400 = _fromHex('#F99D9D');
  static Color dangerDark500 = _fromHex('#FBC4C4');

  //WARNING
  static Color warning50 = _fromHex('#FFF9E6');
  static Color warning75 = _fromHex('#FFE597');
  static Color warning100 = _fromHex('#FFDA6C');
  static Color warning200 = _fromHex('#FFCD34');
  static Color warning300 = _fromHex('#FFC001');
  static Color warning400 = _fromHex('#B38601');
  static Color warning500 = _fromHex('#9C7501');

  //WARNING DARK
  static Color warningDark50 = _fromHex('#4C3A00');
  static Color warningDark75 = _fromHex('#806001');
  static Color warningDark100 = _fromHex('#B38601');
  static Color warningDark200 = _fromHex('#FFC001');
  static Color warningDark300 = _fromHex('#FFD34D');
  static Color warningDark400 = _fromHex('#FFE080');
  static Color warningDark500 = _fromHex('#FFECB3');

  //INFO
  static Color info50 = _fromHex('#E7F6FD');
  static Color info75 = _fromHex('#9CDAF6');
  static Color info100 = _fromHex('#73CBF2');
  static Color info200 = _fromHex('#37B4ED');
  static Color info300 = _fromHex('#0EA5E9');
  static Color info400 = _fromHex('#0B84BA');
  static Color info500 = _fromHex('#09658E');

  //INFO DARK
  static Color infoDark50 = _fromHex('#043146');
  static Color infoDark75 = _fromHex('#075375');
  static Color infoDark100 = _fromHex('#0A73A3');
  static Color infoDark200 = _fromHex('#0EA5E9');
  static Color infoDark300 = _fromHex('#56C0F0');
  static Color infoDark400 = _fromHex('#87D2F4');
  static Color infoDark500 = _fromHex('#B7E4F8');

  //Random Colors
  static Color charcoalGrey = _fromHex('#404852');
  static const Color starColor = Color.fromRGBO(255, 151, 0, 1);
  static Color transparent = Colors.transparent;
  static Color red = _fromHex('#DC2626');

  // Fintech feature tokens
  static Color fintechDarkBackground = _fromHex('#1B1B1D');
  static Color fintechDarkSurface = _fromHex('#232326');
  static Color fintechDarkSurfaceMuted = _fromHex('#2B2B2F');
  static Color fintechDarkCard = _fromHex('#2A2A2D');
  static Color fintechDarkBorder = _fromHex('#34343A');
  static Color fintechDarkTextPrimary = _fromHex('#F8F8FA');
  static Color fintechDarkTextSecondary = _fromHex('#B6B7C0');
  static Color fintechDarkTextMuted = _fromHex('#8B8D97');
  static Color fintechDarkScrim = _fromHex('#131316');
  static Color fintechBalanceOverviewDark = _fromHex('#272729');
  static Color fintechBalanceOverviewBorderStart = _fromHex('#80E5E4E4');
  static Color fintechBalanceOverviewBorderEnd = _fromHex('#3C000000');
  static Color fintechBalanceOverviewBadgeDark = _fromHex('#343437');

  static Color fintechLightBackground = _fromHex('#F5F6FA');
  static Color fintechLightSurface = _fromHex('#FFFFFF');
  static Color fintechLightSurfaceMuted = _fromHex('#EEF1F7');
  static Color fintechLightCard = _fromHex('#FFFFFF');
  static Color fintechLightBorder = _fromHex('#DBE0EA');
  static Color fintechLightTextPrimary = _fromHex('#181B24');
  static Color fintechLightTextSecondary = _fromHex('#5B6473');
  static Color fintechLightTextMuted = _fromHex('#8590A3');
  static Color fintechLightScrim = _fromHex('#12151D');
  static Color fintechBalanceOverviewLight = _fromHex('#FCFCFF');
  static Color fintechBalanceOverviewBorderLightStart = _fromHex('#CCFFFFFF');
  static Color fintechBalanceOverviewBorderLightEnd = _fromHex('#266F7A8F');
  static Color fintechBalanceOverviewBadgeLight = _fromHex('#EEF1F7');

  static Color fintechBlue = _fromHex('#1463FF');
  static Color fintechBlueSoft = _fromHex('#3F86FF');
  static Color fintechBlueDeep = _fromHex('#0D4EDB');
  static Color fintechBlueGlow = _fromHex('#8BB3FF');
  static Color fintechSuccess = _fromHex('#2ED573');
  static Color fintechDanger = _fromHex('#FF3B30');
  static Color fintechWarning = _fromHex('#FFB020');
  static Color fintechPeach = _fromHex('#FFD29A');
  static Color fintechPeachDark = _fromHex('#FFB86A');
  static Color blue100 = _fromHex('#6BA6FF');
}

Color _fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
