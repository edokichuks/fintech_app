import 'package:clean_flutter/src/core/device_features/device_feature_exports.dart';
import 'package:clean_flutter/src/core/services/file_download_service.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

class FileDownloadSampleScreen extends StatefulWidget {
  const FileDownloadSampleScreen({super.key});

  @override
  State<FileDownloadSampleScreen> createState() =>
      _FileDownloadSampleScreenState();
}

class _FileDownloadSampleScreenState extends State<FileDownloadSampleScreen> {
  final FileDownloadService _downloadService = FileDownloadService();
  bool _isDownloading = false;
  double _progress = 0.0;

  Future<void> _downloadAndShareFile() async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    try {
      final file = await _downloadService.downloadFile(
        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        fileName: 'sample_${DateTime.now().millisecondsSinceEpoch}.pdf',
        onProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );

      if (mounted) {
        showSuccessToast(message: "File saved to: ${file.path}");

        await Future.delayed(const Duration(milliseconds: 500));

        DeviceShare.shareFiles(
          files: [XFile(file.path)],
          text: 'Downloaded file',
        );
      }
    } catch (e) {
      if (mounted) {
        showErrorToast(message: 'Error downloading file: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _progress = 0.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Download Sample')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isDownloading) ...[
              CircularProgressIndicator(value: _progress),
              const SizedBox(height: 16),
              Text('${(_progress * 100).toStringAsFixed(0)}%'),
            ] else
              AppButton(
                text: 'Download & Share PDF',
                onPressed: _downloadAndShareFile,
              ),
          ],
        ),
      ),
    );
  }
}
