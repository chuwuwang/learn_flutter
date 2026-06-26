class NativeBridgeException implements Exception {

  final String method;
  final String message;
  final String ? code;
  final dynamic details;

  NativeBridgeException(
      {
        required this.method,
        required this.message,
        this.code,
        this.details,
      }
  );

  @override
  String toString() => '[NativeBridge] method $method execute failed: $message (code: $code)';

}