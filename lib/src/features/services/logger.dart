import 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(
    printer: CustomLogPrinter(className),
    level: Level.trace,
  );
}

class CustomLogPrinter extends LogPrinter {
  final String className;

  CustomLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.defaultLevelColors[event.level];
    var emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;

    return [color!('$emoji $className: $message')];
  }
}
