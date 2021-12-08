import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/common/loading_widget.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';
import 'package:newsapp/view/widget/home_list_view.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesData = ref.watch(articlesProvider);
    return articlesData.when(
      data: (listArticleData) {
        return HomeListView(
          listArticleData: listArticleData,
        );
      },
      loading: () {
        return const LoadingWidget();
      },
      error: (err, _) => ErrorWidget(err),
    );
  }
}
