import 'package:floor/floor.dart';
import 'package:serap_simulador/core/interfaces/i_crud.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_entity.dart';

@dao
abstract class AlternativaDao extends ICrud<Alternativa> {
  @Query('SELECT * FROM Alternativa WHERE id = :id')
  Future<Alternativa?> findObjById(int id);

  @Query('SELECT * FROM Alternativa')
  Future<List<Alternativa>> findAll();

  @Query('SELECT * FROM Alternativa')
  Stream<List<Alternativa>> findAllAsStream();

  @Query('DELETE FROM Alternativa')
  Future<void> deleteAll();
}
