class BlocManagerException implements Exception {
  BlocManagerException({
    this.message,
  });

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
