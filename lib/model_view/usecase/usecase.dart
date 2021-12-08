import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model/api/remote_api.dart';
import 'package:newsapp/model/repository/article_repository_implementation.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/model_view/entitie/request.dart';
import 'package:newsapp/model_view/repository/news_repository.dart';
import 'package:newsapp/service/local_database_service.dart';

final newsUseCaseProvider = Provider<NewsUseCase>(
    (ref) => NewsUseCase(ref.read(newsRepositoryProvider)));

class NewsUseCase {
  NewsUseCase(this._repository) {
    _repository = NewsRepositoryImplementation(RemoteApi());
  }

  NewsRepository _repository;

  Future<List<Article>> getArticles(Request request) {
    //Request request) {
    return _repository.getArticles(request.toArticleRequest());
  }

  Future<List<Article>> getArticlesSave() {
    return LocalDataseServices.instance.readAll();
  }

  void deleteArticleSave(String url) {
    LocalDataseServices.instance.delete(url);
  }

  Future<bool> checkIfSave(String url) {
    return LocalDataseServices.instance.checkIfSave(url);
  }
}
