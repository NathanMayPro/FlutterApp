import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/view/view_model/home_state.dart';
import 'package:newsapp/view/view_model/home_viewmodel.dart';

class HomeListViewAppBar extends HookConsumerWidget {
  const HomeListViewAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.of(context).size.height / 15;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: height,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeListViewAppBarTitle(height: height, width: width),
              HomeListViewAppBarListButton(height: height, width: width)
            ],
          )),
    );
  }
}

class HomeListViewAppBarTitle extends HookConsumerWidget {
  const HomeListViewAppBarTitle(
      {Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      width: width * (2 / 3) - 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [Text("Flutter news", style: TextStyle(fontSize: 32))],
      ),
    );
  }
}

class HomeListViewAppBarListButton extends HookConsumerWidget {
  const HomeListViewAppBarListButton(
      {Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelView = ref.read(homeViewModelProvider.notifier);
    final state = ref.read(homeViewModelProvider);
    return SizedBox(
        height: height,
        width: width * (1 / 3) - 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Button Acsess of Save Local db
            GestureDetector(
                onTap: () {
                  modelView.setPropertyState(
                      saveView: !state.saveView, settingsOpen: false);
                  ref.refresh(articlesProvider);
                },
                child: Icon(
                  Icons.bookmark_border,
                  color: state.saveView ? Colors.blue : Colors.black,
                )),
            // Button Access to settings
            GestureDetector(
                onTap: () => _toggleSettingsOpen(modelView, state),
                child: Icon(Icons.tune,
                    color: state.settingsOpen ? Colors.blue : Colors.black))
          ],
        ));
  }

  void _toggleSettingsOpen(HomeViewModel modelView, HomeState state) {
    // settings useless for local Save Database
    if (!state.saveView) {
      // Save request settings before any changments to avoid useless query
      if (!state.settingsOpen) {
        modelView.saveLastRequest = Map<String, dynamic>.from({
          "language": state.language,
          "sortBy": state.sortBy,
          "searchType": state.searchType
        });
      }
      // Open or close Settings Widget
      modelView.setPropertyState(settingsOpen: !state.settingsOpen);
    }
  }
}
