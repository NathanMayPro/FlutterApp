import 'package:newsapp/model/request/article_request.dart';

class Request {
  String language;
  String sortBy;
  String searchType;

  Request(
      {required this.language, required this.sortBy, required this.searchType});

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
        language: map["language"],
        sortBy: map["sortBy"],
        searchType: map["searchType"]);
  }

  factory Request.initial() {
    return Request(language: "en", sortBy: "publishedAt", searchType: "q");
  }

  ArticleRequest toArticleRequest() {
    return ArticleRequest.fromMap({
      "language": language,
      "sortBy": sortBy,
      "searchType": searchType,
    });
  }
}
