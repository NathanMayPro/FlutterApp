import 'package:newsapp/model_view/entitie/article.dart';

class ArticleResponse {
  ArticleResponse({
    required this.domain,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  String domain;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  factory ArticleResponse.fromMap(Map<String, dynamic> map) => ArticleResponse(
        domain: map["source"]["name"] ?? "",
        author: map["author"],
        title: map["title"],
        description: map["description"],
        url: map["url"],
        // if there is no image available replace by this url, needed in case of local storage db
        urlToImage:
            map["urlToImage"] ?? "https://www.caspianpolicy.org/no-image.png",
        publishedAt: DateTime.parse(map["publishedAt"]),
        content: map["content"],
      );

  Map<String, dynamic> toMap() => {
        "domain": domain,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
  Article toEntitie() {
    return Article(
        author: author,
        domain: domain,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
        image: null);
  }
}
