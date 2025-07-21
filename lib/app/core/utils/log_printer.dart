import 'package:logger/logger.dart';

class LoggerPrinter extends LogPrinter {
  final String className;

  LoggerPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final emoji = _getEmoji(event.level);
    final color = _getColor(event.level);
    return [color('$emoji [$className] ${event.message}')];
  }

  String _getEmoji(Level level) {
    switch (level) {
      case Level.trace:
        return '🔍';
      case Level.debug:
        return '🐛';
      case Level.info:
        return 'ℹ️';
      case Level.warning:
        return '⚠️';
      case Level.error:
        return '❌';
      case Level.fatal:
        return '💀';
      default:
        return '❓';
    }
  }

  String Function(String) _getColor(Level level) {
    switch (level) {
      case Level.trace:
        return (text) => '\x1B[37m$text\x1B[0m';
      case Level.debug:
        return (text) => '\x1B[34m$text\x1B[0m';
      case Level.info:
        return (text) => '\x1B[32m$text\x1B[0m';
      case Level.warning:
        return (text) => '\x1B[33m$text\x1B[0m';
      case Level.error:
        return (text) => '\x1B[31m$text\x1B[0m';
      case Level.fatal:
        return (text) => '\x1B[35m$text\x1B[0m';
      default:
        return (text) => text;
    }
  }
}
