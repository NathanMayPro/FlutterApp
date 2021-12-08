import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';
import 'package:newsapp/view/widget/home_article_view_action_button.dart';
import 'package:newsapp/view/widget/home_article_view_redirection.dart';
import 'package:share_plus/share_plus.dart';

class HomeArticleView extends HookConsumerWidget {
  const HomeArticleView({Key? key, this.articleData}) : super(key: key);
  final Article? articleData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(homeViewModelProvider);
    final modelView = ref.read(homeViewModelProvider.notifier);
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title----------------------------------------------------------------
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            articleData!.title,
            maxLines: 3,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        // Image----------------------------------------------------------------
        SizedBox(
          height: height / 5,
          child: state.saveView
              ? Image.memory(articleData!.image!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover)
              : Image.network(articleData!.urlToImage!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover),
        ),
        // Description------------------------------------------------------------
        Text(articleData!.description,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 12,
            )),
        // Content--------------------------------------------------------------
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            articleData!.content,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        ),
        // Domain----------------------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(articleData!.domain.toUpperCase(),
                style: const TextStyle(fontSize: 12)),
          ],
        ),
        //
        HomeArticleViewRedirection(url: articleData!.url),
        const Spacer(),
        // Action Button--------------------------------------------------------
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Go back to listView
              HomeArticleViewActionButton(
                  callBackFunction: () =>
                      modelView.setPropertyState(listView: true),
                  icon: Icons.arrow_back),
              // Share
              HomeArticleViewActionButton(
                  callBackFunction: () => _shareArticle(articleData!.url),
                  icon: Icons.share),
              // Save or Delete
              state.saveView
                  ? HomeArticleViewActionButton(
                      callBackFunction: () => _deleteArticleFromSave(modelView),
                      icon: Icons.delete)
                  : HomeArticleViewActionButton(
                      callBackFunction: () => _saveArticle(modelView),
                      icon: Icons.bookmark_border)
            ],
          ),
        )
      ],
    );
  }

  void _shareArticle(String url) {
    Share.share("Look at this ! \n$url");
  }

  void _deleteArticleFromSave(HomeViewModel modelView) {
    modelView.deleteArticleSave(articleData!.url);
    modelView.setPropertyState(listView: true);
  }

  void _saveArticle(HomeViewModel modelView) async {
    // If not already in Save Local db
    if (await modelView.checkIfSave(articleData!.url) != true) {
      modelView.saveArticle();
    }
  }
}
