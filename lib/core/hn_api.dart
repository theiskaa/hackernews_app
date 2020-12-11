import 'package:firebase/firebase_io.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:hackernews/core/model/stories.dart';

class HNapi {
  FirebaseClient _firebaseClient = FirebaseClient.anonymous();
  var _apiPath = "https://hacker-news.firebaseio.com/v0/";

  static final HNapi _singleton = HNapi._internal();
  HNapi._internal();

  factory HNapi() {
    return _singleton;
  }

  Future<NewsItem> getNewsItem(int id) async {
    var newsItemPath = "$_apiPath/item/$id.json";
    var response = await _firebaseClient.get(newsItemPath);
    return NewsItem.fromJson(response);
  }

  Future<List<NewsItem>> getNewsComments(NewsItem newsItem) async {
    if (newsItem.kids.length == 0) {
      return List();
    } else {
      //? =============================
      //? =============================
      var comments = await Future.wait(
        newsItem.kids.map(
          (id) => getNewsItem(id),
        ),
      );
      //! =============================
      //! =============================
      var nestedComments = await Future.wait(
        comments.map(
          (comment) => getNewsComments(comment),
        ),
      );
      //  =============================
      //  =============================
      for (var i = 0; i < nestedComments.length; i++) {
        comments[i].comments = nestedComments[i];
      }
      return comments;
    }
  }

  Future<List<dynamic>> getNewsFeed(Stories story) async {
    var path = "";
    switch (story) {
      case Stories.top:
        path = "topstories";
        break;
      case Stories.newest:
        path = "newstories";
        break;
      case Stories.jobs:
        path = "jobstories";
        break;
      case Stories.shows:
        path = "showstories";
        break;
      case Stories.asks:
        path = "askstories";
        break;
      default:
        path = "topstories";
    }

    var fullyPathApi = "$_apiPath$path.json";
    var response = await _firebaseClient.get(fullyPathApi);
    return response;
  }
}
