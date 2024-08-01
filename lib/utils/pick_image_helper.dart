import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageHelper {
  static final picker = ImagePicker();

  static Future<String?> pickerFromCamera() async {
    XFile? pickedFile;
    String? path;
    pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      path = pickedFile.path;
    }
    return path;
  }

  static Future<String?> pickerFromGallery() async {
    XFile? pickedFile;
    String? path;
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      path = pickedFile.path;
    }

    return path;
  }

  static Future<List<int>> fileToBytes(String filePath) async {
    File file = File(filePath);

    if (!await file.exists()) {
      throw Exception("File not found at path: $filePath");
    }

    List<int> fileBytes = await file.readAsBytes();

    return fileBytes;
  }
}
