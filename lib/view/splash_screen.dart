import 'package:flutter/material.dart';
import 'package:newsapp/common/common_style.dart';
import 'package:newsapp/view/screen/home.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/view/widget/home_article_view.dart';
import 'package:newsapp/view/widget/home_list_view_app_bar.dart';
import 'package:newsapp/view/widget/home_list_view_settings.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonStyle.backGroundColor,
        body: Column(
          children: [
            Visibility(visible: state.listView, child: HomeListViewAppBar()),
            Visibility(
                visible: state.settingsOpen, child: HomeListViewSettings()),
            Expanded(
                child: state.listView
                    ? const HomeScreen()
                    : HomeArticleView(
                        articleData: state.article,
                      )),
          ],
        ),
      ),
    );
  }
}
