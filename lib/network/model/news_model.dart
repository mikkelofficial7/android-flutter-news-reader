class NewsModel {
  final String? author;
  final String title;
  final String description;
  final String? urlToImage;
  final String publishedAt;
  final String content;
  final String? url;

  NewsModel({
    required this.title,
    required this.description,
    this.urlToImage,
    required this.publishedAt,
    this.author,
    this.url,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      author: json['author'] ?? 'anonymous',
      publishedAt: json['publishedAt'],
      url: json['url'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'author': author,
      'publishedAt': publishedAt,
      'url': url,
      'content': content
    };
  }
}
