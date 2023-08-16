final class ServiceException implements Exception {
  final String message;

  ServiceException({required this.message});

  @override
  String toString() {
    return 'ServiceException{message: $message}';
  }
}
