import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';
import 'package:newsapp/view/widget/home_list_view_article.dart';

class HomeListView extends HookConsumerWidget {
  const HomeListView({Key? key, required this.listArticleData})
      : super(key: key);

  final List<Article> listArticleData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: listArticleData.isNotEmpty
          ? ListView.builder(
              itemCount: listArticleData.length,
              itemBuilder: (context, index) {
                final articleData = listArticleData[index];
                return HomeListViewArticle(articleData: articleData);
              })
          : Center(
              child: Text(
                  ref.read(homeViewModelProvider).saveView
                      ? "You don't have registered articles"
                      : "No article available with this settings",
                  style: TextStyle(fontSize: height / 40))),
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    return Future.delayed(const Duration(milliseconds: 500))
        .then((value) => ref.refresh(articlesProvider));
  }
}
