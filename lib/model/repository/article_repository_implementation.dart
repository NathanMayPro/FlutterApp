import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model/api/remote_api.dart';
import 'package:newsapp/model/request/article_request.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/model_view/repository/news_repository.dart';

final newsRepositoryProvider = Provider<NewsRepository>(
    (ref) => NewsRepositoryImplementation(ref.read(remoteApiProvider)));

class NewsRepositoryImplementation extends NewsRepository {
  NewsRepositoryImplementation(this._remoteApi);
  final RemoteApi _remoteApi;

  @override
  Future<List<Article>> getArticles(ArticleRequest articleRequest) {
    return _remoteApi
        .getArticles(articleRequest)
        .then((value) => value.map((e) => e.toEntitie()).toList());
  }
}
