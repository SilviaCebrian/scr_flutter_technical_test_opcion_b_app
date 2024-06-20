import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_recomendation.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/providers/rankingResults/ranking_results_providers.dart';

class RankingRecomendationScroller extends ConsumerStatefulWidget {
  final ScrollState scrollState;
  final Size size;
  final double rankingRecomendationHeight;
  const RankingRecomendationScroller({
    super.key,
    required this.size,
    required this.rankingRecomendationHeight,
    required this.scrollState,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RankingRecomendationScrollerState createState() =>
      _RankingRecomendationScrollerState();
}

class _RankingRecomendationScrollerState
    extends ConsumerState<RankingRecomendationScroller> {
  late BoxShadow shadows;
  late Color themeColor;

  final List<Color> colors = [
    Colors.lightBlue.shade300,
    Colors.pink.shade200,
    Colors.orange.shade400
  ];

  @override
  Widget build(BuildContext context) {
    final rankingRecomendationListState =
        ref.watch(currentRankingRecomendationProvider);
    final double recomendationHeight =
        MediaQuery.of(context).size.height * 0.22 - 50;

    themeColor = Theme.of(context).primaryColor;
    shadows = BoxShadow(color: themeColor.withAlpha(80), blurRadius: 5.0);

    if (rankingRecomendationListState.state == ViewState.visible) {
      final rankingReco = rankingRecomendationListState.data!;
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.scrollState.closeTopContainer ? 0 : 1,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.size.width,
              alignment: Alignment.topCenter,
              height: widget.scrollState.closeTopContainer
                  ? 0
                  : widget.rankingRecomendationHeight,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    child: Row(
                        children: List.generate(
                            rankingReco.length,
                            (index) => _itemScroll(recomendationHeight,
                                colors[index], rankingReco[index])).toList()),
                  ),
                ),
              )),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _itemScroll(
      double height, Color color, RankingRecomandation rankingResult) {
    return GestureDetector(
      onTap: () {
        ref
            .read(searchTextProvider.notifier)
            .setTextController(rankingResult.text);
        ref
            .read(currentRankingResultProvider.notifier)
            .getRanking(rankingResult.text);
        ref
            .read(currentRankingRecomendationProvider.notifier)
            .getRankingRecomendation(rankingResult.text);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(scrollProvider.notifier).updateScroll(0);
        });
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 20),
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [shadows]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              rankingResult.text,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  shadows: [shadows]),
            ),
          ),
        ),
      ),
    );
  }
}
