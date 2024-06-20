import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/views/providers/rankingResults/ranking_results_providers.dart';

class SearchWidget extends StatefulWidget {
  final WidgetRef ref;
  final TextEditingController textEditingController;
  const SearchWidget({
    super.key,
    required this.ref,
    required this.textEditingController,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final Color _colorBase = Colors.grey;
  final Color _colorWithTextBase = const Color.fromARGB(255, 96, 33, 112);
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = _colorBase;
    widget.textEditingController.addListener(() {
      if (widget.textEditingController.text.isNotEmpty &&
          currentColor != _colorWithTextBase) {
        setState(() {
          currentColor = _colorWithTextBase;
        });
      } else if (widget.textEditingController.text.isEmpty &&
          currentColor == _colorWithTextBase) {
        setState(() {
          currentColor = _colorBase;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        height: 190,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              "¡Descubre los 10 mejores!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: themeColor.withAlpha(80), blurRadius: 5.0),
                ]),
            child: TextField(
              autofocus: false,
              controller: widget.textEditingController,
              onSubmitted: (value) => onSubmmited(),
              decoration: InputDecoration(
                labelText: "Top 10",
                border: borderDesign(color: _colorBase),
                enabledBorder: borderDesign(color: _colorBase),
                focusedBorder:
                    borderDesign(color: _colorWithTextBase, width: 2.0),
                suffixIcon: GestureDetector(
                    onTap: () => onSubmmited(),
                    child: Spin(
                      child: Transform.rotate(
                        angle: 70,
                        child: Icon(Icons.rocket, color: currentColor),
                      ),
                    )),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ]));
  }

  void onSubmmited() {
    if (widget.textEditingController.text.isNotEmpty) {
      widget.ref
          .read(currentRankingResultProvider.notifier)
          .getRanking("TOP 10 ${widget.textEditingController.text}");
      widget.ref
          .read(currentRankingRecomendationProvider.notifier)
          .getRankingRecomendation(
              "TOP 10 ${widget.textEditingController.text}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.ref.read(scrollProvider.notifier).updateScroll(0);
      });
      FocusScope.of(context).unfocus();
    }
  }

  OutlineInputBorder borderDesign({required Color color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
