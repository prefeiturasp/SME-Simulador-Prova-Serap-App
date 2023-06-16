import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/core/storages/local_storages.dart';

@Injectable()
class SalvarCadernoIdUseCase implements IUseCaseOption<bool?, Params> {
  final LocalStorage localStorage;

  SalvarCadernoIdUseCase(
    this.localStorage,
  );

  @override
  Future<Option<bool?>> call(Params params) async {
    var result = await localStorage.saveCadernoId(params.cadernoId);
    return optionOf(result);
  }
}

class Params extends Equatable {
  final int cadernoId;

  const Params({
    required this.cadernoId,
  });

  @override
  List<Object> get props => [cadernoId];
}
