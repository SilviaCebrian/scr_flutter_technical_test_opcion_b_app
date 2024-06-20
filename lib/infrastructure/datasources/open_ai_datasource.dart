import 'package:dart_openai/dart_openai.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/datasource/ranking_result_datasource.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_recomendation.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/infrastructure/mappers/ranking_result_mapper.dart';

class OpenAIDataSource extends RankingResultDatasource {
  //It tries to emulate a top 10 expert who always returns a json but it is not 100%.
  @override
  Future<List<RankingResult>> getRankingResult({String prompt = ""}) async {
    final completion = await OpenAI.instance.completion.create(
        model: "gpt-3.5-turbo-instruct",
        maxTokens: 1000,
        temperature: 0.5,
        prompt: ''' 
            You are an expert in creating top 10 rankings and you must make one with top 10 $prompt. The answer has to be in the language of $prompt
            The field called "curiosity" that will say in a maximum of 4 words a piece of information associated to "text" field with max 4 words too.
            Do not include explanations, no extra code, ONLY return an RFC8259 compliant JSON response following this format without deviations:
              [
                {
                    "position": 1,
                    "text": "resultado1."
                    "curiosity": "curiosity1"
                },
                {
                    "position": 2,
                    "text": "resultado2.",
                    "curiosity": "curiosity2"
                }
          ...]
        ''',
        n: 1);
    try {
      final List<RankingResult> results =
          RankingResultMapper.getOpenAIRankingResultList(completion);
      return results;
    } catch (e) {
      rethrow;
    }
  }

  //Allows to obtain 3 search results similar to the prompt entered by the user.
  @override
  Future<List<RankingRecomandation>> getRankingRecomendations(
      {String prompt = ""}) async {
    final completion = await OpenAI.instance.completion.create(
        model: "gpt-3.5-turbo-instruct",
        maxTokens: 400,
        prompt: '''  
        Using the prompt: $prompt. Find only three searches that allow us to create other top 10 topics related to $prompt. The answer has to be in the language of $prompt.
        Its important that do not include any explanations, or extra code, ONLY provide a RFC8259 compliant JSON response following this format without deviation.
              [
                {
                    "text": "Result1"
                },
                {
                    "text": "Result2"
                },
                {
                    "text": "Result3"
                }
              ]
        ''',
        n: 1);
    try {
      final List<RankingRecomandation> recomendedRanking =
          RankingResultMapper.getOpenAIRankingRecomandationList(completion);
      return recomendedRanking;
    } catch (e) {
      rethrow;
    }
  }
}
