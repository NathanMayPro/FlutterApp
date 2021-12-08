import 'package:newsapp/model/request/article_request.dart';
import 'package:newsapp/model_view/entitie/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getArticles(
      ArticleRequest articleRequest); //ArticleRequest articleRequest);
}
