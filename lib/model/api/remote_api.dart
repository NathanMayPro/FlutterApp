import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model/request/article_request.dart';
import 'package:newsapp/model/response/article_response.dart';

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

class RemoteApi {
  static const String url = "https://newsapi.org/v2/everything?";
  static const String apiKey = String.fromEnvironment('MY_KEY');

  var dio = Dio();

  Future<List<ArticleResponse>> getArticles(
      ArticleRequest articleRequest) async {
    try {
      final urlFinal =
          "$url${articleRequest.searchType}=flutter&apiKey=$apiKey";
      final response =
          await dio.get(urlFinal, queryParameters: articleRequest.toMap());

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data["articles"]);
        if (results.isNotEmpty) {
          return results.map((e) => ArticleResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err.message);
      return [];
    }
  }
}
