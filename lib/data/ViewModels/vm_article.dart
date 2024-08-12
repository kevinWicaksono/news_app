class VmArticle {
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  VmArticle({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };

  factory VmArticle.fromJson(Map<String, dynamic> json) => VmArticle(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );
}

class VmArticlesResult {
  final String status;
  final int totalResults;
  final List<VmArticle> articles;

  VmArticlesResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };

  factory VmArticlesResult.fromJson(Map<String, dynamic> json) =>
      VmArticlesResult(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<VmArticle>.from((json["articles"] as List)
            .map((x) => VmArticle.fromJson(x))
            .where((vmArticle) =>
                vmArticle.author != null &&
                vmArticle.urlToImage != null &&
                vmArticle.publishedAt != null &&
                vmArticle.content != null)),
        // articles: List<vmArticle>.from(
        //     json["articles"].map((x) => vmArticle.fromJson(x))),
      );
}
