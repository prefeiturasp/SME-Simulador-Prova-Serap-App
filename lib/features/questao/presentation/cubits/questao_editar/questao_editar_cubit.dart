import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'questao_editar_state.dart';
part 'questao_editar_cubit.freezed.dart';

class QuestaoEditarCubit extends Cubit<QuestaoEditarState> {
  QuestaoEditarCubit() : super(QuestaoEditarState.initial());
}
