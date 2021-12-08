import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/model_view/entitie/article.dart';
import 'package:newsapp/model_view/entitie/request.dart';
import 'package:newsapp/model_view/usecase/usecase.dart';
import 'package:newsapp/service/local_database_service.dart';
import 'package:newsapp/view/view_model/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
        (ref) => HomeViewModel(ref.read(newsUseCaseProvider)));

final articlesProvider = FutureProvider.autoDispose<List<Article>>(
    (ref) => ref.read(homeViewModelProvider.notifier).getArticles());

class HomeViewModel extends StateNotifier<HomeState> {
  final NewsUseCase useCase;
  List<String?> requestList = [];

  HomeViewModel(this.useCase) : super(HomeState.init());

  //getters---------------------------------------------------------------------

  // Contain logic for return List of Language Setting choice
  List<Widget> get languageChoiceList {
    final listOfChoice = <Widget>[];
    final listOfPossibility = <String>[
      "ar",
      "de",
      "en",
      "es",
      "fr",
      "he",
      "it",
      "nl",
      "no",
      "pt",
      "ru",
      "se",
      "ud",
      "zh"
    ];

    listOfPossibility.asMap().forEach((index, value) {
      listOfChoice.add(ChoiceChip(
        label: Text(value),
        selected: state.language == value,
        onSelected: (v) {
          setPropertyState(language: value);
        },
      ));
      listOfChoice.add(const SizedBox(width: 4));
    });
    return listOfChoice;
  }

  // Contain logic for return List of sortBy Setting choice
  List<Widget> get sortByChoiceList {
    final listOfChoice = <Widget>[];
    final listOfPossibility = <String>[
      "publishedAt",
      "popularity",
      "relevancy"
    ];
    listOfPossibility.asMap().forEach((index, value) {
      listOfChoice.add(ChoiceChip(
        label: Text(value),
        selected: state.sortBy == value,
        onSelected: (v) {
          setPropertyState(sortBy: value);
        },
      ));
      listOfChoice.add(const SizedBox(width: 4));
    });
    return listOfChoice;
  }

  // Contain logic for return List of searchType Setting choice
  List<Widget> get searchTypeChoiceList {
    final listOfChoice = <Widget>[];
    final listOfPossibility = <String>[
      "q",
      "qInTitle",
      "domains",
    ];
    listOfPossibility.asMap().forEach((index, value) {
      listOfChoice.add(ChoiceChip(
        label: Text(value),
        selected: state.searchType == value,
        onSelected: (v) {
          setPropertyState(searchType: value);
        },
      ));
      listOfChoice.add(const SizedBox(width: 4));
    });
    return listOfChoice;
  }

  // Save and retrieve last Settings to avoid multiple request
  // when settings are similar
  List<String?> get actualList {
    return [state.language, state.sortBy, state.searchType];
  }

  List<String?> get saveList {
    return requestList;
  }

  //Setters---------------------------------------------------------------------

  set saveLastRequest(Map<String, dynamic> map) {
    requestList = [map["language"], map["sortBy"], map["searchType"]];
  }

  //Functions-------------------------------------------------------------------
  String switchCaseDate(DateTime date) {
    var publishedDelay = DateTime.now().difference(date).inDays;
    if (publishedDelay == 0) return "Published today";
    if (publishedDelay <= 7) return "Published last week";
    if (publishedDelay < 30) return "Published last month";
    if (publishedDelay < 365) return "Published last year";
    return "Published ${(publishedDelay / 365).round()} years ago";
  }

  //CRUD operation -------------------------------------------------------------
  Future<List<Article>> getArticles() {
    if (state.saveView) return useCase.getArticlesSave();
    return useCase.getArticles(Request.fromMap({
      "language": state.language,
      "sortBy": state.sortBy,
      "searchType": state.searchType
    }));
  }

  //Manage State----------------------------------------------------------------
  void setPropertyState(
      {bool? listView,
      bool? saveView,
      Article? article,
      bool? settingsOpen,
      String? language,
      String? sortBy,
      String? searchType}) {
    state = state.copyWith(
        listViewCopy: listView,
        saveViewCopy: saveView,
        articleCopy: article,
        settingsOpenCopy: settingsOpen,
        languageCopy: language,
        sortByCopy: sortBy,
        searchTypeCopy: searchType);
  }

  //Manage Local DataBase-------------------------------------------------------
  Future<bool> checkIfSave(String url) async {
    return await useCase.checkIfSave(url);
  }

  Future saveArticle() async {
    LocalDataseServices.instance.create(await state.article!.toLocal());
  }

  void deleteArticleSave(String url) {
    return useCase.deleteArticleSave(url);
  }
}
