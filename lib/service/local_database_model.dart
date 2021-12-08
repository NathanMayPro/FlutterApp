import 'dart:typed_data';

import 'package:newsapp/model_view/entitie/article.dart';

class ArticleLocal {
  final String domain;
  final String? author;
  final String title;
  final String description;
  final String content;
  final String url;
  final Uint8List image;
  final String publishedAt;

  ArticleLocal(
      {required this.domain,
      required this.author,
      required this.title,
      required this.description,
      required this.content,
      required this.url,
      required this.image,
      required this.publishedAt});

  factory ArticleLocal.fromMap(Map<String, dynamic> map) {
    return ArticleLocal(
        domain: map["domain"],
        author: map["author"],
        title: map["title"],
        description: map["description"],
        content: map["content"],
        url: map["url"],
        image: map["image"],
        publishedAt: map["publishedAt"]);
  }

  Article toEntitie() {
    return Article(
        domain: domain,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: "",
        image: image,
        publishedAt: DateTime.parse(publishedAt),
        content: content);
  }
}
