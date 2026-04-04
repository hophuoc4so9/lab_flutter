import 'dart:io';

import 'package:logging/logging.dart';

Logger initFileLogger(String name) {
  hierarchicalLoggingEnabled = true;
  final Logger logger = Logger(name);
  final DateTime now = DateTime.now();

  final File scriptFile = File(Platform.script.toFilePath());
  final String projectDir = scriptFile.parent.parent.path;

  final Directory dir = Directory('$projectDir/logs');
  if (!dir.existsSync()) {
    dir.createSync();
  }

  final File logFile =
      File('${dir.path}/${now.year}_${now.month}_${now.day}_$name.txt');

  logger.level = Level.ALL;
  logger.onRecord.listen((LogRecord record) {
    final String msg =
        '[${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
    logFile.writeAsStringSync('$msg\n', mode: FileMode.append);
  });

  return logger;
}
