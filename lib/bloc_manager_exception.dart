class BlocManagerException implements Exception {
  BlocManagerException({
    this.message,
  });

  String message;

  @override
  String toString() => '$runtimeType: $message';
}
