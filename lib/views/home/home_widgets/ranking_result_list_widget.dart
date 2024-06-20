import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/domain/entities/ranking_result.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/providers/rankingResults/ranking_results_providers.dart';

class RankingResultWidget extends ConsumerStatefulWidget {
  final ScrollState scrollState;
  final Size size;
  final double rankingRecomendationHeight;

  const RankingResultWidget({
    super.key,
    required this.size,
    required this.rankingRecomendationHeight,
    required this.scrollState,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RankingResultwidgetState createState() => _RankingResultwidgetState();
}

class _RankingResultwidgetState extends ConsumerState<RankingResultWidget> {
  late Color themeColor;
  late ScrollController controller;
  @override
  void initState() {
    super.initState();

    controller = ScrollController();
    controller.addListener(() {
      ref.read(scrollProvider.notifier).updateScroll(controller.offset);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rankingResultListState = ref.watch(currentRankingResultProvider);

    themeColor = Theme.of(context).primaryColor;

    if (rankingResultListState.state == ViewState.visible) {
      final ranking = rankingResultListState.data!;
      return Expanded(
        child: ListView.builder(
          controller: controller,
          itemCount: ranking.length,
            padding: const EdgeInsets.only(bottom:20.0),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final itemResult = ranking[index];
            double scale = 1.0;
            if (widget.scrollState.topContainer > 0.5) {
              scale = index + 0.5 - widget.scrollState.topContainer;
              if (scale < 0) {
                scale = 0;
              } else if (scale > 1) {
                scale = 1;
              }
            }
            return Opacity(
              opacity: scale,
              child: Transform(
                transform: Matrix4.identity()..scale(scale, scale),
                alignment: Alignment.bottomCenter,
                child: Align(
                    heightFactor: 0.7,
                    alignment: Alignment.topCenter,
                    child: _rankingItem(itemResult, index % 2 == 0)),
              ),
            );
          },
        ),
      );
    } else if (rankingResultListState.state == ViewState.error) {
      return const Expanded(
          child: Center(
              child: Text(
        "Se ha producido un error, inténtalo de nuevo.",
        style: TextStyle(fontWeight: FontWeight.w500),
      )));
    } else if (rankingResultListState.state == ViewState.loading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    } else {
      return const SizedBox();
    }
  }

  Widget _rankingItem(RankingResult item, bool isVariant) {
    return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: isVariant
                ? Colors.white
                : Color.lerp(themeColor, Colors.white, 0.55)!,
            boxShadow: [
              BoxShadow(color: themeColor.withAlpha(80), blurRadius: 6.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.pink.shade600,
                    shadows: [
                      BoxShadow(
                          color: themeColor.withAlpha(80), blurRadius: 5.0),
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    item.position.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: !isVariant ? Colors.white : Colors.black54),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 4),
                child: Text(
                  item.text,
                  style: TextStyle(
                      fontSize: 18,
                      color: !isVariant ? Colors.white : themeColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 0),
                child: Text(
                  item.curiosity,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: !isVariant ? Colors.black54 : Colors.grey,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ));
  }
}
