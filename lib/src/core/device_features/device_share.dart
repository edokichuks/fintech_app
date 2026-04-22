// Package imports:
import 'package:share_plus/share_plus.dart';

class DeviceShare {
  static shareText({required String text, String? subject}) async {
    final result = await Share.share(text, subject: subject);
    return result;
  }

  static shareFiles({String? text, required List<XFile> files}) async {
    //[XFile('${directory.path}/image.jpg')] //SHARING FORMAT
    final result = await Share.shareXFiles(files, text: text);
    return result;
  }
}
