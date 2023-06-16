import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/usecases/use_case.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/core/storages/local_storages.dart';

@Injectable()
class ObterCadernoIdUseCase implements IUseCaseOption<int?, NoParams> {
  final LocalStorage localStorage;

  ObterCadernoIdUseCase(
    this.localStorage,
  );

  @override
  Future<Option<int?>> call(NoParams params) async {
    var result = await localStorage.getCadernoId();
    return optionOf(result);
  }
}
