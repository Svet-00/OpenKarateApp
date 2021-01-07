import 'dart:developer';

import 'package:logger/src/log_output.dart';
import 'package:logger/src/logger.dart';

/// Implementation of [ConsoleOutput] that uses
/// dart:developer log() function instead of print()
class LogConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(log);
  }
}
