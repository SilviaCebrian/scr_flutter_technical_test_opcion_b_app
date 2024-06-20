// ignore_for_file: public_member_api_docs, sort_constructors_first
class RankingRecomandation {
  final String text;
  RankingRecomandation({
    required this.text,
  });

  factory RankingRecomandation.fromJson(Map<String, dynamic> json) {
    return RankingRecomandation(
      text: json['text'],
    );
  }
}
