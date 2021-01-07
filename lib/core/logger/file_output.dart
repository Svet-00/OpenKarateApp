import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileOutput extends LogOutput {
  IOSink _logSink;

  FileOutput();

  @override
  void output(OutputEvent event) {
    event.lines.forEach(_logSink.writeln);
  }

  @override
  void init() async {
    var dirPath;
    final dir = await getTemporaryDirectory();
    dirPath = dir.path;
    final file = File(join(dirPath, '${DateTime.now()}.log'));
    _logSink = file.openWrite();
  }

  @override
  void destroy() {
    _logSink.close();
  }
}
