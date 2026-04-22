import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileDownloadService {
  final Dio _dio = Dio();

  Future<Directory> getSafeStorageDirectory() async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory())!;
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  Future<File> downloadFile({
    required String url,
    required String fileName,
    void Function(int, int)? onProgress,
  }) async {
    final directory = await getSafeStorageDirectory();
    final filePath = path.join(directory.path, fileName);

    await _dio.download(
      url,
      filePath,
      onReceiveProgress: onProgress,
    );

    return File(filePath);
  }
}
