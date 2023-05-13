import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ConsoleAndFileOutput extends LogOutput {
  late File? file;

  ConsoleAndFileOutput() {
    try {
      String documentsPath = '/storage/emulated/0/Documents/';
      if (Platform.isIOS) {
        getApplicationDocumentsDirectory().then((value) {
          documentsPath = value.path;
        });
      }

      file = File(
        '$documentsPath/nouns_log.txt',
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      print(line);
      file?.writeAsString(line + "\n", mode: FileMode.append);
    }
  }
}
