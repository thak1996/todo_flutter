abstract class BaseException implements Exception {
  final String message;
  final String code;
  final String? userMessage;
  final Object? details;

  const BaseException(
    this.message,
    this.code, {
    this.userMessage,
    this.details,
  });

  /// Returns a user-friendly message if available, otherwise falls back to [message].
  String get displayMessage => userMessage ?? message;

  @override
  String toString() {
    return '[$code] $message'
        '${userMessage != null ? ' (User: $userMessage)' : ''}'
        '${details != null ? ' Details: $details' : ''}';
  }
}
