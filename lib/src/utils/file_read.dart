import 'package:flutter/services.dart';

class FileRead {
  Future<String> loadFromAsset({String filePath}) async {
    return await rootBundle.loadString(filePath);
  }
}
