import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystemHandler {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localSettingsFile async {
    final path = await _localPath;
    final file = File('$path/settings.txt');
    if (file.existsSync()) {
      return file;
    } else {
      await file.create();
      return file;
    }
  }

  static Future<dynamic> readSettings() async {
    try {
      final file = await _localSettingsFile;
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      return null;
    }
  }

  static Future<File?> writeSettings(dynamic contents) async {
    try {
      final file = await _localSettingsFile;
      return file.writeAsString(jsonEncode(contents));
    } catch (e) {
      return null;
    }
  }
}
