import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/infrastructure/datasources/open_ai_datasource.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/infrastructure/repositories/ranking_result_repo_implementation.dart';

final rankingResultRepositoryProvider = Provider((ref) {
  //If we want to change the datasource we would do it from here. OpenAIDataSource to NewAIDataSource
  return RankingResultRepoImplementation(datasource: OpenAIDataSource());
});