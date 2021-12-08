class ArticleRequest {
  String language;
  String sortBy;
  String searchType;
  String keyword = "flutter";

  ArticleRequest(
      {required this.language, required this.sortBy, required this.searchType});

  factory ArticleRequest.fromMap(Map<String, dynamic> map) {
    return ArticleRequest(
        language: map["language"],
        sortBy: map["sortBy"],
        searchType: map["searchType"]);
  }

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from(
        {"language": language, "sortBy": sortBy, searchType: keyword});
  }
}
