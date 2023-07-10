import 'package:floor/floor.dart';
import 'package:serap_simulador/core/interfaces/i_crud.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_entity.dart';

@dao
abstract class QuestaoDao extends ICrud<Questao> {
  @Query('SELECT * FROM Questao WHERE id = :id')
  Future<Questao?> findObjById(int id);

  @Query('SELECT * FROM Questao')
  Future<List<Questao>> findAll();

  @Query('SELECT * FROM Questao')
  Stream<List<Questao>> findAllAsStream();

  @Query('DELETE FROM Questao')
  Future<void> deleteAll();
}
