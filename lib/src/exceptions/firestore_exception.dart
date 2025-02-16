class FirestoreException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? details;

  FirestoreException(
    this.message, {
    this.code,
    this.stackTrace,
    this.details,
  });

  @override
  String toString() {
    final buffer = StringBuffer('FirestoreException: $message');
    if (code != null) buffer.write('\nCode: $code');
    if (details != null) buffer.write('\nDetails: $details');
    if (stackTrace != null) buffer.write('\nStack trace: $stackTrace');
    return buffer.toString();
  }
}
