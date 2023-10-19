import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable{
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure{
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception) : this(message: exception.message, statusCode: exception.statusCode);
}

class NotFoundFailure extends Failure{
   const NotFoundFailure({required super.message, required super.statusCode});
}

class UserStatusUpdateFailure extends Failure{
  const UserStatusUpdateFailure({required super.message, required super.statusCode});
}

class DatabaseUpdateError extends Failure{
  const DatabaseUpdateError({required super.message, required super.statusCode});
}