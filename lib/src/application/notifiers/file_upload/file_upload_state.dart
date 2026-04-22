import 'package:fintech_app/src/application/model/file_upload_response.dart';

class FileUploadState {
  final List<FileUploadResponse>? uploadedFiles;
  final bool isLoading;

  FileUploadState({this.uploadedFiles, this.isLoading = false});

  FileUploadState copyWith({
    List<FileUploadResponse>? uploadedFiles,
    bool? isLoading,
  }) {
    return FileUploadState(
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
