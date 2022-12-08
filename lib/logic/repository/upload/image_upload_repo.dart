import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class ImageUploadRepo {
  static Future<Uint8List?> uploadImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image, allowMultiple: false);
    if (result != null) {
      Uint8List image = result.files.first.bytes!;
      return image;
    } else {
      return null;
    }
  }
}
