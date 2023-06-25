part of 'get_iqair_cubit.dart';

abstract class GetIqairState extends Equatable {
  const GetIqairState();

  @override
  List<Object> get props => [];
}

class GetIqairInitial extends GetIqairState {}

class GetIqairLoading extends GetIqairState {}

class GetIqairError extends GetIqairState {
  final Failure failure;

  const GetIqairError(this.failure);
}

class GetIqairSuccess extends GetIqairState {
  final IQAirEntity iqAirEntity;

  const GetIqairSuccess({required this.iqAirEntity});
}
