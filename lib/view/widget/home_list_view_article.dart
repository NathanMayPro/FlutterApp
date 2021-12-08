import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';

class HomeListViewArticle extends HookConsumerWidget {
  const HomeListViewArticle({Key? key, required this.articleData})
      : super(key: key);

  final Article articleData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double heightArticlePreview = MediaQuery.of(context).size.height / 3;
    final modelView = ref.read(homeViewModelProvider.notifier);
    final state = ref.read(homeViewModelProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => expandItem(modelView, articleData),
        child: Container(
            color: Colors.grey.shade200,
            height: heightArticlePreview,
            width: double.infinity,
            child: Column(
              children: [
                //image switch between Image.network and Image.memory (from local Save db)
                SizedBox(
                    height: heightArticlePreview / 2,
                    child: state.saveView
                        ? Image.memory(articleData.image!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover)
                        : Image.network(articleData.urlToImage!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover)),
                // Title
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    articleData.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Text(
                    articleData.content,
                    style: TextStyle(color: Colors.grey.shade800),
                    maxLines: 4,
                  ),
                ),
                // Date and domain
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(modelView.switchCaseDate(articleData.publishedAt)),
                    Text(articleData.domain),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void expandItem(HomeViewModel modelView, Article article) {
    modelView.setPropertyState(
        listView: false, article: article, settingsOpen: false);
  }
}
