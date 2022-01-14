import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '/Models/news_model.dart';
import '/constances/url.dart';
import 'package:http/http.dart' as http;

enum NewsAction { Fetch, Post, Delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _stateSink => _stateStreamController.sink;
  Stream<List<Article>> get stateStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await _getNews();
          _stateSink.add(news.articles as List<Article>);
        } on Exception catch (e) {
          print('😒');
          print(e.toString());
          print('./😒');
          _stateSink.addError('There was an error!');
        }
      }
    });
  }

  Future<NewsModel> _getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      print('😒');
      print(URL.newsUrl);
      print('./😒');
      var response = await client.get(Uri.parse(URL.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }

  dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
