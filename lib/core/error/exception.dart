/// Custom [Exception] to handle API related errors.
class APIException implements Exception {
  final String clientMessage;
  final String jsonBody;

  const APIException({
    required this.clientMessage,
    required this.jsonBody,
  });

  @override
  String toString() => '''APIException(clientMessage: $clientMessage)
                          JSON Body: $jsonBody''';
}
