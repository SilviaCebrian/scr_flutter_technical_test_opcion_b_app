import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_recomendation.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';

abstract class RankingResultRepository {
  Future<List<RankingResult>> getRankingResult({String prompt = ""});
  Future<List<RankingRecomandation>> getRankingRecomendations({String prompt = ""});
}
