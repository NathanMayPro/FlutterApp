import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/common/common_style.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';
import 'package:collection/collection.dart';

class HomeListViewSettings extends HookConsumerWidget {
  const HomeListViewSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.of(context).size.height;
    final modelView = ref.read(homeViewModelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 4),
      child: SizedBox(
        width: double.infinity,
        // list of fields and options for settings
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: HomeSettingsWidget(
              fieldName: "Language",
              listOptions: modelView.languageChoiceList,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: HomeSettingsWidget(
              fieldName: "SortBy",
              listOptions: modelView.sortByChoiceList,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
            child: HomeSettingsWidget(
                fieldName: "SearchType",
                listOptions: modelView.searchTypeChoiceList),
          ),
          GestureDetector(
              onTap: () => _validatorSettings(ref),
              child: Center(
                child: Container(
                    height: height / 15,
                    width: height / 15,
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: Icon(Icons.done, color: Colors.white)),
              ))
        ]),
      ),
    );
  }

  void _validatorSettings(WidgetRef ref) {
    final modelView = ref.read(homeViewModelProvider.notifier);
    // for compare the two list of settings old and new
    Function eq = const ListEquality().equals;
    modelView.setPropertyState(settingsOpen: false);
    // if needed query again
    if (!eq(modelView.actualList, modelView.saveList)) {
      ref.refresh(articlesProvider);
    }
  }
}

class HomeSettingsWidget extends HookConsumerWidget {
  const HomeSettingsWidget(
      {Key? key, required this.fieldName, required this.listOptions})
      : super(key: key);

  final String fieldName;
  final List<Widget> listOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: CommonStyle.backGroundArticleColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fieldName),
            Wrap(children: listOptions),
          ],
        ),
      ),
    );
  }
}
