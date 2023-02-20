import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagenConveterBase64 {
  Future<String> fileToBase64(XFile file) async {
    File files = File(file.path);
    Uint8List imageBytes = await files.readAsBytes();
    String base64String = base64.encode(imageBytes);
    return base64String;
  }

  Uint8List base64ToImage(String base64) {
    Uint8List bytesImage = const Base64Decoder().convert(base64);
    return bytesImage;
  }
}
