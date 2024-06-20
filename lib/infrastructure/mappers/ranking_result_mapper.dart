import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_recomendation.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';

class RankingResultMapper {
  //ENTITIES
  static RankingResult openAiToEntity(dynamic json) =>
      RankingResult.fromJson(json);

  static RankingRecomandation openAiToEntityRR(dynamic json) =>
      RankingRecomandation.fromJson(json);

  //LISTS
  static List<RankingResult> getOpenAIRankingResultList(
      OpenAICompletionModel responseModel) {
    String responseBody = responseModel.choices.first.text;
    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<RankingResult>(
              (json) => RankingResultMapper.openAiToEntity(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  static List<RankingRecomandation> getOpenAIRankingRecomandationList(
      OpenAICompletionModel responseModel) {
    String responseBody = responseModel.choices.first.text;

    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<RankingRecomandation>(
              (json) => RankingResultMapper.openAiToEntityRR(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
