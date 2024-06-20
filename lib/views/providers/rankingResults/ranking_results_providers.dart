import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_recomendation.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/providers/rankingResults/ranking_results_repo_provider.dart';

//***
//*** DATA
//***

enum ViewState { notVisible, visible, loading, error }

class ViewStateModel<T> {
  final ViewState state;
  final T? data;

  ViewStateModel({required this.state, this.data});
}

//** Ranking Result provider */
final currentRankingResultProvider = StateNotifierProvider<
    RankingResultNotifier, ViewStateModel<List<RankingResult>>>((ref) {
  final fetchRanking =
      ref.watch(rankingResultRepositoryProvider).getRankingResult;
  return RankingResultNotifier(fetchRanking: fetchRanking);
});

typedef RankingResultCallBack = Future<List<RankingResult>> Function(
    {String prompt});

class RankingResultNotifier
    extends StateNotifier<ViewStateModel<List<RankingResult>>> {
  RankingResultCallBack fetchRanking;
  RankingResultNotifier({required this.fetchRanking})
      : super(ViewStateModel(state: ViewState.notVisible));
  late String prompt;
  Future<void> getRanking(String userPrompt) async {
    state = ViewStateModel(state: ViewState.loading);
    try {
      prompt = userPrompt;
      final List<RankingResult> ranking =
          await fetchRanking(prompt: userPrompt);
      state = ViewStateModel(state: ViewState.visible, data: ranking);
    } catch (e) {
      state = ViewStateModel(state: ViewState.error);
    }
  }
}

//** Ranking Recomendations provider */

final currentRankingRecomendationProvider = StateNotifierProvider<
    RankingRecomendationNotifier,
    ViewStateModel<List<RankingRecomandation>>>((ref) {
  final fetchFuncRR =
      ref.watch(rankingResultRepositoryProvider).getRankingRecomendations;
  return RankingRecomendationNotifier(fetchRankingRecomendation: fetchFuncRR);
});

typedef RankingRecomendationCallBack = Future<List<RankingRecomandation>>
    Function({String prompt});

class RankingRecomendationNotifier
    extends StateNotifier<ViewStateModel<List<RankingRecomandation>>> {
  RankingRecomendationCallBack fetchRankingRecomendation;
  RankingRecomendationNotifier({required this.fetchRankingRecomendation})
      : super(ViewStateModel(state: ViewState.notVisible));

  Future<void> getRankingRecomendation(String prompt) async {
    state = ViewStateModel(state: ViewState.loading);
    try {
      final List<RankingRecomandation> rankingRecomendation =
          await fetchRankingRecomendation(prompt: prompt);
      state =
          ViewStateModel(state: ViewState.visible, data: rankingRecomendation);
    } catch (e) {
      state = ViewStateModel(state: ViewState.notVisible);
    }
  }
}

//***
//*** UI
//***

final searchTextProvider =
    StateNotifierProvider<TextfieldNotifier, TextFieldState>((ref) {
  return TextfieldNotifier();
});

class TextFieldState {
  final TextEditingController textEditingController;

  TextFieldState({required this.textEditingController});
}

class TextfieldNotifier extends StateNotifier<TextFieldState> {
  TextfieldNotifier()
      : super(TextFieldState(textEditingController: TextEditingController()));

  void setTextController(String t) {
    state.textEditingController.text = t;
  }
}

//** Ranking Recomendation Scroller Animation */

final scrollProvider =
    StateNotifierProvider<ScrollNotifier, ScrollState>((ref) {
  return ScrollNotifier();
});

class ScrollState {
  final double topContainer;
  final bool closeTopContainer;

  ScrollState({required this.topContainer, required this.closeTopContainer});
}

class ScrollNotifier extends StateNotifier<ScrollState> {
  ScrollNotifier()
      : super(ScrollState(topContainer: 0.0, closeTopContainer: false));

  void updateScroll(double offset) {
    double value = offset / 119;
    state = ScrollState(
      topContainer: value,
      closeTopContainer: offset > 50,
    );
  }
}
