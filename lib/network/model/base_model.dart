class BaseResponse<T> {
  final String? status;
  final int totalResults;
  final T? articles;

  BaseResponse({
    this.status,
    required this.totalResults,
    this.articles,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse(
      totalResults: json['totalResults'],
      articles: fromJsonT(json['articles']),
      status: json['status'],
    );
  }
}
