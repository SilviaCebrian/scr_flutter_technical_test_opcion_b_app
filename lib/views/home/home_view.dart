import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/home/home_widgets.dart';

import 'package:scr_flutter_technical_test_opcion_b_app/views/providers/rankingResults/ranking_results_providers.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = "home";
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late Color themeColor;

  @override
  Widget build(BuildContext context) {
    //providers
    final rankingResultListState = ref.watch(currentRankingResultProvider);
    final rankingRecomendationListState =
        ref.watch(currentRankingRecomendationProvider);

    final ScrollState scrollState = ref.watch(scrollProvider);
    final Size size = MediaQuery.of(context).size;
    final double rankingRecomendationHeight = size.height * 0.19;
    themeColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: size.height,
        child: Column(children: [
          SearchWidget(
              ref: ref,
              textEditingController:
                  ref.watch(searchTextProvider).textEditingController),
          if (rankingResultListState.state == ViewState.visible &&
              rankingRecomendationListState.state == ViewState.visible) ...[
            RankingRecomendationScroller(
                size: size,
                rankingRecomendationHeight: rankingRecomendationHeight,
                scrollState: scrollState)
          ],
          RankingResultWidget(
              size: size,
              rankingRecomendationHeight: rankingRecomendationHeight,
              scrollState: scrollState)
        ]),
      )),
    );
  }
}
