import 'package:scr_flutter_technical_test_opcion_b_app/domain/datasource/ranking_result_datasource.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/repository/ranking_result_repository.dart';

import '../../domain/entities/ranking_recomendation.dart';

class RankingResultRepoImplementation extends RankingResultRepository {
  final RankingResultDatasource datasource;

  RankingResultRepoImplementation({required this.datasource});

  @override
  Future<List<RankingResult>> getRankingResult({String prompt = ""}) {
    return datasource.getRankingResult(prompt: prompt);
  }

  @override
  Future<List<RankingRecomandation>> getRankingRecomendations(
      {String prompt = ""}) {
    return datasource.getRankingRecomendations(prompt: prompt);
  }
}
