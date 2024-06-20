// ignore_for_file: public_member_api_docs, sort_constructors_first
class RankingResult {
  final int position;
  final String text;
  final String curiosity;
  RankingResult({
    required this.position,
    required this.text,
    required this.curiosity,
  });

  factory RankingResult.fromJson(Map<String, dynamic> json) {
    return RankingResult(
      position: json['position'],
      text: json['text'],
      curiosity: json['curiosity'],
    );
  }
}
