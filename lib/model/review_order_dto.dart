class ReviewOrderDTO {
  String orderId;
  double score;
  String feedback;

  ReviewOrderDTO(
      {required this.orderId, required this.score, required this.feedback});

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'score': score.toString(),
      'feedBack': feedback,
    };
  }
}
