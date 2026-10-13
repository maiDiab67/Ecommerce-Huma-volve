import 'package:dio/dio.dart';

import '../failure/failure.dart';

class ErrorHandling {
  static Failure handleError(dynamic exp) {
    if (exp is DioException) {
      return _handleRemoteError(exp.toString());
    }
    return Failure("Unexpected error");
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();
    if (errorMessage.contains('401') || errorMessage.contains('403')) {
      return Failure("Unauthorized access");
    } else if (errorMessage.contains('404')) {
      return Failure("Resource not found");
    } else if (errorMessage.contains('500')) {
      return Failure("Internal server error");
    } else if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Failed host lookup')) {
      return Failure("No internet connection");
    } else if (errorMessage.isEmpty &&
        !errorMessage.contains('Exception') &&
        !errorMessage.contains('Error')) {
      return Failure("Exception");
    }
    return Failure("Remote error: $errorMessage");
  }
}
