import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:newsapp/service/local_database_model.dart';

class Article {
  String domain;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;
  Uint8List? image;

  Article(
      {required this.domain,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.image});

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
        domain: map["domain"],
        author: map["author"],
        title: map["title"],
        description: map["description"],
        url: map["url"],
        urlToImage: map["urlToImage"],
        publishedAt: map["publishedAt"],
        content: map["content"],
        image: null);
  }

  Future<ArticleLocal> toLocal() async {
    // load the image
    final ByteData imageData = urlToImage != null
        ? await NetworkAssetBundle(Uri.parse(urlToImage!)).load("")
        : await NetworkAssetBundle(
                Uri.parse("https://www.caspianpolicy.org/no-image.png"))
            .load("");
    return ArticleLocal(
        domain: domain,
        author: author,
        title: title,
        description: description,
        content: content,
        url: url,
        image: imageData.buffer.asUint8List(),
        publishedAt: publishedAt.toIso8601String());
  }
}
