import 'package:flutter/material.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hackernews/view/screens/content_screen.dart';

class CommentHeader extends StatelessWidget {
  final NewsItem newsItem;
  CommentHeader(this.newsItem);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(newsItem.time * 1000);
    return Container(
      padding: EdgeInsets.all(16.0),
      color: const Color(0xFFFF6600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitle(),
          buildMainTitles(date),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentScreen(
                  url: newsItem.url,
                ),
              ),
            ),
            child: buildURL(),
          ),
        ],
      ),
    );
  }

  Container buildTitle() {
    return Container(
      child: Text(
        newsItem.title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 17.0,
        ),
      ),
    );
  }

  Container buildMainTitles(DateTime date) {
    return Container(
      padding: EdgeInsets.only(top: 6.0),
      child: Text(
        "${newsItem.by} - ${timeago.format(date)} - ${newsItem.score}",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      ),
    );
  }

  Container buildURL() {
    return Container(
      padding: EdgeInsets.only(top: 4.0),
      child: Text(
        newsItem.url != null ? newsItem.url : "-",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
