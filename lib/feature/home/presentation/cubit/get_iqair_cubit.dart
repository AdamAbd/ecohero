import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

part 'get_iqair_state.dart';

class GetIqairCubit extends Cubit<GetIqairState> {
  final IQAirRepository iqAirRepository;

  GetIqairCubit(this.iqAirRepository) : super(GetIqairInitial());

  Future<void> getPollution(List<double>? currentPosition) async {
    emit(GetIqairLoading());

    final response = await iqAirRepository.getPollution(currentPosition);

    emit(
      response.fold(
        (failure) => GetIqairError(failure),
        (iqAir) => GetIqairSuccess(iqAirEntity: iqAir.data!),
      ),
    );
  }
}
