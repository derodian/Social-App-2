import 'dart:math';

class FileSizeUtil {
  static const List<String> _units = ['B', 'KB', 'MB', 'GB', 'TB'];

  /// Converts bytes to a human-readable string.
  ///
  /// [bytes] is the file size in bytes.
  /// [decimals] is the number of decimal places to show (default is 2).
  /// [customUnits] allows you to specify custom unit strings (default is ['B', 'KB', 'MB', 'GB', 'TB']).
  /// [separator] is the string to put between the number and unit (default is ' ').
  static String formatFileSize(
    int bytes, {
    int decimals = 2,
    List<String>? customUnits,
    String separator = ' ',
  }) {
    if (bytes <= 0) return '0$separator${customUnits?.first ?? _units.first}';

    final units = customUnits ?? _units;
    final i = (log(bytes) / log(1024)).floor();
    final size = bytes / pow(1024, i);

    return '${size.toStringAsFixed(decimals)}$separator${units[i]}';
  }

  /// Converts bytes to KB and returns the value as a double.
  static double bytesToKB(int bytes) => bytes / 1024;

  /// Converts bytes to MB and returns the value as a double.
  static double bytesToMB(int bytes) => bytes / (1024 * 1024);

  /// Converts bytes to GB and returns the value as a double.
  static double bytesToGB(int bytes) => bytes / (1024 * 1024 * 1024);

  /// Returns the most appropriate unit for the given byte size.
  static String getMostAppropriateSizeUnit(int bytes) {
    if (bytes < 1024) return 'B';
    if (bytes < 1024 * 1024) return 'KB';
    if (bytes < 1024 * 1024 * 1024) return 'MB';
    return 'GB';
  }

  /// Converts bytes to the most appropriate unit and returns a Map with 'value' and 'unit'.
  static Map<String, dynamic> bytesToMostAppropriateUnit(int bytes) {
    final unit = getMostAppropriateSizeUnit(bytes);
    double value;
    switch (unit) {
      case 'B':
        value = bytes.toDouble();
        break;
      case 'KB':
        value = bytesToKB(bytes);
        break;
      case 'MB':
        value = bytesToMB(bytes);
        break;
      case 'GB':
        value = bytesToGB(bytes);
        break;
      default:
        value = bytes.toDouble();
    }
    return {'value': value, 'unit': unit};
  }
}
