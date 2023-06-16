import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';

part 'questao_state.dart';
part 'questao_cubit.freezed.dart';

class QuestaoCubit extends Cubit<QuestaoState> {
  QuestaoCubit() : super(QuestaoState.inicial());
}
