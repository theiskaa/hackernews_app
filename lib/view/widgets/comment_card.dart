import 'package:flutter/material.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentModeler extends StatelessWidget {
  final NewsItem newsItem;
  CommentModeler({Key key, this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = List<Widget>();
    //? ======================
    //? ======================
    children.add(
      CommentCard(
        key: Key("${newsItem.id}"),
        newsItem: newsItem,
      ),
    );

    //!  ======================
    //!  ======================
    if (newsItem.comments.length > 0) {
      List<Widget> comments = newsItem.comments
          .map((item) => CommentModeler(
                newsItem: item,
                key: Key("${item.id}"),
              ))
          .toList();

      //  ======================
      //  ======================
      children.add(
        Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Container(width: 15.0, color: Colors.grey),
                Expanded(child: Column(children: comments))
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: children);
  }
}

class CommentCard extends StatelessWidget {
  final NewsItem newsItem;
  CommentCard({Key key, this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(newsItem.time * 1000);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Text(
                      newsItem.by != null ? newsItem.by : 'unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Text(" |  ",style: TextStyle(
                        color: const Color(0xFFFF6600),
                        fontWeight: FontWeight.w700,
                        fontSize: 17.0,
                      ),),
                  Container(
                    child: Text(
                      timeago.format(date),
                      style: TextStyle(
                        color: const Color(0xFFFF6600),
                        fontWeight: FontWeight.w700,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6.0),
              child: Text(
                newsItem.text.isNotEmpty ? newsItem.text : "(Not available)",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
