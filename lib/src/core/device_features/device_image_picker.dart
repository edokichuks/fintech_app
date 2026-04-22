// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceImagePicker {
  final ImagePicker _picker = ImagePicker();

  // Pick an image.
  Future<XFile?> pickSingleImageFromGallery() async {
    final status = await [
      Permission.photos,
      Permission.storage,
    ].request();
    final permissionGranted = status.entries
        .every((element) => element.value == PermissionStatus.granted);
    if (permissionGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Capture a photo.
  Future<XFile?> captureImageWithCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      return photo;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Pick a video.
  Future<XFile?> pickSingleVideoFromGallery() async {
    final status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      final XFile? galleryVideo =
          await _picker.pickVideo(source: ImageSource.gallery);
      return galleryVideo;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Capture a video.
  Future<XFile?> captureVideoWithCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? cameraVideo =
          await _picker.pickVideo(source: ImageSource.camera);
      return cameraVideo;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Pick multiple images.
  Future<List<XFile>?> pickMultipleImageFromGallery() async {
    final status = await [
      Permission.photos,
      Permission.storage,
    ].request();
    final permissionGranted = status.entries
        .every((element) => element.value == PermissionStatus.granted);
    if (permissionGranted) {
      final List<XFile> images = await _picker.pickMultiImage();
      return images;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Pick singe image or video.
  Future<XFile?> pickSingleImageOrVideo() async {
    final status = await [
      Permission.mediaLibrary,
      Permission.storage,
    ].request();
    final permissionGranted = status.entries
        .every((element) => element.value == PermissionStatus.granted);
    if (permissionGranted) {
      final XFile? media = await _picker.pickMedia();
      return media;
    } else {
      openAppSettings();
      return null;
    }
  }

  // Pick multiple images and videos.
  Future<List<XFile>?> pickMultipleImageOrVideo() async {
    final status = await [
      Permission.photos,
      Permission.storage,
    ].request();
    final permissionGranted = status.entries
        .every((element) => element.value == PermissionStatus.granted);
    if (permissionGranted) {
      final List<XFile> medias = await _picker.pickMultipleMedia();
      return medias;
    } else {
      openAppSettings();
      return null;
    }
  }
}
