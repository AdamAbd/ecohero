import 'package:equatable/equatable.dart';

import '../../core/core.dart';

class Failure extends Equatable {
  final String message;
  final ResponseEntity? error;

  const Failure({
    required this.message,
    this.error,
  });

  @override
  List<Object?> get props => [message, error];

  @override
  bool get stringify => true;
}
