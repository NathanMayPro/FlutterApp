import 'package:newsapp/model_view/entitie/article.dart';

class HomeState {
  final bool listView;
  final bool saveView;
  final Article? article;
  final bool settingsOpen;
  final String? language;
  final String? sortBy;
  final String? searchType;

  HomeState(
      {required this.listView,
      required this.saveView,
      required this.article,
      required this.settingsOpen,
      required this.language,
      required this.sortBy,
      required this.searchType});

  factory HomeState.init() {
    return HomeState(
        listView: true,
        saveView: false,
        article: null,
        settingsOpen: false,
        language: "en",
        sortBy: "publishedAt",
        searchType: "q");
  }

  HomeState copyWith(
      {required bool? listViewCopy,
      required bool? saveViewCopy,
      required Article? articleCopy,
      required bool? settingsOpenCopy,
      required String? languageCopy,
      required String? sortByCopy,
      required String? searchTypeCopy}) {
    return HomeState(
        listView: listViewCopy ?? listView,
        saveView: saveViewCopy ?? saveView,
        article: articleCopy ?? article,
        settingsOpen: settingsOpenCopy ?? settingsOpen,
        language: languageCopy ?? language,
        sortBy: sortByCopy ?? sortBy,
        searchType: searchTypeCopy ?? searchType);
  }
}
